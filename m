Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E29C35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A7520707
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBWCQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:16:41 -0500
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:51709 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgBWCQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:16:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D6704837F24D;
        Sun, 23 Feb 2020 02:16:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tank92_1ce31dc6cfa4f
X-Filterd-Recvd-Size: 2400
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Feb 2020 02:16:38 +0000 (UTC)
Message-ID: <7792266dfede1df5742e527dc304b610fcfbd025.camel@perches.com>
Subject: Re: [PATCH] phy: phy-meson-g12a-usb2: Fix GENMASK misuse
From:   Joe Perches <joe@perches.com>
To:     Ondrej Jirman <megous@megous.com>, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Date:   Sat, 22 Feb 2020 18:15:12 -0800
In-Reply-To: <20200222235142.242732-1-megous@megous.com>
References: <20200222235142.242732-1-megous@megous.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-23 at 00:51 +0100, Ondrej Jirman wrote:
> Arguments to GENMASK should be msb >= lsb.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
> I just grepped the whole kernel tree for GENMASK argument order issues,
> and this is one of the three that popped up. No testing was done.

Both of these were submitted last year.
https://lkml.org/lkml/2019/7/10/20

I hope they get applied one day.

Neither patch has an affect today as none of the
#defines are used.

Perhaps deleting the #defines is better.

>  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> index 9065ffc85eb47..cd7eccab26490 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> @@ -66,7 +66,7 @@
>  #define PHY_CTRL_R14						0x38
>  	#define PHY_CTRL_R14_I_RDP_EN				BIT(0)
>  	#define PHY_CTRL_R14_I_RPU_SW1_EN			BIT(1)
> -	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(2, 3)
> +	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(3, 2)
>  	#define PHY_CTRL_R14_PG_RSTN				BIT(4)
>  	#define PHY_CTRL_R14_I_C2L_DATA_16_8			BIT(5)
>  	#define PHY_CTRL_R14_I_C2L_ASSERT_SINGLE_EN_ZERO	BIT(6)

