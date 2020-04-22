Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9552C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7012098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587581831;
	bh=ijZwMHJIilf3i+LjKFRurA5yS4s/ePYgWq6wlbXgwH8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vdkENFiNAtD+bZEb3tS86jRv6eSgNzPMnMvET5lbq7hkn79dq3iJkmWh8Gza6RcYk
	 N3yOyHI3+LaW5BxfafpVSccquG+GqqZ6LjnMaWhCQfXyWQZ1U1aRB9vv96oXnlVgsI
	 1oywA6qOPe072n9BX1O+jxZV021BBELqH9Qi6xXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDVS5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:57:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39151 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:57:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id m13so3150876otf.6;
        Wed, 22 Apr 2020 11:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cq9BctsMnDrPgJZQ0WBh6C3iNmbzr1C6pFEKIA64mpY=;
        b=X/W5QlpAPYQVaSrHMERJ4mKZBkY2uIb5WRAv/st6gu+fXyozHt4J7oa17Dl9Lz0Fuk
         mKXp5YrLuL4crZ3Q2xEY+jzxI/SUJEIgeJeRA6KIyl80n5OkZjBm4Zsh0U4KyETaQamO
         SSGGCN8ddO/+bFLm+AvgeWrVm2zLPm9IxjV4IqYmMwV7KN2JNpvBM51OuGSOCQcyVGbw
         FT55LcgcJcAy3D9OghDyOCBvFluo/PIUbO0t1/kpsetKqfEvICgW1CjCBALicNzRi6yT
         jX41FaFXYpfl+h39MWIb9okRpa18t/fHfBh/aKH0jQLNII2ehCXeh7EYMLPHCTf9sBCH
         BtCw==
X-Gm-Message-State: AGi0PuYonCsv1Z5TyH2iHSjkuLShTJeMBylvvU0F4P1X9KwP3PWtMIi5
        gLI+ExCJAtg0iYFAqNaP/open+I=
X-Google-Smtp-Source: APiQypL/GqVNzc1ARP3aXiwV5USQErxQBjQFwCG0zoOAFaG/KPDhfyDYO/zDUkbfBwlmobhszpOflw==
X-Received: by 2002:a05:6830:459:: with SMTP id d25mr401641otc.189.1587581829306;
        Wed, 22 Apr 2020 11:57:09 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n17sm1745792otl.9.2020.04.22.11.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 11:57:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] dt-bindings: Fix command line length limit calling dt-mk-schema
Date:   Wed, 22 Apr 2020 13:57:08 -0500
Message-Id: <20200422185708.6363-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the number of schemas has increased, we're starting to hit the error
"execvp: /bin/sh: Argument list too long". This is due to passing all the
schema files on the command line to dt-mk-schema. It currently is only
with out of tree builds and is intermittent depending on the file path
lengths.

Commit 2ba06cd8565b ("kbuild: Always validate DT binding examples") made
hitting this proplem more likely since the example validation now always
gets the full list of schemas.

Fix this by passing the schema file list in a pipe and using xargs. We end
up doing the find twice, but the time is insignificant compared to the
dt-mk-schema time.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 87c76bdabfe6..7782d9985082 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -14,16 +14,18 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
 # Use full schemas when checking %.example.dts
 DT_TMP_SCHEMA := $(obj)/processed-schema-examples.yaml
 
+find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
+		-name 'processed-schema*' ! \
+		-name '*.example.dt.yaml' \)
+
 quiet_cmd_mk_schema = SCHEMA  $@
-      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
+      cmd_mk_schema = rm -f $@ ; \
+                      $(if $(DT_MK_SCHEMA_FLAGS), \
+                           echo $(real-prereqs), \
+                           $(find_cmd)) | \
+                      xargs $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) >> $@
 
-DT_DOCS = $(addprefix $(src)/, \
-	$(shell \
-	cd $(srctree)/$(src) && \
-	find * \( -name '*.yaml' ! \
-		-name 'processed-schema*' ! \
-		-name '*.example.dt.yaml' \) \
-	))
+DT_DOCS = $(shell $(find_cmd) | sed -e 's|^$(srctree)/||')
 
 DT_SCHEMA_FILES ?= $(DT_DOCS)
 
-- 
2.20.1

