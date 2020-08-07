Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA201C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD0720855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596792024;
	bh=bnwHregWeNIz2L126k+XEbDTwIw/jd2B+q7bRPagxYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xXR9T7s0bmoymLkavsSfkwkd7pf0i4XXo3j4lGRUMKTaBjeJ1+QUwqBVbqliKvIOd
	 /ETCwai0JE+f7+azkXxMtB6IvEbf4pm8LJKAU3Ajeq7wUYcCuQuF/6J1o6AgbGjBpX
	 wiiei0RdkdbYLCsEvIFrQHCSlAPr88AhFdNRoeMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgHGJUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:20:22 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:41596 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgHGJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:19:40 -0400
Received: from localhost.localdomain (softbank060134047170.bbtec.net [60.134.47.170]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0779JBQC032147;
        Fri, 7 Aug 2020 18:19:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0779JBQC032147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596791964;
        bh=w3KzcbrgyiETrQqPWYtQBGT5ncK4Sw4Cv5ADwewuI0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XuI4BpKpwUpsd06Bm4AwQGojdP5uoeov/PesL6MDs2YYXstst4LlCwMOyjVoq95ES
         8AMfnM+kTG7yhuiSpGbKEcnPbZM5i5zsK56vqEqgffox5qdrSH9EWLHeDZRgfzpxpF
         1jr8kfRcGjLXjDhfCmukal/TiJryvRK1EKWE5GG8g0RxLvOQ/1+BZz6jcEdEDYtGRk
         FOg44eIDQqb0kuF5cXoZqGC/ARQjkyecvJOZzq0qEH8PKR59cyLMQj0rCLwUAmtt8i
         hMz6DC+Aw1UQ61fTcnKKwIiGHPZyZr0xWqwUtf8WzhntWgXkg/gUrO5gxOzjEq2Y1g
         1yS0Bj5ezpsRg==
X-Nifty-SrcIP: [60.134.47.170]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/19] kconfig: qconf: remove unused voidPix, menuInvPix
Date:   Fri,  7 Aug 2020 18:19:06 +0900
Message-Id: <20200807091909.2985787-16-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807091909.2985787-1-masahiroy@kernel.org>
References: <20200807091909.2985787-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are initialized, but not used by anyone.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/kconfig/qconf.cc | 2 +-
 scripts/kconfig/qconf.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 04da1397575a..90b618785239 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -291,7 +291,7 @@ ConfigList::ConfigList(ConfigView* p, const char *name)
 	  updateAll(false),
 	  symbolYesPix(xpm_symbol_yes), symbolModPix(xpm_symbol_mod), symbolNoPix(xpm_symbol_no),
 	  choiceYesPix(xpm_choice_yes), choiceNoPix(xpm_choice_no),
-	  menuPix(xpm_menu), menuInvPix(xpm_menu_inv), menuBackPix(xpm_menuback), voidPix(xpm_void),
+	  menuPix(xpm_menu), menuBackPix(xpm_menuback),
 	  showName(false), showRange(false), showData(false), mode(singleMode), optMode(normalOpt),
 	  rootEntry(0), headerPopup(0)
 {
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 012414dcdee5..c46a79a69001 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -100,7 +100,7 @@ public slots:
 
 	QPixmap symbolYesPix, symbolModPix, symbolNoPix;
 	QPixmap choiceYesPix, choiceNoPix;
-	QPixmap menuPix, menuInvPix, menuBackPix, voidPix;
+	QPixmap menuPix, menuBackPix;
 
 	bool showName, showRange, showData;
 	enum listMode mode;
-- 
2.25.1

