Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0BBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFEF20702
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593347318;
	bh=OTkhQpsduF05bVq21aoo5RgCLKJliCpvuAgyHIu4CGY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yiligr999rOmBjlb7UGZZOwM/k3lWxgrF7Oq1Upqg15KEr/TtVfe+AU7aj2hyNqoZ
	 h3fgmhaObS2VavgWvlA7SDyxKAw0di7lKU2PfCtCy8SEGP45/+S+L79itTfNYi+OZg
	 yivK27Ca3FCOBCgBKTRcYV0xS0IXJjSkG+V7cYgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgF1M2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 08:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgF1M2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 08:28:36 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C3120702;
        Sun, 28 Jun 2020 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347315;
        bh=OTkhQpsduF05bVq21aoo5RgCLKJliCpvuAgyHIu4CGY=;
        h=From:To:Cc:Subject:Date:From;
        b=sOIk1Gi24UHHQhISz6yH3gP+jz2tOTer3SPgK+RI3Ot+kNkRENcUiZZw/SDAjJyrA
         vmbo+dRjIIRaWkNRN+DkQHGM8g1gxSDgSMsnOzyaYGYRTKLA8tc1N08Ym4ILxjo9iO
         TenM1lLq1sW6VO4xMzsodq699wf5WwHlJQ4W1pT4=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jpWQD-004j4u-Ba; Sun, 28 Jun 2020 14:28:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: qconf: cleanup includes
Date:   Sun, 28 Jun 2020 14:28:32 +0200
Message-Id: <63117a4424b4740bebd14fb6d00e7b1f35b695a9.1593347262.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of c-like includes are deprecated on modern Qt
versions. So, use the c++ style ones, as described at Qt4/Qt5
documentation.

While here, remove uneeded and redundant ones, sorting
them on alphabetic order.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kconfig/qconf.cc | 27 +++++++++------------------
 scripts/kconfig/qconf.h  | 14 +++++++-------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index cf93d3eb09d3..03cadf27a376 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -4,27 +4,18 @@
  * Copyright (C) 2015 Boris Barbulovski <bbarbulovski@gmail.com>
  */
 
-#include <qglobal.h>
-
-#include <QMainWindow>
-#include <QList>
-#include <qtextbrowser.h>
 #include <QAction>
+#include <QApplication>
+#include <QCloseEvent>
+#include <QDesktopWidget>
 #include <QFileDialog>
+#include <QLabel>
+#include <QLayout>
+#include <QList>
 #include <QMenu>
-
-#include <qapplication.h>
-#include <qdesktopwidget.h>
-#include <qtoolbar.h>
-#include <qlayout.h>
-#include <qsplitter.h>
-#include <qlineedit.h>
-#include <qlabel.h>
-#include <qpushbutton.h>
-#include <qmenubar.h>
-#include <qmessagebox.h>
-#include <qregexp.h>
-#include <qevent.h>
+#include <QMenuBar>
+#include <QMessageBox>
+#include <QToolBar>
 
 #include <stdlib.h>
 
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 0dc667f0f7cb..a193137f2314 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -3,17 +3,17 @@
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  */
 
-#include <QTextBrowser>
-#include <QTreeWidget>
-#include <QMainWindow>
+#include <QCheckBox>
+#include <QDialog>
 #include <QHeaderView>
-#include <qsettings.h>
+#include <QLineEdit>
+#include <QMainWindow>
 #include <QPushButton>
 #include <QSettings>
-#include <QLineEdit>
 #include <QSplitter>
-#include <QCheckBox>
-#include <QDialog>
+#include <QTextBrowser>
+#include <QTreeWidget>
+
 #include "expr.h"
 
 class ConfigView;
-- 
2.26.2


