Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9334C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 14:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3129206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592145872;
	bh=TgUCzye5s+XEY3cUuTnXm7QohfH0TQdeBnxjPjBZUOc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dxnyrsQIjHA6z01g262G6MiARViVi14vDqYWjpOmNkYf/MdxnyUOoRZFzGq4oo6yo
	 XrEGj41fdbIsgdJNvMS5Fx3eDEYtkln7CSqSwHp8QLNusMM94QpMaDF7IOj8RSRpxr
	 1gFS/bBwK46VntQ0vFp9is/XTR7v1m/Z57VXjFJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgFNOob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 10:44:31 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:54494 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNOoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 10:44:30 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05EEhjq0024323;
        Sun, 14 Jun 2020 23:43:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05EEhjq0024323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592145826;
        bh=WqbBHTeTcTELu7HZYZJkll6J0fXNCMEhU1vE64ROybI=;
        h=From:To:Cc:Subject:Date:From;
        b=xpYkCjJxeLziMPFOJzjg7ApXaz44bK6GCZaIVP+/fsukFsadvYzfqMxtnCFEsWFys
         pFjy6ZIRuYZPg+qkpJImx9ZBjxWwXhl3BSI4RCN34X+q2gP6T1/3COHiTwqS78RP31
         s6H74dB4O65n0onYptUtbGF8DdKw30Oq2a38bABEHmNIIzPGPD96hz3XvFnOKeNA6x
         cBsHyLIPrgI+mvxizRJjTyoEmByvfHbwWXmkW2/6CeZ2p4scBiZchfOItor8Y+kQIx
         ef/rkj2BqA1/KnuSQdGQrxj+K9B4IA1S9Z5aGk71RM1V+sGM4NxaXdok9tnusRP+1w
         2XCcv4LPFrwtQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: improve cc-option to clean up all temporary files
Date:   Sun, 14 Jun 2020 23:43:40 +0900
Message-Id: <20200614144341.1077495-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cc-option and friends evaluate compiler flags, the temporary file
$$TMP is created as an output object, and automatically cleaned up.
The actual file path of $$TMP is .<pid>.tmp, here <pid> is the process
ID of $(shell ....) invoked from cc-option. (Please note $$$$ is the
escape sequence of $$).

Such garbage files are cleaned up in most cases, but some compiler flags
create additional output files.

For example, -gsplit-dwarf creates a .dwo file.

When CONFIG_DEBUG_INFO_SPLIT=y, you will see a bunch of .<pid>.dwo files
left in the top of build directories. You may not notice them unless you
do 'ls -a', but the garbage files will increase every time you run 'make'.

This commit changes the temporary object path to .tmp_<pid>/tmp,
and removes .tmp_<pid> directory when exiting. The additional files
.tmp_<pid>/tmp.dwo, will be cleaned away altogether.

When the compiler creates separate build artifacts, their file paths
are usually determined based on the base name of the object. Another
example is -ftest-coverage, which outputs the coverage data into
<base-name-of-object>.gcno

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kbuild.include | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 0c3dc983439b..5dfd224599b7 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -86,20 +86,21 @@ cc-cross-prefix = $(firstword $(foreach c, $(1), \
 			$(if $(shell command -v -- $(c)gcc 2>/dev/null), $(c))))
 
 # output directory for tests below
-TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
+TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
 
 # try-run
 # Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
-# Exit code chooses option. "$$TMP" serves as a temporary file and is
+# Exit code chooses option. "$$TMP" serves as a temporary directory and is
 # automatically cleaned up.
 try-run = $(shell set -e;		\
-	TMP="$(TMPOUT).$$$$.tmp";	\
-	TMPO="$(TMPOUT).$$$$.o";	\
+	TMP=$(TMPOUT)/tmp;		\
+	TMPO=$(TMPOUT)/tmp.o;		\
+	mkdir -p $(TMPOUT);		\
+	trap "rm -rf $(TMPOUT)" EXIT;	\
 	if ($(1)) >/dev/null 2>&1;	\
 	then echo "$(2)";		\
 	else echo "$(3)";		\
-	fi;				\
-	rm -f "$$TMP" "$$TMPO")
+	fi)
 
 # as-option
 # Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
-- 
2.25.1

