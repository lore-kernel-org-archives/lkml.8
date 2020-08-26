Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9ADC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF87206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598438865;
	bh=Lvyb5KpjD9ty7k+AidwSvtKMkTYAduxDPoMjNnhAkaI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qjhjhGuHXWd+NdgZ8QwamalFjemb94902gWlBC7xK3CE+Qa2mH7OuODfYzkzit4yK
	 EAT0zzwGrpNcbyyjEOuDAVonsCcBhPBenRgrEaZKdo1ishErukWn6mWwtnzhBX2mAB
	 B8RwKbBIQC/ziOKxjZJlwfCJ+AQFh1npTmTWSavk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHZKrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgHZKrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:20 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A3320838;
        Wed, 26 Aug 2020 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438837;
        bh=Lvyb5KpjD9ty7k+AidwSvtKMkTYAduxDPoMjNnhAkaI=;
        h=From:To:Cc:Subject:Date:From;
        b=l/3Wb/c9lZmCnQgY1jqh72PqzKgXtxMVpvVF7Cst7nCTpDh+z0qxIQN+L3YNXFEHQ
         sZDOVmokrewaHKhaCg86tSkNG0M8Fw2oZUFlM4Tc01CKWJqxIomUy0rgKQZhMkbLCr
         1uwNcjydTfxyvkCxXytvPdAG8tGhGHCqhlHCPjuQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxX-002Dgk-7v; Wed, 26 Aug 2020 12:47:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] staging: hikey9xx: update references inside the yaml files
Date:   Wed, 26 Aug 2020 12:47:14 +0200
Message-Id: <20200826104714.529235-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The references inside those files were not assuming that
they would end at the staging tree.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml     | 2 +-
 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index c76093f320f1..80e74c261e05 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -17,7 +17,7 @@ description: |
   node.
 
   The SPMI controller part is provided by
-  Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml.
+  drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml.
 
 properties:
   $nodename:
diff --git a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
index b1cfa9c3aca6..f2a56fa4e78e 100644
--- a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
@@ -14,7 +14,7 @@ description: |
   It is a MIPI System Power Management (SPMI) controller.
 
   The PMIC part is provided by
-  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
+  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
 
 properties:
   $nodename:
@@ -41,7 +41,7 @@ patternProperties:
       PMIC properties, which are specific to the used SPMI PMIC device(s).
       When used in combination with HiSilicon 6421v600, the properties
       are documented at
-      Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
+      drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
 
 examples:
   - |
-- 
2.26.2

