Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D45C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28336207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="mh0KQrRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHRHoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:44:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CB1C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:44:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so17254967wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5pN3eJiHp9vz3E+RH+ObRVo3XkJaWoyYYlg3RDmk3E=;
        b=mh0KQrRkKU4DzTcQ9iVzttgK9sKyMvaS3bdhIjI3pgd8eP3EzG7bsR8J5JDo9zObuv
         DF40sjl1OTWshqTj+b9zPsMSZXccIXav7sVjatOG3T49rw7D6wo108e3JuaIUJqTqUmZ
         m6Ej/GufkXQ2TP4cEIM2c3RG1s8WF6a67ez+xCUOhN51+GO0jEtVrXg2k6m1x4woPCBc
         jCwTz0rbfmqhT0tfOdqd42Db/5ZKY4TfVzWScxVNJtGxmNAoScFQRlHx4PrCZImFvWrZ
         jE1FHOyrNAbnEsnuwoIXr1ZRssM6nXd/zYSxLY1yNtBs/6HY0B3g07LH2i7N8utp+T/w
         L3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5pN3eJiHp9vz3E+RH+ObRVo3XkJaWoyYYlg3RDmk3E=;
        b=rloU1NH5cAKI9djO8BLOPe19Q00Oq44cGdrOovIIQaps9x5gmHb2sitwPZSwiEvvpA
         xm7pFp/TMRYRlAPVCxx9JcUbSgqLv7x+ucrEHDR3ql3UpdlNUManFgj8O7NOFGfBBPbX
         bav+Jzy7or/y6eh6nnG0Qaqhn2yrJnSR9jEHBC8PKB+lsuGhUGX/Dkqz09asOu8xltXZ
         Ec0obGjKLGbHGAYrAffNwHHIKDtxsk/14Hzxd7UDqQgmyGMaeS6UobzJK5xbBB3oo9VR
         nbj/9Hi/AmvdOpC8I21/huWEAGKer8V5mnAngg4/O6wOzN9FYfZJRZjlDoGAue3nYOpr
         AH6Q==
X-Gm-Message-State: AOAM532xmWXk8BKFah7kfoQh+qf3UD77tI75jjuL/PWLyRvR5p8NVljN
        0OmMP+2b7kwZ/0/0A81PLckd8rrLIXzWAvuC1qFspQ==
X-Google-Smtp-Source: ABdhPJxW0rIGzvrU6uulZCHt9oY0DvpPITzfVDekF48UCvzk1URfmTLotKQ4p7bNDTK5G2fH2E6foA==
X-Received: by 2002:a5d:414d:: with SMTP id c13mr13675181wrq.78.1597736651139;
        Tue, 18 Aug 2020 00:44:11 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:3cb:7bb0:8875:d92:eae5:ceb5])
        by smtp.gmail.com with ESMTPSA id j11sm32910182wrw.79.2020.08.18.00.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 00:44:10 -0700 (PDT)
From:   Jerome Forissier <jerome@forissier.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>
Subject: [PATCH v3] checkpatch: add --kconfig-prefix
Date:   Tue, 18 Aug 2020 09:43:49 +0200
Message-Id: <20200818074349.726778-1-jerome@forissier.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817095056.31001-1-jerome@forissier.org>
References: <20200817095056.31001-1-jerome@forissier.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
environment variable. Out-of-tree projects may therefore use Kconfig
with a different prefix, or they may use a custom configuration tool
which does not use the CONFIG_ prefix at all. Such projects may still
want to adhere to the Linux kernel coding style and run checkpatch.pl.

One example is OP-TEE [1] which does not use Kconfig but does have
configuration options prefixed with CFG_. It also mostly follows the
kernel coding style and therefore being able to use checkpatch is quite
valuable.

To make this possible, add the --kconfig-prefix command line option.

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 scripts/checkpatch.pl | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

v3:
- Use ${CONFIG_} instead of $CONFIG_.
- Expand the commit message to mention OP-TEE.

v2:
- Use a command-line/.checkpatch.conf option instead of the _CONFIG
  environment variable.
- Changed the patch subject (was: "checkpatch: get CONFIG_ prefix from
  the environment").

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2cbeae6d9aee..fd65f8c774ed 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -65,6 +65,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
 # git output parsing needs US English output, so first set backtick child process LANGUAGE
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
+my ${CONFIG_} = "CONFIG_";
 
 sub help {
 	my ($exitcode) = @_;
@@ -127,6 +128,8 @@ Options:
   --typedefsfile             Read additional types from this file
   --color[=WHEN]             Use colors 'always', 'never', or only when output
                              is a terminal ('auto'). Default is 'auto'.
+  --kconfig-prefix=WORD      use WORD as a prefix for Kconfig symbols (default
+                             ${CONFIG_})
   -h, --help, --version      display this help and exit
 
 When FILE is - read standard input.
@@ -235,6 +238,7 @@ GetOptions(
 	'color=s'	=> \$color,
 	'no-color'	=> \$color,	#keep old behaviors of -nocolor
 	'nocolor'	=> \$color,	#keep old behaviors of -nocolor
+	'kconfig-prefix=s'	=> \${CONFIG_},
 	'h|help'	=> \$help,
 	'version'	=> \$help
 ) or help(1);
@@ -6528,16 +6532,16 @@ sub process {
 		}
 
 # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
-		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^CONFIG_/) {
+		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^${CONFIG_}/) {
 			WARN("IS_ENABLED_CONFIG",
-			     "IS_ENABLED($1) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
+			     "IS_ENABLED($1) is normally used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
 		}
 
 # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
-		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
+		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(${CONFIG_}[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
 			my $config = $1;
 			if (WARN("PREFER_IS_ENABLED",
-				 "Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE\n" . $herecurr) &&
+				 "Prefer IS_ENABLED(<FOO>) to ${CONFIG_}<FOO> || ${CONFIG_}<FOO>_MODULE\n" . $herecurr) &&
 			    $fix) {
 				$fixed[$fixlinenr] = "\+#if IS_ENABLED($config)";
 			}
-- 
2.25.1

