Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA31C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DB221744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+gLArrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:19:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08412C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:19:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so7435074wrw.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/M/pO+rkWb7qCpPBJ9AKwpLrf9Cx4SmKeiQUlOV4LEQ=;
        b=s+gLArrWtrhAjBDErGD/VpINDZzqnf/yyXHodON4rsDLNaeKvMEMdjtL6cDSOFI0rG
         HuV7HJdp9SeDHMt/r+7cMRI0siDrUYS5tUNKuShaTAbs2hI96PdyAKDsDm9pWQQPfNco
         Imm8IlccU1py5kh+nduW8yMm/9AwCNtpZLmO/kUWvFEIcl2dEwFGsi1vmXMDCX+GbaI5
         G41cflVb/dYAu9CY/05JJl2hW7nX1PX5fQnolraQTMSWnpLougaSvMg6vx2xYTLS80f+
         YnEfYLnIdP4X9hhAwH3xFOR6HVsEZZP1J0HhoJbKHZR/eDpALcsGJVyQnMxXAKNOEtM4
         mf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/M/pO+rkWb7qCpPBJ9AKwpLrf9Cx4SmKeiQUlOV4LEQ=;
        b=rinWpbJu7fAL5Eq9L3t/ExEEGFVrMEEUyw4Bk1Z2b2swvbPGLBkaYyPl8wPbAQw4q1
         aOTbdKyGvxAQlKLlf7zqFomuFg7KKKkdN6MhaQfKeADeP1/H7H4P7U9naTD7v3pEvyD9
         YZ7QUzvlI2EZp3LkgDAXSgt2U/hv4Oj7g4JvLndF9yiTAvdwbNOElKyeP3N7I3DlJzNE
         lmlKiRonoHyha9QCRbbfwS476yLldcVsFTQj1V+P7wqpA9txp92w8ZoQ7qK5HLhFhKT1
         CLJPRbAd2DFeSkZkInqHC52eGnCbycE/KQY6g3ZafT5ngJNvsPlEKRUsvD4cgL95/de8
         Nqpw==
X-Gm-Message-State: AGi0PuZ3bK0X37wTNy7as+V1P74MCai8du4N9FVhSMRqZftaYrZwnM4c
        qd/ur6vxwWkMWfjdWpeHuEg=
X-Google-Smtp-Source: APiQypKaDW7zQSv65IfgrnXEo9ciMGjZlLr2mJIy+QtQixAV4Z/zzumxvogS3iHEIokufTcozSSDLA==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr11602814wra.85.1587302395769;
        Sun, 19 Apr 2020 06:19:55 -0700 (PDT)
Received: from localhost.localdomain (x59cc9bd1.dyn.telefonica.de. [89.204.155.209])
        by smtp.gmail.com with ESMTPSA id k184sm15681118wmf.9.2020.04.19.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:19:55 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Sedat Dilek <sedat.dilek@gmail.com>
Subject: [RFC PATCH 1/2] kbuild: add CONFIG_LD_IS_BINUTILS
Date:   Sun, 19 Apr 2020 15:19:47 +0200
Message-Id: <20200419131947.173685-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is currently not mandatory but a prerequisites for the second one.

Folks from ClangBuiltLinux project like the combination of Clang compiler
and LLD linker from LLVM project to build their Linux kernels.

Sami Tolvanen <samitolvanen@google.com> has a patch for using LD_IS_LLD (see [1]).

Documentation/process/changes.rst says and uses "binutils" that's why I called
it LD_IS_BINUTILS (see [2] and [3]).

The second patch will rename existing LD_VERSION to BINUTILS_VERSION to have
a consistent naming convention like:

1. CC_IS_GCC and GCC_VERSION
2. CC_IS_CLANG and CLANG_VERSION
3. LD_IS_BINUTILS and BINUTILS_VERSION

[1] https://github.com/samitolvanen/linux/commit/61889e01f0ed4f07a9d631f163bba6c6637bfa46
[2] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n34
[3] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n76

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 init/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..520116efea0f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -16,9 +16,12 @@ config GCC_VERSION
 	default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
 	default 0
 
+config LD_IS_BINUTILS
+	def_bool $(success,$(LD) -v | head -n 1 | grep -q 'GNU ld')
+
 config LD_VERSION
 	int
-	default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh)
+	default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh) if LD_IS_BINUTILS
 
 config CC_IS_CLANG
 	def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
-- 
2.26.1

