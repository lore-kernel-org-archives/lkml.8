Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC26C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E09205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD0Tmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:42:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46448 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgD0Tmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:42:35 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jT9eB-00007W-C8; Mon, 27 Apr 2020 21:42:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: fix pinctrl sub nodename for spi in rk322x.dtsi
Date:   Mon, 27 Apr 2020 21:42:26 +0200
Message-Id: <158801649141.50507.14560694452002330366.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200424123923.8192-1-jbx6244@gmail.com>
References: <20200424123923.8192-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 14:39:23 +0200, Johan Jonker wrote:
> A test with the command below gives these errors:
> 
> arch/arm/boot/dts/rk3229-evb.dt.yaml: spi-0:
> '#address-cells' is a required property
> arch/arm/boot/dts/rk3229-evb.dt.yaml: spi-1:
> '#address-cells' is a required property
> arch/arm/boot/dts/rk3229-xms6.dt.yaml: spi-0:
> '#address-cells' is a required property
> arch/arm/boot/dts/rk3229-xms6.dt.yaml: spi-1:
> '#address-cells' is a required property
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: fix pinctrl sub nodename for spi in rk322x.dtsi
      commit: 855bdca1781c79eb661f89c8944c4a719ce720e8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
