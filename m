Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA84020721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbgDBCW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:22:29 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:40652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732435AbgDBCW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:22:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2CEDC100E7B40;
        Thu,  2 Apr 2020 02:22:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: eyes58_154b705020d2d
X-Filterd-Recvd-Size: 2647
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu,  2 Apr 2020 02:22:26 +0000 (UTC)
Message-ID: <65cb075435d2f385a53c77571b491b2b09faaf8e.camel@perches.com>
Subject: [PATCH] checkpatch: Look for c99 comments in ctx_locate_comment
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     paulmck@kernel.org, Marco Elver <elver@google.com>,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        apw@canonical.com, Will Deacon <will@kernel.org>
Date:   Wed, 01 Apr 2020 19:20:30 -0700
In-Reply-To: <20200401153824.GX19865@paulmck-ThinkPad-P72>
References: <20200401101714.44781-1-elver@google.com>
         <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
         <20200401153824.GX19865@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some checks look for comments around a specific function like
read_barrier_depends.

Extend the check to support both c89 and c90 comment styles.

	c89 /* comment */
or
	c99 // comment

For c99 comments, only look a 3 single lines, the line being scanned,
the line above and the line below the line being scanned rather than
the patch diff context.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d64c67..0f4db4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1674,8 +1674,16 @@ sub ctx_statement_level {
 sub ctx_locate_comment {
 	my ($first_line, $end_line) = @_;
 
+	# If c99 comment on the current line, or the line before or after
+	my ($current_comment) = ($rawlines[$end_line - 1] =~ m@^\+.*(//.*$)@);
+	return $current_comment if (defined $current_comment);
+	($current_comment) = ($rawlines[$end_line - 2] =~ m@^[\+ ].*(//.*$)@);
+	return $current_comment if (defined $current_comment);
+	($current_comment) = ($rawlines[$end_line] =~ m@^[\+ ].*(//.*$)@);
+	return $current_comment if (defined $current_comment);
+
 	# Catch a comment on the end of the line itself.
-	my ($current_comment) = ($rawlines[$end_line - 1] =~ m@.*(/\*.*\*/)\s*(?:\\\s*)?$@);
+	($current_comment) = ($rawlines[$end_line - 1] =~ m@.*(/\*.*\*/)\s*(?:\\\s*)?$@);
 	return $current_comment if (defined $current_comment);
 
 	# Look through the context and try and figure out if there is a


