Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E48C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BB7206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgEEOeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:34:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:57200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgEEOeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:34:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 003A9AB3D;
        Tue,  5 May 2020 14:34:01 +0000 (UTC)
Subject: Re: [PATCH] xenbus: avoid stack overflow warning
To:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>, Wei Liu <wl@xen.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20200505141546.824573-1-arnd@arndb.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <30d49e6d-570b-f6fd-3a6f-628abcc8b127@suse.com>
Date:   Tue, 5 May 2020 16:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505141546.824573-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.20 16:15, Arnd Bergmann wrote:
> The __xenbus_map_ring() function has two large arrays, 'map' and
> 'unmap' on its stack. When clang decides to inline it into its caller,
> xenbus_map_ring_valloc_hvm(), the total stack usage exceeds the warning
> limit for stack size on 32-bit architectures.
> 
> drivers/xen/xenbus/xenbus_client.c:592:12: error: stack frame size of 1104 bytes in function 'xenbus_map_ring_valloc_hvm' [-Werror,-Wframe-larger-than=]
> 
> As far as I can tell, other compilers don't inline it here, so we get
> no warning, but the stack usage is actually the same. It is possible
> for both arrays to use the same location on the stack, but the compiler
> cannot prove that this is safe because they get passed to external
> functions that may end up using them until they go out of scope.
> 
> Move the two arrays into separate basic blocks to limit the scope
> and force them to occupy less stack in total, regardless of the
> inlining decision.

Why don't you put both arrays into a union?


Juergen

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/xen/xenbus/xenbus_client.c | 74 +++++++++++++++++-------------
>   1 file changed, 41 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
> index 040d2a43e8e3..23ca70378e36 100644
> --- a/drivers/xen/xenbus/xenbus_client.c
> +++ b/drivers/xen/xenbus/xenbus_client.c
> @@ -470,54 +470,62 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
>   			     unsigned int flags,
>   			     bool *leaked)
>   {
> -	struct gnttab_map_grant_ref map[XENBUS_MAX_RING_GRANTS];
> -	struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
>   	int i, j;
>   	int err = GNTST_okay;
>   
> -	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
> -		return -EINVAL;
> +	{
> +		struct gnttab_map_grant_ref map[XENBUS_MAX_RING_GRANTS];
>   
> -	for (i = 0; i < nr_grefs; i++) {
> -		memset(&map[i], 0, sizeof(map[i]));
> -		gnttab_set_map_op(&map[i], addrs[i], flags, gnt_refs[i],
> -				  dev->otherend_id);
> -		handles[i] = INVALID_GRANT_HANDLE;
> -	}
> +		if (nr_grefs > XENBUS_MAX_RING_GRANTS)
> +			return -EINVAL;
>   
> -	gnttab_batch_map(map, i);
> +		for (i = 0; i < nr_grefs; i++) {
> +			memset(&map[i], 0, sizeof(map[i]));
> +			gnttab_set_map_op(&map[i], addrs[i], flags,
> +					  gnt_refs[i], dev->otherend_id);
> +			handles[i] = INVALID_GRANT_HANDLE;
> +		}
> +
> +		gnttab_batch_map(map, i);
>   
> -	for (i = 0; i < nr_grefs; i++) {
> -		if (map[i].status != GNTST_okay) {
> -			err = map[i].status;
> -			xenbus_dev_fatal(dev, map[i].status,
> +		for (i = 0; i < nr_grefs; i++) {
> +			if (map[i].status != GNTST_okay) {
> +				err = map[i].status;
> +				xenbus_dev_fatal(dev, map[i].status,
>   					 "mapping in shared page %d from domain %d",
>   					 gnt_refs[i], dev->otherend_id);
> -			goto fail;
> -		} else
> -			handles[i] = map[i].handle;
> +				goto fail;
> +			} else
> +				handles[i] = map[i].handle;
> +		}
>   	}
> -
>   	return GNTST_okay;
>   
>    fail:
> -	for (i = j = 0; i < nr_grefs; i++) {
> -		if (handles[i] != INVALID_GRANT_HANDLE) {
> -			memset(&unmap[j], 0, sizeof(unmap[j]));
> -			gnttab_set_unmap_op(&unmap[j], (phys_addr_t)addrs[i],
> -					    GNTMAP_host_map, handles[i]);
> -			j++;
> +	{
> +		struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
> +
> +		for (i = j = 0; i < nr_grefs; i++) {
> +			if (handles[i] != INVALID_GRANT_HANDLE) {
> +				memset(&unmap[j], 0, sizeof(unmap[j]));
> +				gnttab_set_unmap_op(&unmap[j],
> +						    (phys_addr_t)addrs[i],
> +						    GNTMAP_host_map,
> +						    handles[i]);
> +				j++;
> +			}
>   		}
> -	}
>   
> -	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, j))
> -		BUG();
> +		if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref,
> +					      unmap, j))
> +			BUG();
>   
> -	*leaked = false;
> -	for (i = 0; i < j; i++) {
> -		if (unmap[i].status != GNTST_okay) {
> -			*leaked = true;
> -			break;
> +		*leaked = false;
> +		for (i = 0; i < j; i++) {
> +			if (unmap[i].status != GNTST_okay) {
> +				*leaked = true;
> +				break;
> +			}
>   		}
>   	}
>   
> 

