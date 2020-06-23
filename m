Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B2CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2192D20781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933844;
	bh=4d8E+xxY6HjJP5yT1ceEnqlab49ZVk3WLYdMr1sR3qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMA3LmrkRSJtBHdE8OYLD7YJyRQyCB+vqWA3Wq8mU/Qsrr+D5fnpeujwVjeU/WY9F
	 c93DomnTWWD1QhgphLEtcGcF5FANVv31P2BJEbdHDIJkgByG5c5JbBtXB9KnQzbBkI
	 ZnFcgvZpqCPws9VBLSEt+IU+7e5d0VGJ9gVBkx64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgFWRhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387751AbgFWRhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:37:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F8920781;
        Tue, 23 Jun 2020 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933829;
        bh=4d8E+xxY6HjJP5yT1ceEnqlab49ZVk3WLYdMr1sR3qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHKGn/nlF6xLfbftxAxfsxGz4ZrCuiH0Pb8Vr11BOh6IqVi5hIlzSYZhiES2Qq4GT
         yjUg9ONj6Jzg/VIFMGlNLqpTiYHKuJitbWOkJWWJh7dSS8NgA0Dj62Pjb0W0s3laDG
         c/qgn7kOsihGzU8hcV+NM2h/lY8KZVaySL7Gd0Sg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/3] kbuild: improve cc-option to clean up all temporary files
Date:   Tue, 23 Jun 2020 13:37:05 -0400
Message-Id: <20200623173706.1356340-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173706.1356340-1-sashal@kernel.org>
References: <20200623173706.1356340-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit f2f02ebd8f3833626642688b2d2c6a7b3c141fa9 ]

When cc-option and friends evaluate compiler flags, the temporary file
$$TMP is created as an output object, and automatically cleaned up.
The actual file path of $$TMP is .<pid>.tmp, here <pid> is the process
ID of $(shell ...) invoked from cc-option. (Please note $$$$ is the
escape sequence of $$).

Such garbage files are cleaned up in most cases, but some compiler flags
create additional output files.

For example, -gsplit-dwarf creates a .dwo file.

When CONFIG_DEBUG_INFO_SPLIT=y, you will see a bunch of .<pid>.dwo files
left in the top of build directories. You may not notice them unless you
do 'ls -a', but the garbage files will increase every time you run 'make'.

This commit changes the temporary object path to .tmp_<pid>/tmp, and
removes .tmp_<pid> directory when exiting. Separate build artifacts such
as *.dwo will be cleaned up all together because their file paths are
usually determined based on the base name of the object.

Another example is -ftest-coverage, which outputs the coverage data into
<base-name-of-object>.gcno

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Kbuild.include | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index e61a5c29b08c5..b6f055157b89a 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -81,20 +81,21 @@ cc-cross-prefix =  \
 		fi)))
 
 # output directory for tests below
-TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
+TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
 
 # try-run
 # Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
 # Exit code chooses option. "$$TMP" is can be used as temporary file and
 # is automatically cleaned up.
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

