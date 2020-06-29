Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871BD204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456971;
	bh=4d8E+xxY6HjJP5yT1ceEnqlab49ZVk3WLYdMr1sR3qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNMSg5q0AfQyGgEPN3w4G+kjlHcRcGRPwQrNNwU8QUoV55Z6TPLW0KkNMkcVQ5ZW3
	 rCPwYN0Dj//CyICjDy2T9iEOLuhWM1yrgm3ZojmZB6BmaVllEjICwKAJF9b17CmBkR
	 ON4NEqQ8y//7jnxhHmmQZvtXBmtU3CNgfSPbSuM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgF2S4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729972AbgF2SzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BEB25564;
        Mon, 29 Jun 2020 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446127;
        bh=4d8E+xxY6HjJP5yT1ceEnqlab49ZVk3WLYdMr1sR3qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEBWlRO/YV5IrZmllkovqNrcQMLRqPzwHO4OQo4Yu4sT6yWpxK7t68NNbZaqYavJi
         QKw+2SiNrTYx4kkhnIhnbrsAKIX7mpblW/r0nA9QGhIWwOjUI+VgP/wV7OtMS+zxvJ
         L/MIl4S/GbBNTgWk3WsrzLW5ibljMAiLk0WFTTtU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 118/135] kbuild: improve cc-option to clean up all temporary files
Date:   Mon, 29 Jun 2020 11:52:52 -0400
Message-Id: <20200629155309.2495516-119-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
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

