Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630BD2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgFQEgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:36:45 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:50730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbgFQEgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:36:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6A500182CED28;
        Wed, 17 Jun 2020 04:36:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: view80_460276a26e04
X-Filterd-Recvd-Size: 2996
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Jun 2020 04:36:43 +0000 (UTC)
Message-ID: <b1eef508475f2ad501a153bb9d90d64a5128ecdd.camel@perches.com>
Subject: Re: [PATCH 2/2] Revert "checkpatch: kconfig: prefer 'help' over
 '---help---'"
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Jun 2020 21:36:42 -0700
In-Reply-To: <20200617030220.34733-2-masahiroy@kernel.org>
References: <20200617030220.34733-1-masahiroy@kernel.org>
         <20200617030220.34733-2-masahiroy@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-17 at 12:02 +0900, Masahiro Yamada wrote:
> This reverts commit 84af7a6194e493fae312a2b7fa5a3b51f76d9282.

Also: https://lore.kernel.org/patchwork/patch/1255848/
---
 scripts/checkkconfigsymbols.py | 2 +-
 scripts/checkpatch.pl          | 6 +-----
 scripts/kconfig/lexer.l        | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/scripts/checkkconfigsymbols.py b/scripts/checkkconfigsymbols.py
index 00a10a293f4f..1548f9ce4682 100755
--- a/scripts/checkkconfigsymbols.py
+++ b/scripts/checkkconfigsymbols.py
@@ -34,7 +34,7 @@ REGEX_SOURCE_SYMBOL = re.compile(SOURCE_SYMBOL)
 REGEX_KCONFIG_DEF = re.compile(DEF)
 REGEX_KCONFIG_EXPR = re.compile(EXPR)
 REGEX_KCONFIG_STMT = re.compile(STMT)
-REGEX_KCONFIG_HELP = re.compile(r"^\s+(help|---help---)\s*$")
+REGEX_KCONFIG_HELP = re.compile(r"^\s+help\s*$")
 REGEX_FILTER_SYMBOLS = re.compile(r"[A-Za-z0-9]$")
 REGEX_NUMERIC = re.compile(r"0[xX][0-9a-fA-F]+|[0-9]+")
 REGEX_QUOTES = re.compile("(\"(.*?)\")")
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 524df88f9364..738bb3fcf202 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3044,11 +3044,7 @@ sub process {
 
 				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
 					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
-					if ($lines[$ln - 1] =~ "---help---") {
-						WARN("CONFIG_DESCRIPTION",
-						     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
-					}
+				} elsif ($lines[$ln - 1] =~ /^\+\s*help\s*$/) {
 					$length = -1;
 				}
 
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 6354c905b006..4b7339ff4c8b 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -105,7 +105,7 @@ n	[A-Za-z0-9_-]
 "endchoice"		return T_ENDCHOICE;
 "endif"			return T_ENDIF;
 "endmenu"		return T_ENDMENU;
-"help"|"---help---"	return T_HELP;
+"help"			return T_HELP;
 "hex"			return T_HEX;
 "if"			return T_IF;
 "imply"			return T_IMPLY;


