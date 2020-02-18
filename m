Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78179C3403D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BC620658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rvM+uTtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBROQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:16:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44197 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgBROQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:16:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so23076923ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DrqryinCHE3R7/2tc3p+dbFE1V3J/tIWBiDcCxcBwPc=;
        b=rvM+uTtYcGhHZ+WHLx8oGBbpf1TICugbYiei2nvci6ZwQkMA9VZjYDMEfliNiJ7eb4
         2/VmsxdyYR1TPgRwPNKxJ9gj17sc1Fvn61NEBh7rzlOaCxPCCSgfVos8wJ/nsBmzS/i6
         JMTCQbN4wS3+XoSTG8Q+XlSxjfzXnSKAb68Rq1M8KMx+YI+5G4kPuw6FuM+CSscyjYgS
         AmMEz3Ow/16C/zWTxJV+MOSpHNgbXVKmIeBKyhrNBdtpAJTpC2kaYtjUkLKIpAZv3pm3
         gyuBowbTttkFmf9D0Ug45JowMXsEdT/gcWQfw5+Oq1YqVTo5uT85Z7PZY6YfAakSyiAq
         V3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DrqryinCHE3R7/2tc3p+dbFE1V3J/tIWBiDcCxcBwPc=;
        b=SGfqebUvtLH1Gu5NSnhg8Xw5RY7MXPT4mAQwDmamz083T1HEpLU6pb82f1CZhNU/+t
         oRWBxVHenjKVJbjq2yAp140V0eNUUUoXqC+RdFR/fKrjIeWKzpJTq5nPfZwT+NsTuata
         9xaqcTCBkv+k1+k16TjLHnhKkX0gfLcl5u+CkWAnMPJb/8nH8dAi7jlw36Tft/qtkdTu
         kMNXvP95QcA+LG/nArdewygC1FaEcV7d1rAFdncIArjj5JSxKai/EtTRMZYtR26yQWmP
         v/HeQI2AQ1TSyBzx7047hdrQYZv0CFNcknMLti91Y8D0xnQK+V0Ohl5XQYROjgtV+bDp
         vh4w==
X-Gm-Message-State: APjAAAXYeI/yMNjWB3pWPHx/pFpbtQoHDFDEIoMupe7+nypzu6QUJ1Tb
        1vV/5Y/jpDgA3ws3AkQkyILtlthyYfI=
X-Google-Smtp-Source: APXvYqzjNYwKgBp80JN3m6/5g5w6xv2WayWUy4GM1ntmp8uClVmyjfzC/fK+c2QkCKfLr3TMKpLlNw==
X-Received: by 2002:a2e:1459:: with SMTP id 25mr13376746lju.189.1582035367727;
        Tue, 18 Feb 2020 06:16:07 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o19sm2978073lji.54.2020.02.18.06.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 06:16:06 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 22631100FA3; Tue, 18 Feb 2020 17:16:34 +0300 (+03)
Date:   Tue, 18 Feb 2020 17:16:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/25] fs: Add zero_user_large
Message-ID: <20200218141634.zhhjgtv44ux23l3l@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-14-willy@infradead.org>
 <20200214135248.zqcqx3erb4pnlvmu@box>
 <20200214160342.GA7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214160342.GA7778@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:03:42AM -0800, Matthew Wilcox wrote:
> On Fri, Feb 14, 2020 at 04:52:48PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Feb 11, 2020 at 08:18:33PM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > We can't kmap() a THP, so add a wrapper around zero_user() for large
> > > pages.
> > 
> > I would rather address it closer to the root: make zero_user_segments()
> > handle compound pages.
> 
> Hah.  I ended up doing that, but hadn't sent it out.  I don't like
> how ugly it is:
> 
> @@ -219,18 +219,57 @@ static inline void zero_user_segments(struct page *page,
>         unsigned start1, unsigned end1,
>         unsigned start2, unsigned end2)
>  {
> -       void *kaddr = kmap_atomic(page);
> -
> -       BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
> -
> -       if (end1 > start1)
> -               memset(kaddr + start1, 0, end1 - start1);
> -
> -       if (end2 > start2)
> -               memset(kaddr + start2, 0, end2 - start2);
> -
> -       kunmap_atomic(kaddr);
> -       flush_dcache_page(page);
> +       unsigned int i;
> +
> +       BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
> +
> +       for (i = 0; i < hpage_nr_pages(page); i++) {
> +               void *kaddr;
> +               unsigned this_end;
> +
> +               if (end1 == 0 && start2 >= PAGE_SIZE) {
> +                       start2 -= PAGE_SIZE;
> +                       end2 -= PAGE_SIZE;
> +                       continue;
> +               }
> +
> +               if (start1 >= PAGE_SIZE) {
> +                       start1 -= PAGE_SIZE;
> +                       end1 -= PAGE_SIZE;
> +                       if (start2) {
> +                               start2 -= PAGE_SIZE;
> +                               end2 -= PAGE_SIZE;
> +                       }

You assume start2/end2 is always after start1/end1 in the page.
Is it always true? If so, I would add BUG_ON() for it.

Otherwise, looks good.

> +                       continue;
> +               }
> +
> +               kaddr = kmap_atomic(page + i);
> +
> +               this_end = min_t(unsigned, end1, PAGE_SIZE);
> +               if (end1 > start1)
> +                       memset(kaddr + start1, 0, this_end - start1);
> +               end1 -= this_end;
> +               start1 = 0;
> +
> +               if (start2 >= PAGE_SIZE) {
> +                       start2 -= PAGE_SIZE;
> +                       end2 -= PAGE_SIZE;
> +               } else {
> +                       this_end = min_t(unsigned, end2, PAGE_SIZE);
> +                       if (end2 > start2)
> +                               memset(kaddr + start2, 0, this_end - start2);
> +                       end2 -= this_end;
> +                       start2 = 0;
> +               }
> +
> +               kunmap_atomic(kaddr);
> +               flush_dcache_page(page + i);
> +
> +               if (!end1 && !end2)
> +                       break;
> +       }
> +
> +       BUG_ON((start1 | start2 | end1 | end2) != 0);
>  }
> 
> I think at this point it has to move out-of-line too.
> 
> > > +static inline void zero_user_large(struct page *page,
> > > +		unsigned start, unsigned size)
> > > +{
> > > +	unsigned int i;
> > > +
> > > +	for (i = 0; i < thp_order(page); i++) {
> > > +		if (start > PAGE_SIZE) {
> > 
> > Off-by-one? >= ?
> 
> Good catch; I'd also noticed that when I came to redo the zero_user_segments().
> 

-- 
 Kirill A. Shutemov
