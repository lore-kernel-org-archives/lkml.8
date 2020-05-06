Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D85C47259
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B07020708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENs11Z2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgEFS6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgEFS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:58:07 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352EAC0610D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:58:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t11so2266903lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hhU7YC1mHWJXOQCa9/YtvMX0AvTF/51BQ11Lkp2if0=;
        b=ENs11Z2E6PTphR/O7XEptV9DrkitQZwLiWGfUE3J1NThoeRLPWDK4tDps5BoTcWit1
         zxwc6iaDbar5hppPTNmyGg+DQIeMEcKomHQdFBhyU8VETMfHL8W2a1Jd5FtPT4MSFPlx
         pW5uAwDfiblCrXtvPdUyMV5XllzXhrrMlu3/oW6uuJTz36qgimok4gbXBH4xnjVurcCX
         lcUe+U7g7T87tsCxaKgUy1ztqhvZkOlPI1dRGORUz42KQ/uPPuoOll0V3+DBw/rjO1OW
         I1Q/zUwoATalGf6bzwzmulWBAfKNsUBbxb1ZM1A5ACSkMtfwmtHD9gRLESdsOugAfng+
         xmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hhU7YC1mHWJXOQCa9/YtvMX0AvTF/51BQ11Lkp2if0=;
        b=R2eDji65umloZibT2OZiHDB71tXEDluvirSWO5EZ0SrFs7OHriAASfSwzhaAyWu94l
         heMlQhoPo0SPWmXsvwRHof8VBH1TrU9fklmfx5A5sEPQ35QEf9G3Tq66Z0Z1ZYymK5rh
         P044w+AkHjJSAj3ZraA9UNr0Z5nM7rFCrwSW4gGqVfreI4QdvVzPGG3JS5wNjzX2CFKX
         C47QzEUJWiDvGDFnuqEXio2r+AxzJ0/RjN7E4vs2T+hnarienH30TSvRiq/bmaANRbkM
         lorQo9KEv52V5EoR7K5MsyLeXDEp8oY/8ZaYH5BoZ20LN+I8xtyA6cIdsnt6s947oCR+
         vXOg==
X-Gm-Message-State: AGi0Pub77S2eGCkZneNde4U95Uc42ci8+XCDcPnCEUBvuxTTNI68bDN6
        w+V0uuzaM5bp1nNVJSwOBOofwb5JJLNppffMNzrlxA==
X-Google-Smtp-Source: APiQypK2/BS9DNLQgUdve0DnZIP+ggCdF8l9P6mtknH7uy4q8+KLPietCh0cyMKc+/gJFltqkIhzsPf/UxXxP4Q5v8I=
X-Received: by 2002:a19:40d2:: with SMTP id n201mr6168784lfa.82.1588791485423;
 Wed, 06 May 2020 11:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <1480357509-28074-1-git-send-email-johan@kernel.org> <1480357509-28074-12-git-send-email-johan@kernel.org>
In-Reply-To: <1480357509-28074-12-git-send-email-johan@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 7 May 2020 00:27:53 +0530
Message-ID: <CA+G9fYvBjUVkVhtRHVm6xXcKe2+tZN4rGdB9FzmpcfpaLhY1+g@mail.gmail.com>
Subject: Re: [PATCH net 11/16] net: ethernet: marvell: mvneta: fix fixed-link
 phydev leaks
To:     Johan Hovold <johan@kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Vince Bridgers <vbridger@opensource.altera.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Claudiu Manoil <claudiu.manoil@freescale.com>,
        Li Yang <leoli@freescale.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lars Persson <lars.persson@axis.com>,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Netdev <netdev@vger.kernel.org>,
        nios2-dev@lists.rocketboards.org,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2016 at 00:00, Johan Hovold <johan@kernel.org> wrote:
>
> Make sure to deregister and free any fixed-link PHY registered using
> of_phy_register_fixed_link() on probe errors and on driver unbind.
>
> Fixes: 83895bedeee6 ("net: mvneta: add support for fixed links")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 0c0a45af950f..707bc4680b9b 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4191,6 +4191,8 @@ static int mvneta_probe(struct platform_device *pdev)
>         clk_disable_unprepare(pp->clk);
>  err_put_phy_node:
>         of_node_put(phy_node);
> +       if (of_phy_is_fixed_link(dn))
> +               of_phy_deregister_fixed_link(dn);

While building kernel Image for arm architecture on stable-rc 4.4 branch
the following build error found.

drivers/net/ethernet/marvell/mvneta.c:3442:3: error: implicit
declaration of function 'of_phy_deregister_fixed_link'; did you mean
'of_phy_register_fixed_link'? [-Werror=implicit-function-declaration]
|    of_phy_deregister_fixed_link(dn);
|    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
|    of_phy_register_fixed_link

ref:
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/541374729

- Naresh
