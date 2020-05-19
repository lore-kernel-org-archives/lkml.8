Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A97AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBE9206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgESJOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:14:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57758 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgESJOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:14:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jayKA-0002vG-Ru; Tue, 19 May 2020 11:14:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: fix defines in pd_vio node for rk3399
Date:   Tue, 19 May 2020 11:14:08 +0200
Message-Id: <158987962022.2283062.2703252906443245111.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428203003.3318-1-jbx6244@gmail.com>
References: <20200428203003.3318-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 22:30:02 +0200, Johan Jonker wrote:
> A test with the command below gives for example this error:
> 
> arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: pd_vio@15:
> 'pd_tcpc0@RK3399_PD_TCPC0', 'pd_tcpc1@RK3399_PD_TCPC1'
> do not match any of the regexes:
> '.*-names$', '.*-supply$', '^#.*-cells$',
> '^#[a-zA-Z0-9,+\\-._]{0,63}$',
> '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$',
> '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$',
> '^__.*__$', 'pinctrl-[0-9]+'
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix pd_tcpc0 and pd_tcpc1 node position on rk3399
      commit: 2b99e6196663199409540fb95798dba464e34343

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
