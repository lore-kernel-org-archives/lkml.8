Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD892071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261806;
	bh=3eXi5Y2LlNte69Jqad2KS0TNErJYIWcHHxtcyLY6VNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ns8hdgCQtZ8woyXPJzZkYvZGR8GOaleAKsi+VfZzEkVy7dm+TZMJg1lXbggCynGvL
	 3kg2y9CImn5RKfT1Sd1NqTGcu9vpQNHAqgDVkAz5UrvGnacTfjanGWpkL366hPJKdw
	 tPLCAX9uY1iEW1Y89VBwkREfejzoIXG8szESAVTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgHXJgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729338AbgHXIsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:48:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4032072D;
        Mon, 24 Aug 2020 08:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258914;
        bh=3eXi5Y2LlNte69Jqad2KS0TNErJYIWcHHxtcyLY6VNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPvIrkMUz2viEIg+3SzimEbA5+16Za/Bx0aWio8iZAh1Uxvrf7sm5x0cHGqW5qG1r
         ei265xp1004bzSK8xx3ihkWgFFyt9t95mWX11q27ZoOheIX+42Mv5OSs3T0NYJS9ZY
         9arxOFTmB0QoB/g60z0D7Lf1B7FF7iSeck5tTiEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 090/107] kconfig: qconf: do not limit the pop-up menu to the first row
Date:   Mon, 24 Aug 2020 10:30:56 +0200
Message-Id: <20200824082409.563072436@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit fa8de0a3bf3c02e6f00b7746e7e934db522cdda9 ]

If you right-click the first row in the option tree, the pop-up menu
shows up, but if you right-click the second row or below, the event
is ignored due to the following check:

  if (e->y() <= header()->geometry().bottom()) {

Perhaps, the intention was to show the pop-menu only when the tree
header was right-clicked, but this handler is not called in that case.

Since the origin of e->y() starts from the bottom of the header,
this check is odd.

Going forward, you can right-click anywhere in the tree to get the
pop-up menu.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/qconf.cc | 68 ++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 0f8c77f847114..3e7fbfae798c2 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -869,40 +869,40 @@ void ConfigList::focusInEvent(QFocusEvent *e)
 
 void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 {
-	if (e->y() <= header()->geometry().bottom()) {
-		if (!headerPopup) {
-			QAction *action;
-
-			headerPopup = new QMenu(this);
-			action = new QAction("Show Name", this);
-			  action->setCheckable(true);
-			  connect(action, SIGNAL(toggled(bool)),
-				  parent(), SLOT(setShowName(bool)));
-			  connect(parent(), SIGNAL(showNameChanged(bool)),
-				  action, SLOT(setOn(bool)));
-			  action->setChecked(showName);
-			  headerPopup->addAction(action);
-			action = new QAction("Show Range", this);
-			  action->setCheckable(true);
-			  connect(action, SIGNAL(toggled(bool)),
-				  parent(), SLOT(setShowRange(bool)));
-			  connect(parent(), SIGNAL(showRangeChanged(bool)),
-				  action, SLOT(setOn(bool)));
-			  action->setChecked(showRange);
-			  headerPopup->addAction(action);
-			action = new QAction("Show Data", this);
-			  action->setCheckable(true);
-			  connect(action, SIGNAL(toggled(bool)),
-				  parent(), SLOT(setShowData(bool)));
-			  connect(parent(), SIGNAL(showDataChanged(bool)),
-				  action, SLOT(setOn(bool)));
-			  action->setChecked(showData);
-			  headerPopup->addAction(action);
-		}
-		headerPopup->exec(e->globalPos());
-		e->accept();
-	} else
-		e->ignore();
+	if (!headerPopup) {
+		QAction *action;
+
+		headerPopup = new QMenu(this);
+		action = new QAction("Show Name", this);
+		action->setCheckable(true);
+		connect(action, SIGNAL(toggled(bool)),
+			parent(), SLOT(setShowName(bool)));
+		connect(parent(), SIGNAL(showNameChanged(bool)),
+			action, SLOT(setOn(bool)));
+		action->setChecked(showName);
+		headerPopup->addAction(action);
+
+		action = new QAction("Show Range", this);
+		action->setCheckable(true);
+		connect(action, SIGNAL(toggled(bool)),
+			parent(), SLOT(setShowRange(bool)));
+		connect(parent(), SIGNAL(showRangeChanged(bool)),
+			action, SLOT(setOn(bool)));
+		action->setChecked(showRange);
+		headerPopup->addAction(action);
+
+		action = new QAction("Show Data", this);
+		action->setCheckable(true);
+		connect(action, SIGNAL(toggled(bool)),
+			parent(), SLOT(setShowData(bool)));
+		connect(parent(), SIGNAL(showDataChanged(bool)),
+			action, SLOT(setOn(bool)));
+		action->setChecked(showData);
+		headerPopup->addAction(action);
+	}
+
+	headerPopup->exec(e->globalPos());
+	e->accept();
 }
 
 ConfigView*ConfigView::viewList;
-- 
2.25.1



