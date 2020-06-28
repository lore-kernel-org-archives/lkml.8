Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C66C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFAD20772
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593346891;
	bh=763c9TBdMIE+c8wE5fb79t97pz7HwIMDwACLxZtaA3c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=g2wtr6E+dRW6RU/wSan5lSeUXm0lFJlL1juGaVH+NeqXCHupZFkbvty+6pxJFWM4h
	 bVyoep4Fs3D2MozH9K6FqfedBBoxlpQDKI/zBOKR9l2KfnwPIWvhUnPo5MqzPlfWfe
	 vgT/JmhfAuMUtEJktFVEDdUAfntQJ58Y90P4uf7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgF1MVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 08:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgF1MV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 08:21:29 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF97720772;
        Sun, 28 Jun 2020 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593346888;
        bh=763c9TBdMIE+c8wE5fb79t97pz7HwIMDwACLxZtaA3c=;
        h=From:To:Cc:Subject:Date:From;
        b=uG+2KqcVcf/axa2hx+xRuVZbfD8mPBhBCUVNgLVOaJDPJpQXdW+FM8UkDruWrrFhm
         8zarlZMnTHxnvmN+AEhvq6YB5B2Vg2q3yaWWFcNg3V+95tImNboDU2cfWAR7Ug6W6v
         oXFAu7nagY1BSmcfpzFml0QoRJE6DjM/QWQ0quo0=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jpWJK-004iPH-JP; Sun, 28 Jun 2020 14:21:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] kconfig: qconf: make debug links work again
Date:   Sun, 28 Jun 2020 14:21:25 +0200
Message-Id: <ff9d1c3369b96c1d14b1e898e3d5f64ad945b604.1593346883.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qt5 conversion broke support for debug info links.

Restore the behaviour added by changeset
ab45d190fd4a ("kconfig: create links in info window").

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kconfig/qconf.cc | 35 ++++++++++++++++++++++++++++++++++-
 scripts/kconfig/qconf.h  |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 631e19659504..03cadf27a376 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1012,7 +1012,7 @@ ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
 	: Parent(parent), sym(0), _menu(0)
 {
 	setObjectName(name);
-
+	setOpenLinks(false);
 
 	if (!objectName().isEmpty()) {
 		configSettings->beginGroup(objectName());
@@ -1224,6 +1224,36 @@ void ConfigInfoView::expr_print_help(void *data, struct symbol *sym, const char
 		*text += str2;
 }
 
+void ConfigInfoView::clicked(const QUrl &url)
+{
+	QByteArray str = url.toEncoded();
+	const std::size_t count = str.size();
+	char *hex = new char[count];
+	unsigned long p;
+
+	if (count < 1)
+		return;
+
+	memcpy(hex, str.constData(), count);
+	p = (int)strtol(hex + 1, NULL, 16);
+
+	if (!p)
+		return;
+
+	if (hex[0] == 's') {
+		struct symbol *s = (struct symbol *)p;
+
+		sym = s;
+		symbolInfo();
+	} else {
+		struct menu *m = (struct menu *)p;
+
+		_menu = m;
+		menuInfo();
+	}
+	emit showDebugChanged(true);
+}
+
 QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
 {
 	QMenu* popup = Parent::createStandardContextMenu(pos);
@@ -1497,6 +1527,9 @@ ConfigMainWindow::ConfigMainWindow(void)
 	helpMenu->addAction(showIntroAction);
 	helpMenu->addAction(showAboutAction);
 
+	connect (helpText, SIGNAL (anchorClicked (const QUrl &)),
+		 helpText, SLOT (clicked (const QUrl &)) );
+
 	connect(configList, SIGNAL(menuChanged(struct menu *)),
 		helpText, SLOT(setInfo(struct menu *)));
 	connect(configList, SIGNAL(menuSelected(struct menu *)),
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index d913a02967ae..a193137f2314 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -250,6 +250,7 @@ public slots:
 	void setInfo(struct menu *menu);
 	void saveSettings(void);
 	void setShowDebug(bool);
+	void clicked (const QUrl &url);
 
 signals:
 	void showDebugChanged(bool);
-- 
2.26.2

