Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD78C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCF2206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si4Be0xI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgGMHbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMHbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:31:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD37C061794;
        Mon, 13 Jul 2020 00:31:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id br7so1391690ejb.5;
        Mon, 13 Jul 2020 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBGepcoKhFbXDRKew9pLyH1Mee+5SLNwBkC3/ifCZ0I=;
        b=si4Be0xIDbX668zLGIX0oFnTUeK+GpxJu0+xCUecosDIG1/eo1at875powKezrq1O2
         2cS36aj3iYelc4cW0RHgRlmFtRRpx7yrYA6fCQpD/xJxTrlpKj7qwq0McMuN6eWVKG9K
         dyvpGfCyr/I8P3NyX9ezZIecxNFiPOkEMqO+kjzqkj07iCmqwIw4Tgc9SB2ekHUWjccI
         NF5UqWqJkZFgoskbFRxBcMIfDPfdQeCccaSQMjEjFqumHzYneN3CNTlwO175QjAnfwRV
         sgqFzIe7V+CT4SpcB0GxP9PH3lSXjDmv3bjxnHo/AmVEiPgkv67YpY1PLAGQG/BwpGiH
         w0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBGepcoKhFbXDRKew9pLyH1Mee+5SLNwBkC3/ifCZ0I=;
        b=dict6rysSiAU1PdwHp/hbZ9/BFEHLWaicCnmARHeHB+dWaAv9iSB6pFrTOVgmeYsoi
         QD8Rdo74BlSwNJbJJEzT3sq9Zp6+0QfRfQe04ehuU18+KugWoEQkww1Sk2Pzyy31WIy5
         1sSc0BbrcyBNFrj66s97Qwv50HWZd6ruWv3xyWIeFbmztbPcGA2GbWl/XYQj2paegNlU
         ooHmSu3gYLQrAd4uD5+tVBbMDXAHI9VJt2QBE1AzHRQGfOu4KQA+158bLzg9WUUZyUQa
         nu2t10sEkB6ghEdAk6OUcHKvMiAOeGxNAP21AKf5FdOy3aTcZ9rCEMt1gidH7oZemeHe
         1bSw==
X-Gm-Message-State: AOAM532GOiS4stKu2vS4LKMtyJOjse284Tkwd+EYhcyN/0a0Q/K8NjMS
        sFGWqyMreqAlMtoWG+dF1RrbwLi4ObcXgKq6leg=
X-Google-Smtp-Source: ABdhPJzN7TuXIpctaa3HLvrc2CzyCMEVfu1H3O0lORN6qEghCZZEm8HDYb5hMhFFwx8hJflSUdAKl1AWux/0FtAs6ko=
X-Received: by 2002:a17:906:dbe5:: with SMTP id yd5mr73142204ejb.328.1594625507103;
 Mon, 13 Jul 2020 00:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
 <20200629114927.17379-3-bruno.thomsen@gmail.com> <20200713025559.GZ21277@dragon>
 <da52724655ff2161add7fb27fea8fc673028b9fc.camel@perches.com>
 <20200713071342.GK12113@dragon> <855b5a01416dfe42d89018450a1c791ccb48e500.camel@perches.com>
In-Reply-To: <855b5a01416dfe42d89018450a1c791ccb48e500.camel@perches.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Mon, 13 Jul 2020 09:31:31 +0200
Message-ID: <CAH+2xPBF7g18XTO_2jUqB2WLkLRWk1gOKHnkWCcz4xZ8636ASw@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add Bruno Thomsen as reviewer of
 Kamstrup DTS
To:     Joe Perches <joe@perches.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den man. 13. jul. 2020 kl. 09.26 skrev Joe Perches <joe@perches.com>:
>
> On Mon, 2020-07-13 at 15:13 +0800, Shawn Guo wrote:
> > On Sun, Jul 12, 2020 at 10:22:50PM -0700, Joe Perches wrote:
> []
> > > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> []
> > > @@ -436,7 +436,7 @@ sub maintainers_in_file {
> > >
> > >      return if ($file =~ m@\bMAINTAINERS$@);
> > >
> > > -    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
> > > +    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
> >
> > It should cover .dts file too?
>
> It does as dtsi? means the i is optional.

It sounds like a good idea for handling dts reviewers.

Maybe we could also update script/checkpatch.pl to ignore
new dts/dtsi files and not suggest updating MAINTAINERS
file.

/Bruno
