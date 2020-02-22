Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5BC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D378206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582398309;
	bh=GGfJRcDzhaMcrw2ayyBjy+cETpDI32AHpC28rYLDq+U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=b6Ka15KbUEr3BFwZMcAEqj4LS4nuSk+KVx7o0KG2zVZYobT09LFBEB7WJNVdVHslq
	 G+7yninc9TO2gkSO2MaJi9vYReOm6o8cGQHWURYTzMgPyRJxB2O1pg0pTXSbHenIdp
	 nruL0DCS12pZRaq5yFFCkavlafVJc/SSVELzYiQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBVTFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:05:08 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:23007 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgBVTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:04:55 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 01MJ4cZ3012807;
        Sun, 23 Feb 2020 04:04:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 01MJ4cZ3012807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582398279;
        bh=OAJy6pWrxR7lNpcqlMigyzZQUmooD1dwjoIE2utcEN8=;
        h=From:To:Cc:Subject:Date:From;
        b=fs8OZ1BpLTf9CvWG/+boO5Xwn0uv7awOShJbmu6/QPDxlfFug5xTxVenYrtEs15im
         Z/iIfq+RtfKavg5Ng97XjyMDv3APCdbaTgcBKPJW3EF9pf2ZVAlBNdeOZ3brvI724a
         q74/+opbx6TRgHCbtO5go/1E0JDtH56ZEPk/EcH4iQ7Lw/wtEy2RvX3Xj0x5dhH8zv
         DZamwd2FHJhk6Ylc9rRWCfnSOCN6OsZYxKoboUagaT9+nJ/QZgBvk/wJ7ScKr9hkq7
         XWv/ttvnN2MQG/Kh7Uo1xFFOKA2yqevSF87IAjfTSkAUvOb/pUo76gHb+4QOsbAgg1
         0uN4HhOlYyo3g==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kbuild: fix DT binding schema rule to detect command line changes
Date:   Sun, 23 Feb 2020 04:04:31 +0900
Message-Id: <20200222190435.11767-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This if_change_rule is not working; it cannot detect any command line
changes.

The reason is because cmd-check in scripts/Kbuild.include compares
$(cmd_$@) and $(cmd_$1), but cmd_dtc_dt_yaml does not exist here.

For if_change_rule to work properly, the stem part of cmd_* and rule_*
must match. Because this cmd_and_fixdep invokes cmd_dtc, this rule must
be named rule_dtc.

Fixes: 4f0e3a57d6eb ("kbuild: Add support for DT binding schema checks")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index bae62549e3d2..64b938c10039 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -302,13 +302,13 @@ DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.yaml
 quiet_cmd_dtb_check =	CHECK   $@
       cmd_dtb_check =	$(DT_CHECKER) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ ;
 
-define rule_dtc_dt_yaml
+define rule_dtc
 	$(call cmd_and_fixdep,dtc,yaml)
 	$(call cmd,dtb_check)
 endef
 
 $(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
-	$(call if_changed_rule,dtc_dt_yaml)
+	$(call if_changed_rule,dtc)
 
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
-- 
2.17.1

