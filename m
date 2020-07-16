Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331DBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB1C20775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Ycw6kDBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGPIqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgGPIqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:46:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5256C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:46:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b11so456917lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bCC4Mo9K3VF01NtlTfFZEG+9hWwFt1H0Qp6ndqIsiwU=;
        b=Ycw6kDBxvy+1hQHj8/FEH/4U7ljQ25EreUCaL8gvHBx79vA4SVG7pi1ofaKXig142P
         Gv4HHcbCIl7RuiW+f6NYdmQ18/KM9+d6WPB3wsltKZM/LHLdCq4EyEaSjSy2kASMEmNd
         UButTqENhwLwFBBan8sW2USiTgE6HsycZxDMUEqXEhq1hNS1IFzcUxBQ/SHQ/4nSdMC8
         ol/m2fyHdFtlPPWvoYWBOenk3RLLYvhDA6+nd+VPnVB+gzGDVHFcJZz6wXcsevOmmK7j
         TG9IlfdqD3qQ+cxBN7CkGBrTKDah/jOIKq8qc3Ty8euWFfetsHaS5lGuEBZvSo5NzgEg
         A08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCC4Mo9K3VF01NtlTfFZEG+9hWwFt1H0Qp6ndqIsiwU=;
        b=TpU/s9V/qtSDj0vnJR+RjZkthDldMNNuoOjuQY2wkGDye65sVe/HlaV1qYJM68d5Dc
         z8fLBWzEb0c+BW19+T/0Lxb6UFUeLxjRtbXiz3N0TxMUMvZqTRm2/4dcS+cwIGCyfQu0
         1yqkq3SIDHrjRJyll+gXxuvWx8+si0/qZmR6Qsnkr2lObznHIdN3N4vpTm5LRm4P7hDk
         cCOcWltIBoisc0YZ7Eo4lwspWChXqavU2w5hJUjqfBNhXTWFgMuxzqdH3ohh+qOcvBFA
         Sp36JBu+a68j9FH0CtaU/0xc8jXgB04n18oy+fzlcViyW0N8GDNjz9KJZ8lpkfV1ID1R
         5LzQ==
X-Gm-Message-State: AOAM532gWnexSuYpNccna4r3zBQ6j5PylOx1jAMu705h9L8zYs/DbvNn
        f5cMOseuJGSO0LiOiTQ97C5g5A==
X-Google-Smtp-Source: ABdhPJz8inNJN8d4cqC6GtP6eT65CJ32H8/x2tA708d+Q20Njn2roHvF8GceCd/xwIpo0KKI8jOrAg==
X-Received: by 2002:a19:4a96:: with SMTP id x144mr1571683lfa.213.1594889206222;
        Thu, 16 Jul 2020 01:46:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y188sm1242637lfc.36.2020.07.16.01.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:46:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B0BE91020FF; Thu, 16 Jul 2020 11:46:51 +0300 (+03)
Date:   Thu, 16 Jul 2020 11:46:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
Message-ID: <20200716084651.4457czjaszv3uprv@box>
References: <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com>
 <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box>
 <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
 <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
 <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
 <CA+G9fYsRcL1mcFhH47ek3YdGcK6sDSa+Gb0UoJzWkMcTsfxWdQ@mail.gmail.com>
 <CA+G9fYuO+ZHDbWR7fqfFoFj2HcSSmDYSBnQBm2FmY4Sj19Rg+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuO+ZHDbWR7fqfFoFj2HcSSmDYSBnQBm2FmY4Sj19Rg+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:53:23PM +0530, Naresh Kamboju wrote:
> On Thu, 16 Jul 2020 at 12:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Thu, 16 Jul 2020 at 04:49, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, Jul 15, 2020 at 4:04 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > It *might* be as simple as this incremental thing on top
> > >
> > > No, it needs to be
> > >
> > > +       if (*old_addr + *len < old->vm_end)
> > > +               return;
> > >
> > > in try_to_align_end(), of course.
> > >
> > > Now I'm going for a lie-down, because this cross-eyed thing isn't working.
> >
> >
> > Just want to double check.
> > Here is the diff after those two patches applied. Please correct me if
> > it is wrong.
> > This patch applied on top of Linus mainline master branch.
> > I am starting my test cycles.
> 
> Sorry this patch (the below pasted ) did not solve the reported problem.

As Linus said, it does not trigger on the stack movement anymore and it is
not going to fix the issue, but may help to increase coverage of the
optimization.

-- 
 Kirill A. Shutemov
