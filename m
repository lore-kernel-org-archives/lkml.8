Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98872C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795AA20828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgB2Xnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:43:51 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55094 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgB2Xnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:43:51 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8Blr-0004pd-AW; Sun, 01 Mar 2020 00:43:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix cpu compatible property for rk3308
Date:   Sun, 01 Mar 2020 00:43:46 +0100
Message-ID: <2296994.saQPy0AWz7@phil>
In-Reply-To: <20200228084827.16198-1-jbx6244@gmail.com>
References: <20200228084827.16198-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 28. Februar 2020, 09:48:27 CET schrieb Johan Jonker:
> A test with the command below gives for example these errors:
> 
> arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml: cpu@0: compatible:
> Additional items are not allowed ('arm,armv8' was unexpected)
> arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml: cpu@0: compatible:
> ['arm,cortex-a35', 'arm,armv8']
> is too long
> 
> Fix these errors by removing the last argument of
> the cpu compatible property in rk3308.dtsi.
> 
> make ARCH=arm64
> dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/cpus.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7 with Robins Rb

Thanks
Heiko


