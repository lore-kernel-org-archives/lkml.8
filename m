Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E21CC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5C92076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588262752;
	bh=HmyB3mSvSoBZPTU9c0iLb35gC8/ETJP1f64nm3K/i1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2LErJj6PYXPbcr2BLGltbr7hQ4O9r8/akI8p+OdBVfDfx5RfmZy1ObmL+MKicwhSC
	 s3Ju05OPGU0qqUpHQ8mwCrBKgFObWKKGjVFeHPAC9wzhhvWkUBivHx5Oa4G3e9TEE6
	 V96jKQ1gKyeX2/zlfXA6A9JHOfftSGXKJ5u47h/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgD3QFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgD3QEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:04:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 841782498E;
        Thu, 30 Apr 2020 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588262676;
        bh=HmyB3mSvSoBZPTU9c0iLb35gC8/ETJP1f64nm3K/i1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vex0vRLfRaPVrDWeUZX5D7AZbuVYx+maDsfpkaQR2lYLrvz6Y/IEFw6KhhR4aTzUT
         YZ5CMzEjin0mg2YFFcoKaYFttoivJ+bX/6XlfhS+2eyvb0OB4QTaMHC88/EYyKLktd
         ZVV42aeM5mxj86iSlDx4aBMxMFdBj21z2/XxQi9U=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBfu-00AxGQ-P1; Thu, 30 Apr 2020 18:04:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 29/37] docs: networking: convert seg6-sysctl.txt to ReST
Date:   Thu, 30 Apr 2020 18:04:24 +0200
Message-Id: <3d8b7e996ad24578d9dcc72de4e0d4bc1479ddd2.1588261997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588261997.git.mchehab+huawei@kernel.org>
References: <cover.1588261997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add SPDX header;
- mark code blocks and literals as such;
- add a document title;
- adjust chapters, adding proper markups;
- mark lists as such;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/index.rst       |  1 +
 Documentation/networking/seg6-sysctl.rst | 26 ++++++++++++++++++++++++
 Documentation/networking/seg6-sysctl.txt | 18 ----------------
 3 files changed, 27 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/networking/seg6-sysctl.rst
 delete mode 100644 Documentation/networking/seg6-sysctl.txt

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 8b672f252f67..716744c568b7 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -102,6 +102,7 @@ Contents:
    rxrpc
    sctp
    secid
+   seg6-sysctl
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/seg6-sysctl.rst b/Documentation/networking/seg6-sysctl.rst
new file mode 100644
index 000000000000..ec73e1445030
--- /dev/null
+++ b/Documentation/networking/seg6-sysctl.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Seg6 Sysfs variables
+====================
+
+
+/proc/sys/net/conf/<iface>/seg6_* variables:
+============================================
+
+seg6_enabled - BOOL
+	Accept or drop SR-enabled IPv6 packets on this interface.
+
+	Relevant packets are those with SRH present and DA = local.
+
+	* 0 - disabled (default)
+	* not 0 - enabled
+
+seg6_require_hmac - INTEGER
+	Define HMAC policy for ingress SR-enabled packets on this interface.
+
+	* -1 - Ignore HMAC field
+	* 0 - Accept SR packets without HMAC, validate SR packets with HMAC
+	* 1 - Drop SR packets without HMAC, validate SR packets with HMAC
+
+	Default is 0.
diff --git a/Documentation/networking/seg6-sysctl.txt b/Documentation/networking/seg6-sysctl.txt
deleted file mode 100644
index bdbde23b19cb..000000000000
--- a/Documentation/networking/seg6-sysctl.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-/proc/sys/net/conf/<iface>/seg6_* variables:
-
-seg6_enabled - BOOL
-	Accept or drop SR-enabled IPv6 packets on this interface.
-
-	Relevant packets are those with SRH present and DA = local.
-
-	0 - disabled (default)
-	not 0 - enabled
-
-seg6_require_hmac - INTEGER
-	Define HMAC policy for ingress SR-enabled packets on this interface.
-
-	-1 - Ignore HMAC field
-	0 - Accept SR packets without HMAC, validate SR packets with HMAC
-	1 - Drop SR packets without HMAC, validate SR packets with HMAC
-
-	Default is 0.
-- 
2.25.4

