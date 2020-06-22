Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD290C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEA62073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgFVV6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:58:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:5659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbgFVV6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:58:39 -0400
IronPort-SDR: oFhWc1wJXvfzxzHSMsKAbAQjza5eaQQ1ecoKplYpgSScsC8PGLq/1Hgdy6mUETAcdxpoiDVID+
 45SNCGdAf7FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123554287"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="123554287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:58:36 -0700
IronPort-SDR: fB/8J8qmlJt3Mr8TDqDQuuvyalAq2ZmOkiO7NhpiF3bDkTPLf6lQM1x6Qd4gxfwwatzPe8zc2A
 oSsBIiFzpoAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="353605289"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2020 14:58:36 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch: use $root/.git when seeding camel case
Date:   Mon, 22 Jun 2020 14:58:34 -0700
Message-Id: <20200622215834.2858106-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When seeding the camel case file, checkpatch.pl uses the $root directory
in order to find the acceptable list of allowed camel case words.

However, if the current directory is a git repository, checkpatch.pl
attempts to seed using the local git directory.

This is problematic if checkpatch.pl is passed a --root and is being run
from within another git repository. Rather than seeding from the
provided root tree, checkpatch.pl will seed using the local files. If
the current git repository isn't a kernel tree, this can lead to
unexpected warnings about camel case issues.

Always honor the $root parameter when seeding camelcase files by using
"$root/.git" and changing directory to the $root before invoking git.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Joe Perches <joe@perches.com>
---
This is a resend of an old patch that appears to have never been picked up.
It was originally reviewed at the following locations a few years ago:

https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20160505231108.1934-1-jacob.e.keller@intel.com/
https://lore.kernel.org/netdev/20190315010334.5707-1-jacob.e.keller@intel.com/

The motivation is that we use checkpatch.pl on code in a separate git
repository that will eventually be submitted upstream. As part of this, we
provide the --root argument to specify the target kernel tree. The camelcase
then gets seeded incorrectly and --strict begins warning about a lot of
cases that aren't errors.

The current workaround is that we cd to the kernel tree and run checkpatch
from there.. but this breaks if we want to use a .checkpatch.conf file as it
won't get picked up from the original directory.

This patch simply fixes the camelcase seeding to honor the git tree at the
$root if one is provided.

I opted to stick with "cd $root &&" instead of "git -C", since there are no other usages
of "git -C" in the checkpatch.pl currently, despite "git -C" being from git
1.8.5,  and being ~7 years old.

 scripts/checkpatch.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4c820607540b..c5646e456325 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -919,8 +919,8 @@ sub seed_camelcase_includes {
 
 	$camelcase_seeded = 1;
 
-	if (-e ".git") {
-		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
+	if (-e "$root/.git") {
+		my $git_last_include_commit = `cd $root && ${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
 	} else {
@@ -947,9 +947,10 @@ sub seed_camelcase_includes {
 		return;
 	}
 
-	if (-e ".git") {
-		$files = `${git_command} ls-files "include/*.h"`;
+	if (-e "$root/.git") {
+		$files = `cd $root && ${git_command} ls-files "include/*.h"`;
 		@include_files = split('\n', $files);
+		@include_files = map("$root/$_", @include_files);
 	}
 
 	foreach my $file (@include_files) {
-- 
2.25.2

