Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F21FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3C522BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087297;
	bh=yzqgOeGUuulbsB4LN8mlMYgkUV39h4cYOiRjSlgDeqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KI+3QVJ2rCa6xdAa/MStAFJ9818OoJ555Hxhf0e1ui/zRlGTcuZc45zsPnL4J5L/s
	 XttvenvcTrkI6DPxa7llx3Q1sR3XKJvhrVr8cX2jOg0+/+AmUkKmkzyoYrdvG1mpUC
	 6cUCxSAgj0ji0eAzgnowP1/RwDYi8nrBJeM3XUw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgHJTVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729710AbgHJTNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:13:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E499F22BEA;
        Mon, 10 Aug 2020 19:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086801;
        bh=yzqgOeGUuulbsB4LN8mlMYgkUV39h4cYOiRjSlgDeqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDIY3MDKeLt62jvl5Bzanpa3EC3h7t8V55vBR9V3gb9nEOYsgRBdJDCwdIAofyfpN
         g6XuaMmZuOh29XZcutJfk/SUg1LQi/Gf3kSwIsx15z9oIcleQaEEIxVO8hQWtnWlp/
         TY6sJjB0JvX5/KDMyaqxeQsiZWV6Qm1VIeFDVDk0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 15/31] drm/debugfs: fix plain echo to connector "force" attribute
Date:   Mon, 10 Aug 2020 15:12:43 -0400
Message-Id: <20200810191259.3794858-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191259.3794858-1-sashal@kernel.org>
References: <20200810191259.3794858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Tretter <m.tretter@pengutronix.de>

[ Upstream commit c704b17071c4dc571dca3af4e4151dac51de081a ]

Using plain echo to set the "force" connector attribute fails with
-EINVAL, because echo appends a newline to the output.

Replace strcmp with sysfs_streq to also accept strings that end with a
newline.

v2: use sysfs_streq instead of stripping trailing whitespace

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20170817104307.17124-1-m.tretter@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 373bd4c2b698b..84b7b22a9590a 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -265,13 +265,13 @@ static ssize_t connector_write(struct file *file, const char __user *ubuf,
 
 	buf[len] = '\0';
 
-	if (!strcmp(buf, "on"))
+	if (sysfs_streq(buf, "on"))
 		connector->force = DRM_FORCE_ON;
-	else if (!strcmp(buf, "digital"))
+	else if (sysfs_streq(buf, "digital"))
 		connector->force = DRM_FORCE_ON_DIGITAL;
-	else if (!strcmp(buf, "off"))
+	else if (sysfs_streq(buf, "off"))
 		connector->force = DRM_FORCE_OFF;
-	else if (!strcmp(buf, "unspecified"))
+	else if (sysfs_streq(buf, "unspecified"))
 		connector->force = DRM_FORCE_UNSPECIFIED;
 	else
 		return -EINVAL;
-- 
2.25.1

