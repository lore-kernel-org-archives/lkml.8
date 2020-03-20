Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F96F2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="tZugQz/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCTMiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:38:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45876 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCTMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:38:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so6526293qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUsFDDLc+OT1mxat4BydgprIPibf9UQTcm/vZqGE7Pg=;
        b=tZugQz/AH0shvqjYWaF1gAAwX+4ovdwCpMJMoGaKc3JPHNP4DA0wP2zsgC6Wc7fcg7
         6b/lkws0cqY8gp36RTo5o0CfaGP2IIcQy+DYVsoxd+wux++dbBa5aLZaeLXCvn6pqDX4
         FgHC2C8kyi7zTi7bMu5dulWZ6wSXCXhxLDDUK533HO0MZDS+kbxeuPXjJpp/F7DX93JL
         g3wBrf1xCYeBbUCQSoEUYQIrA0EszHphDJCTYduJhXi36Hynt6Az3btqPZrUFmEz7+Fx
         GOMEQYUDg01KIVTjvzayfXnA7mXXR76J+LjqCgO0nZg6b4+WcdsuuGzGFuz6G99yEIgf
         3nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUsFDDLc+OT1mxat4BydgprIPibf9UQTcm/vZqGE7Pg=;
        b=d5STttBQwcDtv8IlSBnBNlxkZ7GcL0PQ9kWMaLFtA4w8OKAnTipNp7h39Hkn99LNqx
         hqSF2DRblZUPxE3Hi6riABoY5OlRvcIqO7mpehifmClpvQckEnnQ2V95UbzrDs9vXBt0
         6Pv+TV/ynJv6JMI58DNOup0F2XKTW+dd/E8b28T5/5yVgFfs4aQvTV70GP/ms49cWrEM
         +8X+huhPU0L2poNHactlpIPxUuHh7qpHDolh8iRFJt6juwAA7ncgsH/wHldlyMYlrQcK
         QYBVVuOgujUDAJJzsKgcuhWqY6ljld7M68pobDLOURnM/pnRKClWzW6LLRhZNw/uJ9sK
         c1jg==
X-Gm-Message-State: ANhLgQ0WUVtTmqsDRrArqJaxNo52ygZ7Nkh9xx52TtkJdUh9SoOQqYWi
        KuVRQ1XzSRn5vJxaz6nnQY0W/5SUGSdWdW5D13MOEw==
X-Google-Smtp-Source: ADFU+vvDBQQsdYulrWhgu3FelWi5P2Ua5BYNVN5DgtEqXHnJH+UBtT1nfmzl6r7OJ12TSJdnY5SvrhtF8srk+gySCGk=
X-Received: by 2002:a37:51d5:: with SMTP id f204mr7674280qkb.14.1584707886141;
 Fri, 20 Mar 2020 05:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200312083341.9365-1-jian-hong@endlessm.com> <20200312104643.GA15619@zn.tnic>
In-Reply-To: <20200312104643.GA15619@zn.tnic>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 20 Mar 2020 20:37:54 +0800
Message-ID: <CAD8Lp47ndRqeS5VbkCMR_Faq-du9eDW28rHOG4Owxq862t-kGQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/reboot, efi: Use EFI reboot for Acer
 TravelMate X514-51T"
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 6:46 PM Borislav Petkov <bp@alien8.de> wrote:
> How do you know *everyone* affected will update their BIOS?
>
> And what's the downside of keeping it?

It could indeed be kept without user-visible downside, and that would
be the normal case for quirks that work around BIOS bugs.

But I had two reasons for suggesting that Jian-Hong should send this
revert patch, which may be worth some consideration:

 1. This was working around a BIOS bug truly separate from Linux to
the point where it was a little questionable for Linux to put a quirk
in place. The original bug was that after Linux completed executing
the reboot code, the machine would reboot, the BIOS would start
loading, and then crash well before loading the OS. Presumably
crashing on some state that Linux left that was not reset in the
machine's reboot stage. The vendor later found the issue (something
TPM-related) and fixed the BIOS to avoid the crash.
 2. We normally receive these units before they go into mass
production, so there's a decent chance that production versions
already include this BIOS fix.

Based on that I was considering that the patch could be reverted for
cleanliness/ At the same time, I do not have strong feelings on this,
no issues if the quirk is left in place.

Daniel
