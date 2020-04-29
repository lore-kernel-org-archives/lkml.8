Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72479C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE662076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgD2U41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:56:27 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:38046 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2U41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:56:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2A4F33D13;
        Wed, 29 Apr 2020 20:56:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: town34_724d5c9ce7815
X-Filterd-Recvd-Size: 1767
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Apr 2020 20:56:25 +0000 (UTC)
Message-ID: <3dc7bdaa58490f5906efc11a4d6113e42a087723.camel@perches.com>
Subject: [PATCH] checkpatch: Disallow --git and --file/--fix
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Apr 2020 13:56:24 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow these options to be combined.

Miscellanea:

o Add missing $P: to some die("reason message") output

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e4af60..4a5c6bb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -246,6 +246,8 @@ list_types(0) if ($list_types);
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
 
+die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
+
 my $exit = 0;
 
 my $perl_version_ok = 1;
@@ -269,11 +271,11 @@ if ($color =~ /^[01]$/) {
 } elsif ($color =~ /^auto$/i) {
 	$color = (-t STDOUT);
 } else {
-	die "Invalid color mode: $color\n";
+	die "$P: Invalid color mode: $color\n";
 }
 
 # skip TAB size 1 to avoid additional checks on $tabsize - 1
-die "Invalid TAB size: $tabsize\n" if ($tabsize < 2);
+die "$P: Invalid TAB size: $tabsize\n" if ($tabsize < 2);
 
 sub hash_save_array_words {
 	my ($hashRef, $arrayRef) = @_;


