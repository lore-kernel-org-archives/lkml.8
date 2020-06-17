Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6810C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CA521527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgFQI6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:58:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43348 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQI63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:58:29 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jlTtp-0006BR-SR; Wed, 17 Jun 2020 10:58:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     robh+dt@kernel.org,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>, sboyd@kernel.org,
        mturquette@baylibre.com
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ARM: Add Rockchip rk3288w support
Date:   Wed, 17 Jun 2020 10:58:23 +0200
Message-Id: <159238429476.1470505.6023847362048785737.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602080644.11333-1-mylene.josserand@collabora.com>
References: <20200602080644.11333-1-mylene.josserand@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 10:06:42 +0200, Mylène Josserand wrote:
> Context
> -------
> 
> Here is my V4 of my patches that add the support for the Rockchip
> RK3288w which is a revision of the RK3288. It is mostly the same SOC
> except for, at least, one clock tree which is different.
> This difference is only known by looking at the BSP kernel [1].
> 
> [...]

Applied, thanks!

[1/2] clk: rockchip: Handle clock tree for rk3288w variant
      commit: 1627f683636df70fb25358b0a7b39a24e8fce5bf
[2/2] dt-bindings: clocks: add rk3288w variant compatible
      commit: 00bd404144241155653bb0d0c15be51e4e6983aa

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
