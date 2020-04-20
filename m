Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE045C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6FF206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587422997;
	bh=ER60G7f/wCi9YNreYn1CMCDR1SWv2rYWmzhxdoW2o70=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FaYrQjvXONYw2kmbsXJtAnXVg+CdwmvdxOY/kRzXpQzEw2laiAo11ZFltBrTthN07
	 k6NrRop18ef903xs9Uyyo3CK/OX4XBBLsJ/vWuC7dL9fQkWP+y/Wc55P2iPdaKc8L5
	 qrgytbfboK2/+D15uGZpgEfBdf8Wmv9Fhz4fTTDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDTWt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:49:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44226 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:49:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id j4so9641344otr.11;
        Mon, 20 Apr 2020 15:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WxapfpzO9hO69SC6FH5ie/6DnovyNGoMMyMXhqKbPBU=;
        b=Mmdm+26eykaJdqR19q0NrZ2zAbxTEs/oMzm/89/ug7ywuGluks9FxC2dQcSAjnqDue
         ic3FlvS51A+vcwboApnSWSPKN2NEdGSd2veMLJIKdEgm5x4Bc4yEV2nEpiYNuaCsd0iD
         Rx62B4FXexRVSltTGwgUerDumKmqo9Qy0AEvrhISCMNqKYltYbgi76HLMvTnBCNVFAZ6
         HU/C4SpN/vCzpET3RQO8vaB37WzZ/qL9GWhq0r2wAw9TJ0H0G8ORqv7n9drZVOH+nLXO
         r9hxnEfgKhdsTGeSuNuz8TY3/xU2vZcb0Px4WjthXmEPirgUbCEQpgxmS3Nyqv7GD2aN
         IlHQ==
X-Gm-Message-State: AGi0PuZG1oDR6ZGYfP/DU0ic7TAMbJSz8ltMsKBJZViI8mmnXcqDRNjZ
        uSSbP0OCPVDuKt864Od9WPApPv0=
X-Google-Smtp-Source: APiQypLKcFOePhjlMDYofUDl5mlCPGBJze9fJqLOZ21TvgSwb9QwiaDLoKcHDilILHnRgmsVo9fqcg==
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr10829424otp.246.1587422994251;
        Mon, 20 Apr 2020 15:49:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n38sm218272ooi.21.2020.04.20.15.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:49:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3] dt-bindings: Add a minimum version check for dtschema
Date:   Mon, 20 Apr 2020 17:49:53 -0500
Message-Id: <20200420224953.31327-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtschema package must be somewhat up to date as the tools and
meta-schema checks are still evolving. Implement a version check,
so this can be enforced. This will help ensure new schema submissions
get checked against the latest meta-schemas.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Drop leading '0' in version month
 - Rework with Masahiro's shell commands

v2:
 - Use a build rule for the version check instead
---
 Documentation/devicetree/bindings/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1df680d07461..67b0969281da 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -3,11 +3,19 @@ DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
 
+DT_SCHEMA_MIN_VERSION = 2020.4
+
+PHONY += check_dtschema_version
+check_dtschema_version:
+	@{ echo $(DT_SCHEMA_MIN_VERSION); \
+	$(DT_DOC_CHECKER) --version 2>/dev/null || echo 0; } | sort -VC || \
+	{ echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)" >&2; false; }
+
 quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
       cmd_chk_binding = $(DT_DOC_CHECKER) -u $(srctree)/$(src) $< ; \
                         $(DT_EXTRACT_EX) $< > $@
 
-$(obj)/%.example.dts: $(src)/%.yaml FORCE
+$(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 	$(call if_changed,chk_binding)
 
 # Use full schemas when checking %.example.dts
@@ -34,11 +42,11 @@ override DTC_FLAGS := \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-graph_child_address
 
-$(obj)/processed-schema-examples.yaml: $(DT_DOCS) FORCE
+$(obj)/processed-schema-examples.yaml: $(DT_DOCS) check_dtschema_version FORCE
 	$(call if_changed,mk_schema)
 
 $(obj)/processed-schema.yaml: DT_MK_SCHEMA_FLAGS := -u
-$(obj)/processed-schema.yaml: $(DT_SCHEMA_FILES) FORCE
+$(obj)/processed-schema.yaml: $(DT_SCHEMA_FILES) check_dtschema_version FORCE
 	$(call if_changed,mk_schema)
 
 extra-y += processed-schema.yaml
-- 
2.20.1

