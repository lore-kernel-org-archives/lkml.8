Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765B7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4640B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698960;
	bh=pcbkx+SwLgZT+J5hp/YGrKAUBbwIW8u70spo763dbD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wH3SFc7CgA2WKa4EfUZdrEv+FqRV6thjO6kJQbxW7RM+bRt+vBZLx7dy1HdhguaUu
	 IPih6DLz0YEGlqSV+zqqr5LnmsLKeF17dqFkreIeypigxqvlZiSnWuN34WKJbH0HV4
	 2KCXVpT/S6/FigelEjEGr6KtCNJUJWuqhVF62+3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406558AbgBNQsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405275AbgBNQUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:20:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08FE324746;
        Fri, 14 Feb 2020 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697246;
        bh=pcbkx+SwLgZT+J5hp/YGrKAUBbwIW8u70spo763dbD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4dw4lW1L9uYSVk3lwFEBbWMYCd2NiWr/zDq3zGrK58Ny5UaqUmbkDUKXepyr2pmR
         gyGYwrChCUfsjM0rghjpUk83aioGqzfmd3AlV0Yq+GIgbKQUBZjl0N82f5owufUN3b
         8ZXY/4cueam1p0Von78i+6BXoGPVikfcgsl8nQ+c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 164/186] iwlegacy: ensure loop counter addr does not wrap and cause an infinite loop
Date:   Fri, 14 Feb 2020 11:16:53 -0500
Message-Id: <20200214161715.18113-164-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c2f9a4e4a5abfc84c01b738496b3fd2d471e0b18 ]

The loop counter addr is a u16 where as the upper limit of the loop
is an int. In the unlikely event that the il->cfg->eeprom_size is
greater than 64K then we end up with an infinite loop since addr will
wrap around an never reach upper loop limit. Fix this by making addr
an int.

Addresses-Coverity: ("Infinite loop")
Fixes: be663ab67077 ("iwlwifi: split the drivers for agn and legacy devices 3945/4965")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 8d5acda92a9b8..6e6b124f0d5e3 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -717,7 +717,7 @@ il_eeprom_init(struct il_priv *il)
 	u32 gp = _il_rd(il, CSR_EEPROM_GP);
 	int sz;
 	int ret;
-	u16 addr;
+	int addr;
 
 	/* allocate eeprom */
 	sz = il->cfg->eeprom_size;
-- 
2.20.1

