Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E80206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948135;
	bh=c5PBEyrq6Isn5nYvsMxu0Ja/Wt4szMFeEaEcyPF8RIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzSx+uwqW0NDUsLU5USgv0wRQuyr2R821laAnYOkt02oXwB+tno6SMxirp+fIEPog
	 TQyZWMbITEm0jBmDx3CIIwx7rFC+JAoh/qpRO1gQcVAyJJD43QlzZO4kCKQHAZgfbz
	 ozys5EcXckfqFlSpe/+s5/oE5FHEF5QF/Ve0MLW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393803AbgFWVfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388264AbgFWUKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:10:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B952C20CC7;
        Tue, 23 Jun 2020 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943022;
        bh=c5PBEyrq6Isn5nYvsMxu0Ja/Wt4szMFeEaEcyPF8RIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlypjatDnmT4e0jB5ERSRX7JFuun/zTMEoNHeDM9DV9XQL8tnIzPuHUSjie63vSZ5
         C1ZA3KLBrDmdzng3sm5QNh0P4IhrXGnZHnRb4qZUEpVCe0G8ol+yZ7Okw/PzIhcDdV
         IBJOMioc6eNe4VSC2jKL64lkoXDeEB3a0nUqwDlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roy Spliet <nouveau@spliet.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 228/477] drm/msm/mdp5: Fix mdp5_init error path for failed mdp5_kms allocation
Date:   Tue, 23 Jun 2020 21:53:45 +0200
Message-Id: <20200623195418.358352979@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
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
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 47b989834af16..c23a2fa13fb97 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -943,7 +943,8 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 
 	return 0;
 fail:
-	mdp5_destroy(pdev);
+	if (mdp5_kms)
+		mdp5_destroy(pdev);
 	return ret;
 }
 
-- 
2.25.1



