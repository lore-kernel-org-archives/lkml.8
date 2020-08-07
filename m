Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9604C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8868C2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596792078;
	bh=ArXZfMLzpJBw8O0Hzt6GiokB589sF6f4hSyc89wVJ/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pdpHF6fLzWYgKJaLOU1ADDgRm86PC/3T4lq4NjLnGgpQO5T8dWcuQRwu3SCOHbt9h
	 JRPf3w8QlUMs2uD9iF+TcYBakURivooLP1wFTA3QW1BeiJbSxyvwVb/TR4BRt01cVr
	 VB9u6dmTCHUdnoIx7z53M1MvvCr6G6hTWQOIFT6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHGJVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:21:12 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:41487 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgHGJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:19:36 -0400
Received: from localhost.localdomain (softbank060134047170.bbtec.net [60.134.47.170]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0779JBQ5032147;
        Fri, 7 Aug 2020 18:19:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0779JBQ5032147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596791959;
        bh=wcQtGbOj9XhHI6wWL7vZJQ63g4ziMw2pUhgbDBbdCek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmu7h0Asv4aQ4U6rI66EVNpzQXcJu1zZ9z99DYPzKb12bPs45M9ESQCHAalLonq5R
         dQr42LisLxu0V31JDp/NrplWi0dNCwmM75cofKox0t59sKKWufwpM5r6TWAVpjEg3h
         zVq22PV85x2g7KkqaljOyp3KU9PnZRbUdVmeAkb/Y4/UFW87zgRbyK2dtx1sUKXNkW
         eUuJiuk68+zNu+cCQOfARqeo41dRkggwFMRXcAg2B/rkpLEfJztR0/VorCNpYFr1nT
         MFLGBBQTHlFHO2XvJ7RVaGT3C62tY8DCjzqNPe4M7yuSTFm1IRK7sP1Mj26FG2OZEd
         XymffCisAm4Cg==
X-Nifty-SrcIP: [60.134.47.170]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/19] kconfig: qconf: remove unused argument from ConfigList::updateList()
Date:   Fri,  7 Aug 2020 18:18:59 +0900
Message-Id: <20200807091909.2985787-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807091909.2985787-1-masahiroy@kernel.org>
References: <20200807091909.2985787-1-masahiroy@kernel.org>
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

(no changes since v1)

 scripts/kconfig/qconf.cc | 6 +++---
 scripts/kconfig/qconf.h  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 0b93db2d61aa..8455f81e101f 100644
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

