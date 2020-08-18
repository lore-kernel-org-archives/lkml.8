Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB97C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759C72076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="NJtnJvq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHRIR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRIRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:17:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7927C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:17:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so16118805wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBMoIX0wDDizUWSV+BZ1wgLVBF7AgO627hD9co2j+K8=;
        b=NJtnJvq8/z39J3VudGdLJM9ahaPuoBAe+pfv0cKRVhvmDXVHYUltRJIo7XM4Ah9840
         DtLg1LCLQvEbnPj/jWaWBt8qz2p2MJotiIvPYVomKfINHV+kPCwp4kd4+Ik53tEuTdYH
         kHFxGZdhnVHdY/09JbZJAroYaOZBHuj1DkxYcUU4uf9Ftc0P9mJahqnRA9J8fdKAOB3t
         El+4HagOL3BVbHSFUnNi/Zi7+Z+p3RW2qEo/Z77VUp0VPhQNMRts3l/Y345A7iWshHKi
         GQaPCD4so2tpkUGwyzYLx4HZHP8EYNrPG9zP/tIkR9FePIMJbYO4PRMpdHsEr3s6kofA
         PefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBMoIX0wDDizUWSV+BZ1wgLVBF7AgO627hD9co2j+K8=;
        b=VMcgj9KR1fViFE2bSUPBuoGUS+3X+O8ay9ykYZpt5YOJzDx5z9U7ulVC87ZX3W1OOq
         TFw7Uu8XK4CQFDuPNRtddUpYDv+t+796blLDnNDUkRwUa4rNdKMMpe3AQ4OGV9wnR1wI
         +vA7mL84NMehumpw5vXGJj+laI0Zg6Sc47oa5wXB4ZQx/QLaMniLNwZRFT9/ysImPSY6
         JZT592+gUDuzZ00XxQ+o/mRtFHKNOvtoOTNXDWJoiDYRuu8VRAD8IbDopO+TRvTCf+d1
         B9ou05582Hf3b0ZepLz7jsUGTzzIQBJoDx6OXB1wKz2AZ/DPdRrY+1NpgpH/Nw4fKg0q
         BeMg==
X-Gm-Message-State: AOAM530gvMS0l3zxdNaESEEDlIIi7s7rGr9k+0vooIvu+M2Vp6ZDB79F
        JkwfOeQ0kRYG80IDp24tULeQig==
X-Google-Smtp-Source: ABdhPJxKJF28yU1uBpaF8TUfJ1tQZb/oMyzY8aoLJb7QvVPtrVuksCGg16xpYitkYxzRd9SkGVY6tg==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr18310189wmc.188.1597738673337;
        Tue, 18 Aug 2020 01:17:53 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:3cb:7bb0:8875:d92:eae5:ceb5])
        by smtp.gmail.com with ESMTPSA id h5sm37443151wrc.97.2020.08.18.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 01:17:52 -0700 (PDT)
From:   Jerome Forissier <jerome@forissier.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>
Subject: [PATCH v4] checkpatch: add --kconfig-prefix
Date:   Tue, 18 Aug 2020 10:17:32 +0200
Message-Id: <20200818081732.800449-1-jerome@forissier.org>
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

[1] https://github.com/OP-TEE/optee_os

Signed-off-by: Jerome Forissier <jerome@forissier.org>
Acked-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

v4:
- Add missing link
- Apply Joe's Acked-by: tag

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

