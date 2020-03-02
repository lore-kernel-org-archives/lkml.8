Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBDC3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11A7246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583134745;
	bh=f6i/xaLRU1T6rTh9TlFkJDoYWjgK7JZpOPbZpK+IlBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZVB0no73rhy1f17G7bYW4UKBjYch/uCARuFfufZLLXvV3uYPC+xgoQHcKyeFeSqAe
	 e7UZjmPKxv/8OADV2LQF9f4Uqswm0/dbTj2i/qP7XYt+4gDDWJUk4cdHVtoWTPyWv/
	 w3/EcLAZhQ1frsB0e1ou6kp9w/F1r4dS1xvz4hvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCBHjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCBHiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:38:15 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED26246A1;
        Mon,  2 Mar 2020 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583134694;
        bh=f6i/xaLRU1T6rTh9TlFkJDoYWjgK7JZpOPbZpK+IlBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZC0gx/EyTodst0I9AllFHWhXSLSBkmq8KkXp102rfVUmO6T0D6BYLbJQGR1OQqetT
         xkGhSk/y5ANztZ5UPr1E0WpnHk3p7TNtBMUnIW667jSBS+pfWj6WofAs92j5ZmfH7+
         ocCo81f4216vRBgrWURagHldax0zrKZZqCNfIxhs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8feV-0003Vm-UQ; Mon, 02 Mar 2020 08:38:11 +0100
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 06/12] docs: dt: convert dynamic-resolution-notes.txt to ReST
Date:   Mon,  2 Mar 2020 08:38:01 +0100
Message-Id: <959df4057c4b09f73924c9ee5bafd4ad8c861f99.1583134242.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583134242.git.mchehab+samsung@kernel.org>
References: <cover.1583134242.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

- Add a SPDX header;
- Adjust document title;
- Add it to devicetree/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 ...mic-resolution-notes.txt => dynamic-resolution-notes.rst} | 5 ++++-
 Documentation/devicetree/index.rst                           | 1 +
 Documentation/devicetree/overlay-notes.txt                   | 2 +-
 MAINTAINERS                                                  | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/{dynamic-resolution-notes.txt => dynamic-resolution-notes.rst} (90%)

diff --git a/Documentation/devicetree/dynamic-resolution-notes.txt b/Documentation/devicetree/dynamic-resolution-notes.rst
similarity index 90%
rename from Documentation/devicetree/dynamic-resolution-notes.txt
rename to Documentation/devicetree/dynamic-resolution-notes.rst
index c24ec366c5dc..570b7e1f39eb 100644
--- a/Documentation/devicetree/dynamic-resolution-notes.txt
+++ b/Documentation/devicetree/dynamic-resolution-notes.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
 Device Tree Dynamic Resolver Notes
-----------------------------------
+==================================
 
 This document describes the implementation of the in-kernel
 Device Tree resolver, residing in drivers/of/resolver.c
diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index 64c78c3ffea6..308cac9d7021 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -11,3 +11,4 @@ Open Firmware and Device Tree
    writing-schema
    booting-without-of
    changesets
+   dynamic-resolution-notes
diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index 725fb8d255c1..3f20a39e4bc2 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -3,7 +3,7 @@ Device Tree Overlay Notes
 
 This document describes the implementation of the in-kernel
 device tree overlay functionality residing in drivers/of/overlay.c and is a
-companion document to Documentation/devicetree/dynamic-resolution-notes.txt[1]
+companion document to Documentation/devicetree/dynamic-resolution-notes.rst[1]
 
 How overlays work
 -----------------
diff --git a/MAINTAINERS b/MAINTAINERS
index 09b04505e7c3..1380b1ed69a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12458,7 +12458,7 @@ M:	Pantelis Antoniou <pantelis.antoniou@konsulko.com>
 M:	Frank Rowand <frowand.list@gmail.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/dynamic-resolution-notes.txt
+F:	Documentation/devicetree/dynamic-resolution-notes.rst
 F:	Documentation/devicetree/overlay-notes.txt
 F:	drivers/of/overlay.c
 F:	drivers/of/resolver.c
-- 
2.21.1

