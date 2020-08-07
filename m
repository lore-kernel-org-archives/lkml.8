Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356C22177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596792082;
	bh=ckEJ4HSlgG7falhdJg4K5cIcx8Qimd0ClgnycEf57NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aH5+opurTAYuEqk77eE3pxrm9yIqJSztB0H1/+8Xyriw7n+qcw+V1WNcGBQBW3SWT
	 RWM3XjzfFyQqEGNEKs9NaSOu4QIIPcCagDQVQA2pkzQgGqVZhcNGUEeJvRPzYMIBww
	 pe3dh5PHHfGtEm3xYzGraYJ1UojK/OwNP3fXGHhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHGJVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:21:07 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:41479 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgHGJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:19:36 -0400
Received: from localhost.localdomain (softbank060134047170.bbtec.net [60.134.47.170]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0779JBQ3032147;
        Fri, 7 Aug 2020 18:19:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0779JBQ3032147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596791957;
        bh=VixrBR5qEPvzJaLnnx8ujPP6BniNaD2d3j9IPcWEQO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wIDbO67xDlwUHhIr5vuwgART+SJBGetEr9poFpcUuplduasXsyFjwX33drGqTJT9n
         MBNrm7H6BPZQcfQsghfMO05yDVFoTYg7gyhsckcgkt5WUoKbx40EtpkrTao52kPpju
         LvZMXO0gVlFlanrCBakeCKo2p8yKnfMAdfSAJBup4cK9wsA3YNEYbLfeHpnDZcm5+G
         MPWirm1qrHHa/1WAbHYdiLVbFFGAgf7cCDw3edmjmjVRqrJ2sd8HHACRvxG7cn7/cO
         nyoUJLAUtptUFZwxZH030RHXuQ2Yw9GbMc4og1lJSiW/WPilmYLMoaGxMnb5cm4Lxz
         hgwqFJRwiKD/w==
X-Nifty-SrcIP: [60.134.47.170]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/19] kconfig: qconf: remove name from ConfigSearchWindow constructor
Date:   Fri,  7 Aug 2020 18:18:57 +0900
Message-Id: <20200807091909.2985787-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807091909.2985787-1-masahiroy@kernel.org>
References: <20200807091909.2985787-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This constructor is only called with "search" as the second argument.

Hard-code the name in the constructor, and drop it from the function
argument.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/kconfig/qconf.cc | 44 +++++++++++++++++++---------------------
 scripts/kconfig/qconf.h  |  2 +-
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 0385804cfd08..a4b522bb32e5 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1287,10 +1287,10 @@ void ConfigInfoView::contextMenuEvent(QContextMenuEvent *e)
 	Parent::contextMenuEvent(e);
 }
 
-ConfigSearchWindow::ConfigSearchWindow(ConfigMainWindow* parent, const char *name)
+ConfigSearchWindow::ConfigSearchWindow(ConfigMainWindow *parent)
 	: Parent(parent), result(NULL)
 {
-	setObjectName(name);
+	setObjectName("search");
 	setWindowTitle("Search Config");
 
 	QVBoxLayout* layout1 = new QVBoxLayout(this);
@@ -1311,9 +1311,9 @@ ConfigSearchWindow::ConfigSearchWindow(ConfigMainWindow* parent, const char *nam
 
 	split = new QSplitter(this);
 	split->setOrientation(Qt::Vertical);
-	list = new ConfigView(split, name);
+	list = new ConfigView(split, "search");
 	list->list->mode = listMode;
-	info = new ConfigInfoView(split, name);
+	info = new ConfigInfoView(split, "search");
 	connect(list->list, SIGNAL(menuChanged(struct menu *)),
 		info, SLOT(setInfo(struct menu *)));
 	connect(list->list, SIGNAL(menuChanged(struct menu *)),
@@ -1321,25 +1321,23 @@ ConfigSearchWindow::ConfigSearchWindow(ConfigMainWindow* parent, const char *nam
 
 	layout1->addWidget(split);
 
-	if (name) {
-		QVariant x, y;
-		int width, height;
-		bool ok;
+	QVariant x, y;
+	int width, height;
+	bool ok;
 
-		configSettings->beginGroup(name);
-		width = configSettings->value("/window width", parent->width() / 2).toInt();
-		height = configSettings->value("/window height", parent->height() / 2).toInt();
-		resize(width, height);
-		x = configSettings->value("/window x");
-		y = configSettings->value("/window y");
-		if ((x.isValid())&&(y.isValid()))
-			move(x.toInt(), y.toInt());
-		QList<int> sizes = configSettings->readSizes("/split", &ok);
-		if (ok)
-			split->setSizes(sizes);
-		configSettings->endGroup();
-		connect(configApp, SIGNAL(aboutToQuit()), SLOT(saveSettings()));
-	}
+	configSettings->beginGroup("search");
+	width = configSettings->value("/window width", parent->width() / 2).toInt();
+	height = configSettings->value("/window height", parent->height() / 2).toInt();
+	resize(width, height);
+	x = configSettings->value("/window x");
+	y = configSettings->value("/window y");
+	if (x.isValid() && y.isValid())
+		move(x.toInt(), y.toInt());
+	QList<int> sizes = configSettings->readSizes("/split", &ok);
+	if (ok)
+		split->setSizes(sizes);
+	configSettings->endGroup();
+	connect(configApp, SIGNAL(aboutToQuit()), SLOT(saveSettings()));
 }
 
 void ConfigSearchWindow::saveSettings(void)
@@ -1641,7 +1639,7 @@ void ConfigMainWindow::saveConfigAs(void)
 void ConfigMainWindow::searchConfig(void)
 {
 	if (!searchWindow)
-		searchWindow = new ConfigSearchWindow(this, "search");
+		searchWindow = new ConfigSearchWindow(this);
 	searchWindow->show();
 }
 
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 6e6bb0a96348..335f0776984f 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -272,7 +272,7 @@ class ConfigSearchWindow : public QDialog {
 	Q_OBJECT
 	typedef class QDialog Parent;
 public:
-	ConfigSearchWindow(ConfigMainWindow* parent, const char *name = 0);
+	ConfigSearchWindow(ConfigMainWindow *parent);
 
 public slots:
 	void saveSettings(void);
-- 
2.25.1

