Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7764AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514FF20781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653816;
	bh=WZm9NVwm/5hzx3Z8PKdERAEM9pbyT8kA/yFB5RQ6bAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dLGNC3vhDSSy2nuPmUM4nYk9OQK+KCo0/StMXNKu+oReH0ohOXQ56pwt1sxL6kH4/
	 VF0xn8zd+zJ04nqxrMvR3qI2r6WNYYTkB4DQ3Jon3iMfSLo43ZFJNR+sh6Mwrd1pnB
	 d2bxk1MLs3G13iC43zH6H8dh50gqzoITMQiw9FiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgGBBgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgGBBXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D70C2085B;
        Thu,  2 Jul 2020 01:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593652985;
        bh=WZm9NVwm/5hzx3Z8PKdERAEM9pbyT8kA/yFB5RQ6bAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8qGi+cWwAXzgnN6FLYCB1u4BypWGDm8WUi2uwBLIp3Hp8T+V/fhHja7q6lNT/SSA
         8qj4kSxrGkRn+hv6NAHDs/Igh8w7Z5wP5eQrHVEYj5g6uhzvDrNxo8C+ACSizRL94t
         jEYH2+lDD3YaMXTFy4rBLd/rA/Yt9TdL691MOQOU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 08/53] gpu: host1x: Clean up debugfs in error handling path
Date:   Wed,  1 Jul 2020 21:21:17 -0400
Message-Id: <20200702012202.2700645-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 109be8b23fb2ec8e2d309325ee3b7a49eab63961 ]

host1x_debug_init() must be reverted in an error handling path.

This is already fixed in the remove function since commit 44156eee91ba
("gpu: host1x: Clean up debugfs on removal")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index d24344e919227..3c0f151847bae 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -468,11 +468,12 @@ static int host1x_probe(struct platform_device *pdev)
 
 	err = host1x_register(host);
 	if (err < 0)
-		goto deinit_intr;
+		goto deinit_debugfs;
 
 	return 0;
 
-deinit_intr:
+deinit_debugfs:
+	host1x_debug_deinit(host);
 	host1x_intr_deinit(host);
 deinit_syncpt:
 	host1x_syncpt_deinit(host);
-- 
2.25.1

