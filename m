Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF45C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454B62076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598688915;
	bh=2MWdo+fJ3N3IWRY9wFq3bWtYkjZ3SZ69RDhDRjyVQ5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CSTVR02QjoZ8w2dSo2xvphP1F8/IzImJlKByECUu8ThtFGt5AzpDlSN9kC8FfC9Jb
	 ljRgb9h5Qj3zBfimc0QWocmMXO5QFKH7Zx8OESqjbR14wNFi0eI9aJ+VGQh+VF4erK
	 G90kVVxxsYjtgpKUGJUR2dsgwA4lYzXqLnQGdnQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgH2IPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:15:12 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47604 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgH2IO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:14:59 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 07T8ELfp014307;
        Sat, 29 Aug 2020 17:14:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 07T8ELfp014307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598688866;
        bh=dlDRq5rwoaxJHpgmY0djcQEM4jThgvxWcUuoaR7F3Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9k/N9qN5NhVd1I7mnOIxyDlTKRstXTUa2PYpauAsdTZnDd1JBPpyDmoYwqRxKK27
         CY9grnkNbV3qXppwDg+f74IXHnE1On3/x7JfHR3Pxlsi2MbVCHWDl1xJ3fVmDcZRBV
         /mVTR1+wdaGcU19bzlYJnE+wIFfuldYo0sR40IZyS9ipSPhGunm4dBRBw0C6kzdUyr
         zwvIuxW8k5Lf5uzmOm8s71togoH6lTjwbxZIqTOO+RM5sZPlHDcUcKNxevHr5mKjoS
         2T8eUi1x/C8GVwS1ot6oz4rFXatkzCAVLdJNOKXrZtzFXuDG2N6fmd6huI7jkDUtkB
         wfxi4gXF4NaRQ==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] kconfig: qconf: remove ConfigView class
Date:   Sat, 29 Aug 2020 17:14:15 +0900
Message-Id: <20200829081417.725978-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829081417.725978-1-masahiroy@kernel.org>
References: <20200829081417.725978-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ConfigView only contains ConfigList, we can remove ConfigView
and just use ConfigList.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 43 ++++++++++++++--------------------------
 scripts/kconfig/qconf.h  | 21 ++------------------
 2 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index db7eba95cdf8..b9333115dda3 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -307,8 +307,8 @@ parent:
 	QStyledItemDelegate::setModelData(editor, model, index);
 }
 
-ConfigList::ConfigList(ConfigView* p, const char *name)
-	: Parent(p),
+ConfigList::ConfigList(QWidget *parent, const char *name)
+	: QTreeWidget(parent),
 	  updateAll(false),
 	  showName(false), showRange(false), mode(singleMode), optMode(normalOpt),
 	  rootEntry(0), headerPopup(0)
@@ -965,17 +965,6 @@ QAction *ConfigList::showNormalAction;
 QAction *ConfigList::showAllAction;
 QAction *ConfigList::showPromptAction;
 
