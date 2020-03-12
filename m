Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA1C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E67206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpxD3GkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCLNcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:32:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33129 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbgCLNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:32:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id f13so6459863ljp.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phv583KHgmBN6ZIVEZQJosCjBmDR5QWY1wYtWrk+Juk=;
        b=ZpxD3GkJmXvns9f57dn2keS/VYDG/MpB5ltln4W+Yas9UvW5h9zULypVP8+Qpi8im0
         LBQ0oZYOBeo3jY6AujhmlRTFWPIqsbSMj0C7aW13Bl/puSyQydSV1j+AmdjUGuJ/zmU3
         6MiP4hudPrZ2helO0ort+5942twdvOeeESml0HEx8vPU2GoUQRZ3cjOVEYQY99s7x52A
         KwaaBPfJZQxrW1Ct7OsWDnZfoTGBiMxfwMfS76PN9vpz80ARipO2RKYPaCgOvSBFUF/A
         rmnibzWIgMUS0U08nZ6tpcayypdAp0x6tQdmUOWO8A5sfOa7fYgZK4DYPrz56+aHb9eX
         9ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phv583KHgmBN6ZIVEZQJosCjBmDR5QWY1wYtWrk+Juk=;
        b=cawtlDYzCoNcPYpEWezLPGAZbTEvrq90h4Ru5lM9kwLXGnDxWKcJRtuVNc4HqBfI7W
         rb+/DJ2wnBCTvsk6GkHdI9xn/TxYuR8fxY7BEjiKW5zgbZHF0xZLxk4qPsEpaANM3A0T
         25CLH+djN+5WShvNLVQlQB3HYFr1slnN7KIXCK+dUMcBzERHcT4995MSr9e2WKhmSHlV
         0gsPss9atmweSTLcgyzua7IwtW1eSCiJeuGgexiTQZI0IniCgmNd0+dIegJJLSjpFn3u
         EGJmVSTUo12c64uxOUR951qPzxurjVwCNHclJH8gi1LeZpd9MjCF1INIiNXtktRVbWNI
         lMAg==
X-Gm-Message-State: ANhLgQ2LQf1J2X7VwAknI2S6Re7hf9qY6Mpkxmk/kr9RvutB0Fhapjkm
        ihMzYRc2QiGYZAFk+90buTXacbmi/grxQRRCNhNV/JLzhZGoBw==
X-Google-Smtp-Source: ADFU+vuIYXztVHLH+xsxSsMmMMXpQW+CFPyPa/bMdKIHfiqTcj9pSicijGhKiAHkEGcfLbtDx9szdwkIKD9offP2dO0=
X-Received: by 2002:a05:651c:1026:: with SMTP id w6mr5020478ljm.168.1584019918638;
 Thu, 12 Mar 2020 06:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200123210242.53367-1-hdegoede@redhat.com> <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
In-Reply-To: <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 14:31:47 +0100
Message-ID: <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com>
Subject: Re: [tip: irq/core] x86: Select HARDIRQS_SW_RESEND on x86
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:42 PM tip-bot2 for Hans de Goede
<tip-bot2@linutronix.de> wrote:

>         select GENERIC_GETTIMEOFDAY
>         select GENERIC_VDSO_TIME_NS
>         select GUP_GET_PTE_LOW_HIGH             if X86_PAE
> +       select HARDIRQS_SW_RESEND

Just help me understand the semantics of this thing...

According to the text in KConfig:

# Tasklet based software resend for pending interrupts on enable_irq()
config HARDIRQS_SW_RESEND
       bool

According to
commit a4633adcdbc15ac51afcd0e1395de58cee27cf92

    [PATCH] genirq: add genirq sw IRQ-retrigger

    Enable platforms that do not have a hardware-assisted
hardirq-resend mechanism
    to resend them via a softirq-driven IRQ emulation mechanism.

so when enable_irq() is called, if the IRQ is already asserted,
it will be distributed in the form of a software irq?

OK I give up I don't understand the semantics of this thing.

Maybe it's because I think of a register where the IRQ line
is just a level IRQ bit thing that stays high as long as the IRQ
is not handled.

So I suppose it is for any type of transient IRQ such as
edge triggered that happened before the system came back
online entirely and now the only remnant of it is a bit in
the irchip status register?

I see that ARM and ARM64 simply just select this. What
happens if you do that and why is x86 not selecting it in general?

Explain it to me and I promise to patch kernel/irq/Kconfig
with the explanation so you don't have to give it again.

Yours,
Linus Walleij
