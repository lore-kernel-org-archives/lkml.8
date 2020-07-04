Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 03:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7CF207D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 03:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593831989;
	bh=dLFz4z5Hzt4bJX90vRV/NevUStBviXV2OCble3+BSRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YCy5cOLJMikrSRwSLSczTsl+YAKY3oGZRCj0h6AJS7qJGq3NPry7DXUNNY/+9QDl1
	 XF7eegf75PxUCRMJreVFvIDaOYBMbCTGDGhWgXNirAHUWCexUXllRBeqOKH7dGcBSm
	 7k282XpRKk5oaxSTjr4FOJLgsgihWqu4naYwy2+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgGDDGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 23:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGDDGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 23:06:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB893C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 20:06:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so4798758ljb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 20:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UG4D45IGvmPqWscTI03JmD9b95WYlSr/vxzeTQecpNs=;
        b=OFliIcc6JNYrXG67+Czse3+riioZN7JmepQcVtBmDtleLZBHTMX/zeeeF0WeF6tuCi
         0IWXWfM8I7NzAEGfwrlEm0UTwIhp1oRAcR6VAP9M2fmSj1kJO2RGM/3SddS3RngrSQG1
         8HBZGD7bn16gdo1ixBsBJFDQJia9jiXQN1bq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG4D45IGvmPqWscTI03JmD9b95WYlSr/vxzeTQecpNs=;
        b=VZtT2DSscHt4dOxNvkqkNM180xkLNMkaH7NLeAo72kaHlFW/cGdiWw8XW3PIrxpxnC
         ItYGQW49+o5zULzq4Rupk43vruJr8z7oEPhEOBA64YqY7NselFMxVT1b+xbaCGONEa1P
         a28JY9kv5xDxPrsMuTkhTOm/XFTz6moobI175wbZJb06095XkLZqtqLbGCnGeUtjQYBu
         CBNPE9tNaH5/XdHH54q5HZRrGefmz4vV2opkc1vdkkVNlKcVi9ZXELMpgMeBrevZvpXJ
         m8R06ENVWkcg16gQVIkZ/YD22veW52HP0ckjxx7l6imp/vH+NsuvEmuI9yha+RuxVNIz
         swBw==
X-Gm-Message-State: AOAM530cqiO+00T/YDopj15W6qAyOCoYUf7wY3wDEcAXOpLHP00jnjrT
        +OIipV3oj9wV1SpahtL9z4zZv09GdUM=
X-Google-Smtp-Source: ABdhPJzW/KTCVkBZleV4CwfeaINVat2hVbV6+IfPG29fOuKtCQu1QCY8EQ5GaWOEz4dm82GKkTB8XA==
X-Received: by 2002:a05:651c:118f:: with SMTP id w15mr21735124ljo.211.1593831979976;
        Fri, 03 Jul 2020 20:06:19 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id l4sm1065430ljc.83.2020.07.03.20.06.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 20:06:19 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id h19so39075867ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 20:06:18 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr6880848ljc.285.1593831978454;
 Fri, 03 Jul 2020 20:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <87lfk26nx4.fsf@mpe.ellerman.id.au> <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk> <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk> <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk> <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <20200704004959.GY2786714@ZenIV.linux.org.uk> <CAHk-=whxLURD=qsF3ijmQYxGRPSyjS8_zoxZz-AsD-7tmRBM0w@mail.gmail.com>
 <20200704023009.GA2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200704023009.GA2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jul 2020 20:06:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDUxjUsKWiJArffxRX6iMoj=uVG0yfywx+kYMhL-4bxw@mail.gmail.com>
Message-ID: <CAHk-=whDUxjUsKWiJArffxRX6iMoj=uVG0yfywx+kYMhL-4bxw@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 7:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Lovely...  So basically this is the rare place where we might use those
> insns on userland addresses?

Honestly, I think the code you quote is just confused.

First off, we have special "is this page fault due to a prefetch"
logic in the x86 page fault handler anyway.

Second, we probably shouldn't have those prefetches there in the first place.

Sp I think the nasty code is likely just pointless and legacy. It may
exists simply because that case was the first time somebody noticed
the prefetch errata and it triggered in kernel mode. Who knows..

I'd be inclined to remove all the prefetching code from that csum
thing entirely. Most good CPU's do better prefetch pattern detection
in hardware than we can do in software.

                 Linus
