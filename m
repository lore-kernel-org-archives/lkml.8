Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748E3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2B9206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHAQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:05:26 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:54724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgHAQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 12:05:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B786C180A7FD8;
        Sat,  1 Aug 2020 16:05:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: vest79_370b0cd26f8d
X-Filterd-Recvd-Size: 2994
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Aug 2020 16:05:23 +0000 (UTC)
Message-ID: <7e25090c79f6a69d502ab8219863300790192fe2.camel@perches.com>
Subject: [PATCH] checkpatch: Remove missing switch/case break test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Cambda Zhu <cambda@linux.alibaba.com>
Date:   Sat, 01 Aug 2020 09:05:22 -0700
In-Reply-To: <46F62293-BC9E-4428-94BD-186B0E3D3A5E@linux.alibaba.com>
References: <46F62293-BC9E-4428-94BD-186B0E3D3A5E@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test doesn't work well and newer compilers are much better
at emitting this warning.

Signed-off-by: Joe Perches <joe@perches.com>
---
> 在 2020年8月1日，02:05，Joe Perches <joe@perches.com> 写道：
> > ﻿On Wed, 2020-07-29 at 20:59 +0800, Cambda Zhu wrote:
> > > The checkpatch.pl only searches 3 previous lines when finding missing
> > > switch/case break, and macros are treated as normal statements. If the
> > > cases are surrounded with CONFIG, checkpatch.pl may report false
> > > warnings. For example:
> > 
> > Likely this test should be removed altogether as
> > it's never really worked well and now compilers
> > find this and emit warnings.

 scripts/checkpatch.pl | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cc5542cc234f..4aa1d9d5e62c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6541,31 +6541,6 @@ sub process {
 			}
 		}
 
-# check for case / default statements not preceded by break/fallthrough/switch
-		if ($line =~ /^.\s*(?:case\s+(?:$Ident|$Constant)\s*|default):/) {
-			my $has_break = 0;
-			my $has_statement = 0;
-			my $count = 0;
-			my $prevline = $linenr;
-			while ($prevline > 1 && ($file || $count < 3) && !$has_break) {
-				$prevline--;
-				my $rline = $rawlines[$prevline - 1];
-				my $fline = $lines[$prevline - 1];
-				last if ($fline =~ /^\@\@/);
-				next if ($fline =~ /^\-/);
-				next if ($fline =~ /^.(?:\s*(?:case\s+(?:$Ident|$Constant)[\s$;]*|default):[\s$;]*)*$/);
-				$has_break = 1 if ($rline =~ /fall[\s_-]*(through|thru)/i);
-				next if ($fline =~ /^.[\s$;]*$/);
-				$has_statement = 1;
-				$count++;
-				$has_break = 1 if ($fline =~ /\bswitch\b|\b(?:break\s*;[\s$;]*$|exit\s*\(\b|return\b|goto\b|continue\b)/);
-			}
-			if (!$has_break && $has_statement) {
-				WARN("MISSING_BREAK",
-				     "Possible switch case/default not preceded by break or fallthrough comment\n" . $herecurr);
-			}
-		}
-
 # check for /* fallthrough */ like comment, prefer fallthrough;
 		my @fallthroughs = (
 			'fallthrough',


