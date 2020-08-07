Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E00C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E1420855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596791996;
	bh=y+UA5p3ED5L0oldnwtzdnO0tQj+s1KsXDxuIDsqtj9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/eHimbmoNXzZRzVJZMCfrCbi5S5HlZndGc5FPHV74cAHyiEGR/91NVbpd+1GcHiD
	 wDTGhdxPlqsN9GP+d6U/nhgHw9rxdlzV9t0mO9sRDiPdZDcO/8QqDg4JR911gwlWVP
	 hUpBUDP468MqLZAmQf1X9IzITrmJQou0xGaPRs/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHGJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:19:42 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:41484 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgHGJTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:19:35 -0400
Received: from localhost.localdomain (softbank060134047170.bbtec.net [60.134.47.170]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0779JBQ0032147;
        Fri, 7 Aug 2020 18:19:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0779JBQ0032147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596791954;
        bh=mpfNPfPqiVao3oZ/c3NU7ZKvxQ18iH//rapEaLj9PUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v30nadyfDA8UYzFtmonPfnRZG28HBDhwm6GYLzUmd/0iRRTkiSvB8l0bONPmZ3oN2
         Zjg8P1EgKKnWjqkEccf9pI/clA2GPsxJjthDSzqmI2wVNPtKglGiuCcNSd+PFin4a6
         cyqNUIOz1fWq5JHKm3Zzg0BTL2Da0Y7S/HG8l/ToG+S4o1x2wk3xHmKpQ3OYzm5sFw
         WxrWG8tiCjW2NFSAZGUg6DIU0WzbmBn2OpZxWVxDSdEP5/KxBkWARdC7vzxRlHo5UK
         87/+nu0LDYm741p9ShQTRqpVLc9xMKpZ2I2XSC9mF6W23tuS11ytMCe5IxGRnJSwu4
         M+JC0IflpRpcA==
X-Nifty-SrcIP: [60.134.47.170]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/19] kconfig: qconf: remove toolBar from ConfigMainWindow members
Date:   Fri,  7 Aug 2020 18:18:54 +0900
Message-Id: <20200807091909.2985787-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807091909.2985787-1-masahiroy@kernel.org>
References: <20200807091909.2985787-1-masahiroy@kernel.org>
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

(no changes since v1)

 scripts/kconfig/qconf.cc | 2 +-
 scripts/kconfig/qconf.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 2f7c13a758b6..b4f32199e0df 100644
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

