Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B881C35254
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D97520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgBFDXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:23:46 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:38011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727474AbgBFDXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:23:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BA3171F06;
        Thu,  6 Feb 2020 03:23:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: oven90_3db4475056c3b
X-Filterd-Recvd-Size: 2265
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Feb 2020 03:23:43 +0000 (UTC)
Message-ID: <ca53823fc5d25c0be32ad937d0207a0589c08643.camel@perches.com>
Subject: [PATCH] get_maintainer: Remove uses of P: for maintainer name
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Feb 2020 19:22:31 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1ca84ed6425f ("MAINTAINERS: Reclaim the P: tag for
Maintainer Entry Profile") changed the use of the "P:" tag
from "Person" to "Profile (ie: special subsystem coding styles
and characteristics)"

Change how get_maintainer.pl parses the "P:" tag to match.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 34085d..a00156 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1341,35 +1341,11 @@ sub add_categories {
 		    }
 		}
 	    } elsif ($ptype eq "M") {
-		my ($name, $address) = parse_email($pvalue);
-		if ($name eq "") {
-		    if ($i > 0) {
-			my $tv = $typevalue[$i - 1];
-			if ($tv =~ m/^([A-Z]):\s*(.*)/) {
-			    if ($1 eq "P") {
-				$name = $2;
-				$pvalue = format_email($name, $address, $email_usename);
-			    }
-			}
-		    }
-		}
 		if ($email_maintainer) {
 		    my $role = get_maintainer_role($i);
 		    push_email_addresses($pvalue, $role);
 		}
 	    } elsif ($ptype eq "R") {
-		my ($name, $address) = parse_email($pvalue);
-		if ($name eq "") {
-		    if ($i > 0) {
-			my $tv = $typevalue[$i - 1];
-			if ($tv =~ m/^([A-Z]):\s*(.*)/) {
-			    if ($1 eq "P") {
-				$name = $2;
-				$pvalue = format_email($name, $address, $email_usename);
-			    }
-			}
-		    }
-		}
 		if ($email_reviewer) {
 		    my $subsystem = get_subsystem_name($i);
 		    push_email_addresses($pvalue, "reviewer:$subsystem");


