Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98343C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F53F2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhcWiaKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgB1N0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:26:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41855 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1N0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:26:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id v4so2919842wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3l+XVJLXhdwqxBw3BBK4v/KZHF0nIb1lLNrBLU24AE=;
        b=fhcWiaKiDQfLzC2qCFVmeJuphoSsdqLxx3OiO1/IAQ5QIP7XJg7iy63OTTlOe6pRrh
         lCmP2XB0xcWV4YBB4cOfPscRf1NtYc/B1tTXIdxH6ry6UUNu8b7kd35qgDtGrCJJn0zg
         0nkRuv4SmK842b1oR9RC84zwtpmPslGZyHZ4KFbec+lPgSljmhWhBAnIBSnMRHqv3ViK
         AoqyC4bx6Nkum+est8oYdwQk1fBOOBS+plsAprNzInv8/Cz3ZlgG11P23uw3bJvg7DIZ
         NVzUxYLy001190fclR6XdzmvO8McM09KD9rjby3dSvO/bamxSfA51NgSPt6omkENG6vN
         gabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3l+XVJLXhdwqxBw3BBK4v/KZHF0nIb1lLNrBLU24AE=;
        b=FWEcZVjcbjU9JqFhhXMaKcGzWqyC8VmuvPyoxdeAvrymjKHBnexTdrFbc9LZFrloPN
         xRmnEZkbhHu7/R2Vx0LGd16c9CS7/tI08A7Y/WYOt0/lhclgCnnbGKvZwLD2Yckkm47t
         nuHWK1AsZ9GU8TUr6X29YPmImvC4sy/LhO4NqZsEDDf0TNRCd5QK4fe/hmuEW5IV4Gv9
         /Q1nxahpiawNCZdzV2EIA4FkazBL2vV0PIE/OiO8m6PEByj9Uk6wlv8VJ9U30YfZ3ciX
         bTWN14hlp+p9ZUG5/5aUzXAM8TCpojCLpMn2W8FzwAxxFmuCpYd8OgSA+KY/2Z5e1CBd
         sFnQ==
X-Gm-Message-State: APjAAAXo3D/XgU2We1JUR4Nwqfb6ZdkTnYegwYNC92J2RUMzzTZh6ZoF
        AgK7sjXES0iej5gxW71E1f1AYJI8
X-Google-Smtp-Source: APXvYqyzs4nS44OqUvLS/a3DTAkP0RzBwmR2S23UBjUlmPzYW7f0o2cZzNPUc58bjcBnVZIgR7XFDQ==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr4603578wrw.383.1582896360638;
        Fri, 28 Feb 2020 05:26:00 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p15sm2194720wma.40.2020.02.28.05.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 05:26:00 -0800 (PST)
Date:   Fri, 28 Feb 2020 13:25:59 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of number
 of pages in __remove_pages()
Message-ID: <20200228132559.lbzci6eiwz52quhn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200228095819.10750-1-david@redhat.com>
 <20200228095819.10750-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095819.10750-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:58:18AM +0100, David Hildenbrand wrote:
>In commit 52fb87c81f11 ("mm/memory_hotplug: cleanup __remove_pages()"),
>we cleaned up __remove_pages(), and introduced a shorter variant to
>calculate the number of pages to the next section boundary.
>
>Turns out we can make this calculation easier to read. We always want to
>have the number of pages (> 0) to the next section boundary, starting from
>the current pfn.
>
>We'll clean up __remove_pages() in a follow-up patch and directly make
>use of this computation.
>
>Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/memory_hotplug.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 4a9b3f6c6b37..8fe7e32dad48 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -534,7 +534,8 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
> 	for (; pfn < end_pfn; pfn += cur_nr_pages) {
> 		cond_resched();
> 		/* Select all remaining pages up to the next section boundary */
>-		cur_nr_pages = min(end_pfn - pfn, -(pfn | PAGE_SECTION_MASK));
>+		cur_nr_pages = min(end_pfn - pfn,
>+				   SECTION_ALIGN_UP(pfn + 1) - pfn);
> 		__remove_section(pfn, cur_nr_pages, map_offset, altmap);
> 		map_offset = 0;
> 	}
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
