Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58825C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A98A20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="JZLurGrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbgGONmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgGONmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:42:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B693C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 06:42:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i80so1073384lfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SxxB4qbhw2tWNEvr88Pqt9cvKqwZuyme5Sh3lfJhB5Y=;
        b=JZLurGrNoBYQxciEUm87cgGqTsV5W49DaQV7e35/aDoZH6eIxdJu8vyg9dyV320WYl
         FJpzd9gZU+cOHEpGW0kGqZkz422JyA1uH1U/Q/Adb/jupijKqtOB8t91/s69FfCG+AvD
         tLJ1Xk/K4wreOJfXKFqZ425hRmW58P7f+iFDoUyVrt1bqwbfNacRpzRRexLSwXbVtNEs
         LN7b5lYzKIyDOwS4InTTTePYGOwsE3UXTlRlroYPA8t5p5v3S1oUm1SgPCS/vMZ40HYZ
         k1iVl2msTW8xyEHBJXlQMAL4dV96v9NFDM96Tmtwys39vZdyZtMcGtIc/1tu1C2rxpTy
         9Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SxxB4qbhw2tWNEvr88Pqt9cvKqwZuyme5Sh3lfJhB5Y=;
        b=m2eUnXO+TsLFyNn+vdyyJYfwLvcq1ns/iPbw9uzg95MYvKHM1BIZFY+noSIcQ7vArT
         5AmLKwHyF5/PhmCnZXB52CTpgZv7bUm/VLydydTf+jphu9C5bTTa0d+C/vWDhgP2s9Sq
         TbMrlr/cpElDkZDxLJ6EWFAbEZL19mS2JpJC1gruO0CR4Izh4MOqbV+slsLBCnZ2PYMJ
         bRa0beSikxhesoPrrX7y5oyhrDYMfjAn22pblWQ/XxSKCPa/B+Y8ymp6aj+ag/0oJLvp
         X8jZBwmA0lHQSRYph6jBC4HH/I5QGlpLWlQz2EtKMf4l94TADqR9UkCKpekETRKdle8Z
         hu7Q==
X-Gm-Message-State: AOAM531tjtqKxSFozDrFby+qyhfkm3+xb09j2z4hFUcbmNt3238MoJAM
        8hR9wqQGkgwnHH4x61Y847eyGQ==
X-Google-Smtp-Source: ABdhPJwFrBfWYTK+Q3wN2zFu2P8FuaHH7sb7oZGfLhfgtGrJScnlsn11reIleDOy2JwazRE6wYYnHQ==
X-Received: by 2002:a19:6b16:: with SMTP id d22mr4810925lfa.111.1594820530434;
        Wed, 15 Jul 2020 06:42:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j2sm461147lji.115.2020.07.15.06.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:42:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5B0EB10209F; Wed, 15 Jul 2020 16:42:14 +0300 (+03)
Date:   Wed, 15 Jul 2020 16:42:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH] mm: Fix warning in move_normal_pmd()
Message-ID: <20200715134214.qzkuxnfjszgty2oj@box>
References: <20200715123513.42240-1-kirill.shutemov@linux.intel.com>
 <20200715131451.GA2971370@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715131451.GA2971370@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 09:14:51AM -0400, Joel Fernandes wrote:
> On Wed, Jul 15, 2020 at 03:35:13PM +0300, Kirill A. Shutemov wrote:
> > mremap(2) does not allow source and destination regions to overlap, but
> > shift_arg_pages() calls move_page_tables() directly and in this case the
> > source and destination overlap often. It confuses move_normal_pmd():
> > 
> >   WARNING: CPU: 3 PID: 27091 at mm/mremap.c:211 move_page_tables+0x6ef/0x720
> > 
> > move_normal_pmd() expects the destination PMD to be empty, but when
> > ranges overlap nobody removes PTE page tables on source side.
> > move_ptes() only removes PTE entries, leaving tables behind.
> > When the source PMD becomes destination and alignment/size is right we
> > step onto the warning.
> > 
> > The warning is harmless: kernel correctly fallbacks to handle entries on
> > per-entry basis.
> 
> A link to the debugging effort could be added to the change log:
> https://lore.kernel.org/lkml/20200713025354.GB3644504@google.com/
> 
> > The fix is to avoid move_normal_pmd() if we see that source and
> > destination ranges overlap.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks.

> And one thing that bothers me:
> 
> >  mm/mremap.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 5dd572d57ca9..e33fcee541fe 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -245,6 +245,18 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  	unsigned long extent, next, old_end;
> >  	struct mmu_notifier_range range;
> >  	pmd_t *old_pmd, *new_pmd;
> > +	bool overlaps;
> > +
> > +	/*
> > +	 * shift_arg_pages() can call move_page_tables() on overlapping ranges.
> > +	 * In this case we cannot use move_normal_pmd() because destination pmd
> > +	 * might be established page table: move_ptes() doesn't free page
> > +	 * table.
> > +	 */
> > +	if (old_addr > new_addr)
> > +		overlaps = old_addr - new_addr < len;
> > +	else
> > +		overlaps = new_addr - old_addr < len;
> 
> Does the code really work properly if old_addr < new_addr and overlaps ==
> true ? If not, then we should add a warning here in the else IMHO:
> 
> 	if (old_addr >= new_addr) {
> 		overlaps = old_addr - new_addr < len;
> 	} else {
> 		overlaps = new_addr - old_addr < len;
> 		WARN_ON(overlaps);
> 	}
> 
> (More so, since you have added code that detects overlaps for such a case).

Right, I'll update. But we should warn for old_addr == new_addr too.
Nobody should do this.

> 
> thanks,
> 
>  - Joel
> 
> >  
> >  	old_end = old_addr + len;
> >  	flush_cache_range(vma, old_addr, old_end);
> > @@ -282,7 +294,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  			split_huge_pmd(vma, old_pmd, old_addr);
> >  			if (pmd_trans_unstable(old_pmd))
> >  				continue;
> > -		} else if (extent == PMD_SIZE) {
> > +		} else if (!overlaps && extent == PMD_SIZE) {
> >  #ifdef CONFIG_HAVE_MOVE_PMD
> >  			/*
> >  			 * If the extent is PMD-sized, try to speed the move by
> > -- 
> > 2.26.2
> > 
> > 
> 

-- 
 Kirill A. Shutemov
