Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB037C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD00221EF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444547;
	bh=03fCVU5g+JP9egRymhbYN0IgM6S53R3OBv/GHqButBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qOs9JIajtdT21tssrnx2TOVBskKKd5JZKPgqedpqadQ0KW/FgYyF3JhuQK+jVSdgN
	 rQIwIjrM9jpopCdc2b+omZNtUlIAm6BZBV5rQtC8msAXAMnyGCplwctGDy/nNfIr5h
	 XdVCkbmj/FPwxrGLMQD6Q+lM1o1Ud3KL2ucGShyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbgFRBm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731708AbgFRB30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:29:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686C922209;
        Thu, 18 Jun 2020 01:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443766;
        bh=03fCVU5g+JP9egRymhbYN0IgM6S53R3OBv/GHqButBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKRAVZ7ktGdUMrbz3FCXiAN6ZIbJUm+HKEMAmfzbT0cBuippokiHVU4BWecPAKRPL
         GKsgIvM/7mPYSQQBQeKEWAagMfrUPEhMYxACWehhKOCcBsXUm0XfS5/qbxvBEWq+pE
         VqkXyhv0JAIa6zJubkMS47CKPd77DxZJii7Xtvls=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roy Spliet <nouveau@spliet.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 51/80] drm/msm/mdp5: Fix mdp5_init error path for failed mdp5_kms allocation
Date:   Wed, 17 Jun 2020 21:27:50 -0400
Message-Id: <20200618012819.609778-51-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Spliet <nouveau@spliet.org>

[ Upstream commit e4337877c5d578722c0716f131fb774522013cf5 ]

When allocation for mdp5_kms fails, calling mdp5_destroy() leads to undefined
behaviour, likely a nullptr exception or use-after-free troubles.

Signed-off-by: Roy Spliet <nouveau@spliet.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
index ed7143d35b25..6224aca7cd29 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
@@ -769,7 +769,8 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 
 	return 0;
 fail:
-	mdp5_destroy(pdev);
+	if (mdp5_kms)
+		mdp5_destroy(pdev);
 	return ret;
 }
 
-- 
2.25.1

