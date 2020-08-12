Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E5DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F945207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247964;
	bh=hkulLYVHVROMf/Xty0tsOpIzgHS5/4Fr796lhzDXDlM=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=V43U6s1kFBJcIeTuP1vZ2yfvZKoQK23YMqHEqZ5WUR/pql2nOcbo1HrRtbaCFV88l
	 8YjmLVIvTmi+eCwKuUJwyrqwA+SZeIpvMCz7ohb58Rld57dJ89lODJ7CTCBzXK05+g
	 nXqPLHQZxQgNdSvxQ3YCzqa5h1xbZTr4pW+0lswk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHLP7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgHLP5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:02 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A725022BF3;
        Wed, 12 Aug 2020 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247819;
        bh=hkulLYVHVROMf/Xty0tsOpIzgHS5/4Fr796lhzDXDlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpXYJKZRSmHmqetNhmDitveMAY9tjIAyhMtR57bJKs6ONFA0QKQnPwsOMZAHrjc8G
         pHagld5AGgWFnN4MRN9XeWGgs1FTcGd21xW0HH0I8nMfOAkG6IXbIocph2FdbR4kA0
         Wp5Y2RqL/xsH6b7L4POOVYYQLIXxt23ljv8RvKPA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7Z-005t5w-OV; Wed, 12 Aug 2020 17:56:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 09/44] staging: spmi: hisi-spmi-controller: add it to the building system
Date:   Wed, 12 Aug 2020 17:56:19 +0200
Message-Id: <833ffafa5a5f09c530aafcfc428d32dc689aa2f7.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver was ported to upstream, add it as a
SPMI controller.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/Kconfig           |  2 ++
 drivers/staging/Makefile          |  1 +
 drivers/staging/hikey9xx/Kconfig  | 10 ++++++++++
 drivers/staging/hikey9xx/Makefile |  3 +++
 4 files changed, 16 insertions(+)
 create mode 100644 drivers/staging/hikey9xx/Kconfig
 create mode 100644 drivers/staging/hikey9xx/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 4ec5528f89fa..dfce8e39dbc3 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -120,4 +120,6 @@ source "drivers/staging/qlge/Kconfig"
 
 source "drivers/staging/wfx/Kconfig"
 
+source "drivers/staging/hikey9xx/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 4d34198151b3..e369a4f5e14a 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -50,3 +50,4 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_WFX)		+= wfx/
+obj-y				+= hikey9xx/
diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
new file mode 100644
index 000000000000..31eb01b5ef2b
--- /dev/null
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config SPMI_HISI3670
+	tristate "Hisilicon 3670 SPMI Controller"
+	select IRQ_DOMAIN_HIERARCHY
+	depends on HAS_IOMEM
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
+	  processors.
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
new file mode 100644
index 000000000000..e8085abce444
--- /dev/null
+++ b/drivers/staging/hikey9xx/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPMI_HISI3670) += hisi-spmi-controller.o
-- 
2.26.2

