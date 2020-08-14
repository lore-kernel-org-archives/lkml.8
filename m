Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C359C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E5B20829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597426476;
	bh=T9FLRNsC/mntbOqoqi5Im6KIFOC5H1Dv2Wzcm0xqM/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uds5g2Ky8mL9yUpphNn8D5C3qcbAOjj8Jiq9uFHynR1dlyGleGm7A4WDIw0Np+2Zr
	 CuPo596CQQIZmnjbpfScSqfJdz0HW1oElGYTuWL1Cdd1F5jOpjSx2ou+/QpRCGhsuB
	 abf/nb6hjexNx6fMorpU/Iz9oinFU+Wi6DzkwJ0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgHNRef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:34:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42603 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgHNReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:34:24 -0400
Received: by mail-io1-f67.google.com with SMTP id j8so11488283ioe.9;
        Fri, 14 Aug 2020 10:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBzjqYjSkJEbEHMceXH+VuiJYK8gX6oWBcQRGJhBqfE=;
        b=G8zedPQiWnLalFbPw+D7877COMUUyC+TdqeULlSD3+LkAiM/W3Vy1TBMgLXQmRFwWs
         /Tvy5QCM9zQ8zX3ZGugITcfu/+ZBQ06FCIIfu9mfIFTHFmwcFkr8J8Qwgvk6iiLFEw0H
         uHGC2oftBlFXwv8BsH4fLOOQgyc0KeNsE8BeBWeR7sEo+Abd2ocFd3FQ7Rr4VqbZWndk
         jls1mGwYII99aqXUAboa4cskARQQvwCXqbdnfkfZ1NbluQrJzTeGx2vbvDrs//me8GzE
         Yhs5ejOm0OlhRklOvzqxD1OPKipyNFuSsAI6xOYzzhWBH9/scbxlenw2K4xiDwuLWcr+
         JPZw==
X-Gm-Message-State: AOAM532BWXGBl0hK1StB+o2vDNICMhFzrPE/jgaZWACRn4oyMK9Z4BBj
        9LEkfQLNzbZXNTo93Pi1EriR0mFS0w==
X-Google-Smtp-Source: ABdhPJw0x4lnTF3sMh1n8fbE2ZJKcxJB3/Y0HVzdg+LTtpUJGFGbBuAsXrXNZwTg81dJ5XxHY08m2Q==
X-Received: by 2002:a02:3e11:: with SMTP id s17mr3573532jas.67.1597426463407;
        Fri, 14 Aug 2020 10:34:23 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id x185sm4637575iof.41.2020.08.14.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 10:34:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrei Ziureaev <andrei.ziureaev@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] dt-bindings: Validate DT binding schema in a single call
Date:   Fri, 14 Aug 2020 11:34:17 -0600
Message-Id: <20200814173417.2322509-4-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814173417.2322509-1-robh@kernel.org>
References: <20200814173417.2322509-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the number of binding schemas has grown, the time to run
dt_binding_check has gotten pretty slow. A large part of this is due to
the slow startup time of Python (a well documented problem). There's not
currently any benefit to running dt-doc-validate one file at a time, so
let's switch it to run a single rule. Doing this means we loose the make
parallelism, but we can use xargs instead. This speeds up the validation
time from several minutes to <10 sec.

Since the validation is a single step with no output, we move running it
as part of the processed-schema-examples.json target. We also need to
reorder the extra-y entries so the validation is run first rather than
after all the examples are extracted.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index bedc2210a2e0..d21c4c4f9eee 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -11,12 +11,11 @@ check_dtschema_version:
 	$(DT_DOC_CHECKER) --version 2>/dev/null || echo 0; } | sort -VC || \
 	{ echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)" >&2; false; }
 
-quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
-      cmd_chk_binding = $(DT_DOC_CHECKER) -u $(srctree)/$(src) $< ; \
-                        $(DT_EXTRACT_EX) $< > $@
+quiet_cmd_extract_ex = DTEX    $@
+      cmd_extract_ex = $(DT_EXTRACT_EX) $< > $@
 
 $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
-	$(call if_changed,chk_binding)
+	$(call if_changed,extract_ex)
 
 # Use full schemas when checking %.example.dts
 DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
@@ -25,6 +24,10 @@ find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' ! \
 		-name '*.example.dt.yaml' \)
 
+quiet_cmd_chk_bindings = CHKDT   $@
+      cmd_chk_bindings = $(find_cmd) | \
+                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)
+
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
                       $(if $(DT_MK_SCHEMA_FLAGS), \
@@ -33,6 +36,11 @@ quiet_cmd_mk_schema = SCHEMA  $@
                       $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
 		      rm -f $$f
 
+define rule_chkdt
+	$(call cmd,chk_bindings)
+	$(call cmd,mk_schema)
+endef
+
 DT_DOCS = $(shell $(find_cmd) | sed -e 's|^$(srctree)/||')
 
 override DTC_FLAGS := \
@@ -41,7 +49,7 @@ override DTC_FLAGS := \
 	-Wno-interrupt_provider
 
 $(obj)/processed-schema-examples.json: $(DT_DOCS) check_dtschema_version FORCE
-	$(call if_changed,mk_schema)
+	$(call if_changed_rule,chkdt)
 
 ifeq ($(DT_SCHEMA_FILES),)
 
@@ -63,10 +71,10 @@ $(obj)/processed-schema.json: $(DT_SCHEMA_FILES) check_dtschema_version FORCE
 
 endif
 
-extra-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
-extra-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
 extra-$(CHECK_DT_BINDING) += processed-schema-examples.json
 extra-$(CHECK_DTBS) += processed-schema.json
+extra-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
+extra-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
 
 # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
 # build artifacts here before they are processed by scripts/Makefile.clean
-- 
2.25.1

