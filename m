Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E70C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3202E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgD0Tmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:42:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46444 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD0Tmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:42:36 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jT9eB-00007W-3u; Mon, 27 Apr 2020 21:42:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: swap interrupts interrupt-names rk3399 gpu node
Date:   Mon, 27 Apr 2020 21:42:25 +0200
Message-Id: <158801649141.50507.17010202047447992818.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200425143837.18706-1-jbx6244@gmail.com>
References: <20200425143837.18706-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 16:38:37 +0200, Johan Jonker wrote:
> Dts files with Rockchip rk3399 'gpu' nodes were manually verified.
> In order to automate this process arm,mali-midgard.txt
> has been converted to yaml. In the new setup dtbs_check with
> arm,mali-midgard.yaml expects interrupts and interrupt-names values
> in the same order. Fix this for rk3399.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/gpu/
> arm,mali-midgard.yaml
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: swap interrupts interrupt-names rk3399 gpu node
      commit: c604fd810bda667bdc20b2c041917baa7803e0fb

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
