Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA872C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DE9206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582324204;
	bh=ibCLBwPT8gIhIMNxlQ+Rw4LN6gQvgGYOcR9U3A7vhVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=grqfTGzEhgqEh1HD50z2bzP2vARgbtLVGbQtWfB5ZxmsHjTt3f2TfpwYjGO5ZX34z
	 Hn2OxDhKVFUID0TU8l9Sjot8xE2yUQd4uhqOk5rhCgL6lyxv+ec9Okr6dV0A9u2edg
	 bg+isXhMh5kND/Gn1VnUXASL+WFTZYLJPDfuJ+lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgBUW37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:29:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46279 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUW36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:29:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so3445502otb.13;
        Fri, 21 Feb 2020 14:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A41k8qGuAylginY0SporWSjfXqnF32l+cm+Xzqygr4o=;
        b=NqKfi2CYzhM3dH4i9fJU8lmkiYNAy3yXmqvlU44ldUgfq0zJPYqWHGoG2CYgSnKgpp
         0UM7R+gq4PcQacUZWK0TqXrOzQRKygVpWxwhM6BEo5dR1jrkGmANaA2XQd358m1cOvAH
         tUaw1TUmgskbZEOjmGlmorwFoV6b9p7K6XOIN2dxV+Y6DCxSBTqueGNCOZAMHqFA+KHb
         Tn338euNU8Wp/+QzkUHpCEXN8p5+z/BLyzq7F/wUQgKB5XLRSNuM5cFEMvDmNW5SgP6i
         ryDAQhepoyHMNoynVi6zkL2j8aNb3kXWZwIh0edSmP1OVAwR9/3CSVNqyqysSwwsA26S
         43nA==
X-Gm-Message-State: APjAAAWlMBSub+sMZqesvSAKipPdlqjhk1y8NaDQ3ITXoAOGHyulfEbL
        jdSAVy22gqJnx34irTl0HMGehKQ=
X-Google-Smtp-Source: APXvYqwTfAkFp49cWQY4c3XoyHAjnp8H0GTXgHt4p3Gegq2nHBfitu0oRBMkYatWsGMfde03b4FpLg==
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr30551721otp.339.1582324197639;
        Fri, 21 Feb 2020 14:29:57 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m19sm1515706otn.47.2020.02.21.14.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 14:29:57 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 2/2] kbuild: Build DT binding examples with dtc warnings enabled
Date:   Fri, 21 Feb 2020 16:29:55 -0600
Message-Id: <20200221222955.21038-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221222955.21038-1-robh@kernel.org>
References: <20200221222955.21038-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a separate rule for DT binding examples, we can customize
the dtc options. Let's adjust the dtc warnings to me more strict by
default so the examples get cleaned up as they get converted to schema.

Leaving 'avoid_unnecessary_addr_size' and 'graph_child_address' warnings
disabled as examples tend to be incomplete and they generates a lot of
warnings.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 78fa1a3d983a..1a149e680308 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -308,6 +308,10 @@ define rule_dtc_dt_yaml
 	$(call cmd,dtb_check,$(word 2, $(real-prereqs)))
 endef
 
+$(obj)/%.example.dt.yaml: DTC_FLAGS = \
+	-Wno-avoid_unnecessary_addr_size \
+	-Wno-graph_child_address
+
 $(obj)/%.example.dt.yaml: $(src)/%.example.dts $(DT_EXAMPLES_SCHEMA) $(DTC) FORCE
 	$(call if_changed_rule,dtc_dt_yaml)
 
-- 
2.20.1

