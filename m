Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A141C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C752223F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587138172;
	bh=kagP5imwfFnyfuXXe6TqpflslXEdlrVOwpFJMLTiiq4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XV2MQDCwSh+wp6lNcPOBt1YXUao0f4LN87tZiH8QXM2bhFk9F2HzmK5xtQlh6ckt6
	 STgceZ5SSyPW8f+QvdAzoLGH0zT0C97cs5HZ0p/FOQ7GtMuMhy5oGH+ekk3AWJsCaQ
	 UZV61hMGho9GIx+4UMZdJMqdwyF5PpjPtN5Mp3VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgDQPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:42:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40073 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgDQPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:42:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id t199so2417087oif.7;
        Fri, 17 Apr 2020 08:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yoZ8CcbFLME/ZwmQ3YBGDjBpmj9xhabgRWeRec3Maok=;
        b=ePwH8Izj4U6/7y2E+xV/tXcg7ocx+aGYnxWKPeMhbdD0HS8ABChjivY25eG3I0MNXA
         Xjz7ePeVv7ikvwxzVTW5twoaa+jld7eMLA9kFSDelVuqppW9T9ioJ0BcjKSh3ONmQH6C
         DZupOyiLDhomNkAD5zre1GTsoXeMQuAO9bOYUu+Xz+zK0sTf2hTRwWRkO6pMyZEr9uAZ
         NT2RzMfnYuEU22z6NhG47oLcuv0J5RLLfkPSga7TkCTpNBPxtdSXDD0o6XdOHKhjBdxr
         Gj/bfw6YqmkKvDYz5nGmlTkaZbON5Whw7DKh8bVoxD1TQwmGb/MRrjYxl2boDgvNDvdt
         ND4Q==
X-Gm-Message-State: AGi0PuakZz/x2q85C3hAWUoatAYnVYBeRSpiRPcuz0CCJoLCopSIPSiH
        jdnBnI0rab9Iu2sUYKTXU4NTaCY=
X-Google-Smtp-Source: APiQypI+GA+kBbRldfyKxh5eL6dZtg5236mW4GRY2z5bVcoddCJCjdd4jyehv3n32yULzZ50GdP/2w==
X-Received: by 2002:aca:2212:: with SMTP id b18mr2661325oic.121.1587138168489;
        Fri, 17 Apr 2020 08:42:48 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y131sm8067166oie.39.2020.04.17.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:42:47 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] dt-bindings: Add a minimum version check for dtschema
Date:   Fri, 17 Apr 2020 10:42:46 -0500
Message-Id: <20200417154246.2714-1-robh@kernel.org>
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
v2:
 - Use a build rule for the version check instead

 Documentation/devicetree/bindings/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1df680d07461..daf0dda45a78 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -3,11 +3,19 @@ DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
 
+DT_SCHEMA_MIN_VERSION = 2020.04
+
+PHONY += check_dtschema_version
+check_dtschema_version:
+	@printf "%s\n" $(DT_SCHEMA_MIN_VERSION) \
+	  $$($(DT_DOC_CHECKER) --version 2>/dev/null || echo 0) | sort -VC || \
+	  (echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)"; exit 1) 1>&2
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

