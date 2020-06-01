Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27383C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021952077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXmbS5NV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgFAO3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:29:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbgFAO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591021759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IDTwPNf3l6SEVDe9cErj295Q0DZm/J2XzLe6GU6mFfk=;
        b=HXmbS5NVhGVZ0u8mIW+tsg2IJ8om+NOTOXuFOLfmUGcWHUVkQdvhq5nleM5BUob0nyo2JA
        4TZbWbvitKjzzzgSEJcxOwOkgZfYeQSGzVjRWdytP91ghGPIhupMof5sEaxoixH00/bclI
        ktpFfSVCxJ5m1E5wz5xuumP1yk3pjqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-P8WcvFC1N9OSsCWw6rx2GQ-1; Mon, 01 Jun 2020 10:29:15 -0400
X-MC-Unique: P8WcvFC1N9OSsCWw6rx2GQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 944B1835B43;
        Mon,  1 Jun 2020 14:29:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE26610AB;
        Mon,  1 Jun 2020 14:29:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 051ET8id023708;
        Mon, 1 Jun 2020 10:29:08 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 051ET8q5023704;
        Mon, 1 Jun 2020 10:29:08 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 1 Jun 2020 10:29:08 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     snitzer@redhat.com, agk@redhat.com, prarit@redhat.com,
        tyu1@lenovo.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH] dm writecache: reinitialize lru in writeback instead of
 endio
In-Reply-To: <20200530091250.58420-1-yehs2007@zoho.com>
Message-ID: <alpine.LRH.2.02.2006011022220.23428@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200530091250.58420-1-yehs2007@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 May 2020, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> When wc_entry has been removed from wbl->list in writeback, it will
> be not used again except waiting to be set free in writecache_free_entry.
> 
> That is a little of annoying, it has to reinitialize lru of wc_entry
> in endio before calling writecache_free_entry.
> 
> Using list_del_init instead of list_del in writeback for simpler code.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

This patch doesn't fix anything, so I think we don't need it.

Actually, it's better to keep the list entry uninitialized, because it 
helps us catch bugs where this uninitialized list entry could be used 
improperly.

Mikulas

> ---
>  drivers/md/dm-writecache.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 7bbc21b..66f3a3b 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -1519,7 +1519,6 @@ static void __writecache_endio_pmem(struct dm_writecache *wc, struct list_head *
>  			e = wb->wc_list[i];
>  			BUG_ON(!e->write_in_progress);
>  			e->write_in_progress = false;
> -			INIT_LIST_HEAD(&e->lru);
>  			if (!writecache_has_error(wc))
>  				writecache_free_entry(wc, e);
>  			BUG_ON(!wc->writeback_size);
> @@ -1555,7 +1554,6 @@ static void __writecache_endio_ssd(struct dm_writecache *wc, struct list_head *l
>  		do {
>  			BUG_ON(!e->write_in_progress);
>  			e->write_in_progress = false;
> -			INIT_LIST_HEAD(&e->lru);
>  			if (!writecache_has_error(wc))
>  				writecache_free_entry(wc, e);
>  
> @@ -1654,7 +1652,7 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
>  	while (wbl->size) {
>  		wbl->size--;
>  		e = container_of(wbl->list.prev, struct wc_entry, lru);
> -		list_del(&e->lru);
> +		list_del_init(&e->lru);
>  
>  		max_pages = e->wc_list_contiguous;
>  
> @@ -1685,7 +1683,7 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
>  			if (!wc_add_block(wb, f, GFP_NOWAIT | __GFP_NOWARN))
>  				break;
>  			wbl->size--;
> -			list_del(&f->lru);
> +			list_del_init(&f->lru);
>  			wb->wc_list[wb->wc_list_n++] = f;
>  			e = f;
>  		}
> @@ -1712,7 +1710,7 @@ static void __writecache_writeback_ssd(struct dm_writecache *wc, struct writebac
>  
>  		wbl->size--;
>  		e = container_of(wbl->list.prev, struct wc_entry, lru);
> -		list_del(&e->lru);
> +		list_del_init(&e->lru);
>  
>  		n_sectors = e->wc_list_contiguous << (wc->block_size_bits - SECTOR_SHIFT);
>  
> @@ -1732,7 +1730,7 @@ static void __writecache_writeback_ssd(struct dm_writecache *wc, struct writebac
>  			wbl->size--;
>  			f = container_of(wbl->list.prev, struct wc_entry, lru);
>  			BUG_ON(f != e + 1);
> -			list_del(&f->lru);
> +			list_del_init(&f->lru);
>  			e = f;
>  		}
>  
> -- 
> 1.8.3.1
> 

