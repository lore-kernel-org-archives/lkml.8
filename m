Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789C2C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5163620838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5rTU9hA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgBZM35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:29:57 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36067 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgBZM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:29:56 -0500
Received: by mail-lj1-f173.google.com with SMTP id r19so2905185ljg.3;
        Wed, 26 Feb 2020 04:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYRw4tH2Rs/e60d73NUbkuJbxLkTk8K47OrYj1p7M4A=;
        b=e5rTU9hA8lMf+tk+gVuUunPWotj8HJSvkMmGE3KOwXtl4tirjK2K3T4z65fW1PoYPi
         Iuj3oINUDtG42mwXpH9JpJdHNK0s0rmHYsGkOO2X7lomI1/D2R27634OQA9jT8O+MQVi
         ZJmSaUA8/C5nHwBBj0kv+uQaoGBXkBiP8mK25RakFTvjaTqR7XwCz6i7YsolW4prfJrY
         p/LL1mkTEGEqNgg/ehiug47bLAUaSYvjnqZiudDX1UOWT/GwZ1kIBXLMN1cMrvwU6RrP
         4bGeInJTN0IdkY2eZrRtLq6n6O3Xf/Izwk+mUl2ditBFkca/23awgXWv9nhEvY+GIlc4
         0ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYRw4tH2Rs/e60d73NUbkuJbxLkTk8K47OrYj1p7M4A=;
        b=J60IvysmghzdAsTKjdhz8JOaZ9AuPUc7AIjYZXutL/jlGfiImX4ZVh1fmujVuScyrL
         2QYBuvMGlNeb7DRT1blUm8E1QPl6fvaww/bt4TLJOPTCn6ebVEpmFw3J2yGPVEtmmh0J
         BC7c8hkCpIkGJbXXYehhkZLIrUuOwngl5FtnicKbEH3e+itkpsS0G1qw9PVibpamJove
         a4T2MtzgMKP09PJ/SN1OP/QUgNlM4fL10pakzs/fjJt0WB0chHtw8asP4dmcriR0e5K3
         vMDJVPloZ1lWLyywlBFFeRiGO3BpMS16FknULbMWM4+MEbZBylTuhMW4mNjb01Jhjukq
         j87w==
X-Gm-Message-State: APjAAAV5H36P9mMAQ6xSRGZMeLVN4fwQXVqgnFbVscuVtcJ08u0ftgH1
        8a+OlMv8jePFrmmMKQZVkAnUqdU91VXDkaDmJtyMEQ==
X-Google-Smtp-Source: APXvYqwIy0nEZGxxB6rW+LVv5AmFFL7l6FhryvMruyD05L6OvsPvKIXc/q7r6lY5P+ia6fVHqUpCZi4u77hNg/wnfB8=
X-Received: by 2002:a2e:2e11:: with SMTP id u17mr2825719lju.117.1582720194301;
 Wed, 26 Feb 2020 04:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20200213153151.GB6975@optiplex> <AM0PR04MB4211AC5AB9F6A055F36040A2801A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20200213174225.GA11566@ripley> <AM0PR04MB42111BF00621C1949E1FBA9080150@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20200217070429.GB7973@dragon> <VI1PR04MB42220B24B1C46756A4B9E7B180160@VI1PR04MB4222.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB42220B24B1C46756A4B9E7B180160@VI1PR04MB4222.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Feb 2020 09:29:43 -0300
Message-ID: <CAOMZO5Dq3i5gVR-vrCeZ+g=fmL7CODchVOg0xdcEg+en8tJtLg@mail.gmail.com>
Subject: Re: clk: imx: clock driver for imx8qm?
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Oliver Graute <oliver.graute@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aisheng,

On Mon, Feb 17, 2020 at 4:31 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:

> I remember I addressed all Stephen's comments in the last round of review
> which is marked in the V5 resend change log.
> https://www.spinics.net/lists/arm-kernel/msg769365.html
>
> But I can double check it.
> Should I re-send after a checking or wait for Stephen's feedback?

I think it is a good idea to resend the series.

Thanks
