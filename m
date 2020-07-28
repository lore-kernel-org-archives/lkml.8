Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B046C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C050207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyumjyR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgG1N5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:57:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60609 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726764AbgG1N5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595944619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfTc1Sd6o29rE/cL2xWa+D8N0CUv3nwmUtcS2HIpsf4=;
        b=eyumjyR+kdaQbwLKZnpainUZ6yqCXVqojQLs2sahjK6/KoAKWZn6syRjGGBLHUWhmzmmaM
        Z6PNBJ6t1NVmNaUMZFda8qJPSHVa06w8wSR/XZB3LQtNKBWN2Wb2QpcBC3NHsOGTrr1ZMt
        kt037SfPhuYaY1hJSERpOz8iw9gcpws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-hcivNEh2MGC1nzKRmhLHDg-1; Tue, 28 Jul 2020 09:56:55 -0400
X-MC-Unique: hcivNEh2MGC1nzKRmhLHDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17FA0800460;
        Tue, 28 Jul 2020 13:56:54 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C9E575543;
        Tue, 28 Jul 2020 13:56:45 +0000 (UTC)
Date:   Tue, 28 Jul 2020 21:56:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/6] mm/page_isolation: don't dump_page(NULL) in
 set_migratetype_isolate()
Message-ID: <20200728135641.GD14854@MiWiFi-R3L-srv>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630142639.22770-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/20 at 04:26pm, David Hildenbrand wrote:
> Right now, if we have two isolations racing, we might trigger the
> WARN_ON_ONCE() and to dump_page(NULL), dereferencing NULL. Let's just
> return directly.
> 
> In the future, we might want to report -EAGAIN to the caller instead, as
> this could indicate a temporary isolation failure only.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index f6d07c5f0d34d..553b49a34cf71 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -29,10 +29,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	/*
>  	 * We assume the caller intended to SET migrate type to isolate.
>  	 * If it is already set, then someone else must have raced and
> -	 * set it before us.  Return -EBUSY
> +	 * set it before us.
>  	 */
> -	if (is_migrate_isolate_page(page))
> -		goto out;
> +	if (is_migrate_isolate_page(page)) {
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +		return -EBUSY;

Good catch, the fix looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

> +	}
>  
>  	/*
>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
> -- 
> 2.26.2
> 
> 

