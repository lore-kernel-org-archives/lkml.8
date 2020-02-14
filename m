Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C709BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10EE24670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701169;
	bh=O0EmmN79xtYNYNAQcnXgYG80Tt6C1Uos6QaRz7lY4HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pLJpZDWbR2DrI9kvdkZdv/gNJ45cTuWKSvQGJ490TwM9gHNkxP983mnm/zBTVDr8f
	 j6bs6OJMJH+/2FOapE2yIcyy98Pap2MuDO9Kn/sL9Csiwc1XU5R6au3SB9OiXSyjZ9
	 v5qfmUqqJTzsbk3sqWRdUcp4lNfbP0p00diuKAcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392165AbgBNR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390632AbgBNQIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B7922314;
        Fri, 14 Feb 2020 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696518;
        bh=O0EmmN79xtYNYNAQcnXgYG80Tt6C1Uos6QaRz7lY4HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+Iwc8BySkWRWp4JoUYrZ/lIaq3/rIlt9Qqpf+CNl90q6CJO9O21VPJxLVpJ/B43P
         V60moIHFg1ZFlgTZXxs2Sho+9kV9RNYwO5AZLjuvluI0DzUX7afkxXlmKKnBhmbCF+
         FEONKXnyYjgAaPRNq36YsceVytEyogXxJKHZf48c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 319/459] kbuild: remove *.tmp file when filechk fails
Date:   Fri, 14 Feb 2020 10:59:29 -0500
Message-Id: <20200214160149.11681-319-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 88fe89a47153facd8cb2d06d5c8727f7224c43c2 ]

Bartosz Golaszewski reports that when "make {menu,n,g,x}config" fails
due to missing packages, a temporary file is left over, which is not
ignored by git.

For example, if GTK+ is not installed:

  $ make gconfig
  *
  * Unable to find the GTK+ installation. Please make sure that
  * the GTK+ 2.0 development package is correctly installed.
  * You need gtk+-2.0 gmodule-2.0 libglade-2.0
  *
  scripts/kconfig/Makefile:208: recipe for target 'scripts/kconfig/gconf-cfg' failed
  make[1]: *** [scripts/kconfig/gconf-cfg] Error 1
  Makefile:567: recipe for target 'gconfig' failed
  make: *** [gconfig] Error 2
  $ git status
  HEAD detached at v5.4
  Untracked files:
    (use "git add <file>..." to include in what will be committed)

          scripts/kconfig/gconf-cfg.tmp

  nothing added to commit but untracked files present (use "git add" to track)

This is because the check scripts are run with filechk, which misses
to clean up the temporary file on failure.

When the line

  { $(filechk_$(1)); } > $@.tmp;

... fails, it exits immediately due to the 'set -e'. Use trap to make
sure to delete the temporary file on exit.

For extra safety, I replaced $@.tmp with $(dot-target).tmp to make it
a hidden file.

Reported-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Kbuild.include | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 10ba926ae2924..d1dd4a6b6adb6 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -55,14 +55,13 @@ kecho := $($(quiet)kecho)
 # - stdin is piped in from the first prerequisite ($<) so one has
 #   to specify a valid file as first prerequisite (often the kbuild file)
 define filechk
-	$(Q)set -e;				\
-	mkdir -p $(dir $@);			\
-	{ $(filechk_$(1)); } > $@.tmp;		\
-	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
-		rm -f $@.tmp;			\
-	else					\
-		$(kecho) '  UPD     $@';	\
-		mv -f $@.tmp $@;		\
+	$(Q)set -e;						\
+	mkdir -p $(dir $@);					\
+	trap "rm -f $(dot-target).tmp" EXIT;			\
+	{ $(filechk_$(1)); } > $(dot-target).tmp;		\
+	if [ ! -r $@ ] || ! cmp -s $@ $(dot-target).tmp; then	\
+		$(kecho) '  UPD     $@';			\
+		mv -f $(dot-target).tmp $@;			\
 	fi
 endef
 
-- 
2.20.1

