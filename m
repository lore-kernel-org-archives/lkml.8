Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D71BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696FB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG0Hdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:33:46 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:52432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgG0Hdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:33:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DDE75180A8134;
        Mon, 27 Jul 2020 07:33:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toe01_580981926f5f
X-Filterd-Recvd-Size: 3330
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jul 2020 07:33:43 +0000 (UTC)
Message-ID: <cda9b566ad67976e1acd62b053de50ee44a57250.camel@perches.com>
Subject: [PATCH] checkpatch: Add test for repeated words
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jul 2020 00:33:42 -0700
In-Reply-To: <16aa5f86f2f899a9156305ead4b7042449278eea.camel@perches.com>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
         <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
         <add7c13b1ca24c8cb6f243b99d61c19287020efd.camel@perches.com>
         <4e505c35-8428-89bb-7f9b-bc819382c3cd@infradead.org>
         <16aa5f86f2f899a9156305ead4b7042449278eea.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to avoid adding repeated words either on the
same line or consecutive comment lines in a block

e.g.:

duplicated word in comment block

	/*
	 * this is a comment block where the last word of the previous
	 * previous line is also the first word of the next line
	 */

and simple duplication

	/* test this this again */

Inspired-by: Randy Dunlap (rdunlap@infradead.org>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e9fde28eb0de..c6ef76b72bf3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -591,6 +591,8 @@ our @mode_permission_funcs = (
 	["__ATTR", 2],
 );
 
+my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
+
 #Create a search pattern for all these functions to speed up a loop below
 our $mode_perms_search = "";
 foreach my $entry (@mode_permission_funcs) {
@@ -3340,6 +3342,42 @@ sub process {
 			}
 		}
 
+# check for repeated words separated by a single space
+		if ($rawline =~ /^\+/) {
+			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
+
+				my $first = $1;
+				my $second = $2;
+
+				if ($first =~ /(?:struct|union|enum)/) {
+					pos($rawline) += length($first) + length($second) + 1;
+					next;
+				}
+
+				next if ($first ne $second);
+				next if ($first eq 'long');
+
+				if (WARN("REPEATED_WORD",
+					 "Possible repeated word: '$first'\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\b$first $second\b/$first/;
+				}
+			}
+
+			# if it's a repeated word on consecutive lines in a comment block
+			if ($prevline =~ /$;+\s*$/ &&
+			    $prevrawline =~ /($word_pattern)\s*$/) {
+				my $last_word = $1;
+				if ($rawline =~ /^\+\s*\*\s*$last_word /) {
+					if (WARN("REPEATED_WORD",
+						 "Possible repeated word: '$last_word'\n" . $hereprev) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/(\+\s*\*\s*)$last_word /$1/;
+					}
+				}
+			}
+		}
+
 # check for space before tabs.
 		if ($rawline =~ /^\+/ && $rawline =~ / \t/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";


