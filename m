Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849022063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHSVWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:22:15 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:51706 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgHSVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:22:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A7FFD2465;
        Wed, 19 Aug 2020 21:22:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scene64_34169932702b
X-Filterd-Recvd-Size: 2308
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Aug 2020 21:22:11 +0000 (UTC)
Message-ID: <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
Subject: [PATCH] checkpatch: Add test for comma use that should be semicolon
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Date:   Wed, 19 Aug 2020 14:22:10 -0700
In-Reply-To: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are commas used as statement terminations that should typically
have used semicolons instead.  Only direct assignments or use of a single
function or value on a single line are detected by this test.

e.g.:
	foo = bar(),		/* typical use is semicolon not comma */
	bar = baz();

Add an imperfect test to detect these comma uses.

No false positives were found in testing, but many types of false negatives
are possible.

e.g.:
	foo = bar() + 1,	/* comma use, but not direct assignment */
	bar = baz();

Signed-off-by: Joe Perches <joe@perches.com
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl= 
index 60d4a79674b6..93b99809df07 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4936,6 +4936,17 @@ sub process {
 			}
 		}
 
+# check if a statement with a comma should be two statements like:
+#	foo = bar(),	/* comma should be semicolon */
+#	bar = baz();
+		if (defined($stat) &&
+		    $stat =~ /^\+\s*(?:$Lval\s*$Assignment\s*)?$FuncArg\s*,\s*(?:$Lval\s*$Assignment\s*)?$FuncArg\s*;\s*$/) {
+			my $cnt = statement_rawlines($stat);
+			my $herectx = get_stat_here($linenr, $cnt, $here);
+			WARN("SUSPECT_COMMA_SEMICOLON",
+			     "Possible comma where semicolon could be used\n" . $herectx);
+		}
+
 # return is not a function
 		if (defined($stat) && $stat =~ /^.\s*return(\s*)\(/s) {
 			my $spacing = $1;

