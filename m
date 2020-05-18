Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF22C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26CB20756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgERWml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:42:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52962 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgERWmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:42:40 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoT0-0000DN-Uw; Tue, 19 May 2020 00:42:39 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: add bus-width properties to mmc nodes for px30.dtsi
Date:   Tue, 19 May 2020 00:42:37 +0200
Message-Id: <158984175365.2264243.14630667398753198315.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416183053.6045-1-jbx6244@gmail.com>
References: <20200416183053.6045-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 20:30:53 +0200, Johan Jonker wrote:
> 'bus-width' and pinctrl containing the bus-pins
> should be in the same file, so add them to
> all mmc nodes in 'px30.dtsi'.

Applied, thanks!

[1/1] arm64: dts: rockchip: add bus-width properties to mmc nodes for px30
      commit: fb0ab17f1ab750d9662ec6b9fb3aa541a8ac1f5c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
