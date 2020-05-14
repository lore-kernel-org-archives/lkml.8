Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B04C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16CFC2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483063;
	bh=QmC4m5mXZHaMI4Sh7VoOV4veEBs0bq66Ru4UrSkVv5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SAE+po4KdbgYMg6MlIMfEQB24oC1LQPokNxUOwE+D5Mtd/MWfM7q6hRjUNVw4GmlD
	 Ht3ew/uNXxyZfqPaPALGrbEzA/f7FLDpWRMggSbL4EKIRmZx9bAO+dO2zMviEp9nH+
	 VfKBSr2pAq0584P4fKlcJPqXm2Kz9mQ/4HNmXYAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgENTEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbgENSyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:54:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D94206F1;
        Thu, 14 May 2020 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482471;
        bh=QmC4m5mXZHaMI4Sh7VoOV4veEBs0bq66Ru4UrSkVv5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3mlvct7Yn6Hc9smu2TwH8WewCIiNkpZf82CSrOEg91k/Ng7Zxr9R40RfZc7h8sQ+
         p7ij3vd7biE5dUQJXvyrw63Kg1DGLVe2rilTJeph3GPwfzjovVJjn8ZeuGC4g6+9HZ
         FCqGZHCSuUxuI7xIlF4q71V2f+ZsK3x3y5yS/+40=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 14/31] component: Silence bind error on -EPROBE_DEFER
Date:   Thu, 14 May 2020 14:53:56 -0400
Message-Id: <20200514185413.20755-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185413.20755-1-sashal@kernel.org>
References: <20200514185413.20755-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Hilliard <james.hilliard1@gmail.com>

[ Upstream commit 7706b0a76a9697021e2bf395f3f065c18f51043d ]

If a component fails to bind due to -EPROBE_DEFER we should not log an
error as this is not a real failure.

Fixes messages like:
vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
vc4-drm soc:gpu: master bind failed: -517

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Link: https://lore.kernel.org/r/20200411190241.89404-1-james.hilliard1@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/component.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 7f7c4233cd314..ee4d3b388f447 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -235,7 +235,8 @@ static int try_to_bring_up_master(struct master *master,
 	ret = master->ops->bind(master->dev);
 	if (ret < 0) {
 		devres_release_group(master->dev, NULL);
-		dev_info(master->dev, "master bind failed: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_info(master->dev, "master bind failed: %d\n", ret);
 		return ret;
 	}
 
@@ -506,8 +507,9 @@ static int component_bind(struct component *component, struct master *master,
 		devres_release_group(component->dev, NULL);
 		devres_release_group(master->dev, NULL);
 
-		dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
-			dev_name(component->dev), component->ops, ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
+				dev_name(component->dev), component->ops, ret);
 	}
 
 	return ret;
-- 
2.20.1

