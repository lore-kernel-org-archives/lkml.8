Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCB5C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2A2206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582398302;
	bh=bZGsq3QGq9Uia3PPbJusqM4Yd3Y7GVGLYqm4bOOErYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PTgRJSZHYN0BeZkq8A9Ner3REkZcUcJVU8iFtaVrHeOKefU0BplQYVPnlhIE9iacR
	 M9Y3T98aS30PmFXUc52ZJj4QLdUSS4/pxuV0ih2wc2HmX38FBgwwdS/3inAK9gdhhg
	 01/rVyffLNwBM8xPAbXpElqaB4cDYSvlyavqbujA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBVTFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:05:01 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:23060 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgBVTE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:04:59 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 01MJ4cZ7012807;
        Sun, 23 Feb 2020 04:04:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 01MJ4cZ7012807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582398282;
        bh=+FVDFnLL298bgalkTSawbKe4OXpVDH31Bj+BPaPEFT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1YL5vpg+R4/voPIKhG+mWqnSEUKdufZNN0UNuCAAm8dpbCqJSOy/yk+uniwbGZde
         Zy4blMojdzY32BqtqKd472LQgDCHCVMxUJrtcmiw4HB5zaDErCtBwe0cp4TF1Bv31Y
         TIKeYB95nt9lvjql7zAiJfFHq/Mam7jkWIEDZW8GfjN88zg6XXHjqKzVBucrFcaiFE
         r+UHfUZTNejNJyLEm0XQUarXL+XCimhiHljnzeFo8kXDT0b6T2Ffl0QN1NOgseidug
         /qdPCR4hOUviBa4AyuU/orL15EtJKshu7dqttMQy80bZG+5X9KzIOU16dp+QWKzoRk
         TGs6ABxjpYl2g==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] kbuild: allow to run dt_binding_check and dtbs_check in a single command
Date:   Sun, 23 Feb 2020 04:04:35 +0900
Message-Id: <20200222190435.11767-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222190435.11767-1-masahiroy@kernel.org>
References: <20200222190435.11767-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 93512dad334d ("dt-bindings: Improve validation build error
handling"), 'make dtbs_check' does not validate the schema fully.

If you want to check everything, you need to run two commands.

  $ make ARCH=arm dt_binding_check
  $ make ARCH=arm dtbs_check

You cannot do:

  $ make ARCH=arm dt_binding_check dtbs_check

Because CHECK_DTBS is set, dt-doc-validate and dt-extract-example
are skipped.

Making it work will be useful for schema writers.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/devicetree/bindings/Makefile  | 6 ++----
 Documentation/devicetree/writing-schema.rst | 4 ++++
 Makefile                                    | 8 +++++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 646cb3525373..6efa2094b95e 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -25,10 +25,8 @@ DT_DOCS = $(shell \
 
 DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
 
-ifeq ($(CHECK_DTBS),)
-extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
-extra-y += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
-endif
+extra-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
+extra-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
 
 $(obj)/$(DT_TMP_SCHEMA): $(DT_SCHEMA_FILES) FORCE
 	$(call if_changed,mk_schema)
diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 7635ab230456..220cf464ed77 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -147,6 +147,10 @@ Note that ``dtbs_check`` will skip any binding schema files with errors. It is
 necessary to use ``dt_binding_check`` to get all the validation errors in the
 binding schema files.
 
+It is possible to run both in a single command::
+
+    make dt_binding_check dtbs_check
+
 It is also possible to run checks with a single schema file by setting the
 ``DT_SCHEMA_FILES`` variable to a specific schema file.
 
diff --git a/Makefile b/Makefile
index 83f9b8f6fbaf..59dd768a1c1e 100644
--- a/Makefile
+++ b/Makefile
@@ -1243,7 +1243,7 @@ dtbs dtbs_check: include/config/kernel.release scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
 dtbs_check: export CHECK_DTBS=1
-dtbs_check: dt_binding_check
+dtbs_check: __dt_binding_check
 
 dtbs_install:
 	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
@@ -1258,8 +1258,10 @@ PHONY += scripts_dtc
 scripts_dtc: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts/dtc
 
-PHONY += dt_binding_check
-dt_binding_check: scripts_dtc
+PHONY += dt_binding_check __dt_binding_check
+dt_binding_check: export CHECK_DT_BINDING=y
+dt_binding_check: __dt_binding_check
+__dt_binding_check: scripts_dtc
 	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
 
 # ---------------------------------------------------------------------------
-- 
2.17.1

