Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C32C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3A206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKo3K68q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgAPQ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:26:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26014 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbgAPQ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579191993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQlxSqbAz5Gg0CkQad070bTz8F2AX6/N+P9B7+hnGDo=;
        b=fKo3K68q54zdlfew/C5LpHN6rVj40ArTeHZSQ7mBl/cZH8h7SQhPfYmfctU/BkepHQvfdx
        jU3l/ckmBUSRaOD5CHxf1xl40507i7B6EVuJpP1X8rB3u3PfhEuPtrqwzQ1lMTg0fkaRI9
        xwfCjk8p0B0IgT2VZkzk1q6QPCHakrQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-0SksJhezMXOl6o633zV7og-1; Thu, 16 Jan 2020 11:26:31 -0500
X-MC-Unique: 0SksJhezMXOl6o633zV7og-1
Received: by mail-wr1-f71.google.com with SMTP id y7so9474317wrm.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LQlxSqbAz5Gg0CkQad070bTz8F2AX6/N+P9B7+hnGDo=;
        b=diqiyi6sFmyaH5cQ7g4qfeHWawCiJYKoFL8GG838nD6BCZr+D1fXY3au4xYS5R9TYN
         nJCRBHx79uXqS5lYwlJJM9z2YXsbAr+4E7G3Kzy2x3TMrWZlcV628t5rdlDa0V87TgRc
         BZUvzyoG7/16w3LlZGh5eGVy27hybPCfeq40YJhZpZa6vOpeoDfcwQA3GkpWW3AEVS3z
         aOl81mhOQSSCUlLCxdqRg7hBgM1ivDzxS+ShnEnulTAaCEdzkMoaXakHggqMyapxMX2p
         Ng9lN/hP2Htd5YYTxTc8gkNozzkeP3//Lf8UnQoa0eYjnFYNId9xY4h+7zNLcNQpSFPN
         RGOQ==
X-Gm-Message-State: APjAAAWOODjH5sIVyaey/+Usc1Fy9FWJLzLTIIXxwa03jkGSiScMAHUG
        G5Sr04Z8P2vCK78100zlYz9oLkYM4hTcTeu0+AldMhorWU+o5pqszgZToiwTFtHkYL54vy9FVTO
        /gD2ThWpBaD/qtbV2SRHC2Qvk
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr6855364wmk.172.1579191990296;
        Thu, 16 Jan 2020 08:26:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9EJwBuG6ODNlyZBGksf47bJ8nGES+4PVLl9IGi7RpL8xuA0/DC21LXggZnSo0PfYTMZWZmA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr6855343wmk.172.1579191990037;
        Thu, 16 Jan 2020 08:26:30 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t12sm29701964wrs.96.2020.01.16.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:26:29 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH V2] x86/Hyper-V: Balloon up according to request page number
In-Reply-To: <20200116141600.23391-1-Tianyu.Lan@microsoft.com>
References: <20200116141600.23391-1-Tianyu.Lan@microsoft.com>
Date:   Thu, 16 Jan 2020 17:26:28 +0100
Message-ID: <87tv4vgyff.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Current code has assumption that balloon request memory size aligns
> with 2MB. But actually Hyper-V doesn't guarantee such alignment. When
> balloon driver receives non-aligned balloon request, it produces warning
> and balloon up more memory than requested in order to keep 2MB alignment.
> Remove the warning and balloon up memory according to actual requested
> memory size.
>
> Fixes: f6712238471a ("hv: hv_balloon: avoid memory leak on alloc_error of 2MB memory block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v2:
>     - Change logic of switching alloc_unit from 2MB to 4KB
>     in the balloon_up() to avoid redundant iteration when
>     handle non-aligned page request.
>     - Remove 2MB alignment operation and comment in balloon_up()
> ---
>  drivers/hv/hv_balloon.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 7f3e7ab22d5d..536807efbc35 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1684,7 +1684,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
>  	if (num_pages < alloc_unit)
>  		return 0;
>  
> -	for (i = 0; (i * alloc_unit) < num_pages; i++) {
> +	for (i = 0; i < num_pages / alloc_unit; i++) {
>  		if (bl_resp->hdr.size + sizeof(union dm_mem_page_range) >
>  			HV_HYP_PAGE_SIZE)
>  			return i * alloc_unit;
> @@ -1722,7 +1722,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
>  
>  	}
>  
> -	return num_pages;
> +	return i * alloc_unit;
>  }
>  
>  static void balloon_up(union dm_msg_info *msg_info)
> @@ -1737,9 +1737,6 @@ static void balloon_up(union dm_msg_info *msg_info)
>  	long avail_pages;
>  	unsigned long floor;
>  
> -	/* The host balloons pages in 2M granularity. */
> -	WARN_ON_ONCE(num_pages % PAGES_IN_2M != 0);
> -
>  	/*
>  	 * We will attempt 2M allocations. However, if we fail to
>  	 * allocate 2M chunks, we will go back to PAGE_SIZE allocations.
> @@ -1749,14 +1746,13 @@ static void balloon_up(union dm_msg_info *msg_info)
>  	avail_pages = si_mem_available();
>  	floor = compute_balloon_floor();
>  
> -	/* Refuse to balloon below the floor, keep the 2M granularity. */
> +	/* Refuse to balloon below the floor. */
>  	if (avail_pages < num_pages || avail_pages - num_pages < floor) {
>  		pr_warn("Balloon request will be partially fulfilled. %s\n",
>  			avail_pages < num_pages ? "Not enough memory." :
>  			"Balloon floor reached.");
>  
>  		num_pages = avail_pages > floor ? (avail_pages - floor) : 0;
> -		num_pages -= num_pages % PAGES_IN_2M;
>  	}
>  
>  	while (!done) {
> @@ -1770,7 +1766,7 @@ static void balloon_up(union dm_msg_info *msg_info)
>  		num_ballooned = alloc_balloon_pages(&dm_device, num_pages,
>  						    bl_resp, alloc_unit);
>  
> -		if (alloc_unit != 1 && num_ballooned == 0) {
> +		if (alloc_unit != 1 && num_ballooned != num_pages) {
>  			alloc_unit = 1;
>  			continue;
>  		}

Thank you for addressing my comments on v1, this all looks good to me
now so:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

