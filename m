Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA0820809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CghxhkW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgG2OGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:06:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgG2OGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+s1aLKBFRPjnluxTliPaIDMyp/xACsXQZl8tcf5fJM=;
        b=CghxhkW8cKC/rHEzeALW0GJ3wjQf/9Fbqm2wYaQiID3udd0efAgDSNVjYp3aNBhA98agmP
        5LunPFghk25/QzjpNToMpDoqlIZ62xVUXWz8+nAgTekowdxdkAEONkdv8BJYsPym090Ebi
        kSag19UjdoJiVgwvkClCeFMOT/CdG14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-e9Ns98V6MoS9qE0FM6HyeA-1; Wed, 29 Jul 2020 10:06:41 -0400
X-MC-Unique: e9Ns98V6MoS9qE0FM6HyeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D7DE6988A;
        Wed, 29 Jul 2020 14:06:34 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A100E71924;
        Wed, 29 Jul 2020 14:06:33 +0000 (UTC)
Date:   Wed, 29 Jul 2020 22:06:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 4/6] mm/page_isolation: cleanup
 set_migratetype_isolate()
Message-ID: <20200729140631.GH14854@MiWiFi-R3L-srv>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630142639.22770-5-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/20 at 04:26pm, David Hildenbrand wrote:
> Let's clean it up a bit, simplifying error handling and getting rid of
> the label.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 02a01bff6b219..5f869bef23fa4 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -17,12 +17,9 @@
>  
>  static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
>  {
> -	struct page *unmovable = NULL;
> -	struct zone *zone;
> +	struct zone *zone = page_zone(page);
> +	struct page *unmovable;
>  	unsigned long flags;
> -	int ret = -EBUSY;
> -
> -	zone = page_zone(page);
>  
>  	spin_lock_irqsave(&zone->lock, flags);
>  
> @@ -51,21 +48,20 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  									NULL);
>  
>  		__mod_zone_freepage_state(zone, -nr_pages, mt);
> -		ret = 0;
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +		drain_all_pages(zone);
> +		return 0;
>  	}
>  
> -out:
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -	if (!ret) {
> -		drain_all_pages(zone);
> -	} else if ((isol_flags & REPORT_FAILURE) && unmovable)
> +	if (isol_flags & REPORT_FAILURE)
>  		/*
>  		 * printk() with zone->lock held will likely trigger a
>  		 * lockdep splat, so defer it here.
>  		 */
>  		dump_page(unmovable, "unmovable page");
>  
> -	return ret;
> +	return -EBUSY;

Reviewed-by: Baoquan He <bhe@redhat.com>

