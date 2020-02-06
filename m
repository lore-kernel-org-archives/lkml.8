Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77223C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B77B214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4URz717"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgBFGRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:17:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38257 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBFGRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:17:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so5672415wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 22:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pob0crvk+bFSNi+7NzU1uAYzHzvw+xluiXIfFVGQQvY=;
        b=K4URz717ISLejVb4wNysW+YXWdx+KzvpjXNMHbx/MKwN7FKka1YdxDnyOk9e/ykZEB
         sqaJ6/GHFHOLSGg96AMXLqtWLB6L1fjNg44dSDQpqsBPGTJDqgSoALtbfADZUrIaeUgV
         XFAc1ScYxJZCo/Ohnlm6zrmrpzwwcg2GKiEtyhFNqaoD6kzTCiZ6+cjvtxk/b+NlB2zV
         JG45R5b4vTDPt4mj0v4tnmWi/vI955iNyZ5/Xa+KdnGxmZ4tX+K84+5rQiaRYJk0tmKg
         XVwq5Zi8c2TSuWsQPzmcwSdgnwNDKOnw1+g2yQpu+5Zo3mgBOJeo//cTB7f+eI3+aI7R
         wnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pob0crvk+bFSNi+7NzU1uAYzHzvw+xluiXIfFVGQQvY=;
        b=mi6Sf/AFoNX7UZlWyq3g+ilL/z+UNfwQlqdOUiHJteKLRB/K/oiTvg4FMR8MHVpJjC
         oPZ0Jcet6lat9wf9D6yu2lZm52YVJdAYVM7Nb7P7LCLzsh7tel0d4LUZr12EV9DNNgYI
         kitOtjlJRP/dkdtoAthwItCk4SgozeCRMwYJzwstNjI9fNTttAip7LDhn/QXzUtUqa2H
         tRfBNRkXDvXCF+6QJAAr9eHoViXKo+TwqA9xWIoRgnenNAfeJH0MJH7gKvWZMxVXVS7K
         USwRNkbkNLnb7NqHZWSsdj25QVcORkJlC4yHo71hqDsU8utnHxlC7JsQYv98+R7Vd32v
         VhVg==
X-Gm-Message-State: APjAAAUedIh+vrS990VBy3wVfAMddbg1lz01OShYGspUHnpXhWnMFnLF
        9H3YN3NJbhasq34LqHKqM00=
X-Google-Smtp-Source: APXvYqwTLHQvq8dKx7gcXsdDFu4ciVrTaZgfQEsNQh9NpckWMDytxoedgsK/TUPVY50RM/UzY9aQvg==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr1782167wru.173.1580969819032;
        Wed, 05 Feb 2020 22:16:59 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v12sm2846122wru.23.2020.02.05.22.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 22:16:58 -0800 (PST)
Date:   Thu, 6 Feb 2020 06:16:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, mhocko@suse.com, osalvador@suse.de
Subject: Re: [PATCH] mm/hotplug: Adjust shrink_zone_span() to keep the old
 logic
Message-ID: <20200206061658.uhhsglozzqojd7yr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206053912.1211-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206053912.1211-1-bhe@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 01:39:12PM +0800, Baoquan He wrote:
>In commit 950b68d9178b ("mm/memory_hotplug: don't check for "all holes"
>in shrink_zone_span()"), the zone->zone_start_pfn/->spanned_pages
>resetting is moved into the if()/else if() branches, if the zone becomes
>empty. However the 2nd resetting code block may cause misunderstanding.
>
>So take the resetting codes out of the conditional checking and handling
>branches just as the old code does, the find_smallest_section_pfn()and
>find_biggest_section_pfn() searching have done the the same thing as
>the old for loop did, the logic is kept the same as the old code. This
>can remove the possible confusion.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> mm/memory_hotplug.c | 14 ++++++--------
> 1 file changed, 6 insertions(+), 8 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 089b6c826a9e..475d0d68a32c 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -398,7 +398,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
> static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 			     unsigned long end_pfn)
> {
>-	unsigned long pfn;
>+	unsigned long pfn = zone->zone_start_pfn;
> 	int nid = zone_to_nid(zone);
> 
> 	zone_span_writelock(zone);
>@@ -414,9 +414,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 		if (pfn) {
> 			zone->spanned_pages = zone_end_pfn(zone) - pfn;
> 			zone->zone_start_pfn = pfn;
>-		} else {
>-			zone->zone_start_pfn = 0;
>-			zone->spanned_pages = 0;
> 		}
> 	} else if (zone_end_pfn(zone) == end_pfn) {
> 		/*
>@@ -429,10 +426,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 					       start_pfn);
> 		if (pfn)
> 			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
>-		else {
>-			zone->zone_start_pfn = 0;
>-			zone->spanned_pages = 0;
>-		}
>+	}
>+
>+	if (!pfn) {
>+		zone->zone_start_pfn = 0;
>+		zone->spanned_pages = 0;
> 	}
> 	zone_span_writeunlock(zone);
> }
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
