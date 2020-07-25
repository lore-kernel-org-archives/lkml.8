Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C311C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6D32078A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="ibIWiXjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGYEo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 00:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGYEoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 00:44:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66863C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 21:44:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so9964381wrl.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 21:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VrwN5/UnygvMy3zMm6TjQrq+luQNTXvPZ+NbPuQVPA=;
        b=ibIWiXjGWI4kz9I5MrfgGQdY71Zw+k0eXM7gC5w5R+lLsuD/rVVn4l5bB7vbyRpgSF
         CV+8imaGR1JjGgXBgy9BLroi7X+UhQOc0W+LxYQAbq+YPThjVyOrAleyn+J44L5k/1pZ
         ATDUYH0iFCuMMtfyo4nNuUBNgpolxBm3o3+jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VrwN5/UnygvMy3zMm6TjQrq+luQNTXvPZ+NbPuQVPA=;
        b=djbQUGIpBidPX57iGgb+ZpBWozIGDnLxsrKi4+obvHwCv/eQkKGBsZWdSlzh6/59k3
         vQIyYLmNpY0ezuDoTkXKWY0IfummEnQJRY88xjZWWzqKMzoDRUxAcr4uD3P7O5eKXkCm
         Fhau+XR14KrBat+FAw+QINem7JmtOtvFbNfdH/LUSaGKJHLetY1lcgefcuXUZdEEqDUM
         EEf2gddufh2NtXxVVrPWiY156i8Emx8DsgjC4BI8vFdYSUFYnALSyLZTOenXvLOQXlQq
         Sd0BcURu9XIZMhDB55gzk0bAaCWCAvRfhCrvXYSvzr+6imiNEw/lDRFE35//jKuikJGj
         3rGQ==
X-Gm-Message-State: AOAM532kJ7JwBpTx8+R5NUlBiGQHrlxRdPvMM21NPHKvy0qWDcLOuD5l
        erLsk/T7ctVzQZzCzLNmPXJoIyvffSqPkJ3zbWtBsw==
X-Google-Smtp-Source: ABdhPJyibJBX0jw3LQVOdkevS7Z9trwmeRbeB+lDZ+bqAHr4vmhNL3sBrn1KJuO9i4ieIVDSG6EKmvewA3ljP/CM5q4=
X-Received: by 2002:adf:cd91:: with SMTP id q17mr11312969wrj.5.1595652264082;
 Fri, 24 Jul 2020 21:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200710094544.430258-1-daniel@0x0f.com> <CAK8P3a2xQmba=ikPjRZCu+PhMGMRKDWW=WbgzjRypD9U43WHDw@mail.gmail.com>
In-Reply-To: <CAK8P3a2xQmba=ikPjRZCu+PhMGMRKDWW=WbgzjRypD9U43WHDw@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 25 Jul 2020 13:44:13 +0900
Message-ID: <CAFr9PX=jMd1hogK9_JPU4N+QsDgiFyMMqON0_7-SytX2Kuh6Pg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Initial MStar/Sigmastar ARMv7 SoC support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Marc Zyngier <maz@kernel.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks.

There is one small fix for the v5 set. One of the DTS file names got
broken when I rebased on a different machine.
I'll send a patch for that later today.

Cheer,

Daniel

On Fri, 24 Jul 2020 at 23:37, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 10, 2020 at 11:46 AM Daniel Palmer <daniel@0x0f.com> wrote:
> >
> > This patch set adds initial support for MStar/Sigmastar's
> > Armv7 based SoCs. There is just enough here to get to a shell
> > with an initramfs but support for a lot of the hardware is
> > in progress and will follow.
> >
> > MStar also shipped chips with MIPS cores and ARM9 etc which
> > are incompatible so I've tried to make the distinction in the
> > code that this is strictly for the Armv7 based chips.
> >
> > Sorry for the spamming this. I just really want to make some
> > progress on this because I'm worried the other bits that are
> > needed for these SoCs (Really old AT91 support in macb and
> > the fotg210 usb host) will be lost or stop working in the meantime.
> > This already happened in u-boot.
>
> Hi Daniel,
>
> I just found the series again after looking through some backlog,
> and noticing I missed your submission from July 10. This looks
> all good to me now, so I've merged the series into the arm/newsoc
> branch that already contains added support for the keembay and
> sparx5 SoCs.
>
> If you require any changes to this, please send incremental
> patches against the soc tree, and submit it to soc@kernel.org
> so it makes it gets into patchwork.
>
>        Arnd
