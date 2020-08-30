Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4960C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAC4208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598814855;
	bh=mivJbD+ChOtFH1WtsUT+cOarh8njFtEDV3CxY85h69k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fxH3qG8FLQCjdjbovie6rQ9YtJrymJZ8q7KRsLlTzjDjKkT+GjlhZANL8M0QUEEKl
	 3EenDdCcfkv0cX1QkrYGTvfTnLnSX4rrEVx1aGGSgpzDyAhf8kZPR4p7v4Fb8EnIfl
	 dFbElaW+Nsw6TillceyKQEXvFJ1T9+c8gWGG4MHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgH3TOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3TOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:14:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7C5C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 12:14:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y17so2315348lfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Er/ysSVLApe2TafEStK5jwZq09OdahrxrGqPS35wwr8=;
        b=GHOBSZXpJijEPNTKQ8ip7rst1gs6ib2mzalcShPJ2zz+tyN8t6TLNogGTIHdkl2GlB
         FyUAUtx6GX9Zyf4/Vb/UIIMvqKysRtZpkBcFMXtlkrAY9Q4I6/EaPC8aUta/VcIgBGsH
         PZlmmf806jora7Nx+2D/M4ta6UGtD2aZOizdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Er/ysSVLApe2TafEStK5jwZq09OdahrxrGqPS35wwr8=;
        b=RD0wlELOt4k1HThtD8JQQWk+m1aYTo+XETkRt+PfYVK/eI+A7mTTP8IKJqMbeXocO2
         YZ5EAbnDk4lV5+Af5FEhHd+pV5i1gw/2sBjYtnLaj7jHhBTK9VPcYaEN6nUaVhmso5ht
         mjVnO3D83nYEQQEISUXVSh10Rn2fhZl4q9WBX+4ONNBmCOm4DIktLKc6jFApUqQBAq0W
         o/Ks8pCANWl+gI/3M/9CqDBuzKS+2vdnZLTFHLVIMfXFPWIwo68TV8gW07zFfRwlyZSA
         lBE7X+cC4ZLsWnsF6GmtIClQkAtNqf5HkXi6SPzZdXV4dlC11ayyeiOG/kxb4+vB0A0w
         64Fw==
X-Gm-Message-State: AOAM533PMLSWvCjveibATVK53ijFrhGe7CC1dkwXuwUQmWvH04Lhnih/
        7GY2hwwcUyOM0GV03JHeCHs3Y0PctRt5GA==
X-Google-Smtp-Source: ABdhPJz1mvZJd88D9R3pg6pssW8voKAo+FVypicPFdwN3SiErARS1mZEG57fJ9nEq06H1cyLJoD+9w==
X-Received: by 2002:a19:5214:: with SMTP id m20mr3333725lfb.138.1598814846748;
        Sun, 30 Aug 2020 12:14:06 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g19sm1103100ljn.91.2020.08.30.12.14.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 12:14:06 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r13so4328076ljm.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 12:14:05 -0700 (PDT)
X-Received: by 2002:a05:651c:219:: with SMTP id y25mr2806066ljn.314.1598814845525;
 Sun, 30 Aug 2020 12:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <159881061564.27993.11909051048930389391.tglx@nanos> <159881061925.27993.10669865438175129325.tglx@nanos>
In-Reply-To: <159881061925.27993.10669865438175129325.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Aug 2020 12:13:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj16dFx2Mx1oO2oxhJjAmsaPOqLcGvEGb86-z+v5iu5tw@mail.gmail.com>
Message-ID: <CAHk-=wj16dFx2Mx1oO2oxhJjAmsaPOqLcGvEGb86-z+v5iu5tw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 11:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    The historical inconsistent for_each_cpu() behaviour of
>    ignoring the cpumask and unconditionally claiming that CPU0 is in the
>    mask struck again. Sigh.

I guess we could remove the UP optimizations these days. It's not like
they matter like they used to.

Or leave the optimizations in the sense that they wouldn't do the
crazy bit searching, but they could look at bit 0 of the mask they're
passed..

              Linus
