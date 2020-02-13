Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD9DC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207D82073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="lZb8yl9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgBMPgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:36:43 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48818 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBMPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581608199; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKjxGSNeDcBxV7nToyUB21fty1jGDd6Iqnl1fd+HIIs=;
        b=lZb8yl9UE96+GZJeqOksy6FWcEmxfRWcQ8G1i7Uov8S3xUG/5lRVgtUj/zS/OhZtmeBWLB
        FWrbkP0mQj0jo80+qDUKri5z6y+0byDkV9qvtXj1cpNskfQR1RZkjcbsnsh4mcZhRLJVf0
        AQMrw9RHFpT9Tyqtg+NM0+A8QffhHEo=
Date:   Thu, 13 Feb 2020 12:36:22 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] MIPS: jz4740: Replace <linux/clk-provider.h> by
 <linux/of_clk.h>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hartley <james.hartley@sondrel.com>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1581608182.3.0@crapouillou.net>
In-Reply-To: <20200212101544.8793-5-geert+renesas@glider.be>
References: <20200212101544.8793-1-geert+renesas@glider.be>
        <20200212101544.8793-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Le mer., f=E9vr. 12, 2020 at 11:15, Geert Uytterhoeven=20
<geert+renesas@glider.be> a =E9crit :
> The Ingenic JZ4740 platform code is not a clock provider, and just=20
> needs
> to call of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of=20
> <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good to me.
Reviewed-by: Paul Cercueil <paul@crapouillou.net>


> ---
>  arch/mips/jz4740/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
> index 5476899f0882a4b4..605a84a250bfb299 100644
> --- a/arch/mips/jz4740/time.c
> +++ b/arch/mips/jz4740/time.c
> @@ -4,8 +4,8 @@
>   *  JZ4740 platform time support
>   */
>=20
> -#include <linux/clk-provider.h>
>  #include <linux/clocksource.h>
> +#include <linux/of_clk.h>
>=20
>  #include <asm/mach-jz4740/timer.h>
>=20
> --
> 2.17.1
>=20

=

