Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736F2207ED
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgFESYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:24:49 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:36496 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgFESYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:24:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 82970181D330D;
        Fri,  5 Jun 2020 18:24:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trade08_4000ad726da2
X-Filterd-Recvd-Size: 1762
Received: from XPS-9350 (unknown [172.58.43.180])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Jun 2020 18:24:47 +0000 (UTC)
Message-ID: <e7fda760b91b769ba82844ba282d432c0d26d709.camel@perches.com>
Subject: [PATCH] checkpatch: Add test for possible misuse of IS_ENABLED()
 without CONFIG_
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Date:   Fri, 05 Jun 2020 11:24:43 -0700
In-Reply-To: <202006050718.9D4FCFC2E@keescook>
References: <202006050718.9D4FCFC2E@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ENABLED is almost always used with CONFIG_<FOO> defines.

Add a test to verify that the #define being tested starts with CONFIG_.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5f00df2c3f59..83be88b16166 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6480,6 +6480,12 @@ sub process {
 			}
 		}
 
+# check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
+		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^CONFIG_/) {
+			WARN("IS_ENABLED_CONFIG",
+			     "IS_ENABLED($1) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
+		}
+
 # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
 		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
 			my $config = $1;


