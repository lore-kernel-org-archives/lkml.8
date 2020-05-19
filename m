Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC55C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E3B207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sVtKbz3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgESORu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:17:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD20C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:17:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x27so11257633lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mWWNzaJ6aadJRf1QFTChwqkLpf881oiKsjs+B5iCpiA=;
        b=sVtKbz3dFm7JJ+4o9RJkGMA+xm3lb5olhuxmRlMiIJHoDts73nT0uNGnDnql1XSb4A
         rGTOzxF1VcTz0Vns5OX/imIvtmd8meIJJDkhmppMt2jhh66nllqGjluI6lFY4I/M9XV2
         F5XOB8YaCvbQVDSkHV3W0OT7mIdMkaMhqPQiPfirX1oI47k3fIBs0FkOOycomCeUcXUK
         CcERAfpXaiP0OsgwWPgdBqYiYfv6tI+9/vL4qqFmLgCmHmtyT/XdQw9pHPjYi1t8VEFs
         uIP+1WzgjJHAPZk5seCNpFuyqcaNhvEhepRXV98agrK+CZZoJe5AC29/PBwPrfPH/xNs
         Rrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWWNzaJ6aadJRf1QFTChwqkLpf881oiKsjs+B5iCpiA=;
        b=soXGZrnRevv9+UYZauafw9UKcoS0dFOqE0zAuFygQ5x/VH7NgrpSofSsTBnGzOh0iB
         ubvjvsvOA4opbZ3vK/YIM/wl5N9k2nHNJrWlVTWPrtnh9mnvreM8qnyh8t3o5VzdHMwi
         +MEPE5MC0VCQlaROtrJPEpqZ0LTu5A/CzT6RYVAbK7UZpcvTJGEHBes30o924Pl2ImPa
         lUQvX4f5QplGGs5KrAP6TbzP2ARUdAIgzRFtGz40BQEkQiA+jjl/59iGnyiykFaIXo3K
         z5kvjShtIt6PMsU1kdLFHqg60ZJMymrFjVIGN1HczRDygPzmhPJ6s7SxFJJKAqP2LFFw
         Ar3g==
X-Gm-Message-State: AOAM530wrhnh2EpxU+P3Qt4XX3glz5u3af9Mu92RurDs7L6Ath2X2byy
        hr5wOPWz4rfzNWn+hO0oYHA7jg==
X-Google-Smtp-Source: ABdhPJyGF61MKUstHJxSUEoyoJAB/XlAyvn9NmDc7nTeaMLFkIhtmgypy4CmxmB3UtrJfdG0mqAWKg==
X-Received: by 2002:a05:6512:d1:: with SMTP id c17mr8550220lfp.80.1589897866023;
        Tue, 19 May 2020 07:17:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e19sm2326397lja.19.2020.05.19.07.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 07:17:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8A0EA101E8B; Tue, 19 May 2020 17:17:44 +0300 (+03)
Date:   Tue, 19 May 2020 17:17:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC linux-next PATCH] mm: khugepaged: remove error message when
 checking external pins
Message-ID: <20200519141744.ppj7umkzghs72lk7@box>
References: <1589317383-9595-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200518101956.z6wwjyhv2oxfsqf6@box>
 <27847895-92de-062f-8021-b1140e4421cb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27847895-92de-062f-8021-b1140e4421cb@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 07:04:40PM -0700, Yang Shi wrote:
> 
> 
> On 5/18/20 3:19 AM, Kirill A. Shutemov wrote:
> > On Wed, May 13, 2020 at 05:03:03AM +0800, Yang Shi wrote:
> > > When running khugepaged with higher frequency (for example, set
> > > scan_sleep_millisecs to 0), the below error message was reported:
> > > 
> > > khugepaged: expected_refcount (1024) > refcount (512)
> > > page:ffffd75784258000 count:511 mapcount:1 mapping:ffff968de06c7421 index:0x7fa288600
> > >   compound_mapcount: 0
> > >   flags: 0x17fffc00009003c(uptodate|dirty|lru|active|head|swapbacked)
> > >   raw: 017fffc00009003c ffffd7578ba70788 ffffd7578bdb5148 ffff968de06c7421
> > >   raw: 00000007fa288600 0000000000000000 000001ff00000000 ffff968e5e7d6000
> > >   page dumped because: Unexpected refcount
> > >   page->mem_cgroup:ffff968e5e7d6000
> > > 
> > > This is introduced by allowing collapsing fork shared and PTE-mapped
> > > THPs.  The check may run into the below race:
> > > 
> > > Assuming parent process forked child process, then they do
> > > 
> > > 	CPU A		CPU B			CPU C
> > > 	-----		-----			-----
> > > Parent			Child			khugepaged
> > > 
> > > MADV_DONTNEED
> > >    split huge pmd
> > >    Double mapped
> > > 			MADV_DONTNEED
> > > 			  zap_huge_pmd
> > > 			    remove_page_rmap
> > > 			      Clear double map
> > > 						khugepaged_scan_pmd(parent)
> > > 						  check mapcount and refcount
> > > 						  --> total_mapcount > refcount
> > > 			      dec mapcount
> > > 
> > > The issue can be reproduced by the below test program.
> > Good catch! Thanks. And the fix looks reasnable.
> > 
> > We might want to have a similar debug check in near !is_refcount_suitable()
> > case in __collapse_huge_page_isolate(). The function is called with
> > anon_vma lock taken on write and it should prevent the false-positive.
> 
> However it seems MADV_DONTNEED path doesn't take anon_vma lock.

