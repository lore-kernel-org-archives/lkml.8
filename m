Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6465AC55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B4F20724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587504012;
	bh=GzuSaIlPX4wd66jr87z9fuCN/lEu3HgRq4xSxbopIWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xCbWmT2OxNAY/cgg+1+UtGlQTGMRrLtON7kBxMGadKzcXkpnBTbZZ3W/uhqZW/5qo
	 LbXDUpEaFXyyXW0wpwx0Mj4oJ7xEsLm5FHC2ZvtqJ67Yx3gBftDPlX2yMxaCiPsS58
	 dy4fLI2JBtms3qQPlGwg/bKiLxwrt3O89KQfkRVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDUVUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:20:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39832 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgDUVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:20:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id m13so287646otf.6;
        Tue, 21 Apr 2020 14:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Whprd6tZ2Z3Ve7mfuOJp09utBtWbFV7OF9k2tpLKr2I=;
        b=TIVe4yakHJRg1UYLPJ0kXOOpthkq3sW8dOMh3GoEA9h8kC77h+4nMb1cMQr/KIy6En
         bav8aQfXLXAZMbdaTENlqBVCVNjnETM5YQMmKn35Wtp7k3Z4yRONcDD9nzIdiEC/Tbrg
         A9cgolijyUkUtn0mqJcaklUaZYgqBezjelfNn/R301aFK9BcM3jKWIkqXXry8hab5/TG
         lMwUmf/ZVfbbqeg0/vmrRQKfZHgBRt+lI7ce0OSJ8Dcs1F3bUgAyJ8qbQcxfBdDOxlxT
         srn3XxAwlsZ0cjctRTmvo1vg8ZFuGvLTnvODF7H0PQsRteqgWyRJmkKK8cLny1ys+c3w
         TraQ==
X-Gm-Message-State: AGi0PuaVMMBRh6wCw7bTNpLzByZOOc+Rg5ugua6pCUga50ma0NXjgzNr
        jW/Tp46NQ0AhwiV0sI9ZFt1g6Yc=
X-Google-Smtp-Source: APiQypLpsCeWU4XUjL0B8mZHZX5CA/U+tQ+3fyggCajo3mWxcqIePFw9Tse8L6JifWGxnhFCRDKcuw==
X-Received: by 2002:a9d:1d45:: with SMTP id m63mr14790276otm.271.1587504007552;
        Tue, 21 Apr 2020 14:20:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e15sm1040430otr.36.2020.04.21.14.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:20:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] dt-bindings: Re-enable core schemas for dtbs_check
Date:   Tue, 21 Apr 2020 16:20:04 -0500
Message-Id: <20200421212004.6146-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421212004.6146-1-robh@kernel.org>
References: <20200421212004.6146-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 2ba06cd8565b ("kbuild: Always validate DT binding examples"),
the core schemas (from dtschema repo) were inadvertently disabled for
dtbs_checks. Re-enable them.

Fixes: 2ba06cd8565b ("kbuild: Always validate DT binding examples")
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1c1cad860b7c..c66e8329a645 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -2,6 +2,7 @@
 DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
+DT_MK_SCHEMA_USERONLY_FLAG := $(if $(DT_SCHEMA_FILES), -u)
 
 quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
       cmd_chk_binding = $(DT_DOC_CHECKER) -u $(srctree)/$(src) $< ; \
@@ -38,7 +39,7 @@ override DTC_FLAGS := \
 $(obj)/processed-schema-examples.yaml: $(DT_DOCS) FORCE
 	$(call if_changed,mk_schema)
 
-$(obj)/processed-schema.yaml: DT_MK_SCHEMA_FLAGS := -u
+$(obj)/processed-schema.yaml: DT_MK_SCHEMA_FLAGS := $(DT_MK_SCHEMA_USERONLY_FLAG)
 $(obj)/processed-schema.yaml: $(DT_SCHEMA_FILES) FORCE
 	$(call if_changed,mk_schema)
 
-- 
2.20.1

