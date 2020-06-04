Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67696C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8B20679
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591233851;
	bh=lvvwEwYoa6H2w3Tilm3x0u0SrGQ4zicTydWuQn0aGIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xatfY7mwF3avPbtQRbJmrI65+sNyueR6Dlc3amNyEL2o+OVsySi/ViJYFJ8ggaWTF
	 DkgVt5lsTA/8TNUs/faadWVfv5RK4ARRD/lpQT4aTACXCV5ffPugFP+qWTbLbs5sKq
	 1V44R6CFMp/FSelJeRwW1OpufyRcEa0SZqApbzNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgFDBYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDBYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 21:24:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5B9C03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 18:24:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c12so2519357lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnqOYIUQo+qaj8w3g24MOT2Gco25LKdRH9nOfQU72t8=;
        b=UtdKeZmQ8xReEqzhYUDShUeXsTib84g3eRDLNMK7usyMbV4TBGM0vlhqgnEG9g57OY
         g6RH2h89oJKKLDLPjSogvRLpkY1UOHe+h5yfeawReCQqmn6/iMacwKP9WhjlmJi7gK38
         0/31CbOL/GGaaFwxJ46S/iu6T9fah2XuKCXYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnqOYIUQo+qaj8w3g24MOT2Gco25LKdRH9nOfQU72t8=;
        b=h5clZmErUEq1zy4cxttJu3HNt+3AeAmb6att/TXWnzUBQLMacwhXA6QKMjyjrkAyL6
         ru4ll1Ep6Oiwz9ukmRwcAt3RTw8mQMFbtvWduNWnAitpDS0aCFd1eBa3Z5lWraOFPtAG
         WrdkVrZ/sn/XNQQYww2x8rpi/m+CwYMT6wbPcbeCAW5EiQsmRlrt455/mZB/lSHrAe95
         PZvnR89vpiV4fdUWFlXueLY5a8KIS2f/9LGtP0slqXg+EAEfvXDEyoQmjThYkOoYHr1T
         xL/328b21/I4rae/Zq6dUUp5zGSIHIRc2jGAwtsIyA9Qmh86iN1FW0IBPbDykY9AQXw7
         TeEA==
X-Gm-Message-State: AOAM530dWN+SG/5kg6JnhnscyeFqu0euPPT7W+oz2MLwtOZv+BoJWd/b
        IOJr5xfp+L51okc7bqop+Hl5vGLLPLM=
X-Google-Smtp-Source: ABdhPJysb2BeqR6lJ7pQ9qh6dGvW2XBSxmIUjx6nIbLpRzQk0xhRO0XcLPQZHSBNvSIypys4wvCDVw==
X-Received: by 2002:a05:6512:2034:: with SMTP id s20mr1138323lfs.90.1591233845487;
        Wed, 03 Jun 2020 18:24:05 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k1sm1073029lja.27.2020.06.03.18.24.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 18:24:04 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 9so5159171ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 18:24:04 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr644861ljj.312.1591233844059;
 Wed, 03 Jun 2020 18:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200602125445.GA12527@alpha.franken.de> <CAHk-=whtew82tj8_QLPU-xqT702vmB0pGgQSuQkK_Javnz6PPw@mail.gmail.com>
 <b37df9de-adca-3639-bd11-b114ad2f1e76@loongson.cn>
In-Reply-To: <b37df9de-adca-3639-bd11-b114ad2f1e76@loongson.cn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 18:23:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiP68twiDi58hdgP7LrDeyTUrtFf=Kz0owF=X8i5AUTng@mail.gmail.com>
Message-ID: <CAHk-=wiP68twiDi58hdgP7LrDeyTUrtFf=Kz0owF=X8i5AUTng@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes for v5.8-rc1
To:     maobibo <maobibo@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 6:11 PM maobibo <maobibo@loongson.cn> wrote:
>
> On architectures that manage the access bit in hardware, access bit is
> set at the beginning even if there is no memory access. On MIPS system
> access bit is not set at the beginning, it is set in page fault handling.

I had a hard time parsing that.

But I think you mean that the access bit is already set in the pgprot
bits on other architectures. And yeah, you seem to be right for at
least x86.

So yes, it seems unnecessary to set the accessed bit again, when the
accessed bit is already there from the pgprot bits. Good point.

> I am investigating why access bit is not set at the
> beginning in MIPS system.

Yeah, that does seem to be the right thing to do.

On x86, we have (for example)

  #define PAGE_COPY            __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
..
  #define __P010  PAGE_COPY

where that "__A" bit is the accessed bit (_PAGE_ACCESSED), just a
small internal macro to make all those line up nicely.

And that ends up being used for that protection_map[] array.

MIPS fills in the initial protection bits in protection_map[] with
dummy values, and then seems to initialize them without ever setting
the accessed bit there.

Not sure why that initialization then doesn't just add the pte_mkyoung..

                Linus
