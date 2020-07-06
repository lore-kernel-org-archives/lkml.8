Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E348EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3A920715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqfQJx9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgGFPWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGFPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:22:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D561C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 08:22:13 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z2so29241196qts.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YjNPcHVR4dZuQjAwnCbOyRb8wX3jJIQelGpEqdSOhmU=;
        b=NqfQJx9/UQmjQac/3kK3ryP3Ko5MWUYbBlwCF+RmRpbkWFVZ0OBhlP9iLwKySU2Kr7
         4YwhOirQlU/zrt1k4wYgOru1DTP/o1cDcnX4o/ZVYu1l82SW3zbDdDImbGTuinS91+aV
         6J8BTh9+ARLSbdr3/rzRwJCq6omJxniJGg/hwi8cAnK2FoJXf0pmlSKRPeaRemduopAQ
         Z8AlOxO4tvCv4sJeQukxQbM66db7a+ukkzccWYWZLVv/dxETk6068p2rBguHU/jiki9z
         w4fs6al0Rbh8HkEHDSek9eMhk215nfX/3Y+uYm6dxOshAj1i+hRnGN0uSlIHRMFkTSFr
         gMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YjNPcHVR4dZuQjAwnCbOyRb8wX3jJIQelGpEqdSOhmU=;
        b=co5l+mQD4Q4luOEwo7bnIjdcd2V/taB3snQYVf8pUG0DViP+nmYhxcc3EFuwmX8reY
         5lXrOqjLyryREgB7zn00KNfB6xcUXQijtpTyBXyXtFVmEPZzLBj1YjtMh7j1wjjXdGPs
         bn+h9jZMf6PDGBjGBXHie1J6rn9vCR7QFcbu7NodrwZ+e6Rt7gvuO5Aw2Jcbz+0aQs89
         frt73JPDQi+V4BZLq426y+ygzXdZakhuZLsRTiiVImKXlUoA8X/ECt0NnSHS1MF5cuLp
         Mwm3SZMgqGPiaXKqmZlf3lqxxeJ6CvKawfD7OCBKcYNHEn0PgoGbtuPFllQAqXTeS7zt
         8lxA==
X-Gm-Message-State: AOAM530RolEno0XGbbKa4WNvcjlkiAw5keM6xBPcljUPQGiwfBpIiJJX
        Qpvb15brcdlOpiugcO7Cq7A=
X-Google-Smtp-Source: ABdhPJxkw84cvwqy/ty3RHScHDPgFI+Ze/xwqDPdTLEQrrz9k21XHGj8t3xRVdxIZLky0+sRkhPHBA==
X-Received: by 2002:aed:3bb8:: with SMTP id r53mr25496151qte.58.1594048932165;
        Mon, 06 Jul 2020 08:22:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m26sm21257149qtc.83.2020.07.06.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 08:22:11 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 6 Jul 2020 11:22:10 -0400
To:     Willy Tarreau <w@1wt.eu>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706152210.GA53508@rani.riverdale.lan>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705045505.GA2962@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200705045505.GA2962@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 06:55:05AM +0200, Willy Tarreau wrote:
> On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:
> > +Non-inclusive terminology has that same distracting effect which is why
> > +it is a style issue for Linux, it injures developer efficiency.
> 
> I'm personally thinking that for a non-native speaker it's already
> difficult to find the best term to describe something, but having to
> apply an extra level of filtering on the found words to figure whether
> they are allowed by the language police is even more difficult. *This*
> injures developers efficiency. What could improve developers efficiency
> is to take care of removing *all* idiomatic or cultural words then. For
> example I've been participating to projects using the term "blueprint",
> I didn't understand what that meant. It was once explained to me and
> given that it had no logical reason for being called this way, I now
> forgot. If we follow your reasoning, Such words should be banned for
> exactly the same reasons. Same for colors that probably don't mean
> anything to those born blind.

While I agree that using terms that can only be understood given a
cultural context that not everyone may share, I would think that better
examples would be references to movies/novels etc.

Though I'm not sure if blueprint translates literally into other
languages, it did actually have a logical reason, viz engineering
drawings used to be blue/white. But logical reasons don't have to exist.
In the case of colors, for example, using red-black tree doesn't exclude
blind people, precisely because there is no logical reason for using the
colors red and black, or even colors at all, so it's not as if you gain
any additional insight into the structure if you are able to see the
colors. It just needs _some_ arbitrary labels for distinguishing two
classes of nodes, it could just as well have been named A-B tree or 0-1
tree or whatever. I don't think there is any concise way to label them
that conveys anything useful about how they're used in the data
structure -- you just have to learn about the structure and how it's
used. This isn't the case with whitelist/blacklist, where those colors
actually have connotations about what the two lists mean.
