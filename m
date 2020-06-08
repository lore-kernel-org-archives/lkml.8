Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E0BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A2820842
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662932;
	bh=t8k+A26nle/JylAK0rDU4ayMbCakUSWlwZOpncrVqrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qOVPOx3/5IxdYJHLmfJEuMDVqrH+IE7ox2YVwhdASbH7VK5FAt0eKWMssMm/MxnTo
	 cwUPgem3pJ++e4R18Tr8TFwcRlQ6rBFUQKAMVROGK56ekO1qt7XaYlrYuaZnwy1QB+
	 Jz96qPLCc2Ur7Q90JrDotIzP324gK47NnOObrGBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbgFIAfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbgFHXO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C800921582;
        Mon,  8 Jun 2020 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658067;
        bh=t8k+A26nle/JylAK0rDU4ayMbCakUSWlwZOpncrVqrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJRJpktBCbWglKwcsT4L70nh3m6HsfpyW/RVC4/3avtDawY2VuAXazFE2pXXccH84
         zGXDO0CWjBEIawufyHxwZLAEi43+plskiBh/Apf6uTAaXsHjEkhsuTnFu4jIQWIz4x
         wyDC8bhmZJbkb8C1Vddl79Twn+Ugv5NpetolycDI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 113/606] component: Silence bind error on -EPROBE_DEFER
Date:   Mon,  8 Jun 2020 19:03:58 -0400
Message-Id: <20200608231211.3363633-113-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
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
index c7879f5ae2fb..53b19daca750 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -256,7 +256,8 @@ static int try_to_bring_up_master(struct master *master,
 	ret = master->ops->bind(master->dev);
 	if (ret < 0) {
 		devres_release_group(master->dev, NULL);
-		dev_info(master->dev, "master bind failed: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_info(master->dev, "master bind failed: %d\n", ret);
 		return ret;
 	}
 
@@ -610,8 +611,9 @@ static int component_bind(struct component *component, struct master *master,
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
2.25.1

