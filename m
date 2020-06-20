Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 00:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6200924766
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 00:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFUAXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 20:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgFUAXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 20:23:20 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5FC061795
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 17:23:20 -0700 (PDT)
Received: from mr5.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 05KIqele025348
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:52:40 -0400
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 05KIqZM1004291
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:52:40 -0400
Received: by mail-qv1-f69.google.com with SMTP id q5so9428823qvp.23
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=dwZeMkh+DsPbnyYGwceXjBXapy6lVxCTDStNpO5K+aU=;
        b=s4/6WPE+cE6MBlEcLzXX8260eUsMDqGnJCre5Gv3og8mc7d+HglTCWgId/XOcwtiOc
         8AQ1KwlPEJxMCJsRfUUr696xEflCJFuR3zqGZHZ0MDM175acTenuzjnjymN6uH00U01r
         bb96p9PCyuP0eb2diFYReGPbZxsdz1WrdBqsY4Ae/WdIM16TJoiVTWNRyVYcybScMdFv
         Ka+VrJJeE5/62DH8yDT+zwCQN0BQM1zXDghvGIIXyfFgEoI+OYGAwL2lanvhc8Bo4sCL
         rkRlEBYVVVer7JyTVOFOOzfTpYz/MDjdgU1Q+nJbAeBOXOVRMuhX0mD5hNHm3rQFY6yi
         KJOw==
X-Gm-Message-State: AOAM532vbbNaOTsNLbyhtan8EAisvLE2E+W3J3BJpX4d/rBiX0aN3hZM
        q7FzCMnOENrrUZk5JW2/iGRGjuop2UsJqcJpLkc73/FHvie5cJx4iOWHLR6GbOrf9Hvsy9J0KY8
        mdjjzJSG3xkRmoD11Ti5JDkFfeJq5PJ/I1i8=
X-Received: by 2002:a37:a643:: with SMTP id p64mr9171253qke.214.1592679155361;
        Sat, 20 Jun 2020 11:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB9rQ95PmDCQcidxxn3PnhtBZFxvAShjGrkrwrdZoJbwcRrWurmQO9gfDk1BE1lWP+aUJ4Wg==
X-Received: by 2002:a37:a643:: with SMTP id p64mr9171236qke.214.1592679155078;
        Sat, 20 Jun 2020 11:52:35 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id b53sm10601172qtc.65.2020.06.20.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:52:34 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: kbuild: separate kerneldoc warnings from compiler warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 20 Jun 2020 14:52:33 -0400
Message-ID: <591473.1592679153@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new build flag 'K=1' which controls whether kerneldoc
warnings should be issued, separating them from the compiler warnings that W=
controls.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/Makefile b/Makefile
index 29abe44ada91..b1c0f9484a66 100644
--- a/Makefile
+++ b/Makefile
@@ -1605,6 +1605,7 @@ PHONY += help
 	@echo  '                       (sparse by default)'
 	@echo  '  make C=2   [targets] Force check of all c source with $$CHECK'
 	@echo  '  make RECORDMCOUNT_WARN=1 [targets] Warn about ignored mcount sections'
+	@echo  '  make K=1   [targets] Warn about problems in kerneldoc comments'
 	@echo  '  make W=n   [targets] Enable extra build checks, n=1,2,3 where'
 	@echo  '		1: warnings which may be relevant and do not occur too often'
 	@echo  '		2: warnings which occur quite often but may still be relevant'
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2e8810b7e5ed..9bcb77f5a5f1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -100,7 +100,7 @@ else ifeq ($(KBUILD_CHECKSRC),2)
         cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 endif
 
-ifneq ($(KBUILD_EXTRA_WARN),)
+ifneq ($(KBUILD_KDOC_WARN),)
   cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
 endif
 
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 4aea7cf71d11..3fd5881c91b0 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -17,6 +17,12 @@ endif
 
 export KBUILD_EXTRA_WARN
 
+ifeq ("$(origin K)", "command line")
+  KBUILD_KDOC_WARN := $(K)
+endif
+
+export KBUILD_KDOC_WARN
+
 #
 # W=1 - warnings which may be relevant and do not occur too often
 #


