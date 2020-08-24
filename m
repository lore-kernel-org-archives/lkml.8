Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BA22071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262182;
	bh=RxrUd6NwJT1JocZoUbagDtzQCpm8uEzFEdrEK3y0wMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWp+spE/JrCWkVkVYUSj/0vJjEIcvN5MQaj6ej4qKMbP+TU7GpAI2RBSSDeuaK4Hg
	 fHAo3UPjy3kVpEo3zV9BTA91/QteAA8Rf4K/dEfpiPDykPIlv193okyVtRKJQ2xsc3
	 IEYCJpptuYpOO1NQfQM5NmUZ+tiR2+q+8xX+bPa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgHXJnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbgHXIoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:44:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 591FF2075B;
        Mon, 24 Aug 2020 08:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258669;
        bh=RxrUd6NwJT1JocZoUbagDtzQCpm8uEzFEdrEK3y0wMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idvuJM2V9I7ai6SRes5qute8bm5Vmgo3CutZCv6dHKXiEEq/SevABUTUtzNlHjvjy
         2MMMOENsS+4I0Vsy4O33fqtVSGbr27PEDxRQsBFvQuLQehcMaEfoEwYwKn3BDugkja
         mx2eGofvbsneaaurPSwNyb1wkiIgJiIZbrB7BEjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 102/124] kconfig: qconf: fix signal connection to invalid slots
Date:   Mon, 24 Aug 2020 10:30:36 +0200
Message-Id: <20200824082414.437274361@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit d85de3399f97467baa2026fbbbe587850d01ba8a ]

If you right-click in the ConfigList window, you will see the following
messages in the console:

QObject::connect: No such slot QAction::setOn(bool) in scripts/kconfig/qconf.cc:888
QObject::connect:  (sender name:   'config')
QObject::connect: No such slot QAction::setOn(bool) in scripts/kconfig/qconf.cc:897
QObject::connect:  (sender name:   'config')
QObject::connect: No such slot QAction::setOn(bool) in scripts/kconfig/qconf.cc:906
QObject::connect:  (sender name:   'config')

Right, there is no such slot in QAction. I think this is a typo of
setChecked.

Due to this bug, when you toggled the menu "Option->Show Name/Range/Data"
the state of the context menu was not previously updated. Fix this.

Fixes: d5d973c3f8a9 ("Port xconfig to Qt5 - Put back some of the old implementation(part 2)")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/qconf.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index e7e201d261f78..1eb076c7eae17 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -890,7 +890,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 		connect(action, SIGNAL(toggled(bool)),
 			parent(), SLOT(setShowName(bool)));
 		connect(parent(), SIGNAL(showNameChanged(bool)),
-			action, SLOT(setOn(bool)));
+			action, SLOT(setChecked(bool)));
 		action->setChecked(showName);
 		headerPopup->addAction(action);
 
@@ -899,7 +899,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 		connect(action, SIGNAL(toggled(bool)),
 			parent(), SLOT(setShowRange(bool)));
 		connect(parent(), SIGNAL(showRangeChanged(bool)),
-			action, SLOT(setOn(bool)));
+			action, SLOT(setChecked(bool)));
 		action->setChecked(showRange);
 		headerPopup->addAction(action);
 
@@ -908,7 +908,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 		connect(action, SIGNAL(toggled(bool)),
 			parent(), SLOT(setShowData(bool)));
 		connect(parent(), SIGNAL(showDataChanged(bool)),
-			action, SLOT(setOn(bool)));
+			action, SLOT(setChecked(bool)));
 		action->setChecked(showData);
 		headerPopup->addAction(action);
 	}
@@ -1240,7 +1240,7 @@ QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
 
 	action->setCheckable(true);
 	connect(action, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
-	connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setOn(bool)));
+	connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setChecked(bool)));
 	action->setChecked(showDebug());
 	popup->addSeparator();
 	popup->addAction(action);
-- 
2.25.1



