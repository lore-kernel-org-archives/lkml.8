Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B13C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B2220758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLbJDg/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHQICR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHQICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:02:13 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B24C061388;
        Mon, 17 Aug 2020 01:02:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t10so16630886ejs.8;
        Mon, 17 Aug 2020 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkd7ir4Lc8kADukcTengkjGMz/MiXAOCy4lcMiClwWU=;
        b=NLbJDg/mdLf06f57YwxmSt/5hByD6eH3N+bG9wQ6irkM4AGgOQ3nDSxSzqztzdImua
         +FZ8EIiyDrnbbX7c3BR1F3Yw23Z54UTY1y4PFGB6JXgsJPBqHUMIWxCl6dZUtwWpY/Rg
         yUAi52JyLIjfEpKC42XgNrJdFJ21WXN8RSCCAGbQlPW73LmptYcUI63m1F6WX1UmpsgC
         eyNYWprS69Y0WuvZ9SGDxwDpznhBuY7pgi9nkjkb0chzT7fjmxJLKijSl4/zud1iagud
         cpFpAbx/LfDoJnzNSu2yqJEbzpbEHLtpF1lKu0rP94lPmO+w6XeWsxDm/t5znt8uv/k9
         ReJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkd7ir4Lc8kADukcTengkjGMz/MiXAOCy4lcMiClwWU=;
        b=BnLe0J2lrWqhKasbBvuJHdzdSotHYwcgI9zbq8sMr1ckDQyVhRW1LHLcXEDSs86gWz
         Xsp9ChMzOfp96pa5Rw2PZwBgYagyW6ddpTkwsJ0v/gEtrfNQKgbbdVD0ltcE40SCE3D5
         Q947lopTj+GvH4b4cuv3dHoFUhwkiDwUIaBhf6k8foE1uPddGLN835FPtByEo1tNrmx+
         ZiGmnl2vBWu18ygVf91GXJRyblflA+YazeNMHPS3Oc33iE53Uw42ARDT7qpq/F3HDaXO
         5z09IPhgXhEKcjItBspPbqih6lMuBYdtONqWW2RZJYSc2BdbDUGrovP4lR5HYzwsR4hf
         YDCw==
X-Gm-Message-State: AOAM533O/5jyfx9BS8z15QyCBQsRvjZP90Kgk+10FckmFTGt8oeXjQiz
        rGDuRYA1f4VR9QLR7YT44kBKHJEaiFQ6Tpj28UPARYjcV20=
X-Google-Smtp-Source: ABdhPJyULURHsOc6QrXjl1m4GIJaBypxn0n7q6U6kawvWYJPtUY16SsiyWZ/QvpEtIybyexMm9znpKLiSVA8mAKXH8c=
X-Received: by 2002:a17:906:138b:: with SMTP id f11mr13497776ejc.310.1597651331359;
 Mon, 17 Aug 2020 01:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-6-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-6-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 15:47:05 +0800
Message-ID: <CAA+hA=SbFoPrKfOWFQOiM+Y7bB1HC5Y5F0XpDbqbn5D0=Dn7pA@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] dt-bindings: reset: imx8mp: Add media blk_ctrl
 reset IDs
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:13 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> These will be used by the imx8mp for blk-ctrl driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng
