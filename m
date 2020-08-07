Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F63C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48EE20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596792033;
	bh=PCCMQ+e8IOq/n7lHMEagBTG2jDrHDhpxYyFVZyI+vLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KK4rJjdQdIgM2iAChxK9ZqZ7vVl1Q4HOmNQVxK4ElsbwrTgkKSk+MhWERNb5ecip7
	 7CdL16UZ+QmivXdK3pGga5QJof/9ZleCCF0MDjQtbOLzldOjDz/daGNDqaNa1raCI3
	 IYrpgiftsN/fT7/KV91LIJbpvQOLmN3Auny3TZFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHGJUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:20:31 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:41591 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgHGJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:19:40 -0400
Received: from localhost.localdomain (softbank060134047170.bbtec.net [60.134.47.170]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0779JBQ7032147;
        Fri, 7 Aug 2020 18:19:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0779JBQ7032147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596791961;
        bh=EJhoMRVdg1iJz0MBe3Kh5K5U+at9Y10mnIWZA0y2KL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+Uzc6mPyPLS/bwDdxzoFNlqCTEyjgY41G6c6Xmko6mEpkBGCdch8/jmnBpulnOYz
         w/VwujH7yyZqlcl608uxOC/WZ71tSDKUNit+mt9P8D3NYi/oVW0qYy+MzJiiBLkjy0
         0cJ3hfXu+AuujTsK/W3EHflObQ4Odcb59oXh+8/ay8YFrTlkqdfyd9umpXVFOLVfus
         poXt9wMuCzj7GxIHc4sUhopJArR3NLcyP0NMO8FKJuR/ME4zlFeKded6regXZ9+GS4
         I0toRGnm3Njb5ldyVsrxIIx1+qwuGkq4g9GWNIG7IYGcLcmBjfxlSEl1xaHyUkUxi3
         auPHhSK88GJMg==
X-Nifty-SrcIP: [60.134.47.170]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/19] kconfig: qconf: remove 'parent' from ConfigList::updateMenuList()
Date:   Fri,  7 Aug 2020 18:19:01 +0900
Message-Id: <20200807091909.2985787-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807091909.2985787-1-masahiroy@kernel.org>
References: <20200807091909.2985787-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the call-sites of this function pass 'this' to the first argument.

So, 'parent' is always the 'this' pointer.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/kconfig/qconf.cc | 18 +++++++++---------
 scripts/kconfig/qconf.h  |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 808bc311e335..604f7855b070 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -446,7 +446,7 @@ void ConfigList::updateList()
 		return;
 	}
 update:
-	updateMenuList(this, rootEntry);
+	updateMenuList(rootEntry);
 	update();
 	resizeColumnToContents(0);
 }
@@ -524,7 +524,7 @@ void ConfigList::setRootMenu(struct menu *menu)
 	type = menu && menu->prompt ? menu->prompt->type : P_UNKNOWN;
 	if (type != P_MENU)
 		return;
-	updateMenuList(this, 0);
+	updateMenuList(0);
 	rootEntry = menu;
 	updateListAll();
 	if (currentItem()) {
@@ -628,7 +628,7 @@ hide:
 	}
 }
 
-void ConfigList::updateMenuList(ConfigList *parent, struct menu* menu)
+void ConfigList::updateMenuList(struct menu* menu)
 {
 	struct menu* child;
 	ConfigItem* item;
@@ -637,19 +637,19 @@ void ConfigList::updateMenuList(ConfigList *parent, struct menu* menu)
 	enum prop_type type;
 
 	if (!menu) {
-		while (parent->topLevelItemCount() > 0)
+		while (topLevelItemCount() > 0)
 		{
-			delete parent->takeTopLevelItem(0);
+			delete takeTopLevelItem(0);
 		}
 
 		return;
 	}
 
-	last = (ConfigItem*)parent->topLevelItem(0);
+	last = (ConfigItem*)topLevelItem(0);
 	if (last && !last->goParent)
 		last = 0;
 	for (child = menu->list; child; child = child->next) {
-		item = last ? last->nextSibling() : (ConfigItem*)parent->topLevelItem(0);
+		item = last ? last->nextSibling() : (ConfigItem*)topLevelItem(0);
 		type = child->prompt ? child->prompt->type : P_UNKNOWN;
 
 		switch (mode) {
@@ -670,7 +670,7 @@ void ConfigList::updateMenuList(ConfigList *parent, struct menu* menu)
 			if (!child->sym && !child->list && !child->prompt)
 				continue;
 			if (!item || item->menu != child)
-				item = new ConfigItem(parent, last, child, visible);
+				item = new ConfigItem(this, last, child, visible);
 			else
 				item->testUpdateMenu(visible);
 
@@ -683,7 +683,7 @@ void ConfigList::updateMenuList(ConfigList *parent, struct menu* menu)
 		}
 hide:
 		if (item && item->menu == child) {
-			last = (ConfigItem*)parent->topLevelItem(0);
+			last = (ConfigItem*)topLevelItem(0);
 			if (last == item)
 				last = 0;
 			else while (last->nextSibling() != item)
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 6d06ec399ff0..952bd98d7912 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -102,7 +102,7 @@ public slots:
 	bool menuSkip(struct menu *);
 
 	void updateMenuList(ConfigItem *parent, struct menu*);
-	void updateMenuList(ConfigList *parent, struct menu*);
+	void updateMenuList(struct menu *menu);
 
 	bool updateAll;
 
-- 
2.25.1

