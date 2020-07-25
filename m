Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC9BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B70206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgGYR32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:29:28 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:48736 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbgGYR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:29:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 96F931822385B;
        Sat, 25 Jul 2020 17:29:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: idea91_290e32e26f51
X-Filterd-Recvd-Size: 3369
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 Jul 2020 17:29:24 +0000 (UTC)
Message-ID: <58ed7006138bb256ad1821d5f4f892f3c3e031a8.camel@perches.com>
Subject: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        apw@canonical.com, colin.king@canonical.com, sj38.park@gmail.com,
        jslaby@suse.cz, pavel@ucw.cz
Date:   Sat, 25 Jul 2020 10:29:23 -0700
In-Reply-To: <20200725130248.GC18633@qmqm.qmqm.pl>
References: <20200725130248.GC18633@qmqm.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> Hello,
> 
> I see that this patch went into next and is already inciting people to
> do wrong things [1]. Can you please fix it to require '--subjective'
> switch or otherwise mark it clearly as suggestion-only?
> 
> The coding-style as in Linus' master says about *NEW* uses of the words
> listed (those introductions I expect to be actually rare) and not about
> existing use in the code or industry. Making a noise about all uses
> found surely will generate a lot more irrelevant patches.
> 
> [1] https://www.spinics.net/lists/linux-tegra/msg51849.html

And if not reverted, perhaps do not check existing files
at all but only check patches and change the message to
show only suggestions not from a specification.
---
 scripts/checkpatch.pl | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e9fde28eb0de..7ef1ba80cb20 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2970,21 +2970,16 @@ sub process {
 			}
 		}
 
-# Check for deprecated terms
-		if (defined($deprecated_terms) &&
+# Check for deprecated terms not used by a specification (not used on files)
+		if (!$file && defined($deprecated_terms) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
 			while ($rawline =~ /(?:^|[^a-z@])($deprecated_terms)(?:\b|$|[^a-z@])/gi) {
-				my $deprecated_term = $1;
-				my $suggested = $deprecated_terms_fix{lc($deprecated_term)};
-				$suggested = ucfirst($suggested) if ($deprecated_term=~ /^[A-Z]/);
-				$suggested = uc($suggested) if ($deprecated_term =~ /^[A-Z]+$/);
-				my $msg_level = \&WARN;
-				$msg_level = \&CHK if ($file);
-				if (&{$msg_level}("DEPRECATED_TERM",
-						  "Use of '$deprecated_term' is deprecated, please '$suggested', instead.\n" . $herecurr) &&
-				    $fix) {
-					$fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($deprecated_term)($|[^A-Za-z@])/$1$suggested$3/;
-				}
+				my $deprecate = $1;
+				my $suggest = $deprecated_terms_fix{lc($deprecate)};
+				$suggest = ucfirst($suggest) if ($deprecate =~ /^[A-Z]/);
+				$suggest = uc($suggest) if ($deprecate =~ /^[A-Z]+$/);
+				CHK("DEPRECATED_TERM",
+				    "Use of '$deprecate' is controversial - if not required by specification, perhaps '$suggest' instead\n" . $herecurr);
 			}
 		}
 

