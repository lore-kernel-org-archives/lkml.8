Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6A2C2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960E3206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 22:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RMRd5Uge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960E3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDLWVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgDLWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 18:21:01 -0400
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67C0C0A88B5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 15:21:01 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03CMKOMv043305;
        Sun, 12 Apr 2020 22:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZFzvXlEz3aQDYueL7xZArt573VAUwf+OIG6zYzoJ7PE=;
 b=RMRd5UgeaxFfVeeAWOGvLDZPxueA8mJFi5pBoUb7GRdTa4iTj6B3OjOuJ6MWe2BwiPER
 I8/masZwLRSu3MooKJpkBl1r0rOFJTo+urNNmkwhPXRtdr9zjeHO5FIgIqCLyRYIVOrk
 ATP1z3zpp3qy/sRwSYMx1rQdd4t4sJlLyckumATrp2onED/6NY6GD0DIHxtPKVe+rGkL
 vljHC5nBKi6NXOe0ioA4pIN7VptWF5Xa0E1JoiBLfrxSYtL0L0rpi8hZ24licjuMiEQu
 dvtpbcrso18wtQnvK+3IgF8weGHZLvDs3aoOeWDaatgmJ1nFCIFNJfb/AAMhY4nyjuYf +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30b5aquutp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Apr 2020 22:20:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03CMHpm2022319;
        Sun, 12 Apr 2020 22:20:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30bqp95gys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Apr 2020 22:20:50 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03CMKl98023513;
        Sun, 12 Apr 2020 22:20:48 GMT
Received: from [10.0.0.251] (/24.5.189.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Apr 2020 15:20:47 -0700
Subject: Re: [PATCH 1/1] mm: slub: fix corrupted freechain in
 deactivate_slab()
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
References: <20200331031450.12182-1-dongli.zhang@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <343df8bf-9a30-fd33-ef0b-c2ac3cc3baa5@oracle.com>
Date:   Sun, 12 Apr 2020 15:20:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331031450.12182-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9589 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=1 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120202
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9589 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004120202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

May I get the feedback for this patch?

This reduces the chance of page fault when freepointer is corrupted while
"slub_debug=F" is set.

Thank you very much!

Dongli Zhang

On 3/30/20 8:14 PM, Dongli Zhang wrote:
> The slub_debug is able to fix the corrupted slab freelist/page. However,
> alloc_debug_processing() only checks the validity of current and next
> freepointer during allocation path. As a result, once some objects have
> their freepointers corrupted, deactivate_slab() may lead to page fault.
> 
> Below is from a test kernel module when
> 'slub_debug=PUF,kmalloc-128 slub_nomerge'. The test kernel corrupts the
> freepointer of one free object on purpose. Unfortunately, deactivate_slab()
> does not detect it when iterating the freechain.
> 
> [ 92.665260] BUG: unable to handle page fault for address: 00000000123456f8
> [ 92.671597] #PF: supervisor read access in kernel mode
> [ 92.676159] #PF: error_code(0x0000) - not-present page
> [ 92.681666] PGD 0 P4D 0
> [ 92.684923] Oops: 0000 [#1] SMP PTI
> ... ...
> [ 92.706684] RIP: 0010:deactivate_slab.isra.92+0xed/0x490
> ... ...
> [ 92.819781] Call Trace:
> [ 92.823129]  ? ext4_htree_store_dirent+0x30/0xf0
> [ 92.829488]  ? ext4_htree_store_dirent+0x30/0xf0
> [ 92.834852]  ? stack_trace_save+0x46/0x70
> [ 92.839342]  ? init_object+0x66/0x80
> [ 92.843729]  ? ___slab_alloc+0x536/0x570
> [ 92.847664]  ___slab_alloc+0x536/0x570
> [ 92.851696]  ? __find_get_block+0x23d/0x2c0
> [ 92.856763]  ? ext4_htree_store_dirent+0x30/0xf0
> [ 92.862258]  ? _cond_resched+0x10/0x40
> [ 92.866925]  ? __getblk_gfp+0x27/0x2a0
> [ 92.872136]  ? ext4_htree_store_dirent+0x30/0xf0
> [ 92.878394]  ? __slab_alloc+0x17/0x30
> [ 92.883222]  __slab_alloc+0x17/0x30
> [ 92.887210]  __kmalloc+0x1d9/0x200
> [ 92.891448]  ext4_htree_store_dirent+0x30/0xf0
> [ 92.896748]  htree_dirblock_to_tree+0xcb/0x1c0
> [ 92.902398]  ext4_htree_fill_tree+0x1bc/0x2d0
> [ 92.907749]  ext4_readdir+0x54f/0x920
> [ 92.912725]  iterate_dir+0x88/0x190
> [ 92.917072]  __x64_sys_getdents+0xa6/0x140
> [ 92.922760]  ? fillonedir+0xb0/0xb0
> [ 92.927020]  ? do_syscall_64+0x49/0x170
> [ 92.931603]  ? __ia32_sys_getdents+0x130/0x130
> [ 92.937012]  do_syscall_64+0x49/0x170
> [ 92.940754]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Therefore, this patch adds extra consistency check in deactivate_slab().
> Once an object's freepointer is corrupted, all following objects starting
> at this object are isolated.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  mm/slub.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6589b41d5a60..c27e2d993535 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2082,6 +2082,20 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>  		void *prior;
>  		unsigned long counters;
>  
> +		if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
> +		    !check_valid_pointer(s, page, nextfree)) {
> +			/*
> +			 * If 'nextfree' is invalid, it is possible that
> +			 * the object at 'freelist' is already corrupted.
> +			 * Therefore, all objects starting at 'freelist'
> +			 * are isolated.
> +			 */
> +			object_err(s, page, freelist, "Freechain corrupt");
> +			freelist = NULL;
> +			slab_fix(s, "Isolate corrupted freechain");
> +			break;
> +		}
> +
>  		do {
>  			prior = page->freelist;
>  			counters = page->counters;
> 
