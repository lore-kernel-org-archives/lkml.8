Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A39C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8AC2074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585819699;
	bh=uW5gIy6Vwri4JjBZCqV2GhL39w/KMjWmxypGxq5SSDw=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=m3ShcgikcSoBdTqLFh7v3u75ehnS/GRAiJ3bj49kbuTG2aUYnitek2kTD3C/1xImD
	 5e087vY1yLGYWA1kfzIiHn/IKrsqegExYmJA81GdAgeQvY1ysIFk8ztoZQBEDegX3v
	 ISYF/7xSJtCv9MyhqRfXq8xx410pDrph5KVoRMHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbgDBJ2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgDBJ2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:28:08 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD52D2073B;
        Thu,  2 Apr 2020 09:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585819687;
        bh=uW5gIy6Vwri4JjBZCqV2GhL39w/KMjWmxypGxq5SSDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H580aSQR61YugH6s4MZW4GdgtvX8Nq0d54fqTDql8QtZ4i4D1B4T81ygOL76yEJyI
         fed4KFk+QNQ/4Flf5odrDQoOM57gUbLORUwELeFPRiggWb3+CvgvB8FoAMFlY+nqrf
         F1Zxx6ZyqlR5M4hi9q5eRq2u3fm1kzZXreumy7nc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jJw8s-000Aa6-1a; Thu, 02 Apr 2020 11:28:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 1/6] kconfig: qconf: clean deprecated warnings
Date:   Thu,  2 Apr 2020 11:27:58 +0200
Message-Id: <9e939a9af7adbfc1e567ca13955788608aecddd3.1585819250.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585819250.git.mchehab+huawei@kernel.org>
References: <cover.1585819250.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recommended way to initialize a null string is with
QString(). This is there at least since Qt5.5, with is
when qconf was ported to Qt5.

Fix those warnings:

	scripts/kconfig/qconf.cc: In member function ‘void ConfigItem::updateMenu()’:
	scripts/kconfig/qconf.cc:158:31: warning: ‘QString::null’ is deprecated: use QString() [-Wdeprecated-declarations]
	  158 |    setText(noColIdx, QString::null);
	      |                               ^~~~
	In file included from /usr/include/qt5/QtCore/qobject.h:47,
	                 from /usr/include/qt5/QtWidgets/qwidget.h:45,
	                 from /usr/include/qt5/QtWidgets/qmainwindow.h:44,
	                 from /usr/include/qt5/QtWidgets/QMainWindow:1,
	                 from scripts/kconfig/qconf.cc:9:

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kconfig/qconf.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 82773cc35d35..daa3325c0a49 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -154,9 +154,9 @@ void ConfigItem::updateMenu(void)
 
 		if (!sym_is_changeable(sym) && list->optMode == normalOpt) {
 			setPixmap(promptColIdx, QIcon());
-			setText(noColIdx, QString::null);
-			setText(modColIdx, QString::null);
-			setText(yesColIdx, QString::null);
+			setText(noColIdx, QString());
+			setText(modColIdx, QString());
+			setText(yesColIdx, QString());
 			break;
 		}
 		expr = sym_get_tristate_value(sym);
@@ -276,7 +276,7 @@ void ConfigLineEdit::show(ConfigItem* i)
 	if (sym_get_string_value(item->menu->sym))
 		setText(QString::fromLocal8Bit(sym_get_string_value(item->menu->sym)));
 	else
-		setText(QString::null);
+		setText(QString());
 	Parent::show();
 	setFocus();
 }
-- 
2.25.1

