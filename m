Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C06C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09DB20672
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595993110;
	bh=73C4hjWJ1i//PJgQIyTg0dr9hGkKSVuAU02bki5N6Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lXmTNq3n+v2Sl+gwycjX06Nwa3+AxoPAT5oeyROb6TuXGJMQejptoEGOe2pnwsB/M
	 rqBDhgwRBGh4Wet7RCQZ9Adl+lxGcnx2AH3MbUlIA3N1o3FbDbaVFFraEyOGfx6iPO
	 9CyZbmidkVAOG73W5MVjmvz0sUKiS5qWAXvYvHjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2DZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:25:09 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:25122 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgG2DZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:25:09 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 23:25:08 EDT
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-08.nifty.com with ESMTP id 06T3GJ8i030079;
        Wed, 29 Jul 2020 12:16:19 +0900
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 06T3Fi05000857;
        Wed, 29 Jul 2020 12:15:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 06T3Fi05000857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1595992545;
        bh=UempUcm31dYx4tjARW5o0hFSDrdGFkdiTyxqMOHP3V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Odfzr8aX6Tyca6O/rRqMtQdZXr3EPMx6pSPeCEFWrYfjx4IqQciybu5qqI2HAKXpU
         XD/H9wE4uMyumfoZHg3Kiqp6NYk8+L8TlgOBas5B16hl2OcQCyErBZzzUxthYOYjK+
         K9MShcztZiwH5AaBPBj/liQMI258Iw2yjIrm8hls7OKggRsiNHtN9X8bklPEP4on4n
         sR2rxT+x9pKH36vI40ZYxQeu7oTj8AhUlwOEvF5t9kgjNRwf3J6G3auVGSi4EJvUst
         R5kCNoaOimDjRSqZeGqQonGHcOnEo0f6R4cGzLhBTbXgSWwfjxW29bO/Tw4lVjLGrV
         YgP7U1UBgSlSg==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kbuild: sort hostprogs before passing it to ifneq
Date:   Wed, 29 Jul 2020 12:15:37 +0900
Message-Id: <20200729031537.37926-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729031537.37926-1-masahiroy@kernel.org>
References: <20200729031537.37926-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditional:

  ifneq ($(hostprogs),)

... is evaluated to true if $(hostprogs) does not contain any word but
whitespace characters.

  ifneq ($(strip $(hostprogs)),)

... is a safe way to avoid interpreting whitespace as a non-empty value,
but I'd rather want to use the side-effect of $(sort ...) to do the
equivalent.

$(sort ...) is used in scripts/Makefile.host in order to drop duplication
in $(hostprogs). It is also useful to strip excessive spaces.

Move $(sort ...) before evaluating the ifneq.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build |  5 ++++-
 scripts/Makefile.host  | 10 ++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d41c1cd453b9..e0b6b5db11c2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -45,12 +45,15 @@ include $(kbuild-file)
 
 include scripts/Makefile.lib
 
-# Do not include hostprogs rules unless needed
+# Do not include hostprogs rules unless needed.
+# $(sort ...) is used here to remove duplicated words and excessive spaces.
+hostprogs := $(sort $(hostprogs))
 ifneq ($(hostprogs),)
 include scripts/Makefile.host
 endif
 
 # Do not include userprogs rules unless needed.
+# $(sort ...) is used here to remove duplicated words and excessive spaces.
 userprogs := $(sort $(userprogs))
 ifneq ($(userprogs),)
 include scripts/Makefile.userprogs
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 687ca3f309e9..278b4d6ac945 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -38,24 +38,22 @@ $(obj)/%.tab.c $(obj)/%.tab.h: $(src)/%.y FORCE
 # Will compile qconf as a C++ program, and menu as a C program.
 # They are linked as C++ code to the executable qconf
 
-__hostprogs := $(sort $(hostprogs))
-
 # C code
 # Executables compiled from a single .c file
-host-csingle	:= $(foreach m,$(__hostprogs), \
+host-csingle	:= $(foreach m,$(hostprogs), \
 			$(if $($(m)-objs)$($(m)-cxxobjs),,$(m)))
 
 # C executables linked based on several .o files
-host-cmulti	:= $(foreach m,$(__hostprogs),\
+host-cmulti	:= $(foreach m,$(hostprogs),\
 		   $(if $($(m)-cxxobjs),,$(if $($(m)-objs),$(m))))
 
 # Object (.o) files compiled from .c files
-host-cobjs	:= $(sort $(foreach m,$(__hostprogs),$($(m)-objs)))
+host-cobjs	:= $(sort $(foreach m,$(hostprogs),$($(m)-objs)))
 
 # C++ code
 # C++ executables compiled from at least one .cc file
 # and zero or more .c files
-host-cxxmulti	:= $(foreach m,$(__hostprogs),$(if $($(m)-cxxobjs),$(m)))
+host-cxxmulti	:= $(foreach m,$(hostprogs),$(if $($(m)-cxxobjs),$(m)))
 
 # C++ Object (.o) files compiled from .cc files
 host-cxxobjs	:= $(sort $(foreach m,$(host-cxxmulti),$($(m)-cxxobjs)))
-- 
2.25.1

