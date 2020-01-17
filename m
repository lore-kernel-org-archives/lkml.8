Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168F6C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8752087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KvEFe/oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbgAQA5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:57:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39533 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733306AbgAQA5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:57:09 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so24092360ioh.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 16:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxvKFjNlmm2YdNSGQw/t2H4ugTVLAvz4laRQaFal8lM=;
        b=KvEFe/oPSc/2vbeoAoO8Cv0bwwOn3KLVCs/6kRN3PwcgZSGV+n/Wrb6aVEmAOMogOn
         h4pA9N57WVBjf7QbLbPqFcTaMsjUi3/A+t+S4/iE/ZhV3vIpsdqKP3hgGTIfZOeMn6Zj
         oB3j6VcpKGXeOZ/wQRITOkn/RxiSiCIbeoTcYaERKW2EZulydgGpr5xyrQq2vPGIJjXH
         +YG4ZkqYnyLGXbu+khhWczvpAHPjL7jdDj2oAsP0aKA+OhXfoaXlcWDtvn51snQ+Yauu
         4q/7+cEgg2hJEV4Da8Cs0O17uRRNO5ZQrlm7uZz3RC/I3f4ZsMnIoYe5xJfBJ/xHhOpP
         MalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxvKFjNlmm2YdNSGQw/t2H4ugTVLAvz4laRQaFal8lM=;
        b=JEDY2/DlOYm5g3/UvS3qleRsKA5sakpA7MXi32qxOhFuXK7P6Sl30fTXxEtGPjAH6x
         /B0GBT6Trpgsa5bjo+sjw5v2950YuIRY4jYUDCQNR8iLbZ8wI7mr221zCO0QhMs2piRa
         iYcBuGSNPAEIYbNES3ZhbiDpNA//K28B/JoF1ocsfFZigiQlF1q5U58P/q8XWYKjySMO
         9nm5jGgT3xGoWsOU66mmgUOX+fpjUs54Q6SnsdEETbPn8DQIJxOuRtztHVVcNwtjxh7L
         WaxKSfpWYK2MLkLxM2S4P0CIAZoHAsCHBXaZLmnabrPre4+FMtUdQMKmv3heOen1fr6b
         xWSg==
X-Gm-Message-State: APjAAAVr8DzCovnKVrIK73CsYgV4psJdi2Z0BlI4Qk4zXZE/WxsB6YJN
        T/p1ce6keBe3CC1RC+uwuPdP0+EaF7WepBP6kYNeqQ==
X-Google-Smtp-Source: APXvYqyu4SPZDC4zObU6mM2JzTlSxF5CffLtlPXclG31ycWTRt+tto82A8i6lJJF1bygD3jkMFbplVRmLMMnnOilohQ=
X-Received: by 2002:a02:ca10:: with SMTP id i16mr1119516jak.10.1579222628788;
 Thu, 16 Jan 2020 16:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20200110063755.19804-1-zhang.lyra@gmail.com> <20200110063755.19804-3-zhang.lyra@gmail.com>
 <CAOesGMjNkVpTOhSrLUKjNZnKFk55DTgg29QzVBEFVh3Z=Ra+cQ@mail.gmail.com> <CAAfSe-tx+S_tc1y0c5wobQy2xygNr01b3LOqQ4FQtHoDNhHNeA@mail.gmail.com>
In-Reply-To: <CAAfSe-tx+S_tc1y0c5wobQy2xygNr01b3LOqQ4FQtHoDNhHNeA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 16 Jan 2020 16:56:57 -0800
Message-ID: <CAOesGMhNxkyAYMeHSRAuxzR51-5eHZ278LLVYe-3jaS7EKa-jw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: Add Unisoc's SC9863A SoC support
To:     Chunyan Zhang <zhang.lyra@gmail.com>
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

On Sun, Jan 12, 2020 at 5:44 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Sat, 11 Jan 2020 at 01:41, Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi,
> >
> > On Thu, Jan 9, 2020 at 10:38 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > >
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > Add basic DT to support Unisoc's SC9863A, with this patch,
> > > the board sp9863a-1h10 can run into console.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > You reposting a patch that we have already applied, and there's also
> > no changelog for it in the description.
>
> Oh, I have to explain a bit.
>
> I was expecting an email which inform me that the patch was got merged.
> That's the reason I resent this patchset.

Ah, yes -- me too. This was a combination of two things:

1) The patch was originally sent to arm@kernel.org, not soc@kernel.org
2) I bounced it to there to apply it using PatchWork

... but, it seems that the bot won't reply to patches that have been
bounced, only those who were originally sent there.

In this case, I should have made a manual reply -- I've gotten too
used to the bot and relied on it doing it.

> About the changelog, this new patchset actually had a cover-letter[1]
> in which I documented a little changes (which was not important now).

Not sure why, but I seem to have missed it. Maybe because it was 3
patches on v5, and I didn't notice that one was now a cover letter.
Anyway, all good.

I'll also apply 1/2 shortly.


-Olof
