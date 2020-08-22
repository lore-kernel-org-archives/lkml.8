Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F00C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7379C207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nco1Bexi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgHVT7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHVT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 15:59:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1389C061573;
        Sat, 22 Aug 2020 12:59:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so5443880ljj.7;
        Sat, 22 Aug 2020 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QaA69A53wRsk/xOwAPK6odxwa97IFanslOlt/RcosY=;
        b=Nco1BexirMrMl/fJTIIrQrjzGC1T0kJR2aAdQFFyjPAbb9fL3KqVtPzetNROrRVKrj
         X7AqeakjcrLb5F+xh+GoAHxW+iy2FDlCd4gZ2gLIvXI0HmqDyaZ6Xy7gmFGqfhgdjH5D
         D6qPU/Uz9VuaScNa5QIDKZFp9DXltm5/sMIrjc2OJO+zdDCNIUDV3nduhaiMyk9gVNn/
         8Yf1G95cRp1wkESwJrBKWrCfK4p3lYvSu4ULcy0XbpKIn7NsqF1OA/pkDBqug27Yuy4j
         0v1HLaNjoT/iX6msJKD1ByAULc0eBAmgWXO7pI99idPC7xN2BH4x8hukdFx0btHc5g8+
         WZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QaA69A53wRsk/xOwAPK6odxwa97IFanslOlt/RcosY=;
        b=FxNU0MQnfCZShDjglhcRsVSIm83KPWtKeZ9DXQ7qmTTKh7Dk0Zax3G1qFyL2C9UGp4
         RDr8PFuRmscj6sM8xC9eRrFPLlKMWwmGfg468FqnFTHmcGZlKsPh2E0kDrBVhPIZKthg
         qkQRYw2MYrrP731VNFoEN0SoM/a4Tf8MoHsaMX9cDE+dxTbuJi35jl9dstI3T4Y0rnUt
         jQubEFkh9FvtB9Pq6mzOlmgXg5Ic3O4KsDUFWsRPuvlTxxD+Bjqi1RkyZUuAFgWeC3Yg
         Qv0nBto5r7utDCSwm83ra/hUs2UteduhulS0xi8CtcgIylOTJUU3yx7b/bsnH/2qAlDS
         SAXQ==
X-Gm-Message-State: AOAM532S2RcVaLGRWdx6FS369eFEJ90PrmYU42ev/77d4nkM/fMgvR6l
        sQ0u0VXfMEQi5DQb/GNg8ufXyniH0K7Idxgk3+8=
X-Google-Smtp-Source: ABdhPJxVNtw06MwVhVD1xJWK9LHN5m11245DFUYgus7aZf5RkTsCyEWzKqoHQzZgmiqOMAwX4VRi4aQWjX7HmtUKRDA=
X-Received: by 2002:a2e:9c8b:: with SMTP id x11mr3886145lji.218.1598126380331;
 Sat, 22 Aug 2020 12:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200817030401.3124855-1-cphealy@gmail.com>
In-Reply-To: <20200817030401.3124855-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 22 Aug 2020 16:59:31 -0300
Message-ID: <CAOMZO5DNS0jgc5aryzHvcViVUDZCVF+NMMf_RG2EB28p8Z0Ghw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-zii-rmu2: fix rgmii phy-mode for ksz9031 phy
To:     Chris Healy <cphealy@gmail.com>
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

Hi Chris,

On Mon, Aug 17, 2020 at 12:04 AM Chris Healy <cphealy@gmail.com> wrote:
>
> From: Chris Healy <cphealy@gmail.com>
>
> Since commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the
> KSZ9031 PHY") the networking is broken on the imx7d-zii-rmu2 board.
>
> Fix it by switching to phy-mode = "rgmii-id".

The patch looks good, but the commit log could be improved to explain
more about the reason for the breakage.

Please check commit 0672d22a19244 ("ARM: dts: imx: Fix the AR803X
phy-mode") as a reference.
