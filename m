Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD18820829
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596385110;
	bh=Y0en/AZJopbLmCxXIaQn+P+q9X2/9AUn6KzYYURXPRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NbZGhOANU+d9Nh4qeXeiDZ6v4sbjtyJ2BJWZDNx2fqBfXqSpJMVNOqJp5bgAoHcKR
	 1cxYXTD19HgzxfJxV4jGbmE0MMJA/GrpIvCeXM3ZqBGTYN3iJI5ZNrNE3bfiaOKU93
	 kXu6PkCdV5DH/WKp6yTtqOLl4EinrwP+td6+JXRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgHBQS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:18:29 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:48910 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgHBQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:18:06 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 072GHOak003720;
        Mon, 3 Aug 2020 01:17:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 072GHOak003720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596385048;
        bh=F/o54aoJCSOXONzWWk/Ap8g8IDQiwDgOohQ0NDziXL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DS/Law3jOVA5nQ/7z478BAtiPjYSw5Ac220b6cNHjeQZaV5U/3AatEC9ZunW0FD3P
         Vt5McF/7oDvbdP/DLaiWwuEhyHtKfK2ZiOiWTdbCkhSST1PjjbcytH5Rl0R5twlUJW
         sGzeDH+z39WS3X1hQd5J1z2vEo3cfkdD93g7chYBcgflL9DfVIXJiOYx6vuOd0gcVF
         LCbEIsPVGIMTt6kj4aXK1YCA1UlrunUFjTpS7Sgvtmz1dQN+Nt0Sh6KEN+rMxznteq
         L/fMlaBlAOXQk4VgEkvRlPR8a8/XTzusTNJFoDcU32L3v5X9mtUf3XZly7ZNzP/5Km
         GyZ6Lbfm/J8EQ==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/16] kconfig: qconf: remove unused argument from ConfigView::updateList()
Date:   Mon,  3 Aug 2020 01:17:14 +0900
Message-Id: <20200802161721.921721-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200802161721.921721-1-masahiroy@kernel.org>
References: <20200802161721.921721-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ConfigList::updateList() takes no argument, the 'item' argument
ConfigView::updateList() is no longer used.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 8 ++++----
 scripts/kconfig/qconf.h  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index e65a323754fd..f492e8810f89 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -280,7 +280,7 @@ void ConfigLineEdit::keyPressEvent(QKeyEvent* e)
 	case Qt::Key_Return:
 	case Qt::Key_Enter:
 		sym_set_string_value(item->menu->sym, text().toLatin1());
-		parent()->updateList(item);
+		parent()->updateList();
 		break;
 	default:
 		Parent::keyPressEvent(e);
@@ -471,7 +471,7 @@ void ConfigList::setValue(ConfigItem* item, tristate val)
 			return;
 		if (oldval == no && item->menu->list)
 			item->setExpanded(true);
-		parent()->updateList(item);
+		parent()->updateList();
 		break;
 	}
 }
@@ -505,7 +505,7 @@ void ConfigList::changeValue(ConfigItem* item)
 				item->setExpanded(true);
 		}
 		if (oldexpr != newexpr)
-			parent()->updateList(item);
+			parent()->updateList();
 		break;
 	case S_INT:
 	case S_HEX:
@@ -984,7 +984,7 @@ void ConfigList::setAllOpen(bool open)
 	}
 }
 
-void ConfigView::updateList(ConfigItem* item)
+void ConfigView::updateList()
 {
 	ConfigView* v;
 
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 4dc5d34a6bca..6d06ec399ff0 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -210,7 +210,7 @@ class ConfigView : public QWidget {
 public:
 	ConfigView(QWidget* parent, const char *name = 0);
 	~ConfigView(void);
-	static void updateList(ConfigItem* item);
+	static void updateList();
 	static void updateListAll(void);
 
 	bool showName(void) const { return list->showName; }
-- 
2.25.1

