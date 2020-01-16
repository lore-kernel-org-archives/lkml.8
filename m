Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D24C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C57F22525
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193960;
	bh=LWfOhuUCSRHlkBTUYtRzpo2sbP9fou7RPxTKLQqvUxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9dTPm+IqNLKRi5RM732Q5LOqyt9FObUTZpvguT+oReFr21J63djAsir9NJSvwNG5
	 sG1ggUQKfRVGXq37S63t8nDEH58JLxBFGa06nz7B0YtZwvGjl3GZQGI3s1WyJBV4ED
	 G4jrr98Df3qIkKmQntzX6xixc7TGVvmIjkKE2cvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbgAPQ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbgAPQ50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983BF2467E;
        Thu, 16 Jan 2020 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193846;
        bh=LWfOhuUCSRHlkBTUYtRzpo2sbP9fou7RPxTKLQqvUxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTfODH++/Jf/b3aFCy3tDQ7/ffBVSnPUTI6ndtZLk1lCcjpKJa4xq93+Uzr5uKu2u
         qQY4bkGfGoYwp7MTd6TVlYN+MOS4x4e/hbDC/1W/z+EPtWM2/KiFWs0HonBJ3x5kKa
         Dru8a8DQRFAM59cscwcA4dzQsfnG+feobVPSHj8A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 099/671] arm64: defconfig: Re-enable bcm2835-thermal driver
Date:   Thu, 16 Jan 2020 11:45:30 -0500
Message-Id: <20200116165502.8838-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 4d9226fd9a0d747030575d7cb184b30c6e64f155 ]

The bcm2835-thermal driver was added with commit ac178e4280e6
("ARM64: bcm2835: add thermal driver to default config"). Unfortunately
this was accidentally dropped by commit eb1e6716cc9c
("arm64: defconfig: sync with savedefconfig"). So enable the driver again.

Fixes: eb1e6716cc9c ("arm64: defconfig: sync with savedefconfig")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364f8476..1a4f8b67bbe8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -365,6 +365,7 @@ CONFIG_THERMAL_EMULATION=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_TEGRA_BPMP_THERMAL=m
-- 
2.20.1

