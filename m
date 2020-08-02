Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C49206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596385091;
	bh=1UtANFu/BmJylUjVYFVC/NjDZsYvtBkcmG1Bw3m32As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m8yX/s+vzOUlhZMm41J2JebhYBLcAXjud2v00MoCVbqgU1Ckc161BdyHf7K5HCLwb
	 s8eVh7pGUDtOn0jP3CidNCTDxweKVHYLBPCRZGQVN1a58KDxHT9IODCgdxjtxlvsW3
	 05fjHzrw3qjNVfrqDtvA8gVqmkPeE4VRj6ixV6pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHBQSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:18:10 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:48907 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgHBQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:18:06 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 072GHOae003720;
        Mon, 3 Aug 2020 01:17:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 072GHOae003720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596385046;
        bh=hqiIXIqdCOcES7qgpPpJ8J0MEsEi3bePazNZOEv2i18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJ4yFE95su/9EDUh+wbvFz2rn9zl8n3Wpb18zB5RlCgpWcaie0DDVGU/UI7s6elCM
         fC4jNWc5zFcJhfYuipxAY/aSUU8VnSW7ix2duAJ5evacq3rCqRDNpE/++DDeEIn7lu
         sehDfAvQvknhHhjmUabLqDQqBXDjtMmNyGCUJ2J43V05eCPenkws4FYtobragnIHg7
         1TOcEE9Eol/t+wGaJLVidXTW/FRQt9FH7h7pr2+TNgWVBKLlhdKq1X8SANqFZTUdi8
         ilnnaGv93dA1axblFcB+r/AUq7LFdcn6voyvhS9on+C+xphlB1OTbtGKKBzcHuy66s
         QStzxb0jk86/w==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/16] kconfig: qconf: remove toolBar from ConfigMainWindow members
Date:   Mon,  3 Aug 2020 01:17:08 +0900
Message-Id: <20200802161721.921721-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200802161721.921721-1-masahiroy@kernel.org>
References: <20200802161721.921721-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pointer is only used in the ConfigMainWindow constructor.

Drop it from the private members.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 2 +-
 scripts/kconfig/qconf.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 0ef9a1da6475..4eb846c90b1d 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1431,7 +1431,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 	setTabOrder(configList, helpText);
 	configList->setFocus();
 
-	toolBar = new QToolBar("Tools", this);
+	QToolBar *toolBar = new QToolBar("Tools", this);
 	addToolBar(toolBar);
 
 	backAction = new QAction(QPixmap(xpm_back), "Back", this);
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 5eeab4a8bb43..b80683998635 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -326,7 +326,6 @@ public slots:
 	ConfigView *configView;
 	ConfigList *configList;
 	ConfigInfoView *helpText;
-	QToolBar *toolBar;
 	QAction *backAction;
 	QAction *singleViewAction;
 	QAction *splitViewAction;
-- 
2.25.1

