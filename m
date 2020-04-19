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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEBCC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED19B21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCaGHhSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDSNVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:21:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:21:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f13so8611576wrm.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PoXpptiQvZNo1E5nzo28jyKXV1DD0hsQqmB0l8Idshk=;
        b=lCaGHhSawMAYCMT/A8HhE1E3b4/W32o3Apk3ZS+JH88wehgLrmwsSqWB/Rhzq8rW+z
         oakNod42/DC7/Pnf4bP/9LHa9IBbwHDd+drosTw5UVxO6cac3hl4h9T3JcCxdeNpxltM
         2B4Aso2DAlRfI6QoyObDSV/NhAuQpIOuMmtADIFPbjs8pUjai3ywuEkFlW4p/VbH1eti
         WHD4HSV87eJwrJu3gApXJDm/Q3W+3AT4MPkZSBMCprroYMjVVkTm3N2b1Ps8ZLa2kX1l
         WlJ3QSAOp2ldmi6+olPk5h6hqu2irSuoLu6+rQuwQCXKELzmW8hyG3NAIVqCNXH/F/4H
         Zuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PoXpptiQvZNo1E5nzo28jyKXV1DD0hsQqmB0l8Idshk=;
        b=QeYiG3nADxvE531glUjTBilPwNlhfENpsGcpD2JPWlq6ggCjkTWNiaGNkrckc/6Fop
         whOKsvTQf0rxImBA/PBt2KmgcXwbf8rsvktdxxjO53BbUWTUI4eWKpNLPE+K6u8ztcQR
         Hb/gcq2JvJrBb3zKD1g0iXMs59R1d6Ll8aq+X5L+gC4WWvfMk0ww9lJlE8SHTCNRPOL4
         rVU6GQAM3pbgkjaqDxDbdrxHBbTwh2tIs9+nY3z/hxvUGvC2yhkli608pFSXNkUSCknK
         Als694Q58eCpx6d3ZFITHoxTusHMF6G5T9HYwtqrpU0NCmdVfSGQsgWzBSrySuI/A7fz
         yJgg==
X-Gm-Message-State: AGi0Pub6e2EHxBco7BQKQDT3MawKZmhwsIHTDtXE+mZYvsG39gMcaHAs
        cVP99dmWRSmpOTEHf/swxEk=
X-Google-Smtp-Source: APiQypLo+SnHWzuzHnraxWsYZXTwTBc9Vya4hBaRUfr/K1B/G8PCCPfUkQNRMr0/L4KwPhwweYy8CA==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr14066983wru.203.1587302510950;
        Sun, 19 Apr 2020 06:21:50 -0700 (PDT)
Received: from localhost.localdomain (x59cc9bd1.dyn.telefonica.de. [89.204.155.209])
        by smtp.gmail.com with ESMTPSA id c1sm40401206wrc.4.2020.04.19.06.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:21:50 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@gmail.com>
Subject: [RFC PATCH 2/2] kbuild: Rename and use BINUTILS_VERSION where needed
Date:   Sun, 19 Apr 2020 15:21:42 +0200
Message-Id: <20200419132142.173861-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first patch I introduced LD_IS_BINUTILS Kconfig.

To be consistent in naming convention I renamed from LD_VERSION
to BINUTILS_VERSION.

So, we have the double "LD_IS_BINUTILS" and "BINUTILS_VERSION"
like "CC_IS_GCC" and "GCC_VERSION".

For the same reason I renamed the shell script to detect the GNU ld
linker version.

In Documentation/process/changes.rst we use "binutils" and GNU ld
binary is part of it (see [3]).

The patches "init/kconfig: Add LD_VERSION Kconfig" (see [1]) and
"arm64: Kconfig: ptrauth: Add binutils version check to fix mismatch"
(see [2]) added checks for binutils >=2.23.1 whereas binutils
version 2.23 is minimum supported version (see [3]).

I have renamed to BINUTILS_VERSION where needed.

[1] https://git.kernel.org/linus/9553d16fa671b9621c5e2847d08bd90d3be3349c
[2] https://git.kernel.org/linus/15cd0e675f3f76b4d21c313795fe0c23df0ee20f
[3] https://git.kernel.org/linus/Documentation/process/changes.rst#n79

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/arm64/Kconfig                             | 2 +-
 init/Kconfig                                   | 4 ++--
 scripts/{ld-version.sh => binutils-version.sh} | 0
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename scripts/{ld-version.sh => binutils-version.sh} (100%)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..274ba9b3ac95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1504,7 +1504,7 @@ config ARM64_PTR_AUTH
 	depends on (CC_HAS_SIGN_RETURN_ADDRESS || CC_HAS_BRANCH_PROT_PAC_RET) && AS_HAS_PAC
 	# GCC 9.1 and later inserts a .note.gnu.property section note for PAC
 	# which is only understood by binutils starting with version 2.33.1.
-	depends on !CC_IS_GCC || GCC_VERSION < 90100 || LD_VERSION >= 233010000
+	depends on !CC_IS_GCC || GCC_VERSION < 90100 || BINUTILS_VERSION >= 233010000
 	depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
 	help
diff --git a/init/Kconfig b/init/Kconfig
index 520116efea0f..946db4786951 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -19,9 +19,9 @@ config GCC_VERSION
 config LD_IS_BINUTILS
 	def_bool $(success,$(LD) -v | head -n 1 | grep -q 'GNU ld')
 
-config LD_VERSION
+config BINUTILS_VERSION
 	int
-	default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh) if LD_IS_BINUTILS
+	default $(shell,$(LD) --version | $(srctree)/scripts/binutils-version.sh) if LD_IS_BINUTILS
 
 config CC_IS_CLANG
 	def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
diff --git a/scripts/ld-version.sh b/scripts/binutils-version.sh
similarity index 100%
rename from scripts/ld-version.sh
rename to scripts/binutils-version.sh
-- 
2.26.1

