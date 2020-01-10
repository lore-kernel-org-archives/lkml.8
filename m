Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34F2C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 05:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FE420678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 05:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578632574;
	bh=+jjmac1V9FdX+jcDJLTS9cwaq7WDOSaNjjX6s05KjDs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HphQlk0yOha+pFlsx1IAncmNU4X/adDD2+dx/y32hGbz5EyyVPEQMs2KzLnZGt2Dp
	 ofJiaPRkoerY6JX9QJB3Ps8Lb67PzOwEOYDlsPjZlh1CjTaD7j8iGiidUAHvywPsiV
	 JPMoGMcvPv8Cq+ICEbkADJsiHX0hgStWhtZCWZIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgAJFCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 00:02:53 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:23170 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgAJFCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 00:02:53 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 00A52T4x008935;
        Fri, 10 Jan 2020 14:02:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 00A52T4x008935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578632550;
        bh=0/cY8IsswU5niZbLqmUKfFA8G6a7ndo5JrsR3tH+n64=;
        h=From:To:Cc:Subject:Date:From;
        b=XZU4uwLv6i3L64c695M6jpmZ+tHOACfvVO45aoT1HUv8+yyUIO9PNyaZEgGRwrYXo
         xido2cjER3/JPgjK/ifBtXw7UBs1kHT6qtkXoLd7Ovfjr7kwmu2XVrHg7sUNwSk2Sx
         M1gTbZwcyD9AXlPJ1MF6UUEbIuPW+n8JjDKeecGa2euEQNyIn5YrPdgu/2WAE9Y5tK
         bM68BIi9OnzNuyfPoi0O0Xy0hR86YfFjqlCkqgM8no1p3E/7d6kG27Yd7XZgKNlXZj
         BNBnCV3lCbW9TMD/YhA2f8by3gfioPApgk7YFrddsmbQ1uixUv1BIt88hxeMWFAk0D
         Lyq+acKPK5q4A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove .tmp file when filechk fails
Date:   Fri, 10 Jan 2020 14:02:24 +0900
Message-Id: <20200110050224.1004-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

 scripts/Kbuild.include | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 3da8321efb74..6cabf20ce66a 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -59,14 +59,13 @@ kecho := $($(quiet)kecho)
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
2.17.1