That's true. I missed that.

> > 
> > Anyway:
> > 
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Thanks.
> 
> > 
> > > ---8<---
> > > void main()
> > > {
> > >          void *addr;
> > >          int ret;
> > >          pid_t pid;
> > > 
> > >          addr = memalign(ALIGN, 2 * 1024 * 1024);
> > >          if (!addr) {
> > >                  printf("malloc failed\n");
> > >                  return;
> > >          }
> > > 
> > >          ret = madvise(addr, 2 * 1024 * 1024, MADV_HUGEPAGE);
> > >          if (ret < 0) {
> > >                  printf("madvise failed\n");
> > >                  return;
> > >          }
> > > 
> > >          memset(addr, 0xdeadbeef, 2 * 1024 * 1024);
> > > 
> > >          pid = fork();
> > > 
> > >          if (pid == 0) {
> > >                  /* Child process */
> > >                  ret = madvise(addr + (2 * 1024 * 1024) - 4096, 4096, MADV_DONTNEED);
> > >                  if (ret < 0) {
> > >                          printf("madvise failed in child\n");
> > >                          return;
> > >                  }
> > >                  sleep(120);
> > >          } else if (pid > 0) {
> > >                  sleep(5);
> > >                  /* Parent process */
> > >                  ret = madvise(addr, 2 * 1024 * 1024, MADV_DONTNEED);
> > >                  if (ret < 0) {
> > >                          printf("madvise failed in parent\n");
> > >                          return;
> > >                  }
> > >          } else {
> > >                  printf("fork failed\n");
> > >                  return;
> > >          }
> > > 
> > >          sleep(120);
> > > }
> > > ---8<---
> > > 
> > > So, total_mapcount > refcount seems not unexpected due to the inherent
> > > race.  Removed the error message even though it is protected by
> > > CONFIG_VM_DEBUG since we have to live with the race and AFAIK some
> > > distros may have CONFIG_VM_DEBUG enabled dy default.
> > > 
> > > Since such case is ephemeral we could always try collapse the area again
> > > later, so it sounds not harmful.  But, it might report false positive if
> > > the page has excessive GUP pins (i.e. 512), however it might be not that
> > > bad since the same check will be done later.  I didn't figure out a
> > > simple way to prevent the false positive.
> > > 
> > > Added some notes to elaborate the race and the consequence as well.
> > > 
> > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > ---
> > >   mm/khugepaged.c | 24 +++++++++++++++++-------
> > >   1 file changed, 17 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 1fdd677..048f5d4 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -602,12 +602,6 @@ static bool is_refcount_suitable(struct page *page)
> > >   	if (PageSwapCache(page))
> > >   		expected_refcount += compound_nr(page);
> > > -	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
> > > -		pr_err("expected_refcount (%d) > refcount (%d)\n",
> > > -				expected_refcount, refcount);
> > > -		dump_page(page, "Unexpected refcount");
> > > -	}
> > > -
> > >   	return page_count(page) == expected_refcount;
> > >   }
> > > @@ -1341,7 +1335,23 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
> > >   			goto out_unmap;
> > >   		}
> > > -		/* Check if the page has any GUP (or other external) pins */
> > > +		/*
> > > +		 * Check if the page has any GUP (or other external) pins.
> > > +		 *
> > > +		 * Here the check is racy it may see totmal_mapcount > refcount
> > > +		 * in some cases.
> > > +		 * For example, one process with one forked child process.
> > > +		 * The parent has the PMD split due to MADV_DONTNEED, then
> > > +		 * the child is trying unmap the whole PMD, but khugepaged
> > > +		 * may be scanning the parent between the child has
> > > +		 * PageDoubleMap flag cleared and dec the mapcount.  So
> > > +		 * khugepaged may see total_mapcount > refcount.
> > > +		 *
> > > +		 * But such case is ephemeral we could always retry collapse
> > > +		 * later.  However it may report false positive if the page
> > > +		 * has excessive GUP pins (i.e. 512).  Anyway the same check
> > > +		 * will be done again later the risk seems low.
> > > +		 */
> > >   		if (!is_refcount_suitable(page)) {
> > >   			result = SCAN_PAGE_COUNT;
> > >   			goto out_unmap;
> > > -- 
> > > 1.8.3.1
> > > 
> > > 
> 

-- 
 Kirill A. Shutemov
