Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD09BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A3320756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589841746;
	bh=ZI+2+ZLy6El97MHhuoWAAbeg02T2A/2czo6xMrDyQeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cUFgkIPec/VvCNYuv2f04uzM5lmdpP8f+VWcP9EfaOGwPN9c6BO0fjhK+pycT/OA3
	 gw2yi/R6o7LSjVJGaU4rO2qdQix5jd4XVx5MnFnSfIlXqjMWoVe0EPNP78Y/ia9xCw
	 GuTGp8E77Ql8l0sPJkRyXHuAJehMb5T3+uvXdo5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgERWm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgERWmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:42:25 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0652820829;
        Mon, 18 May 2020 22:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589841745;
        bh=ZI+2+ZLy6El97MHhuoWAAbeg02T2A/2czo6xMrDyQeQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vOSx/Y4IyKGmqAuJ61atK8+HUo9I3nP2s/Bv2HwbAZtQyPTNC8eS0qTDTgCHuLzXv
         I2qDAi7eosVWfEPP8f93XGzMjuPg2uOHxtBV16eQOU+HZNNRrUu14Femx1bHay9t5q
         UBicFWQvH4DuOZhs/GVewhTX+Nfir9BToSzdHxA4=
Received: by mail-ot1-f46.google.com with SMTP id d26so9603230otc.7;
        Mon, 18 May 2020 15:42:24 -0700 (PDT)
X-Gm-Message-State: AOAM533dP0jgB7Of9I+vUag6ovpR+AicHdu9uJkcV5A7lpsCyll++5dh
        wS4jFZdo4bvo1Pn4oMkUWBANULC28nXUMMHLCw==
X-Google-Smtp-Source: ABdhPJyTKe6FGOymx9XkJB3VrJm6FEmEGYNTais4t83A3HPZxAJIq6IGr2eZbbeLBRbZNy+cx/WbS3w2gtcXkBXBluc=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr14114210oth.192.1589841744310;
 Mon, 18 May 2020 15:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <1589198262-21372-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589198262-21372-1-git-send-email-Anson.Huang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 May 2020 16:42:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+dTFy5HBhV9-eU1a0UZikXkUd1HJuHG0KfU-PFetsAMg@mail.gmail.com>
Message-ID: <CAL_Jsq+dTFy5HBhV9-eU1a0UZikXkUd1HJuHG0KfU-PFetsAMg@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: reset: Convert i.MX7 reset to json-schema
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 6:07 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Convert the i.MX7 reset binding to DT schema format using json-schema.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
>         - Improve description;
>         - Remove i.MX8MM and i.MX8MN compatible, they use i.MX8MQ's compatible;
>         - Keep original author as maintainer;
>         - Remove unnecessary "..." at the end of file.
> ---
>  .../devicetree/bindings/reset/fsl,imx7-src.txt     | 56 ---------------------
>  .../devicetree/bindings/reset/fsl,imx7-src.yaml    | 58 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml

I'd apply but doesn't apply cleanly to my tree, so:

Reviewed-by: Rob Herring <robh@kernel.org>
