Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D57C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6983A20829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597426480;
	bh=gpyWRef+xsyd/pCQfqd0BvD+flkKD5FfR32rFwbHrng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZU9lIZ3JZf9ivog5KgUa0y0CzC8K/Alw7OtKLVRG2iZkIhLQ9uyu0hMXyq11fpXno
	 4lk6fpE1/9MoWCX/Q4BCVCP+1cnbY2keoK7+mf5TNEdo6lUEnE2ZBThsXQuPr0fTY/
	 G/HPZyUaSkYwFAdpzROGzYy/SMWwmnusRHL6jNs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgHNRei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:34:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33734 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgHNReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:34:23 -0400
Received: by mail-io1-f68.google.com with SMTP id g14so11627873iom.0;
        Fri, 14 Aug 2020 10:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vBukXRpzXGxxaRWK2ZPECr+qES1cRfcn/6HodQxij4=;
        b=ZlHBsS56oorpgPD696c5Jzw6EWMZDje4ZsA37e3slXf8S8LOmb0gi+KjBP9aHyC9gv
         KvRKxppPIeD7ECfPNx9IfRjs4lXpot+orX2SBpXury1kYs8JMm0SxQ84PG0dxgZ9KgMG
         k78RDtUwWyKaTbPGR9dgjUCTNung0SqfoSa19apQN9QlW/FQ8n2/Ek+B2AKJhfBtfag3
         aXdRM+GL4xbdIHPGCPOXKZq4Ckh1yK5TjvlPenjnGStFgu+upHvxn1exYtdzJh3Xf1ij
         ADkekhQV45iJ5EmwBa83JN/APC5yGo0bAGdO2rWAsCuIzNU/ZT5grDZmKZW6Ra1lEtMF
         +dhw==
X-Gm-Message-State: AOAM530J5TGeslul+8RbEfwy/1Bo0sURjkWsIxgqheA6rYUhjrLcKMsc
        rJ6PDbCT7jcI27dEGrKe6Z4NWl09Hw==
X-Google-Smtp-Source: ABdhPJxgMrUsgBgV3ET3NUD4M+5bdwYtnUCb++jdhFmj34uW/1f/iL1tQMdcYie6nasWarr/muwGQQ==
X-Received: by 2002:a02:a04d:: with SMTP id f13mr3672108jah.112.1597426462005;
        Fri, 14 Aug 2020 10:34:22 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id x185sm4637575iof.41.2020.08.14.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 10:34:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrei Ziureaev <andrei.ziureaev@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] dt-bindings: Use json for processed-schema*
Date:   Fri, 14 Aug 2020 11:34:16 -0600
Message-Id: <20200814173417.2322509-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814173417.2322509-1-robh@kernel.org>
References: <20200814173417.2322509-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Ziureaev <andrei.ziureaev@arm.com>

Change the format of processed-schema* from yaml to json to speed up
validation. With json output, using xargs and appending the output won't
work since json has explicit list begin and end characters. Instead,
we pass the schema files as a list in a temp file.

The parsing time for the processed schema goes down from ~2sec to 70ms.
Also, 'make dtbs_check' becomes 33% faster.

Some error messages are affected by this change. For example, "True was
expected" becomes "... is not of type 'boolean'". The order of messages
is also changed.

Signed-off-by: Andrei Ziureaev <andrei.ziureaev@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/.gitignore |  1 +
 Documentation/devicetree/bindings/Makefile   | 25 ++++++++++----------
 scripts/Makefile.lib                         |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
index 5c6d8ea1a09c..3a05b99bfa26 100644
--- a/Documentation/devicetree/bindings/.gitignore
+++ b/Documentation/devicetree/bindings/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 *.example.dts
 processed-schema*.yaml
+processed-schema*.json
diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 6a678eb5b5cd..bedc2210a2e0 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -19,18 +19,19 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 	$(call if_changed,chk_binding)
 
 # Use full schemas when checking %.example.dts
-DT_TMP_SCHEMA := $(obj)/processed-schema-examples.yaml
+DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
 
 find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' ! \
 		-name '*.example.dt.yaml' \)
 
 quiet_cmd_mk_schema = SCHEMA  $@
-      cmd_mk_schema = rm -f $@ ; \
+      cmd_mk_schema = f=$$(mktemp) ; \
                       $(if $(DT_MK_SCHEMA_FLAGS), \
                            echo $(real-prereqs), \
-                           $(find_cmd)) | \
-                      xargs $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) >> $@
+                           $(find_cmd)) > $$f ; \
+                      $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
+		      rm -f $$f
 
 DT_DOCS = $(shell $(find_cmd) | sed -e 's|^$(srctree)/||')
 
@@ -39,33 +40,33 @@ override DTC_FLAGS := \
 	-Wno-graph_child_address \
 	-Wno-interrupt_provider
 
-$(obj)/processed-schema-examples.yaml: $(DT_DOCS) check_dtschema_version FORCE
+$(obj)/processed-schema-examples.json: $(DT_DOCS) check_dtschema_version FORCE
 	$(call if_changed,mk_schema)
 
 ifeq ($(DT_SCHEMA_FILES),)
 
 # Unless DT_SCHEMA_FILES is specified, use the full schema for dtbs_check too.
-# Just copy processed-schema-examples.yaml
+# Just copy processed-schema-examples.json
 
-$(obj)/processed-schema.yaml: $(obj)/processed-schema-examples.yaml FORCE
+$(obj)/processed-schema.json: $(obj)/processed-schema-examples.json FORCE
 	$(call if_changed,copy)
 
 DT_SCHEMA_FILES = $(DT_DOCS)
 
 else
 
-# If DT_SCHEMA_FILES is specified, use it for processed-schema.yaml
+# If DT_SCHEMA_FILES is specified, use it for processed-schema.json
 
-$(obj)/processed-schema.yaml: DT_MK_SCHEMA_FLAGS := -u
-$(obj)/processed-schema.yaml: $(DT_SCHEMA_FILES) check_dtschema_version FORCE
+$(obj)/processed-schema.json: DT_MK_SCHEMA_FLAGS := -u
+$(obj)/processed-schema.json: $(DT_SCHEMA_FILES) check_dtschema_version FORCE
 	$(call if_changed,mk_schema)
 
 endif
 
 extra-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
 extra-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
-extra-$(CHECK_DT_BINDING) += processed-schema-examples.yaml
-extra-$(CHECK_DTBS) += processed-schema.yaml
+extra-$(CHECK_DT_BINDING) += processed-schema-examples.json
+extra-$(CHECK_DTBS) += processed-schema.json
 
 # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
 # build artifacts here before they are processed by scripts/Makefile.clean
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3d599716940c..94133708889d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -328,7 +328,7 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 DT_CHECKER ?= dt-validate
 DT_BINDING_DIR := Documentation/devicetree/bindings
 # DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
-DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.yaml
+DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
 quiet_cmd_dtb_check =	CHECK   $@
       cmd_dtb_check =	$(DT_CHECKER) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@
-- 
2.25.1

