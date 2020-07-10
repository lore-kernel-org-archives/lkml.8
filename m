Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A61C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE45B2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C016bLjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGJQCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:02:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FA8C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:02:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j11so7044805ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dP/Cwrj374IdB7UlLTFuDEBsi+Cb3XJB3iKosVI1sUk=;
        b=C016bLjS1iSmlTj0cYHyYgpPqWoY/JAMQZDnD7WVqXT+pAak4ctDI2JY5PrUCGEqjQ
         kK1fGu7t89n/K2qg2s0gtOMBRkEH4Gux1s7dsDRhKk8lkH3i0vAs+rdiFO6xBSDOqp72
         MiuNlhIBNiLc6XYJgQY1TRcEIm6QIoZsFQtuImstn9NX9d/xjTVXRbm5A+W66VrnUjNA
         oTskdRfKYWp5HN6JqO0FzrYzjTURpSMwqj4S2IntcSUJ8C+j2dRGORfVgAod0hF5t8oY
         U5JvZb1Zx66ljOmk9sECCvq3zuZ+EyViOSvG1wYgBRDMgwDb888R3tqYosDQzX4f3vAk
         D3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dP/Cwrj374IdB7UlLTFuDEBsi+Cb3XJB3iKosVI1sUk=;
        b=qGVKJPqO9d9P7qN0B0VGwhFOuDiwDS+5VZ0a5Ehika5E9uZ1QBszpsqySIkY0PqHUh
         lGQAmaZSeQJ5FTEn+2oPTqC49HCmKNkTDpbrSG2VZjUbHnoyjEk0BZAbH+xTYers7O9L
         KpX5SYmpW3BdA6Hx+Yz/WTBSBoNRYO+swUEw5Qn4DiOe1x8wn3538kkoPsVVvsHYtsDP
         UK22mc+PE/Vuwo4LV3G6Hdj/g1yQIxRTNuWwaENEJYzStlxsGUKngJBq+LqhLbiVY2xX
         Cv/giS3rTmLKSukX0YWFoJgQvhzBTAneWmkhFpsszA7msK3vCjB3jrjBl+nwLnYiFwLF
         7dMw==
X-Gm-Message-State: AOAM532+jFDLLkPKJ/v/e927yNxjesTNgE00yRaJtH7VpZC5npArFK28
        12mhiuqDVVSqeP5FYNIH20FrXmEImjbuF/qQE64o1A==
X-Google-Smtp-Source: ABdhPJxrjkl/SqLB51dbIteb5teAD4c/1Mys6FI12CCbyigPoK1IQmofSn+hyrV2N/0Fs+ibrYIikoRo5cMZoGwR1cY=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr26850311ljg.100.1594396959423;
 Fri, 10 Jul 2020 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Jul 2020 18:02:28 +0200
Message-ID: <CACRpkdax9wSFtYxyCu18bWwc5T1GqNx7EDVA6JN+Qu42hOCh_A@mail.gmail.com>
Subject: Re: [PATCH v2] CodingStyle: Inclusive Terminology
To:     Dan Williams <dan.j.williams@intel.com>
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

On Wed, Jul 8, 2020 at 9:40 AM Dan Williams <dan.j.williams@intel.com> wrote:

> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
>
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Chris Mason <clm@fb.clm>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

An interesting piece on the topic is Douglas R. Hofstadter's
satirical "A Person paper On Purity in Language" from 1985,
which is funny, witty, Jonathan Swift-like and at one point
convinced me on the importance of proper language in
my professional work.
http://www.cs.virginia.edu/~evans/cs655/readings/purity.html

Thanks,
Linus Walleij
