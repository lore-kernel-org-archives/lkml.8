Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF7EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2DA20656
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945173;
	bh=UVp5OmduPnw/nEMLzWnUN8SYvlWYf5TeIche6W/rs3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=owGeE056K8LO8BMKRzhq/pyILYnyLmzbocR08C3PBYVItqHZ5HeduIRRKkm1HQlUf
	 Ustw+9I39Z2azyS9xe0DnPZd0OJVadfyjJX/QerhrFyzm8Nohk+tpiAJWQdtbtK8uD
	 wmh+f3eVHiPSf9rDzrDfPb6QYZib2k0Hw5f0KIZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392447AbgFWUqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392800AbgFWUqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:46:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8CC2098B;
        Tue, 23 Jun 2020 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945162;
        bh=UVp5OmduPnw/nEMLzWnUN8SYvlWYf5TeIche6W/rs3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYx+oibkR1mukYvOBo3G4xTtEBbO5/NiXPyACNy8BYaCWJo/I8/Ib1qOkmYcWBbDC
         dEyvQZ82P1XgbF/px0bJuUmGfZDqLMsSrOkNe6Pv/H+meAdhw6/goaP2tLJk68LZSl
         e4nf3gS3GnzFYg0JlzBYfQP50y+70lkzVl00c4rs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roy Spliet <nouveau@spliet.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 062/136] drm/msm/mdp5: Fix mdp5_init error path for failed mdp5_kms allocation
Date:   Tue, 23 Jun 2020 21:58:38 +0200
Message-Id: <20200623195306.812414837@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f7c0698fec401..791a74b9907d8 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
@@ -972,7 +972,8 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 
 	return 0;
 fail:
-	mdp5_destroy(pdev);
+	if (mdp5_kms)
+		mdp5_destroy(pdev);
 	return ret;
 }
 
-- 
2.25.1



