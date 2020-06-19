Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61021C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313CB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584940;
	bh=w96C5JcmLJzPwAqpvSgNRFgF+RlRL5FkxBIIA1WKEbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F9Txij2ofe1+0dUFMMXhZlY39fx+x2DcTKh02/jUcDmAmGr86v9bvyEzP9g6KFrzV
	 QuFkrjIrqoJhvg1ko+IpePWXz8pdNSDKz+Zrl9FhpOBu9vjIvZlXXGw2ri7zwBNJKR
	 LR04vwaLsrtezDs5QA3xxZWEL9iwwAFOTBTyNakE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394076AbgFSQmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388577AbgFSOod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:44:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD4221556;
        Fri, 19 Jun 2020 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577873;
        bh=w96C5JcmLJzPwAqpvSgNRFgF+RlRL5FkxBIIA1WKEbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5MquRJgJIREd7LFMq2QmasYlepbH4jnvKk7tvG887YTzWsVdn9hlVylfL8KtJJyw
         5MpNWYdkiJorQNbAZa/7TVuWaav2pjx/lCy8OMp04Kj7DHXhwVIPo//TRymH3pvcN1
         2fY8exzmZxvAoWZRgY4bduPINhYYucgyMjUVq8Yw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 094/128] mmc: sdhci-esdhc-imx: fix the mask for tuning start point
Date:   Fri, 19 Jun 2020 16:33:08 +0200
Message-Id: <20200619141625.109869957@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit 1194be8c949b8190b2882ad8335a5d98aa50c735 ]

According the RM, the bit[6~0] of register ESDHC_TUNING_CTRL is
TUNING_START_TAP, bit[7] of this register is to disable the command
CRC check for standard tuning. So fix it here.

Fixes: d87fc9663688 ("mmc: sdhci-esdhc-imx: support setting tuning start point")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/r/1590488522-9292-1-git-send-email-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 445fc47dc3e7..b4336534f628 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -79,7 +79,7 @@
 #define ESDHC_STD_TUNING_EN		(1 << 24)
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
 #define ESDHC_TUNING_START_TAP_DEFAULT	0x1
-#define ESDHC_TUNING_START_TAP_MASK	0xff
+#define ESDHC_TUNING_START_TAP_MASK	0x7f
 #define ESDHC_TUNING_STEP_MASK		0x00070000
 #define ESDHC_TUNING_STEP_SHIFT		16
 
-- 
2.25.1



