Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F509C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4664E214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583180084;
	bh=PuE8ZCiJD8DgMUZwzGmLaQNAO/btEjzMcvcDwImLPRc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VAorQALYxKtsCxmZa7ITVlo9h1prh100lREHbytpdpbxKfiWW9JxygXpyvHYUymDJ
	 uAoeGgSprWZDSKjYVjP45Y633KbzRDQIIez8f4qikCE3t4A9mcIuyY2awRXxp6FTNa
	 BBIytSZMQ2CK5pmjrOjs2tARukS+0IGYTi2N4zkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgCBUOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBUOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:14:42 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E9B21D56;
        Mon,  2 Mar 2020 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583180082;
        bh=PuE8ZCiJD8DgMUZwzGmLaQNAO/btEjzMcvcDwImLPRc=;
        h=From:To:Cc:Subject:Date:From;
        b=pH6zHLMzR8wKLWannlMNzbF6n8IV/94M6grkFg1hmgkH1X3uzvs47/kmy5RCdhOol
         myNpCfEFbSR8JT+Go83VmjeR6nAAgacBHNLKN2HheiFcYpM/5f2cepxKivhKN7ftHZ
         veSyirT1zAk14pSlCMU3T4fGPVw0Hyps3iK2B+vY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] soc: fsl: Enable compile testing of FSL_RCPM
Date:   Mon,  2 Mar 2020 21:14:36 +0100
Message-Id: <20200302201436.17030-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSL_RCPM can be compile tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 4df32bc4c7a6..e142662d7c99 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -43,7 +43,7 @@ config DPAA2_CONSOLE
 
 config FSL_RCPM
 	bool "Freescale RCPM support"
-	depends on PM_SLEEP && (ARM || ARM64)
+	depends on PM_SLEEP && (ARM || ARM64 || COMPILE_TEST)
 	help
 	  The NXP QorIQ Processors based on ARM Core have RCPM module
 	  (Run Control and Power Management), which performs all device-level
-- 
2.17.1

