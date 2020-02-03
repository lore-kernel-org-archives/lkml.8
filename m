Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F881C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0C120838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748187;
	bh=BzlMyKwXv75wjNabzgbZkYoVsn31ZotCYKArAXaw3lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZjZPHafH463Oxgm0MN4Xl+xcNtnQ/8rIOC545DdRusot6oqd/8MTkaZh7J6gA7F7
	 0013ix8PrHZ/HarKit2/yT/8an8NTHnl2XhZmA07h7s6uZ1O4G5tN6dNzgZZB7l3aT
	 lUXZacYoDIZGtCilk8ingyh4CDOv8ZLVc1rGhAEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgBCQnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbgBCQdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:21 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F48A2051A;
        Mon,  3 Feb 2020 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747601;
        bh=BzlMyKwXv75wjNabzgbZkYoVsn31ZotCYKArAXaw3lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxQPMXyckgEVT/csYH9Ujl69a0GeCQwVNNhKEFZcp5/syIkDLe0hSbl4+F3pj+qPn
         y5JzjctzpfizDd2P+wrMQ4BbtLKk91l6NbW6G/vDLc3yER0aIHR9kURDuhjKuy27s2
         shR20o7O5kC4tIiyp9DUC97QD9kgt/7j+B9Og7oU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raag Jadav <raagjadav@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 63/70] ARM: dts: am43x-epos-evm: set data pin directions for spi0 and spi1
Date:   Mon,  3 Feb 2020 16:20:15 +0000
Message-Id: <20200203161921.249600649@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raag Jadav <raagjadav@gmail.com>

[ Upstream commit b0b03951544534d6d9ad4aa2787eefec988fff20 ]

Set d0 and d1 pin directions for spi0 and spi1 as per their pinmux.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 12735cf9674bb..b6950eee550b2 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -839,6 +839,7 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&spi0_pins_default>;
 	pinctrl-1 = <&spi0_pins_sleep>;
+	ti,pindir-d0-out-d1-in = <1>;
 };
 
 &spi1 {
@@ -846,6 +847,7 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&spi1_pins_default>;
 	pinctrl-1 = <&spi1_pins_sleep>;
+	ti,pindir-d0-out-d1-in = <1>;
 };
 
 &usb2_phy1 {
-- 
2.20.1



