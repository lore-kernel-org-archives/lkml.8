Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43630C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131CB2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863947;
	bh=iGIVwKh4dEiyG5aVdrsAeG2XRuSXCWOm8Ve0WVQRsdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nYLbONZb0hxq46sv9LY7KtpUUQYEfiKBMTL6GhSTfaE5doWImePyHuAEgjlKa0Gsa
	 aT+FCJfyrFfregCiqaA+dDdAQM9ztmOt2tHAvkV+v+BueHpTsuBowVmGsnDxRwuFQ7
	 qI2ypnX6pOgqDddxJPqZ9xnPzsg4t+IQG/5N2utI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbgAXLFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388880AbgAXLFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:05:44 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FCD2075D;
        Fri, 24 Jan 2020 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863943;
        bh=iGIVwKh4dEiyG5aVdrsAeG2XRuSXCWOm8Ve0WVQRsdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUhxYINn42nRl95V64zGWZa8prpzqWDlFv+tH5CE1sTjKEq4MMQfgdA70ilkU2m4T
         ucQPLjwlkAwZwiJHP5LbsO7yeXAs2BoXnkMgzVerq0llpxXMSqKA0Op/+dcDFinBqX
         btDeNueOQMmacHa/ri7LG+kmbPCf/FT0f/d+UyVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 116/639] arm64: defconfig: Re-enable bcm2835-thermal driver
Date:   Fri, 24 Jan 2020 10:24:46 +0100
Message-Id: <20200124093101.855399873@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index db8d364f84768..1a4f8b67bbe80 100644
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



