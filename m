Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EB1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967E0222C3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXd6sjDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgB2WGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 17:06:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54373 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgB2WGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 17:06:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id z12so7271323wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 14:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zEk8G7Cl/+5CWZ371T9rRGys+VePLgRQkSGZWONW6/U=;
        b=lXd6sjDe5VKrBvndMtfMSg1AEc0IqixzU5D2hAKtPrWEwfxJN5CRMtUYLXGhMvL5RA
         OAPbSmTnL2mYRJ6fJAPE49aYzbiVOdsxkvsPsmGFeP2djSI6UKHaObg+ZOca9cYdjuKb
         2rwt+3UkpNHcebaSPDtVNwdnRQlCZKp1W11RjGC3hHmfzGfeZy9HXuN485ulXubFWV11
         h7O14LsfLcjz94gCcymsYt2vAOc7KL0L46seJojDXKaoBlOKAaylJG9D69TUdvOILUd2
         N72Q8sxwj3mxMQ8CP1WBzdUuG7i7goZV/Zg2jj8ewSp7X605YyEqj0nVX60eA1F7gosU
         wMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zEk8G7Cl/+5CWZ371T9rRGys+VePLgRQkSGZWONW6/U=;
        b=ki2KALkCk+220KsNanZlWZE/EsZmJAfYZcBfThqZoCd9mEF8dBjzPG19ZAlML4tZDX
         pQ92weviiJH56qaBn2+9X9Ngs0hTYq4U/1w+aJvHtzLncA1oY3ur3eGUeKNwkAu3oZK3
         gzvKjGZPjN26cR1wZr648XGmd3YkSJHX4zM40kj/SL3Irwt8egQLZXL5SiN83lMfITAn
         AIY9k0bvca8IjG33IIMnJxFBslUC+NxsdV2sUsD/WYhTHQD+ayig6laU72P6ZLA+7O6W
         yUJU/DIj9ZG8PlknUXy84UinyGmlXlaFBspprU5ewTqOcygnvWrX9DdfVP4nZ820/oRp
         1ZhA==
X-Gm-Message-State: APjAAAUw2fydmd1oIDhb24QVXTyzK2ift5heIzapKzKtw/tGVHFDDzTC
        lZK9C2auPIAHmJs5m634MOM=
X-Google-Smtp-Source: APXvYqyWhDKoU0+UsWjoPJ3HY1TPyKuSZG26Z/oTeAwLb7pSHDFlRqbenAnPvCmi73erWq5DGxiZJA==
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr10597236wmg.29.1583013975664;
        Sat, 29 Feb 2020 14:06:15 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j15sm19740498wrp.9.2020.02.29.14.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 14:06:14 -0800 (PST)
Date:   Sat, 29 Feb 2020 22:06:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/swapfile.c: simplify the scan loop in
 scan_swap_map_slots()
Message-ID: <20200229220613.oyryopfshe6juvro@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200229131537.3475-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229131537.3475-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 01:15:37PM +0000, Wei Yang wrote:
>After commit c60aa176c6de8 ("swapfile: swap allocation cycle if
>nonrot"), swap allocation is cyclic. Current approach is done with two
>separate loop on the upper and lower half. This looks a little
>redundant.
>
>>From another point of view, the loop iterates [lowest_bit, highest_bit]
>range starting with (offset + 1) but except scan_base. So we can
>simplify the loop with condition (next_offset() != scan_base) by
>introducing next_offset() which makes sure offset fit in that range
>with correct order.
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>CC: Hugh Dickins <hughd@google.com>
>---
> mm/swapfile.c | 26 +++++++++-----------------
> 1 file changed, 9 insertions(+), 17 deletions(-)
>
>diff --git a/mm/swapfile.c b/mm/swapfile.c
>index 95024f9b691a..42c5c2010bfc 100644
>--- a/mm/swapfile.c
>+++ b/mm/swapfile.c
>@@ -729,6 +729,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
> 	}
> }
> 
>+static unsigned long next_offset(struct swap_info_struct *si,
>+				 unsigned long *offset)
>+{
>+	if (++(*offset) > si->highest_bit)
>+		*offset = si->lowest_bit;

Hmm... I found one potential problem here. If someone has eaten the lower
part, (si->lowest_bit > scan_base), we would fall into infinite loop.

Will wait for some comment before sending v2.

>+	return *offset;
>+}
>+
> static int scan_swap_map_slots(struct swap_info_struct *si,
> 			       unsigned char usage, int nr,
> 			       swp_entry_t slots[])
>@@ -883,7 +891,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
> 
> scan:
> 	spin_unlock(&si->lock);
>-	while (++offset <= si->highest_bit) {
>+	while (next_offset(si, &offset) != scan_base) {
> 		if (!si->swap_map[offset]) {
> 			spin_lock(&si->lock);
> 			goto checks;
>@@ -897,22 +905,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
> 			latency_ration = LATENCY_LIMIT;
> 		}
> 	}
>-	offset = si->lowest_bit;
>-	while (offset < scan_base) {
>-		if (!si->swap_map[offset]) {
>-			spin_lock(&si->lock);
>-			goto checks;
>-		}
>-		if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
>-			spin_lock(&si->lock);
>-			goto checks;
>-		}
>-		if (unlikely(--latency_ration < 0)) {
>-			cond_resched();
>-			latency_ration = LATENCY_LIMIT;
>-		}
>-		offset++;
>-	}
> 	spin_lock(&si->lock);
> 
> no_page:
>-- 
>2.23.0

-- 
Wei Yang
Help you, Help me
