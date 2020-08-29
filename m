Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E19C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2888206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598688936;
	bh=ejdFeGYSJEDJKBzEdypLhEyussjVuaEcy95Qo0TI4ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ouY0dzrKvw9ZyuCWyFurDipP5cAAvQOcBNUmntzdHmbLM8Z3SKYV2nYh0CEdLyyTo
	 fbvvB5NOBZUKK00Ylc1/fvt0KbaH4sDYBPdyL6OZroSgwrymcXFipapVm1ovUvJaPm
	 dDCjo93hliD27xVTM2gESFRtDxkmqHooF9tYmkhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgH2IPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:15:35 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47652 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgH2IPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:15:00 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 07T8ELfl014307;
        Sat, 29 Aug 2020 17:14:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 07T8ELfl014307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598688864;
        bh=BZ/dWAzubQyO+3A+DUU3NFdKv2g0TsDuGaAwSvn85Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMIyff6jmWXKQZaAWJoFetXJvi6AkLmmfjLm0A8DaaIFux1P8UUNiR9GE7weLmPb1
         mwQSF+0JMdnmdMxAoWEtSA55TWC6UjvROYbbsGKMAQi1VXrZ/SeoOZQ7V7Q2yQz8oo
         6tfyYipNUWJkz8TYHRXlhOq4txtZj9eQ8QzIKA2whe1pndGrE9xBTLit5xESHW1A2M
         X3KE3JT53KVctB3GTX/fCEnIShI3bnRCb+2jz7E1K+rb6OD5m+LrJaIp92RVcSttti
         JXQatinI30tl14k31MUi/WO8HrHnMKH6y1BgtaCtOLDFg5JruV3O8HU0jnj3VB+RGW
         c8DtucGKeqDvg==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] kconfig: qconf: show data column all the time
Date:   Sat, 29 Aug 2020 17:14:11 +0900
Message-Id: <20200829081417.725978-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829081417.725978-1-masahiroy@kernel.org>
References: <20200829081417.725978-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next commit will allow users to edit "int", "hex", "string"
menus in-place from the data column.

The data column should be always displayed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 29 +----------------------------
 scripts/kconfig/qconf.h  |  5 +----
 2 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 035101984bd3..c48e48a3735f 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -288,7 +288,7 @@ void ConfigLineEdit::keyPressEvent(QKeyEvent* e)
 ConfigList::ConfigList(ConfigView* p, const char *name)
 	: Parent(p),
 	  updateAll(false),
-	  showName(false), showRange(false), showData(false), mode(singleMode), optMode(normalOpt),
+	  showName(false), showRange(false), mode(singleMode), optMode(normalOpt),
 	  rootEntry(0), headerPopup(0)
 {
 	setObjectName(name);
@@ -307,7 +307,6 @@ ConfigList::ConfigList(ConfigView* p, const char *name)
 		configSettings->beginGroup(name);
 		showName = configSettings->value("/showName", false).toBool();
 		showRange = configSettings->value("/showRange", false).toBool();
-		showData = configSettings->value("/showData", false).toBool();
 		optMode = (enum optionMode)configSettings->value("/optionMode", 0).toInt();
 		configSettings->endGroup();
 		connect(configApp, SIGNAL(aboutToQuit()), SLOT(saveSettings()));
@@ -338,7 +337,6 @@ bool ConfigList::menuSkip(struct menu *menu)
 
 void ConfigList::reinit(void)
 {
-	hideColumn(dataColIdx);
 	hideColumn(yesColIdx);
 	hideColumn(modColIdx);
 	hideColumn(noColIdx);
@@ -351,8 +349,6 @@ void ConfigList::reinit(void)
 		showColumn(modColIdx);
 		showColumn(yesColIdx);
 	}
-	if (showData)
-		showColumn(dataColIdx);
 
 	updateListAll();
 }
@@ -375,7 +371,6 @@ void ConfigList::saveSettings(void)
 		configSettings->beginGroup(objectName());
 		configSettings->setValue("/showName", showName);
 		configSettings->setValue("/showRange", showRange);
-		configSettings->setValue("/showData", showData);
 		configSettings->setValue("/optionMode", (int)optMode);
 		configSettings->endGroup();
 	}
@@ -918,15 +913,6 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 			action, SLOT(setChecked(bool)));
 		action->setChecked(showRange);
 		headerPopup->addAction(action);
-
-		action = new QAction("Show Data", this);
-		action->setCheckable(true);
-		connect(action, SIGNAL(toggled(bool)),
-			parent(), SLOT(setShowData(bool)));
-		connect(parent(), SIGNAL(showDataChanged(bool)),
-			action, SLOT(setChecked(bool)));
-		action->setChecked(showData);
-		headerPopup->addAction(action);
 	}
 
 	headerPopup->exec(e->globalPos());
@@ -970,15 +956,6 @@ void ConfigView::setShowRange(bool b)
 	}
 }
 
-void ConfigView::setShowData(bool b)
-{
-	if (list->showData != b) {
-		list->showData = b;
-		list->reinit();
-		emit showDataChanged(b);
-	}
-}
-
 void ConfigList::setAllOpen(bool open)
 {
 	QTreeWidgetItemIterator it(this);
@@ -1470,9 +1447,6 @@ ConfigMainWindow::ConfigMainWindow(void)
 	QAction *showRangeAction = new QAction("Show Range", this);
 	  showRangeAction->setCheckable(true);
 	  connect(showRangeAction, SIGNAL(toggled(bool)), configView, SLOT(setShowRange(bool)));
-	QAction *showDataAction = new QAction("Show Data", this);
-	  showDataAction->setCheckable(true);
-	  connect(showDataAction, SIGNAL(toggled(bool)), configView, SLOT(setShowData(bool)));
 
 	QActionGroup *optGroup = new QActionGroup(this);
 	optGroup->setExclusive(true);
@@ -1525,7 +1499,6 @@ ConfigMainWindow::ConfigMainWindow(void)
 	menu = menuBar()->addMenu("&Option");
 	menu->addAction(showNameAction);
 	menu->addAction(showRangeAction);
-	menu->addAction(showDataAction);
 	menu->addSeparator();
 	menu->addActions(optGroup->actions());
 	menu->addSeparator();
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 818e00617ae3..d01a6c620dbb 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -101,7 +101,7 @@ public slots:
 
 	bool updateAll;
 
-	bool showName, showRange, showData;
+	bool showName, showRange;
 	enum listMode mode;
 	enum optionMode optMode;
 	struct menu *rootEntry;
@@ -196,15 +196,12 @@ class ConfigView : public QWidget {
 
 	bool showName(void) const { return list->showName; }
 	bool showRange(void) const { return list->showRange; }
-	bool showData(void) const { return list->showData; }
 public slots:
 	void setShowName(bool);
 	void setShowRange(bool);
-	void setShowData(bool);
 signals:
 	void showNameChanged(bool);
 	void showRangeChanged(bool);
-	void showDataChanged(bool);
 public:
 	ConfigList* list;
 	ConfigLineEdit* lineEdit;
-- 
2.25.1

