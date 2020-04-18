Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA0C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E955F221F4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587220888;
	bh=8FF1v0rY69L8p6oHi3x5IgDbWvw9BTh5mmYIlqVDmCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qjUmpLUVeo7JfjYeH+G2/fb45L2/Dmkex/1NK6G9YPfuoNsQgRnX2X7ZWQqYqOHRh
	 6TePs1PLa/sBN8LTPFO91hyxvLAu8Y0aGgfw5zFZUSZbgXwX/MIYcXZ1iF8zDv6O3A
	 t6OLqCmcw6UGSWZbYMMaqyawWeaa+/6cynKogl3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgDROl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgDROlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:41:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EEE021D82;
        Sat, 18 Apr 2020 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220882;
        bh=8FF1v0rY69L8p6oHi3x5IgDbWvw9BTh5mmYIlqVDmCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PsjmSurHrRvV2RZjqI8ANFZUuxUG3ICOloLfIGHsVeQH48vSOnLdfbj6V95/rvpXB
         SSxMH+xBBkdHbHUQ62ChB12FIPtKJJLi3+tYNBEnKUhWYcVC/uFaB6xmS8UVEVqVpF
         +W9cYq+7qqPtlJvTQElUlT36HVOioLY3g/etDFsI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 27/78] kconfig: qconf: Fix a few alignment issues
Date:   Sat, 18 Apr 2020 10:39:56 -0400
Message-Id: <20200418144047.9013-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 60969f02f07ae1445730c7b293c421d179da729c ]

There are a few items with wrong alignments. Solve them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/qconf.cc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 82773cc35d356..0f8c77f847114 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -627,7 +627,7 @@ void ConfigList::updateMenuList(ConfigItem *parent, struct menu* menu)
 			last = item;
 			continue;
 		}
-	hide:
+hide:
 		if (item && item->menu == child) {
 			last = parent->firstChild();
 			if (last == item)
@@ -692,7 +692,7 @@ void ConfigList::updateMenuList(ConfigList *parent, struct menu* menu)
 			last = item;
 			continue;
 		}
-	hide:
+hide:
 		if (item && item->menu == child) {
 			last = (ConfigItem*)parent->topLevelItem(0);
 			if (last == item)
@@ -1225,10 +1225,11 @@ QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
 {
 	QMenu* popup = Parent::createStandardContextMenu(pos);
 	QAction* action = new QAction("Show Debug Info", popup);
-	  action->setCheckable(true);
-	  connect(action, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
-	  connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setOn(bool)));
-	  action->setChecked(showDebug());
+
+	action->setCheckable(true);
+	connect(action, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
+	connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setOn(bool)));
+	action->setChecked(showDebug());
 	popup->addSeparator();
 	popup->addAction(action);
 	return popup;
-- 
2.20.1

