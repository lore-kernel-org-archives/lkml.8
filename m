Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839DBC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC83206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDHCQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:16:06 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:53438 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbgDHCQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:16:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5D69FA2AD;
        Wed,  8 Apr 2020 02:16:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smash49_17ed2be884012
X-Filterd-Recvd-Size: 2449
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Apr 2020 02:16:04 +0000 (UTC)
Message-ID: <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 07 Apr 2020 19:14:05 -0700
In-Reply-To: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This works rather better:

Perhaps you could test?
---

v2:

o Avoid pr_cont
o Use only last format line if split across multiple lines

 scripts/checkpatch.pl | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d64c67..f00a6c8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5673,6 +5673,28 @@ sub process {
 			}
 		}
 
+# check for possible missing newlines at the end of common logging functions
+		if (defined($stat) &&
+		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
+		    $1 !~ /_cont$/ && $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
+			my $cnt = statement_rawlines($stat);
+			my $extracted_string = "";
+			for (my $i = 0; $i < $cnt; $i++) {
+				next if ($lines[$linenr + $i - 1] !~ /$String\s*[,\)]/);
+				$extracted_string = get_quoted_string($lines[$linenr + $i - 1],
+								      $rawlines[$linenr + $i - 1]);
+				last if ($extracted_string ne "");
+			}
+			if ($extracted_string ne "" && $extracted_string !~ /\\n"$/) {
+				my $herectx = $here . "\n";
+				for (my $n = 0; $n < $cnt; $n++) {
+					$herectx .=  raw_line($linenr, $n) . "\n";
+				}
+				WARN("MISSING_FORMAT_NEWLINE",
+				     "Possible missing '\\n' at the end of a logging message format string\n" . $herectx);
+			}
+		}
+
 # check for logging functions with KERN_<LEVEL>
 		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
 		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {


