Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A30C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B32206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596385123;
	bh=8CP467njzFcgw1TGSpA5nswBzbqiPPWk079ixyaizAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k6ihbkBu1jxrPRBx3ct8Fwl/6EyNlQluuSZSmTC0/fGbbdW+hVc5cxPOB5yMFmXWC
	 QNJ4udL188P1gukbnZwsCHp/r2FXTglj0TQetU0NgVEcYbwcxC9E281kjFsYJ7GBhK
	 p+l10ce3KHjluRkwGBU5ax7QZAxGyRny7p2sGr2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgHBQSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:18:41 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:48897 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgHBQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:18:06 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 072GHOaj003720;
        Mon, 3 Aug 2020 01:17:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 072GHOaj003720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596385048;
        bh=JUASlDdYi9Wry5HM8MJA4Tibcs9HL5OwbAaKk04di+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAog5cgPDYhj605TPdzfy4AsA3biykyR3Et873GvJdYC4evWxEaoHppQvIrkGSLo3
         OUJWP/KNTNf7Ujo6SqjoVLwDxfPmipcDmObrvoh+KxacTJrhL6x8LvnAJYX67empJW
         pNvyrJOQEYAuKCfomE3/mhWzlgKQRTo10EltKQD4ktZbVIuHBBXKYVNPCO97p1GZxv
         S/VAh/8CPR4cS0AB0DaTHPoRAaECgQQoNPaEHb5DimaKXjpfzCAoenWdjFqJorwSgr
         WNsOxkX0/CzGLJ0ISvI3ntzapzPDWtqCM3bFYaMYx1x6YXr5Z6gcq4jJXUsAIrfykB
         Dz0ZGCe8HuT8Q==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] kconfig: qconf: remove unused argument from ConfigList::updateList()
Date:   Mon,  3 Aug 2020 01:17:13 +0900
Message-Id: <20200802161721.921721-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200802161721.921721-1-masahiroy@kernel.org>
References: <20200802161721.921721-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function allocates 'item' before using it, so the argument 'item'
is always shadowed.

Remove the meaningless argument.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 6 +++---
 scripts/kconfig/qconf.h  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 81d55e75cf71..e65a323754fd 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -404,15 +404,15 @@ void ConfigList::updateSelection(void)
 		emit menuSelected(menu);
 }
 
-void ConfigList::updateList(ConfigItem* item)
+void ConfigList::updateList()
 {
 	ConfigItem* last = 0;
+	ConfigItem *item;
 
 	if (!rootEntry) {
 		if (mode != listMode)
 			goto update;
 		QTreeWidgetItemIterator it(this);
-		ConfigItem* item;
 
 		while (*it) {
 			item = (ConfigItem*)(*it);
@@ -989,7 +989,7 @@ void ConfigView::updateList(ConfigItem* item)
 	ConfigView* v;
 
 	for (v = viewList; v; v = v->nextView)
-		v->list->updateList(item);
+		v->list->updateList();
 }
 
 void ConfigView::updateListAll(void)
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 335f0776984f..4dc5d34a6bca 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -69,7 +69,7 @@ class ConfigList : public QTreeWidget {
 public slots:
 	void setRootMenu(struct menu *menu);
 
-	void updateList(ConfigItem *item);
+	void updateList();
 	void setValue(ConfigItem* item, tristate val);
 	void changeValue(ConfigItem* item);
 	void updateSelection(void);
@@ -85,7 +85,7 @@ public slots:
 	void updateListAll(void)
 	{
 		updateAll = true;
-		updateList(NULL);
+		updateList();
 		updateAll = false;
 	}
 	void addColumn(colIdx idx)
-- 
2.25.1

