Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B000DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6960C20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfELUF82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMHTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMHTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:19:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932BDC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:19:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so4294633wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0PMpcfRppAoUGJncP235LdBlus/JCPWxzeDSjTFTxlk=;
        b=MfELUF82XrskD3PzSvsAJMactFaSuw711hoSLL/caEWjDdo1ppi5MqwMCH5ofNCeNC
         17eMZzrmh2oW1hiGQf4bZ2qC+5iriER7hBPocvX1YZ1+R7VTxLlGRFP/svc9KPgFAkac
         R9ciVJ9Y70LP3yeQR4lrpB8viFPGk5+Pef40iolEvg4Er7FVhO7wPJyJiymhtF5QINWT
         wogj4jpHt2KB4ZZJAYJ0PRlmdqjhQMnakBQbO1siKP6SoXyi8BFKNUPp4E5xEb8bJXkW
         FMePjYM4vGsDauWGPHRU8LBJ1CVsH5q2A27OQkcRfuLdtLmQ8Wf3LiVl3WRPHPIVR1q7
         lfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0PMpcfRppAoUGJncP235LdBlus/JCPWxzeDSjTFTxlk=;
        b=oy//JU3AAQEvDJS0Dq2rezVFL8cZ7rAS2m9rPC2NVbofRs0nhdiKRNODyHUHJw8oXO
         6wegkTUfxfj1YU83mMS5zagbyfPfBqU4znofeqz0K9sDk+zqq5li+oc7oRlbaM2c5a1L
         uXVv171pKx762vjRNw1hVUP3ADoe0hA9KHPdRNiLCLHyleeK0dsJioLKlgI1voT6Pj3X
         BtZJBLAE7dXjW7hP91I3b5Nq+ndnzP8taudepcUOdYjr0Sq/w6kdRigIUA5EKwW6xnRD
         WGAKdT42kpkeqWtFOPzukp0nCcdeE8iCjEAj9Iuh0Kv12wQv9Dl/fKwbOgt7gNsBlEbp
         idEg==
X-Gm-Message-State: AOAM5301dNAYcKJ/Pgo1TNsv5zwQ5gPU7mYB+jX/m+zc3Qlfr0ey6qY7
        L9FF/URUeBc7aZFhlYZfEfUTGTLLBfI=
X-Google-Smtp-Source: ABdhPJwibRCSqbRvEmB8kCB04uXuYUN9/LUiNxuC3m5/6SHLALRn7TFlTgaijieGwj0oQuYslhtWsg==
X-Received: by 2002:adf:f189:: with SMTP id h9mr2668931wro.122.1597303192314;
        Thu, 13 Aug 2020 00:19:52 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id g70sm8123214wmg.24.2020.08.13.00.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:19:51 -0700 (PDT)
Date:   Thu, 13 Aug 2020 08:19:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MFD for v5.9
Message-ID: <20200813071949.GG4354@dell>
References: <20200811074637.GG4411@dell>
 <CAHk-=wgF6Ld0-E0Ych_s=jyS4ssaabK08QR4NOzfRrde0LVHfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgF6Ld0-E0Ych_s=jyS4ssaabK08QR4NOzfRrde0LVHfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020, Linus Torvalds wrote:

> On Tue, Aug 11, 2020 at 12:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Enjoy!
> 
> No.
> 
> This causes new compiler warnings.

Hmm... that's frustrating.

Mea culpa.  Apologies for this.

As you know this is unheard of from me.
 
> I pulled, did a basic test-compile, and unpulled.
> 
> I refuse to pull garbage that hasn't even seen the most trivial build-test.
> 
> And no, "I built it but didn't check for warnings" is not a build
> test. That's just complete garbage. It's showing the code to the
> compiler, and not bothering to look at what the compiler said about
> it.

Let me give you my 'reason' (I know there is no 'excuse').

I've been grafting on an attempt to rid the kernel of W=1 warnings
this cycle.  Starting with MFD then working through Backlight, SCSI,
Regulator, RemoteProc, IIO, USB, Misc, Pinctrl, GPIO, etc etc, I've
managed to extinguish almost 3000 warnings to date.  I hope to do
something similar this cycle.

Anyway, I forgot to turn W=1 off when testing MFD.  I saw that there
were a couple of warnings, but I (stupidly) assumed that these were
just residue W=1 issues that I would clean-up next cycle.  Not
realising there were 2 real 'unused variable' problems present.

> You can try again next merge window, by now it's too late to send me
> completely untested garbage and try to fix it up.

Could I please urge you to reconsider.  The branch is well tested (in
-next, by private 'kernel test robot' tests and by extensive TuxBuild
testing).  I have cleaned up the offending line (it was just one line
causing the 2 new 'unused variable' issues) and all of my tests are
now passing (with W=1 turned off).  The branch also extinguishes well
over 100 W=1 warnings to boot.  It certainly does more good than
harm.

If you decide stick with your decision however, I'll also understand.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
