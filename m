Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7274BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B0520720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="isKdQKPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgGJQNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgGJQNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:13:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB30C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:13:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so6694111ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuTemQ7KYRFEUiSXBnnfVYEJAwLMSHFjzyXd2qUpBJM=;
        b=isKdQKPNlEDojcebZaIkUqT/0t9js4SLcA3mJCOcioV+3ATcqDxdJCxfd3ILcFOLZl
         tOpvnVcodD05qit011zarA1ggkgVfVB/d4xaBV61gDXqcNoMFLprTwjguRUNpThyMqMu
         PLeoxfuiYD6PlKu9hCxjjBVXvghQXzHmu0ZumROT5OsnGOCmp/D3KHgodO5B+HlQV/bg
         oHmKnl0wQA3PwOvL7o9tUKflDiU1CorxFe6/pjsSstrrmP7voSAFGFNLqT9anvtjtEFb
         VWqtGh9BTarWrZSz+pkTQqFks18quP+n6EtZwUo8oBZS84qr8b0L/WVkJrXHWuIx6JrO
         vRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuTemQ7KYRFEUiSXBnnfVYEJAwLMSHFjzyXd2qUpBJM=;
        b=QzwodrkiVOV+OtD/HBaohpeX4QcrmoilKvqoC7IyPEnpan0EtlALwIGnk96t4tu436
         Vbh4vA8xKA51Y03vqNrTty6FHyPGk23bgfQinvbSwEzXNn569GE6cDa8ZQrad0MiSurV
         pzg/lcesdp00afES2iTL0Z1mUeT17DOgkDhVGFAgbvUxj6AnXdaFYZRip0LqzCKoVNQ/
         KEwW9YC2ZoR3t29N1Fs1eYFu15islieFckyAD1ZrdabnOCKLD4ue2EZUIEhsZpfyWijR
         uoZv1DgZk3h6Mm4xyyiOsN2s0M4JeA+ie7B6Yzv3BzHtUZ0q/9susonJZA9w0ZW692iJ
         yxQQ==
X-Gm-Message-State: AOAM530MmowzDEUmFj22aCHWIuAbUqsWT+qc5xMXBO/ODglQZc/0mWn4
        p1SKR+ZLtyflJfKQBhor/xuN1MBPzYlq+Yqc6gPv5g==
X-Google-Smtp-Source: ABdhPJzCbKvo8U8scwvbkPOPP/8wbfKDhI1Qe8+dFjUDkLc3+GTw9TBaNPbuhtlMWViJabrxSULQvMydjEo4r5TzVxQ=
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr61467350ejb.174.1594397609098;
 Fri, 10 Jul 2020 09:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CACRpkdax9wSFtYxyCu18bWwc5T1GqNx7EDVA6JN+Qu42hOCh_A@mail.gmail.com>
In-Reply-To: <CACRpkdax9wSFtYxyCu18bWwc5T1GqNx7EDVA6JN+Qu42hOCh_A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jul 2020 09:13:17 -0700
Message-ID: <CAPcyv4jxnayrq6FKVkR-hCedm-XARd-wuQpFjfGVBg6j5ow0xw@mail.gmail.com>
Subject: Re: [PATCH v2] CodingStyle: Inclusive Terminology
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        SeongJae Park <sjpark@amazon.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 9:03 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jul 8, 2020 at 9:40 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Linux maintains a coding-style and its own idiomatic set of terminology.
> > Update the style guidelines to recommend replacements for the terms
> > master/slave and blacklist/whitelist.
> >
> > Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Acked-by: Dave Airlie <airlied@redhat.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > Acked-by: SeongJae Park <sjpark@amazon.de>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Chris Mason <clm@fb.clm>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Linus.

>
> An interesting piece on the topic is Douglas R. Hofstadter's
> satirical "A Person paper On Purity in Language" from 1985,
> which is funny, witty, Jonathan Swift-like and at one point
> convinced me on the importance of proper language in
> my professional work.
> http://www.cs.virginia.edu/~evans/cs655/readings/purity.html

...and thanks for that laugh.
