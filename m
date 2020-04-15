Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72318C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEFD2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961959;
	bh=Tgx8bhgHklE3FDZN9i6EsAGZk7UfLJB3Oy+zSTpJTjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CZK/zx/Z2YQjinSAObe2ozhtVPhbqa1oxm269UzfaZZ4Jn61sZN8E3ez2HH2aAcnv
	 9ji2nYlqSNrC8OU+/YU+4onllx5azXfxMQTodF8ot8GJ7//2WQm58vShPhvu6RLyJn
	 aPExP23MARcKkuM6cDEt0NMtx4+RPv17dnCQ8i74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370932AbgDOOp4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636795AbgDOOpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D72218AC;
        Wed, 15 Apr 2020 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961929;
        bh=Tgx8bhgHklE3FDZN9i6EsAGZk7UfLJB3Oy+zSTpJTjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qy38bo6tXyunOd7fssISCteEmQC1jwS+lxtVXlNgBuwUsCE1XBnGqltK8LvvfU38O
         N2qgx9t7zxpsbTrfhqCb2N3TorkMRnTTDQBaX02kYlJNP+Rn28JogIJyaA5xT8Wmdw
         hjai+vMqj0Mhhi6NEwCsGQmds4IRE5GmSuy6ng84=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOjI7-006ka3-I8; Wed, 15 Apr 2020 16:45:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 12/12] docs: dt: convert writing-bindings.txt to ReST
Date:   Wed, 15 Apr 2020 16:45:26 +0200
Message-Id: <f2fb27f86a12c16d4b20d9051dec405d4f29a2bb.1586961793.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586961793.git.mchehab+huawei@kernel.org>
References: <cover.1586961793.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Mark literal blocks as such;
- Add it to bindings/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/index.rst                | 1 +
 .../{writing-bindings.txt => writing-bindings.rst}         | 7 +++++++
 2 files changed, 8 insertions(+)
 rename Documentation/devicetree/bindings/{writing-bindings.txt => writing-bindings.rst} (92%)

diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
index 6b87875a049c..3837b17c234f 100644
--- a/Documentation/devicetree/bindings/index.rst
+++ b/Documentation/devicetree/bindings/index.rst
@@ -9,3 +9,4 @@ Device Tree
 
    ABI
    submitting-patches
+   writing-bindings
diff --git a/Documentation/devicetree/bindings/writing-bindings.txt b/Documentation/devicetree/bindings/writing-bindings.rst
similarity index 92%
rename from Documentation/devicetree/bindings/writing-bindings.txt
rename to Documentation/devicetree/bindings/writing-bindings.rst
index ca024b9c7433..45ff426d0019 100644
--- a/Documentation/devicetree/bindings/writing-bindings.txt
+++ b/Documentation/devicetree/bindings/writing-bindings.rst
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================================
 DOs and DON'Ts for designing and writing Devicetree bindings
+============================================================
 
 This is a list of common review feedback items focused on binding design. With
 every rule, there are exceptions and bindings have many gray areas.
@@ -8,6 +12,7 @@ Documentation/devicetree/bindings/submitting-patches.rst
 
 
 Overall design
+==============
 
 - DO attempt to make bindings complete even if a driver doesn't support some
   features. For example, if a device has an interrupt, then include the
@@ -32,6 +37,7 @@ Overall design
 
 
 Properties
+==========
 
 - DO make 'compatible' properties specific. DON'T use wildcards in compatible
   strings. DO use fallback compatibles when devices are the same as or a subset
@@ -53,6 +59,7 @@ Properties
 
 
 Board/SoC .dts Files
+====================
 
 - DO put all MMIO devices under a bus node and not at the top-level.
 
-- 
2.25.2

