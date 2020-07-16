Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9039C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9F02076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Ys1XGUJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgGPNQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:16:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282ADC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:16:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so7133576ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T9nY5ELWY7Hl/4mK89mT6Hffvzqz77l+mjrXK+4ynVQ=;
        b=Ys1XGUJyEbffz3RZyvLHPAvT9FmvLOd+uNwPybZFWmza3ZzRa2f2kRxQ9iXNz7nlpR
         Gm+Un7oy2Md5t5oet8U4mnIH9ddT12CalQnopMHlqlF6Nq+yDi2RuEBJ5eVPCIVIncDf
         xSmEk+HxvqWMF8eA6V72vUrgBMXG1ijDJRzmodGxJSHszWsNa6LMxvb293UBdCjmg6Z0
         dwYq1m+ILgXyU7mvOEBpgaKJ5ofDt7tNMbrwHlIoskliMg1JsXpJd0TgFaoOWRxqFhce
         Q6s166R4rFrFutkHvgNJFFaTZP/d3pFm6gN0tDblWamFFRvkVCS1El0+yk0cKQ/LwPtp
         x6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T9nY5ELWY7Hl/4mK89mT6Hffvzqz77l+mjrXK+4ynVQ=;
        b=i5LaxkoXsfCT/Z2lqGkNY5aW9V+jFaM3EH6mM+Z1lwvXLnnQfY6nRC1+Yker8Ld6qx
         DndILu4m2xM0SAAXa2N4LHRYZGZsbhDrPZvLS+NnZYPUHxPj4YRxbUBMeFRYJms5lt50
         X/Nc2VzFYDtl0+5mDKNaLKglmSbIT5PqkMZJcLAF3e6b+oQWnJb+SGISRwOK+s1L7DES
         mR1jxKCFo1n3U3YG16W2b0vTQOvjQPVHzD/mxTcivmolNwF+3pX/ulSUOFg0/X03v3BT
         NKsgPlU20H/nA2vf6OPyLOl+VHqBwOccg2TvgpMrEdeALu2o4/udM7fRdAOFLIzD2dFu
         ppfw==
X-Gm-Message-State: AOAM531F1h5qmw5L1GBjqGeNlMLzgxUVQOSr7dcRyzDH5UCWKBETFWW3
        XN6NOx4xr4Z9DJjss8HRzgRdqw==
X-Google-Smtp-Source: ABdhPJy7gCv3dXr+UB5F9E/xopQ45tu8ynLN6cqlD5C82+ySh5tTdAe1bGFa3NQUUh+tatCmVle6eg==
X-Received: by 2002:a05:651c:1186:: with SMTP id w6mr1914641ljo.123.1594905367640;
        Thu, 16 Jul 2020 06:16:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z1sm1041337ljn.88.2020.07.16.06.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:16:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CFDE61020C1; Thu, 16 Jul 2020 16:16:12 +0300 (+03)
Date:   Thu, 16 Jul 2020 16:16:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
Message-ID: <20200716131612.b7ottczdgnxwdvrp@box>
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com>
 <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box>
 <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
 <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
 <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 04:18:44PM -0700, Linus Torvalds wrote:
> On Wed, Jul 15, 2020 at 4:04 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It *might* be as simple as this incremental thing on top
> 
> No, it needs to be
> 
> +       if (*old_addr + *len < old->vm_end)
> +               return;
> 
> in try_to_align_end(), of course.

Okay, this should work, but I'm not convinced that it gives much: number
of cases covered by the optimization not going to be high.

It can also lead to performance regression: for small mremap() if only one
side of the range got aligned and there's no PMD_SIZE range to move,
kernel will still iterate over PTEs, but it would need to handle more
pte_none()s than without the patch.

-- 
 Kirill A. Shutemov
