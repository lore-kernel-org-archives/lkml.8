Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6CC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2512520728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7eATrCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgAQIXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:23:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44034 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAQIXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:23:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so21746225wrm.11;
        Fri, 17 Jan 2020 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUSs0EsfkQm4mYmzDjaRdaKR/Kgrp8H6zh/MaOdy+jo=;
        b=N7eATrCSbI76C1TS7ve9xxuJbIToFETnuLOaLgsv5KDeBQq9tVSlM7YISkI24LOs0h
         Y1SBbW6JbvHf3o5M/zO1rZY/Ot40TVbRDAkmo1W1B0Lcr9Jy6rCZ44tvlAEK47TLLAbj
         dC5AxeD4ZhAo8xyb8Utfu+GVOlWPUzm8dYav28oTeUrAwFcuzwqbjh3Y1rHPav90hIWG
         32yQ22iH1xj5OpZTCpDh8/qmYT2DymqEqa85/zLjB//0S2r4syb7v9Q3guKUJh4zYKnj
         Z2YNTcdtwbfo5A7PqHc3uTS9+xZi1EMc891Xfoz/nQlkplYN/msR6ro+AhSzsxxizlx9
         /Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUSs0EsfkQm4mYmzDjaRdaKR/Kgrp8H6zh/MaOdy+jo=;
        b=Y6B3V+cDCjhlmGIxyiMY0CSy2CqLDsDBiGgt2NbtI8YMBZcIEftHT/6pVxe+d98LTs
         e6+vlXcMtnTSyRNKPatuLk+FkFlRMelOIkx5cgz8e3JFCWIQMm5ai0FLntRkaNGXbYvO
         ebJNwPfNh8vwDKxz8hi4i2D8kKCHLM9N5nXfpjbntR//KNCgkF11iAFAJeOA5baUW9sL
         m+FIwJu6PVvchbNkNFvPcmFX07btsFR58nX+tTOerO/hjdtFK69i7Jk1lIgA4tGp9Mht
         hNetrO55OuYp8WqD9YEnSJQIQvtEXWgW7CdoMBY3QhOl0wiRsiVK1hQeTlG+drGgZeUC
         jN7g==
X-Gm-Message-State: APjAAAWeVKVjRnkxcb9QyI4/AufkeUou03RBm5twGfv/uDUp4rMIPIjb
        J2axZtJpQ/ytCVLTshVvNi4NkcsfN9gB8kFa4DdLwWnn
X-Google-Smtp-Source: APXvYqy74lCYML2O2IJyen/bXWr0/b/xMIholfFw9/Wbi+EVQLNVVoPq5k2Tz5phcAAjtdgiq+Dyz89gvNiHEhBI0Uw=
X-Received: by 2002:a5d:484d:: with SMTP id n13mr1724822wrs.420.1579249383710;
 Fri, 17 Jan 2020 00:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20200110063755.19804-1-zhang.lyra@gmail.com> <20200110063755.19804-3-zhang.lyra@gmail.com>
 <CAOesGMjNkVpTOhSrLUKjNZnKFk55DTgg29QzVBEFVh3Z=Ra+cQ@mail.gmail.com>
 <CAAfSe-tx+S_tc1y0c5wobQy2xygNr01b3LOqQ4FQtHoDNhHNeA@mail.gmail.com>
 <CAOesGMhNxkyAYMeHSRAuxzR51-5eHZ278LLVYe-3jaS7EKa-jw@mail.gmail.com> <CAOesGMi=1uKK=rCyD+d5yTE3O+HpNXTntNghLaWXt86z+GaKhg@mail.gmail.com>
In-Reply-To: <CAOesGMi=1uKK=rCyD+d5yTE3O+HpNXTntNghLaWXt86z+GaKhg@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 17 Jan 2020 16:22:27 +0800
Message-ID: <CAAfSe-tDDdCix3=C0-BARqeBCMDqM7XUCc_S5kZTEswtK5-ZvA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: Add Unisoc's SC9863A SoC support
To:     Olof Johansson <olof@lixom.net>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 08:57, Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Jan 16, 2020 at 4:56 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Sun, Jan 12, 2020 at 5:44 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > >
> > > On Sat, 11 Jan 2020 at 01:41, Olof Johansson <olof@lixom.net> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Jan 9, 2020 at 10:38 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > >
> > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > >
> > > > > Add basic DT to support Unisoc's SC9863A, with this patch,
> > > > > the board sp9863a-1h10 can run into console.
> > > > >
> > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > You reposting a patch that we have already applied, and there's also
> > > > no changelog for it in the description.
> > >
> > > Oh, I have to explain a bit.
> > >
> > > I was expecting an email which inform me that the patch was got merged.
> > > That's the reason I resent this patchset.
> >
> > Ah, yes -- me too. This was a combination of two things:
> >
> > 1) The patch was originally sent to arm@kernel.org, not soc@kernel.org
> > 2) I bounced it to there to apply it using PatchWork
> >
> > ... but, it seems that the bot won't reply to patches that have been
> > bounced, only those who were originally sent there.
> >
> > In this case, I should have made a manual reply -- I've gotten too
> > used to the bot and relied on it doing it.
> >
> > > About the changelog, this new patchset actually had a cover-letter[1]
> > > in which I documented a little changes (which was not important now).
> >
> > Not sure why, but I seem to have missed it. Maybe because it was 3
> > patches on v5, and I didn't notice that one was now a cover letter.
> > Anyway, all good.
> >
> > I'll also apply 1/2 shortly.
>
> I'm ahead of myself, it's already applied as well.
>

Thank you very much!
Chunyan


FYI:
The patchset v5 seems also NOT sent to arm@kernel.org, it was
accurately sent to soc@kernel.org :-)
https://patchwork.ozlabs.org/cover/1214863/