-ConfigView::ConfigView(QWidget* parent, const char *name)
-	: Parent(parent)
-{
-	setObjectName(name);
-	QVBoxLayout *verticalLayout = new QVBoxLayout(this);
-	verticalLayout->setContentsMargins(0, 0, 0, 0);
-
-	list = new ConfigList(this);
-	verticalLayout->addWidget(list);
-}
-
 void ConfigList::setAllOpen(bool open)
 {
 	QTreeWidgetItemIterator it(this);
@@ -1297,12 +1286,12 @@ ConfigSearchWindow::ConfigSearchWindow(ConfigMainWindow *parent)
 
 	split = new QSplitter(this);
 	split->setOrientation(Qt::Vertical);
-	list = new ConfigView(split, "search");
-	list->list->mode = listMode;
+	list = new ConfigList(split, "search");
+	list->mode = listMode;
 	info = new ConfigInfoView(split, "search");
-	connect(list->list, SIGNAL(menuChanged(struct menu *)),
+	connect(list, SIGNAL(menuChanged(struct menu *)),
 		info, SLOT(setInfo(struct menu *)));
-	connect(list->list, SIGNAL(menuChanged(struct menu *)),
+	connect(list, SIGNAL(menuChanged(struct menu *)),
 		parent, SLOT(setMenuLink(struct menu *)));
 
 	layout1->addWidget(split);
@@ -1346,7 +1335,7 @@ void ConfigSearchWindow::search(void)
 	ConfigItem *lastItem = NULL;
 
 	free(result);
-	list->list->clear();
+	list->clear();
 	info->clear();
 
 	result = sym_re_search(editField->text().toLatin1());
@@ -1354,7 +1343,7 @@ void ConfigSearchWindow::search(void)
 		return;
 	for (p = result; *p; p++) {
 		for_all_prompts((*p), prop)
-			lastItem = new ConfigItem(list->list, lastItem, prop->menu,
+			lastItem = new ConfigItem(list, lastItem, prop->menu,
 						  menu_is_visible(prop->menu));
 	}
 }
@@ -1402,23 +1391,21 @@ ConfigMainWindow::ConfigMainWindow(void)
 	split1->setOrientation(Qt::Horizontal);
 	split1->setChildrenCollapsible(false);
 
-	menuView = new ConfigView(widget, "menu");
-	menuList = menuView->list;
+	menuList = new ConfigList(widget, "menu");
 
 	split2 = new QSplitter(widget);
 	split2->setChildrenCollapsible(false);
 	split2->setOrientation(Qt::Vertical);
 
 	// create config tree
-	configView = new ConfigView(widget, "config");
-	configList = configView->list;
+	configList = new ConfigList(widget, "config");
 
 	helpText = new ConfigInfoView(widget, "help");
 
 	layout->addWidget(split2);
 	split2->addWidget(split1);
-	split1->addWidget(configView);
-	split1->addWidget(menuView);
+	split1->addWidget(configList);
+	split1->addWidget(menuList);
 	split2->addWidget(helpText);
 
 	setTabOrder(configList, helpText);
@@ -1727,7 +1714,7 @@ void ConfigMainWindow::showSingleView(void)
 
 	backAction->setEnabled(true);
 
-	menuView->hide();
+	menuList->hide();
 	menuList->setRootMenu(0);
 	configList->mode = singleMode;
 	if (configList->rootEntry == &rootmenu)
@@ -1758,7 +1745,7 @@ void ConfigMainWindow::showSplitView(void)
 	menuList->mode = symbolMode;
 	menuList->setRootMenu(&rootmenu);
 	menuList->setAllOpen(true);
-	menuView->show();
+	menuList->show();
 	menuList->setFocus();
 }
 
@@ -1773,7 +1760,7 @@ void ConfigMainWindow::showFullView(void)
 
 	backAction->setEnabled(false);
 
-	menuView->hide();
+	menuList->hide();
 	menuList->setRootMenu(0);
 	configList->mode = fullMode;
 	if (configList->rootEntry == &rootmenu)
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 843725584bfa..1289fdaa7d82 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -17,7 +17,6 @@
 
 #include "expr.h"
 
-class ConfigView;
 class ConfigList;
 class ConfigItem;
 class ConfigMainWindow;
@@ -43,14 +42,10 @@ class ConfigList : public QTreeWidget {
 	Q_OBJECT
 	typedef class QTreeWidget Parent;
 public:
-	ConfigList(ConfigView* p, const char *name = 0);
+	ConfigList(QWidget *parent, const char *name = 0);
 	~ConfigList();
 	void reinit(void);
 	ConfigItem* findConfigItem(struct menu *);
-	ConfigView* parent(void) const
-	{
-		return (ConfigView*)Parent::parent();
-	}
 	void setSelected(QTreeWidgetItem *item, bool enable) {
 		for (int i = 0; i < selectedItems().size(); i++)
 			selectedItems().at(i)->setSelected(false);
@@ -190,16 +185,6 @@ class ConfigItemDelegate : public QStyledItemDelegate
 			  const QModelIndex &index) const override;
 };
 
-class ConfigView : public QWidget {
-	Q_OBJECT
-	typedef class QWidget Parent;
-public:
-	ConfigView(QWidget* parent, const char *name = 0);
-
-public:
-	ConfigList* list;
-};
-
 class ConfigInfoView : public QTextBrowser {
 	Q_OBJECT
 	typedef class QTextBrowser Parent;
@@ -245,7 +230,7 @@ public slots:
 	QLineEdit* editField;
 	QPushButton* searchButton;
 	QSplitter* split;
-	ConfigView* list;
+	ConfigList *list;
 	ConfigInfoView* info;
 
 	struct symbol **result;
@@ -280,9 +265,7 @@ public slots:
 	void closeEvent(QCloseEvent *e);
 
 	ConfigSearchWindow *searchWindow;
-	ConfigView *menuView;
 	ConfigList *menuList;
-	ConfigView *configView;
 	ConfigList *configList;
 	ConfigInfoView *helpText;
 	QAction *backAction;
-- 
2.25.1

