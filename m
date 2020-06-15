Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BD1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AE320679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFOFgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:36:04 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:59452 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725648AbgFOFgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:36:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E1274180A7FEB;
        Mon, 15 Jun 2020 05:36:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rice41_210a42e26df3
X-Filterd-Recvd-Size: 3609
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jun 2020 05:36:01 +0000 (UTC)
Message-ID: <923edc47122b3a143b06a1e711d2ec1736d898f9.camel@perches.com>
Subject: Re: [PATCH 2/2] media: atomisp: replace old ---help--- tags by just
 help
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 14 Jun 2020 22:36:00 -0700
In-Reply-To: <20200615072254.7be610bd@coco.lan>
References: <d94e7bff13e8a361353360e4cdbf637bfb701bed.1592198305.git.mchehab+huawei@kernel.org>
         <849016f49273cd245401cc2d7d454d3a12330658.1592198305.git.mchehab+huawei@kernel.org>
         <20200615072254.7be610bd@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-15 at 07:22 +0200, Mauro Carvalho Chehab wrote:
> Em Mon, 15 Jun 2020 07:18:34 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > There are several places on this file using the deprecated
> > ---help--- tag.
> > 
> > Replaces them.
> 
> Just ignore it. A treewide patch already changed it:
> 
> 	a7f7f6248d97 ("treewide: replace '---help---' in Kconfig files with 'help'")
> 
> I'll double-check the spacing things here. If it lasts upstream, I'll
> send the changes on a separate patch.

Another possible change to avoid more ---help--- lines:
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


