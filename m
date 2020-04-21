Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32240C55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126A020724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587504009;
	bh=pFS2yzzer8QmZtAyTrONwxocmpCDAdckbuwvMAT2QwY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ow6010gO6s18eP6Jyt+YqiPXrMbMH6C85cobb/7IcOefKHz2TMzF4FAp6lJZFUDaE
	 nLIGanmMCap8zBWhgzgHva2n9P8Nao5o910zi+5wkfzziKUbp1TThymatoJZaK9I2x
	 QfFSqjoG3hvlUcV/XYyUNLvxzeI4BeAo1tEvE5UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDUVUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:20:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35414 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDUVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:20:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id o7so61858oif.2;
        Tue, 21 Apr 2020 14:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BekGHQXhf3Jp2g2yBPT6sfHMkawHAJ1e7QouDFB2tgI=;
        b=uORWPMJTrzsmtUNiX1N/VOoxwKCVrXlP4MTNtaFPGv309mGsPIHlc4Z3c6VrfAjIpJ
         Q6evG9c967S70aeaDKxMDJGuKFGOTUVUeiDvdaD2VhjP4Rbrs+YURYjMtCleW8J/VG7k
         opMDpUle4xogIp5wd6HJaPuZqaQZS+38LFrenBHbhX4obJSNj8pMK5Pt5tnP8tpYJW0q
         8B5Wunw6vagFUuUH+nX3Goq910Ej6PIr5eQRGaYQ+8aMIItQt4KKqhcRSN4D+C7WnxHR
         hB/bKPWKQTbgT8jkJlM+gztmMqticXkErCKnNRVHqQNLAy95RcGsqagznOBt5VbxfWhY
         ckCg==
X-Gm-Message-State: AGi0PuYk8rGjxbYLIKymoM+NOZtRanHxK9s7+MKNHkfg7oPtwM4HY3vE
        VPRir182R69ACZt2ewDzt+Ph5OU=
X-Google-Smtp-Source: APiQypJrtH80baDZtKRTOT0kMElY1jA2cRjLb3VeIJ1NvV5x+EnvfLhDMQL6YiHEORNm+arCo/wTiA==
X-Received: by 2002:aca:4d47:: with SMTP id a68mr4743679oib.60.1587504006390;
        Tue, 21 Apr 2020 14:20:06 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e15sm1040430otr.36.2020.04.21.14.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:20:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] dt-bindings: Fix command line length limit calling dt-mk-schema
Date:   Tue, 21 Apr 2020 16:20:03 -0500
Message-Id: <20200421212004.6146-1-robh@kernel.org>
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

Fix this by putting the schema file list into a temp file and using xargs.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/.gitignore | 2 +-
 Documentation/devicetree/bindings/Makefile   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
index 5c6d8ea1a09c..0a6aef915fa4 100644
--- a/Documentation/devicetree/bindings/.gitignore
+++ b/Documentation/devicetree/bindings/.gitignore
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 *.example.dts
-processed-schema*.yaml
+processed-schema*.yaml*
diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1df680d07461..1c1cad860b7c 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -14,7 +14,8 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
 DT_TMP_SCHEMA := $(obj)/processed-schema-examples.yaml
 
 quiet_cmd_mk_schema = SCHEMA  $@
-      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
+      cmd_mk_schema = $(file >$@.tmp, $(real-prereqs)) \
+                      cat $@.tmp | xargs $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@
 
 DT_DOCS = $(addprefix $(src)/, \
 	$(shell \
-- 
2.20.1

