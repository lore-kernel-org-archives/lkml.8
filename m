Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1773C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B2B2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579117803;
	bh=EK9KrakNvlOHYpZa9EAN5/yi9ZbCkBVMJ6+BkKH/oEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HQziCnE1Rqf1JR8nfYpCvNclEtv5vFwx1sv+kdKHPFBOGSz+fWJ8F6y9zb8OrCt55
	 Ds3ROvE3iBnZHORHgFRnP1xlFw0UCPWGIe4O9kL1oS6L9+A+PnFFnKeaw4UYSCQ3wO
	 AozoTzJjky2lajitCnOGlzaVkT4CtnBaQNkXNcTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgAOTuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:50:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41749 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgAOTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:50:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so19900735ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5YJji0qsgvZEhJKmEybkUMk9F7tRfYQ2btF70jS2bQ=;
        b=Q3dtBuyAAYaVR6kphmaXQdQwAqXGs7+IXkxkA97uPulSCLsjbwLbDIpcd20aDV8CNF
         h6zeg+gwF07nqSczDspewMKk/CFEcITv26d5UJTH0S6cCJwGyeQ1fLw049up9t2GG2tL
         F/iGyp8+dSJcV2e9mBFerylantrs7S6j5879U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5YJji0qsgvZEhJKmEybkUMk9F7tRfYQ2btF70jS2bQ=;
        b=b7OnhTPNHeznjuPwXq0UI3ll4JDrjSUtkRbLg0YNLA8Y4PSLmsR06lliPaERprXwYZ
         w7oTrGETrcRvfmxHC+NvvWYZChINoLAEg77D2wj13IXuzBwipqtKV2qV4Lg4HmGQDsP4
         88g9x5ZX95UIFoAKlhXOxFU7mKbDG2pqsxgalQjdtzvuwSNiCHF0cR1ancmnh3TQ/n7F
         G9nDqRc8SEhNQsXseVdECGFRCPbPhfKn7+zOZf4VPkYo+QioDnrDrhyFHvvFVADRUQLg
         sUY0ZfvyGXufL6wQPFksD3vadRE6iUfsxl6W2DalkUFoGsTlCPd7dau6RdE0/2TeuMje
         6L2A==
X-Gm-Message-State: APjAAAV8d0yh8dPioMZbiaa2bZoG1f+Gtgc2rP14dCS0u0cn/LwcbqGp
        A3pChoAC+t3beRfTy2Yd6PaoM2lYkJQ=
X-Google-Smtp-Source: APXvYqx8BhebadrqWWtr1kvi//VfY9XtTABvUExSFjPyyEyRgt3blQpyxvH5mKaAGxBTaskUl0NyGQ==
X-Received: by 2002:a2e:9095:: with SMTP id l21mr26402ljg.175.1579117799929;
        Wed, 15 Jan 2020 11:49:59 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n3sm9444674lfk.61.2020.01.15.11.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:49:58 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id y6so19949234lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:49:58 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr37224ljo.41.1579117798263;
 Wed, 15 Jan 2020 11:49:58 -0800 (PST)
MIME-Version: 1.0
References: <CACMCwJLJCA2iXS0QMKKAWQv252oUcmfsNvwDNP5+4Z_9VB-rTg@mail.gmail.com>
 <5C216684-6FDF-41B5-9F51-89DC295F6DDC@amacapital.net> <CACMCwJLogOH-nG7QEMzrXK-iJPOdzCrL05y0a6yAbtPsfdRjsQ@mail.gmail.com>
In-Reply-To: <CACMCwJLogOH-nG7QEMzrXK-iJPOdzCrL05y0a6yAbtPsfdRjsQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jan 2020 11:49:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqPHc=BzSYO4N=awucq0td3s9VuBkct=m-B_xZVCgzBg@mail.gmail.com>
Message-ID: <CAHk-=wiqPHc=BzSYO4N=awucq0td3s9VuBkct=m-B_xZVCgzBg@mail.gmail.com>
Subject: Re: Fix built-in early-load Intel microcode alignment
To:     Jari Ruusu <jari.ruusu@gmail.com>, Ashok Raj <ashok.raj@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>, johannes.berg@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 11:15 AM Jari Ruusu <jari.ruusu@gmail.com> wrote:
>
> No problem at microcode load time.
> Hard lockup after 1-2 days of use.

That is "interesting".

However, the most likely cause is that you have a borderline dodgy
system, and the microcode update then just triggers a pre-existing
problem.

Possibly because of how newer microcode will have things like "VERW
now flushes CPU buffers" etc.

But it might be worth it if the intel people could check up with their
microcode people on this anyway - if there is _one_ report of "my
system locks up with newer ucode", that's one thing. But if Jari isn't
alone...

I don't know who the right intel person would be. There's a couple of
Intel people on the cc (and I added one more at random), can you try
to see if somebody would be aware of or interested in that "ucode
problems with i5-7200U (fam 6 model 142 step 9 pf 0x80)"

               Linus
