Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCB3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A75246B9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583134705;
	bh=bQRwx5N1oMLXQUYzamAbbIdg3iVXNtnWVf4W1C9hQYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CPawczHjG2M87npnAqUAO80xidlNAXnshDt9GXw57KwbguuXV9y9TSasLLeb1xvox
	 hPIuaAGDDu1i/duXQUJ9bfoN8AWRfF10wxlijMHUGia9LyE9unLy+/pclvixyCd/ji
	 ob0bjKo+asKYeb4FTfnriAQXJGOLLKYs1waDDwAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCBHiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:38:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgCBHiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:38:17 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E87D246BF;
        Mon,  2 Mar 2020 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583134696;
        bh=bQRwx5N1oMLXQUYzamAbbIdg3iVXNtnWVf4W1C9hQYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfLrHLjXrkIM7eQBCCeL+qHVgyG/Gy2SZ8JbcLR9/CSIIblyRHnFBz1NKwe+m8xhB
         +djCBge5zD/6eTZJYYpOmgcNvCOvpHDd9NosavfqLoSoO22DkXr/LtaF8eGiIPtQ6i
         0WaKDxNLAiQvAz1genTg6GluUq0oq7bZJSCxSdLo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8feW-0003WA-2y; Mon, 02 Mar 2020 08:38:12 +0100
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 12/12] docs: dt: convert writing-bindings.txt to ReST
Date:   Mon,  2 Mar 2020 08:38:07 +0100
Message-Id: <00ea462a2db1a9b4fd188e0100c52fdf0d68aaf0.1583134242.git.mchehab+samsung@kernel.org>
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
- Adjust document and section titles;
- Mark literal blocks as such;
- Add it to bindings/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
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
2.21.1

