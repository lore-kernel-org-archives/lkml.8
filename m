Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5DFC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F40B206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDHAfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:35:23 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:41858 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726421AbgDHAfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:35:23 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id DB3DC182D5840;
        Wed,  8 Apr 2020 00:35:21 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id EFBCD4995ED;
        Wed,  8 Apr 2020 00:35:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: woman93_117a4295ed250
X-Filterd-Recvd-Size: 4179
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Apr 2020 00:35:19 +0000 (UTC)
Message-ID: <437746b14735ecef311720ad41d5b237209e9674.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 07 Apr 2020 17:33:21 -0700
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

On Tue, 2020-04-07 at 22:49 +0200, Christophe JAILLET wrote:
> Strings logged with pr_xxx and dev_xxx often lack a trailing '\n'.
> Introduce new tests to try to catch them early.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is more a PoC for now.
> 
> Regex could be improved, merged, ...
> We could also check for surrounding pr_cont...
> 
> This patch is based on idea from [1]. coccinelle spots too many places
> where \n are missing (~ 2800 with the heuristic I've used).
> Fixing them would be painful.
> I instead propose to teach checkpatch.pl about it to try to spot cases
> early and avoid introducing new cases.
> 
> [1]: https://marc.info/?l=kernel-janitors&m=158619533629657&w=4
> ---
>  scripts/checkpatch.pl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c392ab8ea12e..792804bd6ad9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5676,6 +5676,16 @@ sub process {
>  			}
>  		}
>  
> +# check for missing \n at the end of logging function
> +		if ($line =~ /\bpr_(emerg|alert|crit|err|warning|warn|notice|info|debug|dbg)\s*\("([^"]*(?<!\\n))"/) {
> +			WARN("MISSING NL",
> +			     "Possible missing '\\n' at the end of a log message\n" . $hereprev);
> +		}
> +		if ($line =~ /\bdev_(emerg|alert|crit|err|warning|warn|notice|info|debug|dbg)\s*\([^,]*,\s*"([^"]*(?<!\\n))"/) {
> +			WARN("MISSING NL",
> +			     "Possible missing '\\n' at the end of a log message\n" . $hereprev);
> +		}

This can't work as string is masked to "XXX"

This is probably better using $stat and checking if a "XX" format
string exists as 1st or 2nd arg and adding an extraction
from the $rawline equivalent and checking that.

Also this test should probably using $logFunctions and check
if the initial block is one of the known functions that
use a newline termination (pr_|dev_|netdev_|wiphy_)

Something like:
---
 scripts/checkpatch.pl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d64c67..79eee2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5673,6 +5673,27 @@ sub process {
 			}
 		}
 
+# check for possible missing newlines at the end of common logging functions
+		if (defined($stat) &&
+		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
+		    $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
+			my $cnt = statement_rawlines($stat);
+			my $extracted_string = "";
+			for (my $i = 0; $i < $cnt; $i++) {
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


