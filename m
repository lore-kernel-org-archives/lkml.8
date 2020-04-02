Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA062072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585819702;
	bh=Or/c+7Yz7rNaW586sekoMkfB7wAeHBOv0HFxS+7zG40=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=Y3cYvUxtJozjVQh1qjI4LwKH3C7l4pwq/PXM+QifbiNdXEGHeGusta48afLrgJlFg
	 bcmvlx6+0u+nJW6kWfY24fDuwkmU85PBROu1kzinUkG19pl77zt+RFEC/BP8oycN0A
	 O6BP0Lp836NBaF4CO1RoKy7tDb0+ftCswhxa0mVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbgDBJ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387736AbgDBJ2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:28:08 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE3C2082F;
        Thu,  2 Apr 2020 09:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585819688;
        bh=Or/c+7Yz7rNaW586sekoMkfB7wAeHBOv0HFxS+7zG40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0WI4+vcBSk8+E2ARSSPEU1XwovcM+dB83Jptmv+EGVvU62aA2N/XmomFXsdHwe0B
         wuEPUL7eIBqFi6RQHsbntYvK893NkrzfrpMtvD252I3I0qiHR7zXxmaUCoOLjpYszM
         fsuRgbeCMi16wbSXk11P59p409GHAZNuL9rnL+iw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jJw8s-000AaP-5U; Thu, 02 Apr 2020 11:28:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 5/6] kconfig: qconf: remove some old bogus TODOs
Date:   Thu,  2 Apr 2020 11:28:02 +0200
Message-Id: <d12dc3231f3f9b1148c002ca3d44d6d9cd6585e5.1585819250.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585819250.git.mchehab+huawei@kernel.org>
References: <cover.1585819250.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The items described on those TODOs are already solved. So,
remove the comments.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kconfig/qconf.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 5a560c647321..f3eaeb2b70da 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -839,7 +839,7 @@ void ConfigList::mouseMoveEvent(QMouseEvent* e)
 
 void ConfigList::mouseDoubleClickEvent(QMouseEvent* e)
 {
-	QPoint p = e->pos(); // TODO: Check if this works(was contentsToViewport).
+	QPoint p = e->pos();
 	ConfigItem* item = (ConfigItem*)itemAt(p);
 	struct menu *menu;
 	enum prop_type ptype;
@@ -1773,7 +1773,6 @@ void ConfigMainWindow::showFullView(void)
 
 /*
  * ask for saving configuration before quitting
- * TODO ask only when something changed
  */
 void ConfigMainWindow::closeEvent(QCloseEvent* e)
 {
-- 
2.25.1

