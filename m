Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7176C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D2C207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="eFwuIq38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgAXBXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:23:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35766 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgAXBXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:23:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so355451qto.2;
        Thu, 23 Jan 2020 17:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+JCfN+nSKvj6z6tQnbylC4tnVuTXLYg++T8pHk3n1Rs=;
        b=eFwuIq388GfKUC6GUKdGzBK6GS8QptU0z6snMlcCeYTB3OaEDOZ8Jp5i/8m/E4MMgs
         +mu3AnfZEzmniI06Z8QY4BWKEfa1omxAnAQLDJEXq+X4QN1LQHxhyUK2ltD7Qfwep/vv
         dpXNOopKQBKiOxQ4TmC2BZlLeLUJ4V8yvSHsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+JCfN+nSKvj6z6tQnbylC4tnVuTXLYg++T8pHk3n1Rs=;
        b=i+fznQ3VP0jOSvX+BOzacg2Ec2DFHX8YtJee1osp+3mkdAOe4TWs2szmYRUKiJTu/K
         p+9OSc0RfFygJGky5AFxWXhsw/Mms5AM2k1SbKeTmsrxxtVL5BZ3QkgTEALaKoTuZ5KL
         puGpoBMjDi7XlOxrUUe/JApwBHrBP7cEO7O3DBYM1tKGGx5PlnqKFg/aKarKBfr4hgfe
         vLLvIQDk2FJPsJ6H1GwfDUS6EvI+7rQpT+1LCqtZgi2T8cddvrRzrczBuKZFq+fudoC2
         3mYaDYUlSTKT9Fz3nvJx4Fao71IyAxBXooFTX7t/SwuRI5hZVskZFgP6A17MfkWWJtOX
         eE5Q==
X-Gm-Message-State: APjAAAWwAoGgR5MOcC1GE5Y6ohkVRwrscE9M7xNEZT8EhrlM5plpOGy0
        JRB2ZTpbEAPwqdXLGK1UvqzXob5KpsUsPza8UfQ=
X-Google-Smtp-Source: APXvYqxTqcFmlwZcBGSX8ZImKVjjr5b8leE8AoohXrep2/0vxHoDMlibAChu/aMO2jSWaB/SxV3cSnP5w6RVZVwCoT8=
X-Received: by 2002:ac8:4244:: with SMTP id r4mr1014134qtm.169.1579828989644;
 Thu, 23 Jan 2020 17:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20200124011801.18712-1-sashal@kernel.org> <20200124011801.18712-3-sashal@kernel.org>
In-Reply-To: <20200124011801.18712-3-sashal@kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 24 Jan 2020 01:22:57 +0000
Message-ID: <CACPK8XdJ8=+SNws2NCjKeX8PRa2wV-J0wzAuWUiP6miL-TioNw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 3/5] ARM: config: aspeed-g5: Enable 8250_DW quirks
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 at 01:18, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Joel Stanley <joel@jms.id.au>
>
> [ Upstream commit a5331a7a87ec81d5228b7421acf831b2d0c0de26 ]
>
> This driver option is used by the AST2600 A0 boards to work around a
> hardware issue.

This hardware was only supported from 5.4+, so I think we can drop this pat=
ch.

Cheers,

Joel

>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm/configs/aspeed_g5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspe=
ed_g5_defconfig
> index c0ad7b82086bd..cb23f8ade3e2b 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -110,6 +110,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=3D6
>  CONFIG_SERIAL_8250_EXTENDED=3Dy
>  CONFIG_SERIAL_8250_ASPEED_VUART=3Dy
>  CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> +CONFIG_SERIAL_8250_DW=3Dy
>  CONFIG_SERIAL_OF_PLATFORM=3Dy
>  CONFIG_ASPEED_BT_IPMI_BMC=3Dy
>  # CONFIG_HW_RANDOM is not set
> --
> 2.20.1
>
