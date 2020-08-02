Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1082CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E412020885
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596385063;
	bh=UklBIa1svaZEUGZY6ukHtxMHq0RAcb8mI8dcMphJZgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rr3qmpTwXFrhn8K+5oE9GM1y+O24ql3MFbIYgE/bOYkrRq27teqdqKWJ/eAbMzgtj
	 urUB7Q1pTMN3YVJFnMExuufvuS1t7JL/vKtM8cObEgm+DwfhcWDtg0BFLjiDY6jvaK
	 4yELaaPIKW8fsY5QtuZt2alG6Kpgw3cvNlaoCgH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHBQRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:17:41 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:48422 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHBQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:17:40 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 072GHOad003720;
        Mon, 3 Aug 2020 01:17:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 072GHOad003720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596385045;
        bh=OsE1s3BNvGrY4g69Jb5MF5p6Ruan+BT3dER0FGv6bKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmKgKl1tM944R69Gjgh9ykQGxrfKg/G+QxldFfGHOMjg7+CfZTjHYOG2rsBiZxyE4
         LRxfELJsdg9Swu4HjbZlCWanUTTtk9bsYWKk3LB3620jrTn8WFdnXrMxadBjlHshAC
         puk+KdkXGUJpYtTm3FPuhSK0I1jjocDG3tpotRDESLJAblnT4FUNH71VYEgT1r0dRN
         mbqHwIlz8olz3EsCzOsVThkeg6M6vQrK/rVf9j7gZOj689LzWLYkUvWeTuAFFSB8pp
         ZbOZvvGMjTm0y3kNYkrXOk31wRImNb/JfZbsZSYGlMCyM+WbgT2Jd5Csbpu8UtCTeI
         pc+TV3GHrAUOQ==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] kconfig: qconf: remove 'menu' variable
Date:   Mon,  3 Aug 2020 01:17:07 +0900
Message-Id: <20200802161721.921721-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200802161721.921721-1-masahiroy@kernel.org>
References: <20200802161721.921721-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is a bit confusing to use 'menu' to hold a QMenuBar pointer
because it looks like a QMenu pointer.

You do not need to use a local variable here. Use QMenuBar() directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 9513c0ba8d0c..0ef9a1da6475 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1381,7 +1381,6 @@ void ConfigSearchWindow::search(void)
 ConfigMainWindow::ConfigMainWindow(void)
 	: searchWindow(0)
 {
-	QMenuBar* menu;
 	bool ok = true;
 	QVariant x, y;
 	int width, height;
@@ -1432,7 +1431,6 @@ ConfigMainWindow::ConfigMainWindow(void)
 	setTabOrder(configList, helpText);
 	configList->setFocus();
 
-	menu = menuBar();
 	toolBar = new QToolBar("Tools", this);
 	addToolBar(toolBar);
 
@@ -1518,7 +1516,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 	toolBar->addAction(fullViewAction);
 
 	// create file menu
-	QMenu *fileMenu = menu->addMenu("&File");
+	QMenu *fileMenu = menuBar()->addMenu("&File");
 	fileMenu->addAction(loadAction);
 	fileMenu->addAction(saveAction);
 	fileMenu->addAction(saveAsAction);
@@ -1526,12 +1524,13 @@ ConfigMainWindow::ConfigMainWindow(void)
 	fileMenu->addAction(quitAction);
 
 	// create edit menu
-	QMenu* editMenu = menu->addMenu("&Edit");
+	QMenu *editMenu = menuBar()->addMenu("&Edit");
 	editMenu->addAction(searchAction);
 
 	// create options menu
-	QMenu* optionMenu = menu->addMenu("&Option");
+	QMenu *optionMenu = menuBar()->addMenu("&Option");
 	optionMenu->addAction(showNameAction);
+
 	optionMenu->addAction(showRangeAction);
 	optionMenu->addAction(showDataAction);
 	optionMenu->addSeparator();
@@ -1540,8 +1539,8 @@ ConfigMainWindow::ConfigMainWindow(void)
 	optionMenu->addAction(showDebugAction);
 
 	// create help menu
-	menu->addSeparator();
-	QMenu* helpMenu = menu->addMenu("&Help");
+	menuBar()->addSeparator();
+	QMenu *helpMenu = menuBar()->addMenu("&Help");
 	helpMenu->addAction(showIntroAction);
 	helpMenu->addAction(showAboutAction);
 
-- 
2.25.1

