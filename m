Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C85EC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B305206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200803;
	bh=3HHfS9JyXTsPeo4L+d32CBBCjD70uuHQHAkyQG+Vet0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WYfQPPTeU1vRIG6tH23uISs/T0sKEQPBJiyadnHvAk04ARyDM0HwCiLFqd9NvuPli
	 smJU1LQuG3OFTZhOWM5wAW37HJx2LeksCgox+z0UUFsL2GIvZKMfjXBDcUcmdgdnZk
	 fAhX7R9jlXmpGjGwEWKzy6TvAa1JCq0W0/nfTK8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436958AbgAPSxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:53:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388563AbgAPRIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:08:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B15A2467E;
        Thu, 16 Jan 2020 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194496;
        bh=3HHfS9JyXTsPeo4L+d32CBBCjD70uuHQHAkyQG+Vet0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsKXi8THRlduP2alsLDLBH4iDyaPv00XqYbBhU1Y5IMtH490i86yo9B7PXt1B+VOv
         RGkVoFp7/zhGnNIGNR+Bmpga0zDZwks9jJdfxDO2bO2dvk7ymCQVY9Xd7y9TnT0TW6
         +6bJjPBdwRde+g994qVkXcpYwb7CNTJtiHxlWC/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 393/671] phy: qcom-qusb2: fix missing assignment of ret when calling clk_prepare_enable
Date:   Thu, 16 Jan 2020 12:00:31 -0500
Message-Id: <20200116170509.12787-130-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit d98010817a26eba8d4d1e8a639e0b7d7f042308a ]

The error return from the call to clk_prepare_enable is not being assigned
to variable ret even though ret is being used to check if the call failed.
Fix this by adding in the missing assignment.

Addresses-Coverity: ("Logically dead code")
Fixes: 891a96f65ac3 ("phy: qcom-qusb2: Add support for runtime PM")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 69c92843eb3b..9b7ae93e9df1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -526,7 +526,7 @@ static int __maybe_unused qusb2_phy_runtime_resume(struct device *dev)
 	}
 
 	if (!qphy->has_se_clk_scheme) {
-		clk_prepare_enable(qphy->ref_clk);
+		ret = clk_prepare_enable(qphy->ref_clk);
 		if (ret) {
 			dev_err(dev, "failed to enable ref clk, %d\n", ret);
 			goto disable_ahb_clk;
-- 
2.20.1

