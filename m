Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A406C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC19820888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590626072;
	bh=CNHtDH7CXmj5PPGFhcPIQ0giZ2MYP3VRo+LSzcUtMTE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=mtTWSgFpYJe24zN7caCD1grCTk1oTy8UNGaVdAP0c5VLrRORjXYDLOBPr3+faGd6m
	 1mCwaodPS5c4r/wlQopT4kQpwyyjmWGWHJeFaabL7trbf3D/jw9lMdnMdVZ38mksbF
	 lO3eBZrJP3U3Ttl2pNpxjBG3roT+vRHS3v5+JHdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgE1Aeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 20:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgE1Aea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 20:34:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7C7207CB;
        Thu, 28 May 2020 00:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590626070;
        bh=CNHtDH7CXmj5PPGFhcPIQ0giZ2MYP3VRo+LSzcUtMTE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=zBXQUK1mLH6dnoDGcZM90MZ85YVbAGo1PE9HJM/SAHxTI5AzwfTK8s63gSvwrHd/B
         /wSI0mtaHYn+SyKqsaWSdS9SOvkqqYA8QDxfet+nh1YJfu7PEkymP91SIvRLVcP1Eu
         91TJ5eUvjKkEAlEr0wHHb41xxTMLNsvhWIyj1fHI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527134043.807045-1-arnd@arndb.de>
References: <20200527134043.807045-1-arnd@arndb.de>
Subject: Re: [PATCH] clk: versatile: undo some dependency changes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 27 May 2020 17:34:29 -0700
Message-ID: <159062606969.69627.15005677857751012104@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-05-27 06:40:33)
> SP810 and ICST are selected by a couple of platforms, most but
> not all in the versatile family:
>=20
> WARNING: unmet direct dependencies detected for CLK_SP810
>   Depends on [n]: COMMON_CLK [=3Dy] && COMMON_CLK_VERSATILE [=3Dn]
>   Selected by [y]:
>   - ARCH_REALVIEW [=3Dy] && (ARCH_MULTI_V5 [=3Dn] || ARCH_MULTI_V6 [=3Dn]=
 ||
> ARCH_MULTI_V7 [=3Dy])
>=20
> WARNING: unmet direct dependencies detected for ICST
>   Depends on [n]: COMMON_CLK [=3Dy] && COMMON_CLK_VERSATILE [=3Dn]
>   Selected by [y]:
>   - ARCH_REALVIEW [=3Dy] && (ARCH_MULTI_V5 [=3Dn] || ARCH_MULTI_V6 [=3Dn]=
 || ARCH_MULTI_V7 [=3Dy])
>   - ARCH_VEXPRESS [=3Dy] && ARCH_MULTI_V7 [=3Dy]
>   - ARCH_ZYNQ [=3Dy] && ARCH_MULTI_V7 [=3Dy]
>=20
> Change back the Kconfig logic to allow these to be selected
> without the main option.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Is this similar to
https://lore.kernel.org/r/20200527181307.2482167-1-robh@kernel.org
?
