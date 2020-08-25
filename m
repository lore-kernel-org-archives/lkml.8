Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC83C20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXHm/dJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHYRQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:16:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57CCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:16:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so14711272ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mo0Muk7fdL9/zKvFIFzgemUwwyHBnlsardInfQrXhhI=;
        b=AXHm/dJ0rHd2TZInwSAMWT4xkULe3KuDv7PEy7Vmvg/70C93nEQmnBLnPpdCBjEU/a
         LJpWzWoIZgMXXtaBkJKYQjGsN166f2E2VBNOpC5bVvUamarlECX/2LPLkbbcBPTwTvvE
         qT1suASowH5CMkTUCLy+iBbc5oXs37/DBfN9KLkV3fR13Qj17TxGnzyjuaA1VYZAztPs
         9JUjeZmcOpEbVMQO8+ALhLoqRhIqBdWw9dOvSSUX52BZ+DfxwRKcXxnwcQu/a2yx4OpK
         jP0UXr2BNWAJsVwDVO2WsFf5U+hO4aKj+5xGQc+MsIS5bvDUhJZ88ujLF0S0/azfHkTb
         Cjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mo0Muk7fdL9/zKvFIFzgemUwwyHBnlsardInfQrXhhI=;
        b=seDupLxQyjufGlM24NzkW4DXV8BpTN40bGbzOttrcXwMYPd8ZWbOafIKab/+ijtC3O
         TvxU7F9194iab9skzPOlHFQGyEg3CoLLKDdXdhJ78iZhK7AfHb5bSWR5s6yekdNuHAZm
         5fflnKkbQ9MZ4UCbNk1mNc7abjCZPEW0iLXFxxW1au9SgT2BbdAfMz4JsGnNLPv2bOZF
         fXm2tUblCfekeduCQg4PVylh4QJM548Ezo8PITUVTNyL3xb6buRuIwTVpcjWy5Cp1rph
         8lc+2t+Xadyy2tkEg7tMNgKhpSZRUzVqgjXTeLb/RDxMfFzZ/UF9iuL9Syrqy0upe4As
         rpTA==
X-Gm-Message-State: AOAM530M2JjnbtJAYRC1Kw0eJowIaj89KQ4KiY+GrthpCkiZAJUaqtRI
        PKYQSENN59JEh7NUCglBmRNH2ZDfzj+0wZ/QtBS3po/YyIQ=
X-Google-Smtp-Source: ABdhPJyl4eVEh3fx1XakUFyburv/u13PcRmesrkEZ5DyEj3uIY2alEfePNPmrcFzUWwlz8YZ9r6wJ12wLIIebJZhfuw=
X-Received: by 2002:a2e:8ed4:: with SMTP id e20mr5672379ljl.403.1598375776209;
 Tue, 25 Aug 2020 10:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
 <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
 <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
 <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com> <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
In-Reply-To: <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Aug 2020 14:16:05 -0300
Message-ID: <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:40 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> Makes sense. Does the following logic sound correct?
>
> - If num-cs is set, use that (and add it to the docs)

I would not add num-cs to the docs. As far as I can see there is no
imx dts that uses num-cs currently.

> - If num-cs is unset, use the number of cs-gpios
> - If num-cs is unset and no cs-gpios are defined, use a driver-provided
> default
>
>
> I'm not sure if 3 is a particularly useful default either, but it seems
> it was chosen to accommodate boards that previously set this via
> platform data. All SoCs I've checked (i.MX6Q/DL, i.MX6UL, i.MX7) have 4
> internal CS pins per ECSPI instance, so maybe the driver should use
> that as its default instead?

I think it is time to get rid of i.MX board files. I will try to work
on this when I have a chance.

bout using 4 as default chip select number, please also check some
older SoCs like imx25, imx35, imx51, imx53, etc
