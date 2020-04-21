Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB567C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8FB2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="KxYeTqdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgDURj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDURj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:39:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF178C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:39:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so7106870pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=fLBHNTyEET/yN5Pbpw/2Hy4qmejsajrMOOJIyx+I7vQ=;
        b=KxYeTqdE2Xi/vsj4nfFw22Mcod7tNepgLgc7ivj4J1gSCt6gZxeOxbavGFtnIwhVrF
         cyCfz+vVg56J/H2lfYv4JDibjvABfMelTSj26Lt4JBQQzGDEmRatxGsJWjIIU3YsUBo/
         IixeXzxsautP+LS5WbTP55rRehic1N2mklNfHQWqf4+57SoXzSYkWqnxqGCo3VgIqvUF
         /ZjEFTlmUKmb93uKsH0LwJodvDRfDhFnc3IOD3VdrJ5fBY6u0B2jV9TGyO/2hRWGzRGe
         6gZo4RJS2IPaLpr3f6baakWQgFNSfjtwToSPI+sf6lCDbb9xX89jrUVzdJUOp+xFQxt3
         RcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=fLBHNTyEET/yN5Pbpw/2Hy4qmejsajrMOOJIyx+I7vQ=;
        b=Es1h+3VXnaBte6mDRHZ0ZUEBfrh0bBunBMvOrtsd2R95e/9a8bFt/AEU5mD8EkwsXD
         GyJZPQ5J4o8Iwiu1QXXZPV6h7M3sgxTcNUQ3aLwTMKrj7wJ+8uTqMEFB8hxWSc8/ULtI
         6y0h4Np4hcjw58jNqGXKsXFLV8vziWkOhS//EVIgMQxm+CrCNeFFOQAa3gJ1gSGrcGSP
         /YtpJlGzzVrj/hFKU1X2Sts8VvVSwY1HCmbOoiqAmuLFXY6ru5tnkmXxlhPhNPcB7hf+
         8u5dpvgIOtG9K4hQqi9FQj5UMCgroKb88AJt+5nayn3b0JglvF1QogX5CV+fCsqVp7QQ
         LPdg==
X-Gm-Message-State: AGi0PuZw1WDmu1fAccBRX9+BOqwcDNLaWNJdh6XywYYxv1wL6cnX5+ZB
        Kd8MT1wi6c8UffAWB3UPXR0wLRKVQQIkaA==
X-Google-Smtp-Source: APiQypKywrO7hvKPoqgv4/W+BCQ475nPawaOscHavB+UF8mMal6F4MZ01I4kbOku83ik8xRZ5a2M0w==
X-Received: by 2002:a62:6807:: with SMTP id d7mr6229124pfc.296.1587490767094;
        Tue, 21 Apr 2020 10:39:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f99sm3213045pjg.22.2020.04.21.10.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 10:39:26 -0700 (PDT)
Subject: [PATCH] checkpatch: Allow users to specify the python command to use
Date:   Tue, 21 Apr 2020 10:36:05 -0700
Message-Id: <20200421173604.38979-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

checkpatch.pl invokes spdxcheck.py using "python".  On my system that's
Python 2, but I only have a git package for Python 3.  This patch adds a
"--python=..." argument to checkpatch.pl that allows users to specify a
command to invoke Python.  I've just given this a little smoke test:
running it without any arguments still works, and running with
--python=python3 finds the git module.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

---
I'd considered reading some sort of environment variable, but searching
for "getenv" in checkpatch.pl didn't reveal any other enviornment
variables so I figured it'd be cleaner to avoid adding one.  I only
invoke checkpatch.pl from wrapper scripts anyway, so it's the same for
me.
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d64c67b67e3c..05ce52a2aaa9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -65,6 +65,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
 # git output parsing needs US English output, so first set backtick child process LANGUAGE
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
+my $python = "python";
 
 sub help {
 	my ($exitcode) = @_;
@@ -125,6 +126,7 @@ Options:
   --typedefsfile             Read additional types from this file
   --color[=WHEN]             Use colors 'always', 'never', or only when output
                              is a terminal ('auto'). Default is 'auto'.
+  --python=COMMAND           Use the give command to invoke python.
   -h, --help, --version      display this help and exit
 
 When FILE is - read standard input.
@@ -233,6 +235,7 @@ GetOptions(
 	'color=s'	=> \$color,
 	'no-color'	=> \$color,	#keep old behaviors of -nocolor
 	'nocolor'	=> \$color,	#keep old behaviors of -nocolor
+	'python=s'      => \$python,
 	'h|help'	=> \$help,
 	'version'	=> \$help
 ) or help(1);
@@ -897,10 +900,10 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
-	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
+	return 1 if (!$tree || which($python) eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
 
 	my $root_path = abs_path($root);
-	my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
+	my $status = `cd "$root_path"; echo "$license" | $python scripts/spdxcheck.py -`;
 	return 0 if ($status ne "");
 	return 1;
 }
-- 
2.26.1.301.g55bc3eb7cb9-goog

