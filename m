Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC662072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZo9Hubt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgHVUGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHVUGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:06:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAEBC061573;
        Sat, 22 Aug 2020 13:06:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y2so5483069ljc.1;
        Sat, 22 Aug 2020 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7TSDixHb61TOsN7YB6xR3mupClY/fil07Cu6O4z/P8=;
        b=XZo9Hubtg90BHUH/LA0I+mSm8INq3oP0rpHN3LBRlLwzRP8j4Fg8IjzvLANObOEr3K
         AH3T2NRc4jcRmBb242RURj98giG3uq3kmS8X0KBAVllBWKDdz/gyLKo9GT1DeWVwB0d6
         rtGkFlaHZreQRO62e7luNpPIG+S/oJafQPmTLwKp8KXmY3BEZcYMFOGY+RSPusJFUmO3
         0xTDe0hiE905kI5gnrRYArTaJJBH4fcNsN9H07ayUZoka94ydYSurSxdkNQ0LrAi3vFD
         ChIvocCTQ/S9eh5z0x7YJybK3FYl/YZxOvm1W/HaLEMhhhqJjDCP+jZ8NR7RyVT16nhk
         Hj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7TSDixHb61TOsN7YB6xR3mupClY/fil07Cu6O4z/P8=;
        b=cZ1uWwcusHFxMjLdTZmNgQlSQ+PgSWowGHYi8h9WO/XV+Aq/0cBcnnnuZu/qO3iHpV
         qPd7h0tuTaC6cpEECn/fUGmxOB1W+JchKWO6rmOXkf8zVA6uSgQLVXjIYZnDpqeDfrvW
         pZohIJWczQberHRKydRHOEzPrywsEKGO3bbLIsYmEgZ0KKZIYigHH3CJoYW7hLogoP7j
         i415c7DbKvWAw7eS37ozqN6oYvGQTIvHj3MX1FRN4h6igOPJX52byAbOTXcysOliWQg5
         gvwbcoTZFjbN34w3zy7L19EyBLqJajrk5Sw6yct4CO5WdX+3BGrXFtParki3FXK1NqDJ
         pgrQ==
X-Gm-Message-State: AOAM531zGMLz5DvKOVYvBsS1irM6zphJO/VamuC7ip2a78Q+6oycpIKm
        H4kpzyWGVxZd+Pvs/NUQeBragdExgZcvKc7/pEo=
X-Google-Smtp-Source: ABdhPJwetRYxbDxlrQLlGNw1QkPN7UuMZbC6Sx7Ub10S257Sd9sSSwhaNepGYWww9YyYTyXoEH6+5HxXU5WorRnOsuY=
X-Received: by 2002:a2e:b0d2:: with SMTP id g18mr3988714ljl.136.1598126801417;
 Sat, 22 Aug 2020 13:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200817030401.3124855-1-cphealy@gmail.com> <CAOMZO5DNS0jgc5aryzHvcViVUDZCVF+NMMf_RG2EB28p8Z0Ghw@mail.gmail.com>
In-Reply-To: <CAOMZO5DNS0jgc5aryzHvcViVUDZCVF+NMMf_RG2EB28p8Z0Ghw@mail.gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Sat, 22 Aug 2020 13:06:30 -0700
Message-ID: <CAFXsbZph08Zd1p+91x+RA5Y8Oo56YTTeRAHopFi2+ciOme3CZg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-zii-rmu2: fix rgmii phy-mode for ksz9031 phy
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 12:59 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Chris,
>
> On Mon, Aug 17, 2020 at 12:04 AM Chris Healy <cphealy@gmail.com> wrote:
> >
> > From: Chris Healy <cphealy@gmail.com>
> >
> > Since commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the
> > KSZ9031 PHY") the networking is broken on the imx7d-zii-rmu2 board.
> >
> > Fix it by switching to phy-mode = "rgmii-id".
>
> The patch looks good, but the commit log could be improved to explain
> more about the reason for the breakage.
>
> Please check commit 0672d22a19244 ("ARM: dts: imx: Fix the AR803X
> phy-mode") as a reference.

Sounds good, I'll improve the commit log in v2.
