Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 690FC20772
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593345399;
	bh=1LfnQKBGk2CNqW2Lh9NqvGynqkDXzo/zqaHgeaLAN+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZubiDC60HslGZOaTYizL/DTiy90cQS948eZEW2hvKcf0JsuBQ8yjuuLRyUiiPUBzq
	 Ay0KLSqWbOotlu1Y8kxpFGMdIcib6RDREnnPrKuAyPYJSKM1tLah/8A4dx4fACIfXH
	 O+3XW2lYT55Wnh3KrEMnq9QoExqLLW1rl+Ny+Rys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgF1L4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 07:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgF1L4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 07:56:37 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F992076E;
        Sun, 28 Jun 2020 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593345396;
        bh=1LfnQKBGk2CNqW2Lh9NqvGynqkDXzo/zqaHgeaLAN+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cPGJF4d3icVaIveRSzQj4I8RhrH9VNsJBdAXCpDYgnzXPev8oLdrsYFOOJMPlaYey
         eFBGi2crg+vCkHxOPSoEb0yTvQaFjbV7xsGpvly6TaJVcFZTw5CrTFIAznMcziV9Z9
         KJtVBmBciUPqa0Y6XlUDf/yonnAmrfP6P1lBHCRk=
Date:   Sun, 28 Jun 2020 13:56:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Search function in xconfig is partially broken after recent
 changes
Message-ID: <20200628135632.198e0083@coco.lan>
In-Reply-To: <004fa015321d2e612c99eb9ba7954da8023816b7.camel@redhat.com>
References: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
        <20200625125906.6b7688eb@coco.lan>
        <20200625131758.52dbdab7@coco.lan>
        <855fea60f47c1a0dbcf0395a4cdbe5d9c57592c1.camel@redhat.com>
        <20200625170546.270cf5fc@coco.lan>
        <2d536ba419ffe76e031bd65375e5af6a401faec0.camel@redhat.com>
        <20200628125421.12458086@coco.lan>
        <004fa015321d2e612c99eb9ba7954da8023816b7.camel@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 28 Jun 2020 14:20:41 +0300
Maxim Levitsky <mlevitsk@redhat.com> escreveu:

> > But this is not happening. Perhaps this also broke with the Qt5
> > conversion?
> > 
> > I suspect it should, instead, use a different signal to handle it.
> > 
> > See, with the enclosed patch, clicking on a link will now show:
> > 
> > 	Clicked on URL QUrl("s0x21c3f10")
> > 	QTextBrowser: No document for s0x21c3f10
> > 
> > Which helps to explain what's happening here.
> > 
> > See, when debug is turned on, it will create hyperlinks like:
> > 
> > 	head += QString().sprintf("<a href=\"s%p\">", sym);
> > 
> > It seems that the code needs something like:
> > 
> > 	connect (helpText, SIGNAL (anchorClicked (const QUrl &)),
> > 			 helpText, SLOT (clicked (const QUrl &)) );
> > 
> > and a handler for this signal that would translate "s%p"
> > back into sym, using such value to update the menus.
> > 
> > Do you know if this used to work after Kernel 3.14?  
> 
> I don't know yet, but I can test it. 
> 
> I didn't do much kernel developement for lot of time, so I only vaguely
> remember that once upon a time it did work. I don't use this feature much,
> so it might as well be broken back when conversion to Qt5 happened.
> Also worth noting that I probably used Qt4 untill recently when I updated
> to fedora 31, which looks like dropped Qt4 developement packages.
> 
> I used to know a thing or two about Qt, long long ago, so on next weekend or so,
> I can also take a look at this.

Yeah, I suspect you probably tried it before the Qt5 conversion
patches then.

The enclosed patch is one step further fixing this bug. It still
needs to implement the part of the code which starts using the
selected menu or item.

The first hunk won't apply cleanly, because I added a patch
before it, in order to sort out the include mess, but solving
the conflict is trivial (just add an include for QDebug).

Thanks,
Mauro

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 631e19659504..b989b6543d7a 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -7,6 +7,7 @@
 #include <QAction>
 #include <QApplication>
 #include <QCloseEvent>
+#include <QDebug>
 #include <QDesktopWidget>
 #include <QFileDialog>
 #include <QLabel>
@@ -1012,7 +1013,7 @@ ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
 	: Parent(parent), sym(0), _menu(0)
 {
 	setObjectName(name);
-
+	setOpenLinks(false);
 
 	if (!objectName().isEmpty()) {
 		configSettings->beginGroup(objectName());
@@ -1224,6 +1225,36 @@ void ConfigInfoView::expr_print_help(void *data, struct symbol *sym, const char
 		*text += str2;
 }
 
+void ConfigInfoView::clicked(const QUrl &url)
+{
+	QByteArray str = url.toEncoded();
+	const std::size_t count = str.size();
+	char *hex = new char[count];
+	unsigned long p;
+	struct symbol *sym;
+	struct menu *menu;
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
+	qInfo() << "Clicked on URL" << url;
+
+	if (hex[0] == 's') {
+		sym = (struct symbol *)p;
+
+		qInfo() << "symbol name:" << sym->name;
+	} else {
+		menu = (struct menu *)p;
+		qInfo() << "menu:" << qgettext(menu_get_prompt(menu));
+	}
+}
+
 QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
 {
 	QMenu* popup = Parent::createStandardContextMenu(pos);
@@ -1497,6 +1528,9 @@ ConfigMainWindow::ConfigMainWindow(void)
 	helpMenu->addAction(showIntroAction);
 	helpMenu->addAction(showAboutAction);
 
+	connect (helpText, SIGNAL (anchorClicked (const QUrl &)),
+		 helpText, SLOT (clicked (const QUrl &)) );
+
 	connect(configList, SIGNAL(menuChanged(struct menu *)),
 		helpText, SLOT(setInfo(struct menu *)));
 	connect(configList, SIGNAL(menuSelected(struct menu *)),
@@ -1601,6 +1635,9 @@ void ConfigMainWindow::searchConfig(void)
 
 void ConfigMainWindow::changeItens(struct menu *menu)
 {
+	if (menu->flags & MENU_ROOT)
+		qInfo() << "Wrong type when changing item";
+
 	configList->setRootMenu(menu);
 
 	if (configList->rootEntry->parent == &rootmenu)
@@ -1611,6 +1648,9 @@ void ConfigMainWindow::changeItens(struct menu *menu)
 
 void ConfigMainWindow::changeMenu(struct menu *menu)
 {
+	if (!(menu->flags & MENU_ROOT))
+		qInfo() << "Wrong type when changing menu";
+
 	menuList->setRootMenu(menu);
 
 	if (menuList->rootEntry->parent == &rootmenu)
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
