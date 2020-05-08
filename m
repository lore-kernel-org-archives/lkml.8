Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7817C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F262070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgEHS2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:28:41 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:39776 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHS2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:28:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E07FA837F253;
        Fri,  8 May 2020 18:28:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cake24_4b84b1fd02a33
X-Filterd-Recvd-Size: 1924
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 May 2020 18:28:38 +0000 (UTC)
Message-ID: <c9d89bb24c7414142414c60371e210fdcf4617d2.camel@perches.com>
Subject: Re: + checkpatch-use-patch-subject-when-reading-from-stdin.patch
 added to -mm tree
From:   Joe Perches <joe@perches.com>
To:     akpm@linux-foundation.org, geert+renesas@glider.be,
        konstantin@linuxfoundation.org,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 08 May 2020 11:28:37 -0700
In-Reply-To: <20200505191846.eUGRUOXlc%akpm@linux-foundation.org>
References: <20200505191846.eUGRUOXlc%akpm@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 12:18 -0700, akpm@linux-foundation.org wrote:
> The patch titled
>      Subject: checkpatch: use patch subject when reading from stdin
> has been added to the -mm tree.  Its filename is
>      checkpatch-use-patch-subject-when-reading-from-stdin.patch

Hey Andrew:

Please apply this patch on top of Geert's first one to reduce cpu usage.

For the original patch:

Acked-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e5b6b9aa21d6..8223342e9b69 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1061,11 +1061,8 @@ for my $filename (@ARGV) {
 	}
 	while (<$FILE>) {
 		chomp;
-		if ($vname eq 'Your patch') {
-			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
-			$vname = '"' . $subject . '"' if $subject;
-		}
 		push(@rawlines, $_);
+		$vname = qq("$1") if ($filename eq '-' && $_ =~ m/^Subject:\s+(.+)/i);
 	}
 	close($FILE);
 

