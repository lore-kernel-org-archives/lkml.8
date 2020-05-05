Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207B2C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F6E20838
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgEEN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgEEN0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:26:20 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCEC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:26:19 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by xavier.telenet-ops.be with bizsmtp
        id b1SE2200B3VwRR3011SECU; Tue, 05 May 2020 15:26:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVxaQ-0007wb-Hl; Tue, 05 May 2020 15:26:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVxaQ-0004YE-ET; Tue, 05 May 2020 15:26:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, users@linux.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] checkpatch: use patch subject when reading from stdin
Date:   Tue,  5 May 2020 15:26:13 +0200
Message-Id: <20200505132613.17452-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While "git am" can apply an mbox file containing multiple patches (e.g.
as created by b4[1], or a patch bundle downloaded from patchwork),
checkpatch does not have proper support for that.  When operating on an
mbox, checkpatch will merge all detected tags, and complain falsely
about duplicates:

    WARNING: Duplicate signature

As modifying checkpatch to reset state in between each patch is a lot of
work, a simple solution is splitting the mbox into individual patches,
and invoking checkpatch for each of them.  Fortunately checkpatch can read
a patch from stdin, so the classic "formail" tool can be used to split
the mbox, and pipe all individual patches to checkpatch:

    formail -s scripts/checkpatch.pl < my-mbox

However, when reading a patch file from standard input, checkpatch calls
it "Your patch", and reports its state as:

    Your patch has style problems, please review.

or:

    Your patch has no obvious style problems and is ready for submission.

Hence it can be difficult to identify which patches need to be reviewed
and improved.

Fix this by replacing "Your patch" by (the first line of) the email
subject, if present.

Note that "git mailsplit" can also be used to split an mbox, but it will
create individual files for each patch, thus requiring cleanup
afterwards.  Formail does not have this disadvantage.

[1] https://git.kernel.org/pub/scm/utils/b4/b4.git

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add more rationale,
  - Refer to the new b4 tool.
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eac40f0abd56a9f4..3355358697d9e790 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1057,6 +1057,10 @@ for my $filename (@ARGV) {
 	}
 	while (<$FILE>) {
 		chomp;
+		if ($vname eq 'Your patch') {
+			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
+			$vname = '"' . $subject . '"' if $subject;
+		}
 		push(@rawlines, $_);
 	}
 	close($FILE);
-- 
2.17.1

