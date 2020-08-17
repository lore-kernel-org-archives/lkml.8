Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3EBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC73E20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597685669;
	bh=5i+13h+RjX9pme+BnGmA/QeLhyXAY9spHIanBHjPJBc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RMf7ZjNE7G6kdHapJLeOHjVVeNlE22SDK3hr1BfaKRnofcMLeI2rIxX7bOGdpo34C
	 DYPYJ43PvX9ZaslS2rrZR+RCvVCvsGroXQXvYL/b1y9NQAIwgVnq7i5QhdHQzoYrQ7
	 +0OOpviZeXmAOMdKO/f735BAxS7VB6ToJC5n9Cfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgHQReZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:34:25 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:42632 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbgHQQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:37:41 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 07HGah90005234;
        Tue, 18 Aug 2020 01:36:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 07HGah90005234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597682203;
        bh=81xEsjm4pxHgAS08vQ4c2bZwqjpy5PBpw7sZI7XBHzA=;
        h=From:To:Cc:Subject:Date:From;
        b=oHqF7vLF5b3iefAE7OBDhaD276Q60SgDE2Q4h638aoKILp3+AhF+qEIhzCi3eyHfD
         j7QzL/O25GqWBPwBfMN64qmoL5Jfo0fGZpYu1PYC9S27QtGojkdyy61Bwdrb2ocvC6
         /Vr52g8/FuftvTk6YHYI6wX33Ekf1fN+1b1qtSNhAhZx35yDaZGEGOaK7v49UX59Gh
         0sQ1U7js7oi8gg3gJjVkzlBy9jb74D6/Qs7oT1+CnrcLd9uYZHuVWtenN6pCSxDxKY
         eO3nWJZicr4DQj5D0dAa0kXWYZrlOBCuN1POd3UoLGomO7c/q9JIXwYC8XVZAw6UCp
         eYGB/xr+AxiEQ==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Boris Barbulovski <bbarbulovski@gmail.com>,
        Michal Marek <mmarek@suse.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kconfig: qconf: fix signal connection to invalid slots
Date:   Tue, 18 Aug 2020 01:36:29 +0900
Message-Id: <20200817163631.37034-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

 scripts/kconfig/qconf.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index bc390df49f1f..c1812563b818 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -885,7 +885,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 		connect(action, SIGNAL(toggled(bool)),
 			parent(), SLOT(setShowName(bool)));
 		connect(parent(), SIGNAL(showNameChanged(bool)),
-			action, SLOT(setOn(bool)));
+			action, SLOT(setChecked(bool)));
 		action->setChecked(showName);
 		headerPopup->addAction(action);
 
@@ -894,7 +894,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 		connect(action, SIGNAL(toggled(bool)),
 			parent(), SLOT(setShowRange(bool)));
 		connect(parent(), SIGNAL(showRangeChanged(bool)),
-			action, SLOT(setOn(bool)));
+			action, SLOT(setChecked(bool)));
 		action->setChecked(showRange);
 		headerPopup->addAction(action);
 
@@ -903,7 +903,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 		connect(action, SIGNAL(toggled(bool)),
 			parent(), SLOT(setShowData(bool)));
 		connect(parent(), SIGNAL(showDataChanged(bool)),
-			action, SLOT(setOn(bool)));
+			action, SLOT(setChecked(bool)));
 		action->setChecked(showData);
 		headerPopup->addAction(action);
 	}
@@ -1275,7 +1275,7 @@ QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
 
 	action->setCheckable(true);
 	connect(action, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
-	connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setOn(bool)));
+	connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setChecked(bool)));
 	action->setChecked(showDebug());
 	popup->addSeparator();
 	popup->addAction(action);
-- 
2.25.1

