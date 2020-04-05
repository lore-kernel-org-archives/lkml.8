Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D104DC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B3B206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586113570;
	bh=s7jBti/EYKWZ83qo1mm3BAAccCbtDGraRQ4InJtJJ0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2B6KKaVnDxAI77jOGzK+oH8cbtCBML7/JNXGUT5VoslloRvvi+QmLsN1dbl2Blkqp
	 Qv6PgBwA3EfgndiquKBf//KLAXcS1Sl2GMLqu6JWzeKymlKMb0pKG4Ll4fLMQc2nFU
	 6pO+FmwrvYW11mgfcR/LojMvukZsqxw1wu81M3XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgDETGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:06:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34645 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgDETGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:06:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10so12371909ljn.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7l5PKSkiUm5y5Anqut8GXd6/HQY32R9b8/6v8Yv3/Y=;
        b=hhFjiX6eAmiLO7UvcvHDqjKYw1HL5IRSCRPu+b4BSSUKyxCf+imtjMFsnCKSqMmJqW
         9vKgFehiVHLS6ZVYGiN4utBZNCIm+6UGEVvZApcqInJ6mEyDqPqFPLlhbxqASXf4RWoW
         ANf4gJxtxdldfM37Qw8jIuQIuGRp7ugkJBw+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7l5PKSkiUm5y5Anqut8GXd6/HQY32R9b8/6v8Yv3/Y=;
        b=rax/CGjhHTMCI+1K7RxBlWoxLOYZczH7eebKxhxUIzyZ5sKS74zJKAAWqif+sl/VpZ
         fiUfjvPCZsQB9C4ON7pgKcfG8cXYj0J/kuCJZM26CD9uvuoQPhxwgdJ64WjChqMIjgyS
         GOYCwQJGxZe2SPzhdhszVFD3j+Ocl1soFUxqKEoNRRkiUMujpHo3BK+6/6Zp/F6WKEIF
         +fwR7nllQ63xgGlZ493q62funNR81IG6v9vHdvvrW7UpnvEuR6k558U9bduCLDumWwWM
         ws3fBPqvJykzlgvIOBeGIUo5gWzMZE2NKZNVFIEBxp0SEAxzdlPyygJkCjFEyI2UWcrf
         7rCA==
X-Gm-Message-State: AGi0PuaEIgGAKe8I8uY75hDhrHbJOvJ63g6OtkW1Z+ldhvfeUqH6KiNW
        kW9/GIw30MoWEJyysiv1Ba+KFVTCZ1Y=
X-Google-Smtp-Source: APiQypJSVcPPXnyAoedC5yX+WWMGN4ywPaVOJtl4XkvBg5/4nq8rkdQxu+FEOkUBt0hZgxKV9EBlIQ==
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr10161745ljk.14.1586113565093;
        Sun, 05 Apr 2020 12:06:05 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y29sm8804011ljd.26.2020.04.05.12.06.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 12:06:04 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 19so12296325ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 12:06:03 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr10535760ljm.201.1586113563358;
 Sun, 05 Apr 2020 12:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
In-Reply-To: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Apr 2020 12:05:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wix=qQ79=fqgSy8Fc9jenRG8HoUp3VZs=Ek+PGz7d+13g@mail.gmail.com>
Message-ID: <CAHk-=wix=qQ79=fqgSy8Fc9jenRG8HoUp3VZs=Ek+PGz7d+13g@mail.gmail.com>
Subject: Re: [GIT pull] irq/urgent for 5.7-rc1
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 5, 2020 at 6:43 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Two reverts addressing regressions of the Xilinx interrupt controller
> driver which affected the PPC users.

Gah.

Those reverts don't actually say what was wrong with the commits.

The "breaks a number of PPC platforms" is not actually saying what
went wrong. Breaks how? Does it stop booting, does it not build, or
what?

And the link in it also is entirely useless.

This link _would_ have been useful:

  https://lore.kernel.org/linux-next/20200323175946.7ad497ea@canb.auug.org.au/

but that's not what is in the commit messages.

Please write _useful_ commit messages, not this completely worthless noise.

            Linus
