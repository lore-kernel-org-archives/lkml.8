Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D3BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E826920658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692231;
	bh=NgurdkAyS3ZCan68jj+yrGYmGwZI9CQBOjFPTO0lW1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YiyJXQZPTvp/Ut81/u63yJt/wh/GFYJeRBrQxfXjRlkALwb7U0xHENx7D2FauKuSZ
	 1LePeiVqrJxqvQR83onbnveMt9+xbkYZVkBzJvN2Ev4CySJx4NyG3f/vA8XFCkgp28
	 It2rL+5B2IsKAm83GEDrNQFc2iDKPlRJ610d2FKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbgHQTXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730431AbgHQPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:35:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D9E20882;
        Mon, 17 Aug 2020 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678500;
        bh=NgurdkAyS3ZCan68jj+yrGYmGwZI9CQBOjFPTO0lW1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6y1gmQkGyMhhuLsgLVj6DUqLJs7i3yQp6aGJJ+g1IGzxkbNaMtZGyRtObW383iwZ
         N52Ustqab1ED6xP53QE92xDnqniai36Eqq9cYgr3soeTrbRJOKRXP2UuOg5Ea+WHF2
         3d96iG7viyJ84/dK75oydZkHt73MtXNBegxCz3EI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Auhagen <sven.auhagen@voleatech.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 324/464] cpufreq: ap806: fix cpufreq driver needs ap cpu clk
Date:   Mon, 17 Aug 2020 17:14:37 +0200
Message-Id: <20200817143849.312255244@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

[ Upstream commit 8c37ad2f523396e15cf002b29f8f796447c71932 ]

The Armada 8K cpufreq driver needs the Armada AP CPU CLK
to work. This dependency is currently not satisfied and
the ARMADA_AP_CPU_CLK can not be selected independently.

Add it to the cpufreq Armada8k driver.

Fixes: f525a670533d ("cpufreq: ap806: add cpufreq driver for Armada 8K")
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index c6cbfc8baf724..a967894c4613e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -41,6 +41,7 @@ config ARM_ARMADA_37XX_CPUFREQ
 config ARM_ARMADA_8K_CPUFREQ
 	tristate "Armada 8K CPUFreq driver"
 	depends on ARCH_MVEBU && CPUFREQ_DT
+	select ARMADA_AP_CPU_CLK
 	help
 	  This enables the CPUFreq driver support for Marvell
 	  Armada8k SOCs.
-- 
2.25.1



