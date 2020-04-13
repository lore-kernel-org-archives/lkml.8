Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3A720656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbgDMUMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:12:53 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:53276 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727816AbgDMUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:12:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E0A15180257EF;
        Mon, 13 Apr 2020 20:12:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: truck75_6fe61a90e6901
X-Filterd-Recvd-Size: 3304
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Apr 2020 20:12:48 +0000 (UTC)
Message-ID: <17677130b3ca62d79817e6a22546bad39d7e81b4.camel@perches.com>
Subject: [PATCH] checkpatch: Additional MAINTAINER section entry ordering
 checks
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Apr 2020 13:10:41 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a preferred order for the entries in MAINTAINERS sections.

See:

commit 3b50142d8528 ("MAINTAINERS: sort field names for all entries")
and
commit 6680125ea5a2 ("MAINTAINERS: list the section entries in the preferred order)

Add checkpatch tests to try to keep that ordering.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d64c67..3c44833 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3060,14 +3060,43 @@ sub process {
 			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
 
-# check for MAINTAINERS entries that don't have the right form
-		if ($realfile =~ /^MAINTAINERS$/ &&
-		    $rawline =~ /^\+[A-Z]:/ &&
-		    $rawline !~ /^\+[A-Z]:\t\S/) {
-			if (WARN("MAINTAINERS_STYLE",
-				 "MAINTAINERS entries use one tab after TYPE:\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/^(\+[A-Z]):\s*/$1:\t/;
+# check MAINTAINERS entries
+		if ($realfile =~ /^MAINTAINERS$/) {
+# check MAINTAINERS entries for the right form
+			if ($rawline =~ /^\+[A-Z]:/ &&
+			    $rawline !~ /^\+[A-Z]:\t\S/) {
+				if (WARN("MAINTAINERS_STYLE",
+					 "MAINTAINERS entries use one tab after TYPE:\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/^(\+[A-Z]):\s*/$1:\t/;
+				}
+			}
+# check MAINTAINERS entries for the right ordering too
+			my $preferred_order = 'MRLSWQBCPTFXNK';
+			if ($rawline =~ /^\+[A-Z]:/ &&
+			    $prevrawline =~ /^[\+ ][A-Z]:/) {
+				$rawline =~ /^\+([A-Z]):\s*(.*)/;
+				my $cur = $1;
+				my $curval = $2;
+				$prevrawline =~ /^[\+ ]([A-Z]):\s*(.*)/;
+				my $prev = $1;
+				my $prevval = $2;
+				my $curindex = index($preferred_order, $cur);
+				my $previndex = index($preferred_order, $prev);
+				if ($curindex < 0) {
+					WARN("MAINTAINERS_STYLE",
+					     "Unknown MAINTAINERS entry type: '$cur'\n" . $herecurr);
+				} else {
+					if ($previndex >= 0 && $curindex < $previndex) {
+						WARN("MAINTAINERS_STYLE",
+						     "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev);
+					} elsif ((($prev eq 'F' && $cur eq 'F') ||
+						  ($prev eq 'X' && $cur eq 'X')) &&
+						 ($prevval cmp $curval) > 0) {
+						WARN("MAINTAINERS_STYLE",
+						     "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev);
+					}
+				}
 			}
 		}
 

