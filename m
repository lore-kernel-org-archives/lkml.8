Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7609DC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526442080C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSLgy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 07:36:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55764 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgDSLgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 07:36:54 -0400
Received: from p508fcedd.dip0.t-ipconnect.de ([80.143.206.221] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQ8Fh-0006Sg-Fa; Sun, 19 Apr 2020 13:36:45 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: dts: rockchip: misc. cleanups
Date:   Sun, 19 Apr 2020 13:36:44 +0200
Message-ID: <75587978.rJgf9MR2fZ@phil>
In-Reply-To: <20200327030414.5903-1-wens@kernel.org>
References: <20200327030414.5903-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 27. März 2020, 04:04:08 CEST schrieb Chen-Yu Tsai:
> Chen-Yu Tsai (6):
>   arm64: dts: rockchip: rk3399-roc-pc: Fix MMC numbering for LED
>     triggers
>   arm64: dts: rockchip: rk3328: Replace RK805 PMIC node name with "pmic"
>   arm64: dts: rockchip: rk3328: drop non-existent gmac2phy pinmux
>     options
>   arm64: dts: rockchip: rk3328: drop #address-cells, #size-cells from
>     grf node
>   arm64: dts: rockchip: rk3399: drop #address-cells, #size-cells from
>     pmugrf node
>   arm64: dts: rockchip: rk3399: Rename dwc3 device nodes to make dtc
>     happy

I've applied patches 2-6 as fix for 5.7.
The discussion on patch1 somehow stopped on monday, so feel
free to resubmit that one separately once everybody is happy

Heiko


