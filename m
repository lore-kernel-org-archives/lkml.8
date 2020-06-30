Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C8020672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593498414;
	bh=wGa+qBV2V1GP8GCaDKNfsF9c/pokG/wFsofWOOaD/1A=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=gaSlega+d21zGkcxiCKokK/cY3cmKD82VhLCtcv0dsXvC1IjuD5MyYKgUqQh11ZnN
	 8Dz/EDm5vid1JAMgxwMQRlNTmJ8qWjrwNXxXFEE3eAuv8wNcWTFh8xTLGtaMQn5ZUU
	 X0rG7ihYcIl5w9DKovBaRDtO4lgLr2fsWMLc/PfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgF3G0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbgF3G0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:26:46 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897BC20759;
        Tue, 30 Jun 2020 06:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593498405;
        bh=wGa+qBV2V1GP8GCaDKNfsF9c/pokG/wFsofWOOaD/1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfcupfYZOFR260roxhZ7vOF60m/dlnmaRVEmulDm2P4M+V+wdMpsjH9tjvNIJF8Og
         PVz5lcHBK/6zWf0UJL2Y82WUE7kpDjyVJlVpJCpm81pLJrRlBIf3UaE3K/Shj2cw+M
         ZUanRschzU60HYohVs/Cb2O6TO57CFE9oassZEFY=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jq9j9-008Wap-N9; Tue, 30 Jun 2020 08:26:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] kconfig: qconf: cleanup includes
Date:   Tue, 30 Jun 2020 08:26:35 +0200
Message-Id: <c138cd9af908952a85a0fc0f0ff30c57b0e547ba.1593498345.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593498345.git.mchehab+huawei@kernel.org>
References: <cover.1593498345.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of c-like include is deprecated on modern Qt
versions. Use the c++ style includes.

While here, remove uneeded and redundant ones, sorting
them on alphabetic order.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kconfig/qconf.cc | 27 +++++++++------------------
 scripts/kconfig/qconf.h  | 14 +++++++-------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index c0ac8f7b5f1a..0e06afa08908 100644
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
index c879d79ce817..d913a02967ae 100644
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

