Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A98BC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDC4207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZvTtZkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHSTyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:54:32 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860ACC061757;
        Wed, 19 Aug 2020 12:54:32 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v15so12684189lfg.6;
        Wed, 19 Aug 2020 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IvK+EL/VOaugfZMqZ8Z/Egjo0W/7GCCfRunfaBVoSZ4=;
        b=HZvTtZkDdbdqL09lS9Fs03LUKhdiQZ0jy/XY5fRTD1HZvLCJ6f+fR4cNZbxNQD32kJ
         5GDVt5w3w3LsbCjS2/qchaO93jKi55rRiTpWOJOdjkLUltDbXAgbel2aXAKCQAmpz1B7
         Z5nFJ+AML7V8tqwlUrQbljc6FGyZwkKIN6spDRZGBtLac9DwPVNFegDRYsRp+1kbb9AC
         RaXpssNrm+6jmIf3sMHHqn/kCpOZ1vXNMwHA9FpD6kluqYw+XzSJ2cef2NW/j6SVZacJ
         l8xzpiAJUtojbeH+IPAo0tOCVZ85Jl44b9MAei6nL6xuDgrYDVqQhKDxl2mHTqnnG1/V
         FJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvK+EL/VOaugfZMqZ8Z/Egjo0W/7GCCfRunfaBVoSZ4=;
        b=obDTrahDdPB5PvhDM+MOOLP+vXpQlADzRujgMZDNPC9JvAf6iujhbUm+JBWHWQdaxK
         N4Aj5RYPFY7kwbI8+HWQ6xgLiqfNaWENhsWl+bKDtTD0kVrwPlR1fEqzz0pvIW8u1NKZ
         yng6gOnVJeK1BdVveew5NNfx11YecudA2epnpRmpadcV9cbi0LXfkLoCXEs5a2riqe91
         /4B1XetjVdW7aEVkK/VpSMokKl/tWUWTlCy0ujsEW/0Gea75MhL5H/wFi1coodqdbFDh
         0fGIqN2fxOc59pgdDQQIPWKxi2RiQel84nDQRSyGyV6U8Ol0inRSdYUrqdUhIg5KLmTG
         y4xg==
X-Gm-Message-State: AOAM532okF5Ki4sdUd89gyK4LPLwZh8tpycfj4yykQKxmIMWa6+lCpDU
        Kkq542ruFQpYya7ms7dhaQX7OodoGOz+bfIeuzk=
X-Google-Smtp-Source: ABdhPJypbMJ0z5sN6qj32nOVFnCNMHrXLvGQB0p6A0BMG6NTG6o1X2AZz7aqBNayn71WVQ0fiOH9yWhlJO3D8PP5jaQ=
X-Received: by 2002:a05:6512:3156:: with SMTP id s22mr13021431lfi.140.1597866870874;
 Wed, 19 Aug 2020 12:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200819194845.2866317-1-aford173@gmail.com>
In-Reply-To: <20200819194845.2866317-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Aug 2020 16:54:19 -0300
Message-ID: <CAOMZO5AcC=4ybac9+BH4fT1mZTbrZo361ZV7TnXXd7p+zT-x=g@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: imx6q-logicpd: Fix broken PWM
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Wed, Aug 19, 2020 at 4:48 PM Adam Ford <aford173@gmail.com> wrote:
>
> The DTC doesn't like the default PWM settings, because it's expecting
> three cells.  This patch reduces adds the extra entry of 0 to the PWM
> reference.
>
> Fixes:  fa28d8212ede ("ARM: dts: imx: default to #pwm-cells = <3> in the SoC dtsi files")
> ---
> V2:  Don't change HDMI
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Your Signed-off-by tag should go below the Fixes line (without a blank
line between) and above the --- line.

With that fixed you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
