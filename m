Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26524C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBED246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583136007;
	bh=hLSGx3jFKShNIdTWCrJg3t3okWLJsIVfxmsvEFZuNyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xp1YZ6jtuQbl1Yhel7SV/Vrb3YGHASYWXjLEUFIQ4UnXyC8gSGVbXVwhoXaKDds0C
	 bAUJ58Af3wq7gTJTIxK2UYziIO/7qsmxmjO9Z/A7BVUl4+OdPqK0PL1zJgkEDPL87h
	 tiIsd296i2lq/yty/soRXKAqceF0RNtxm/vGdfRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCBIAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgCBH7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:59:43 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F83F246C2;
        Mon,  2 Mar 2020 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135981;
        bh=hLSGx3jFKShNIdTWCrJg3t3okWLJsIVfxmsvEFZuNyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xA7f2U0A0LQn71bvlD1TezC/NZtDPt+J8oFb2ItJcFghbk2vrgj5vBWzSWBE1w49a
         7U7mVFYLGo/jk8n8kZgqvaR2q3Hg4ozYIUWh4dfWiN8sMaZQHJBzmXGkVxd7AitbOt
         QKkKNAFnv9giONG/HmLzTfOXKIkFi8kazBT7IL7I=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8fzH-0003h1-8b; Mon, 02 Mar 2020 08:59:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 10/12] docs: dt: convert ABI.txt to ReST format
Date:   Mon,  2 Mar 2020 08:59:35 +0100
Message-Id: <099b1f43450e7ed5670b585204c6e37dea90a5ad.1583135507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583135507.git.mchehab+huawei@kernel.org>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file only requires a properly-formatted title to be
recognized as a ReST file.

As there will be more files under bindings/ that will be
included at the documentation body, add a new index.rst
file there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm/microchip.rst                        |  2 +-
 Documentation/devicetree/bindings/{ABI.txt => ABI.rst} |  5 ++++-
 Documentation/devicetree/bindings/arm/amlogic.yaml     |  2 +-
 Documentation/devicetree/bindings/arm/syna.txt         |  2 +-
 Documentation/devicetree/bindings/index.rst            | 10 ++++++++++
 Documentation/devicetree/index.rst                     |  2 ++
 6 files changed, 19 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/{ABI.txt => ABI.rst} (94%)
 create mode 100644 Documentation/devicetree/bindings/index.rst

diff --git a/Documentation/arm/microchip.rst b/Documentation/arm/microchip.rst
index 05e5f2dfb814..9c013299fd3b 100644
--- a/Documentation/arm/microchip.rst
+++ b/Documentation/arm/microchip.rst
@@ -192,7 +192,7 @@ Device Tree files and Device Tree bindings that apply to AT91 SoCs and boards ar
 considered as "Unstable". To be completely clear, any at91 binding can change at
 any time. So, be sure to use a Device Tree Binary and a Kernel Image generated from
 the same source tree.
-Please refer to the Documentation/devicetree/bindings/ABI.txt file for a
+Please refer to the Documentation/devicetree/bindings/ABI.rst file for a
 definition of a "Stable" binding/ABI.
 This statement will be removed by AT91 MAINTAINERS when appropriate.
 
diff --git a/Documentation/devicetree/bindings/ABI.txt b/Documentation/devicetree/bindings/ABI.rst
similarity index 94%
rename from Documentation/devicetree/bindings/ABI.txt
rename to Documentation/devicetree/bindings/ABI.rst
index d25f8d379680..a885713cf184 100644
--- a/Documentation/devicetree/bindings/ABI.txt
+++ b/Documentation/devicetree/bindings/ABI.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-  Devicetree (DT) ABI
+===================
+Devicetree (DT) ABI
+===================
 
 I. Regarding stable bindings/ABI, we quote from the 2013 ARM mini-summit
    summary document:
diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index f74aba48cec1..a21ce4ad63f6 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -17,7 +17,7 @@ description: |+
   any time. Be sure to use a device tree binary and a kernel image
   generated from the same source tree.
 
-  Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
+  Please refer to Documentation/devicetree/bindings/ABI.rst for a definition of a
   stable binding/ABI.
 
 properties:
diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
index 2face46a5f64..d8b48f2edf1b 100644
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ b/Documentation/devicetree/bindings/arm/syna.txt
@@ -13,7 +13,7 @@ considered "unstable". Any Marvell Berlin device tree binding may change at any
 time. Be sure to use a device tree binary and a kernel image generated from the
 same source tree.
 
-Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
+Please refer to Documentation/devicetree/bindings/ABI.rst for a definition of a
 stable binding/ABI.
 
 ---------------------------------------------------------------
diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
new file mode 100644
index 000000000000..98ebdab24b51
--- /dev/null
+++ b/Documentation/devicetree/bindings/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+Device Tree
+===========
+
+.. toctree::
+   :maxdepth: 1
+
+   ABI
diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index 0669a53fc617..2f2c93c75713 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -14,3 +14,5 @@ Open Firmware and Device Tree
    dynamic-resolution-notes
    of_unittest
    overlay-notes
+
+   bindings/index
-- 
2.21.1

