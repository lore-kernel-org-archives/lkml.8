Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69792C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420BD206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQwn1SCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbgF3NcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:32:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgF3NcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593523939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WB0Yd27fftKZItOj7IqAPzZFMcB8Kks9E0khozHUDtU=;
        b=MQwn1SCdHOer/dOz6NgZwkgHDBt0gbjZGjbOdQx7LW3errSxNqop6h7FtvO8Ee/tZoSo+s
        7cPwbK2TWxyM8rG2HVWg4vFQqKszgCyKRmQ/Glc0+eb+W/2Y3AdMsPVvIs+UTH0yNG75aW
        P6Qzr+IsnZ355nPDIUVdLd9PNBNXuHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-4OYjGvZnMpSewXQZT9Dgkg-1; Tue, 30 Jun 2020 09:32:14 -0400
X-MC-Unique: 4OYjGvZnMpSewXQZT9Dgkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F6D10059A1;
        Tue, 30 Jun 2020 13:32:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4D6E5D9E7;
        Tue, 30 Jun 2020 13:32:01 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05UDW1KX014784;
        Tue, 30 Jun 2020 09:32:01 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05UDW16L014771;
        Tue, 30 Jun 2020 09:32:01 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 Jun 2020 09:32:01 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Suchanek <msuchanek@suse.de>
cc:     linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Pankaj Gupta <pagupta@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jakub Staron <jstaron@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm writecache: reject asynchronous pmem.
In-Reply-To: <20200630123528.29660-1-msuchanek@suse.de>
Message-ID: <alpine.LRH.2.02.2006300929580.4801@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200630123528.29660-1-msuchanek@suse.de>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jun 2020, Michal Suchanek wrote:

> The writecache driver does not handle asynchronous pmem. Reject it when
> supplied as cache.
> 
> Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.com/
> Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  drivers/md/dm-writecache.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 30505d70f423..57b0a972f6fd 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -2277,6 +2277,12 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  
>  		wc->memory_map_size -= (uint64_t)wc->start_sector << SECTOR_SHIFT;
>  
> +		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
> +			r = -EOPNOTSUPP;
> +			ti->error = "Asynchronous persistent memory not supported as pmem cache";
> +			goto bad;
> +		}
> +
>  		bio_list_init(&wc->flush_list);
>  		wc->flush_thread = kthread_create(writecache_flush_thread, wc, "dm_writecache_flush");
>  		if (IS_ERR(wc->flush_thread)) {
> -- 

Hi

Shouldn't this be in the "if (WC_MODE_PMEM(wc))" block?

WC_MODE_PMEM(wc) retrurns true if we are using persistent memory as a 
cache device, otherwise we are using generic block device as a cache 
device.

Mikulas

