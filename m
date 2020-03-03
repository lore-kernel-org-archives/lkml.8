Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D384FC3F2D9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F6B20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583259111;
	bh=rqivXkV16iF43yCkpdhW87I7b55J5RVrhFZwHWy1Fyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PNHcrynvIHOHQULkJN5hkgLdLTTfZRYXj34SJvpW7gdKpFW1iJFHYAYtEmXSEnu95
	 JOBzhs/XFm7eQbM/WjWRkqO5FkUap4lYz+0UVh4ytYZFVMA7VsPHc5upjCD9ve3DWm
	 nVMrESbtc8Bu2AiEhYHBGwWWLvcSkcFuI8kBcBkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgCCSLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbgCCRt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:49:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2E320870;
        Tue,  3 Mar 2020 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257765;
        bh=rqivXkV16iF43yCkpdhW87I7b55J5RVrhFZwHWy1Fyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vr7FAr7yjp7v6uyVqsq7oLWiSvf4eqxa9UDjn/ie2UPt2u7unuvQNsWbl9ISU0lqB
         rUx+zvcemIipQcP5IMk5ESsqEu9aKKUScV5iRln1CqGPErFIixAHQqzfbgTcQFsF3B
         A4I5tRyrVpYuXWHBYyNkuFz+0bI4fGwV+OTrF3HI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.5 120/176] kbuild: fix DT binding schema rule to detect command line changes
Date:   Tue,  3 Mar 2020 18:43:04 +0100
Message-Id: <20200303174318.683392252@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

commit 7a04960560640ac5b0b89461f7757322b57d0c7a upstream.

This if_change_rule is not working properly; it cannot detect any
command line change.

The reason is because cmd-check in scripts/Kbuild.include compares
$(cmd_$@) and $(cmd_$1), but cmd_dtc_dt_yaml does not exist here.

For if_change_rule to work properly, the stem part of cmd_* and rule_*
must match. Because this cmd_and_fixdep invokes cmd_dtc, this rule must
be named rule_dtc.

Fixes: 4f0e3a57d6eb ("kbuild: Add support for DT binding schema checks")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Makefile.lib |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -291,13 +291,13 @@ DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING
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
 


