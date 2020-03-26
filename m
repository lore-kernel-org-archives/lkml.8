Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DECC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825BB208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgCZX2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:28:04 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:41350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728106AbgCZX17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:27:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 95D65180A7355;
        Thu, 26 Mar 2020 23:27:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: food14_286f5c524e222
X-Filterd-Recvd-Size: 5098
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 23:27:57 +0000 (UTC)
Message-ID: <5aa5aad6fb1678230c260337dc066cd449a2bf32.camel@perches.com>
Subject: [PATCH] MAINTAINERS: List the section entries in the preferred order
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Mar 2020 16:26:06 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAINTAINERS file header has never shown a preferred order for the
section entries but scripts/parse-maintainers.pl added a preferred
order with commit 61f741645a35 ("parse-maintainers: Add section pattern
sorting")

Commit 5cdbec108fd2 ("parse-maintainers: Do not sort section content by
default") changed the preferred order to be a bit more sensible.

Update the MAINTAINERS section description block to use this preferred
section entry ordering.

Add a slightly better description for the N: entry too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5060aa..ae4db4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -77,21 +77,13 @@ Tips for patch submitters
 
 8.	Happy hacking.
 
-Descriptions of section entries
--------------------------------
+Descriptions of section entries and preferred order
+---------------------------------------------------
 
 	M: *Mail* patches to: FullName <address@domain>
 	R: Designated *Reviewer*: FullName <address@domain>
 	   These reviewers should be CCed on patches.
 	L: *Mailing list* that is relevant to this area
-	W: *Web-page* with status/info
-	B: URI for where to file *bugs*. A web-page with detailed bug
-	   filing info, a direct bug tracker link, or a mailto: URI.
-	C: URI for *chat* protocol, server and channel where developers
-	   usually hang out, for example irc://server/channel.
-	Q: *Patchwork* web based patch tracking system site
-	T: *SCM* tree type and location.
-	   Type is one of: git, hg, quilt, stgit, topgit
 	S: *Status*, one of the following:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
@@ -102,30 +94,39 @@ Descriptions of section entries
 	   Obsolete:	Old code. Something tagged obsolete generally means
 			it has been replaced by a better system and you
 			should be using that.
+	W: *Web-page* with status/info
+	Q: *Patchwork* web based patch tracking system site
+	B: URI for where to file *bugs*. A web-page with detailed bug
+	   filing info, a direct bug tracker link, or a mailto: URI.
+	C: URI for *chat* protocol, server and channel where developers
+	   usually hang out, for example irc://server/channel.
 	P: Subsystem Profile document for more details submitting
 	   patches to the given subsystem. This is either an in-tree file,
 	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
 	   for details.
+	T: *SCM* tree type and location.
+	   Type is one of: git, hg, quilt, stgit, topgit
 	F: *Files* and directories wildcard patterns.
 	   A trailing slash includes all files and subdirectory files.
 	   F:	drivers/net/	all files in and below drivers/net
 	   F:	drivers/net/*	all files in drivers/net, but not below
 	   F:	*/net/*		all files in "any top level directory"/net
 	   One pattern per line.  Multiple F: lines acceptable.
+	X: *Excluded* files and directories that are NOT maintained, same
+	   rules as F:. Files exclusions are tested before file matches.
+	   Can be useful for excluding a specific subdirectory, for instance:
+	   F:	net/
+	   X:	net/ipv6/
+	   matches all files in and below net excluding net/ipv6/
 	N: Files and directories *Regex* patterns.
-	   N:	[^a-z]tegra	all files whose path contains the word tegra
+	   N:	[^a-z]tegra	all files whose path contains tegra
+	                        (not including files like integrator)
 	   One pattern per line.  Multiple N: lines acceptable.
 	   scripts/get_maintainer.pl has different behavior for files that
 	   match F: pattern and matches of N: patterns.  By default,
 	   get_maintainer will not look at git log history when an F: pattern
 	   match occurs.  When an N: match occurs, git log history is used
 	   to also notify the people that have git commit signatures.
-	X: *Excluded* files and directories that are NOT maintained, same
-	   rules as F:. Files exclusions are tested before file matches.
-	   Can be useful for excluding a specific subdirectory, for instance:
-	   F:	net/
-	   X:	net/ipv6/
-	   matches all files in and below net excluding net/ipv6/
 	K: *Content regex* (perl extended) pattern match in a patch or file.
 	   For instance:
 	   K: of_get_profile


