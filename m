Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4565C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF8820716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgA2WM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:12:27 -0500
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:50402 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgA2WM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:12:27 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 0CAE48124179;
        Wed, 29 Jan 2020 22:12:26 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E498918223245;
        Wed, 29 Jan 2020 22:12:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sack18_895e316a0954a
X-Filterd-Recvd-Size: 4818
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Jan 2020 22:12:23 +0000 (UTC)
Message-ID: <39042657067088e4ca960f630a7d222fc48f947a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check proper licensing of Devicetree
 bindings
From:   Joe Perches <joe@perches.com>
To:     Lubomir Rintel <lkundrak@v3.sk>, Andy Whitcroft <apw@canonical.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Jan 2020 14:11:17 -0800
In-Reply-To: <20200129123334.388530-1-lkundrak@v3.sk>
References: <20200129123334.388530-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-29 at 13:33 +0100, Lubomir Rintel wrote:
> According to Devicetree maintainers (see Link: below), the Devicetree
> binding documents are preferrably licensed (GPL-2.0-only OR
> BSD-2-Clause).
> 
> Let's check that. The actual check is a bit more relaxed, to allow more
> liberal but compatible licensing (e.g. GPL-2.0-or-later OR
> BSD-2-Clause).
> 
> Link: https://lore.kernel.org/lkml/20200108142132.GA4830@bogus/
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  scripts/checkpatch.pl | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e2976c3fe5ff8..ac93e98cddcee 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3111,6 +3111,11 @@ sub process {
>  						WARN("SPDX_LICENSE_TAG",
>  						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
>  					}
> +					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
> +					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
> +						WARN("SPDX_LICENSE_TAG",
> +						     "DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)\n" . $herecurr);

I think not unless the existing licenses already
there are changed first.  Only about 1/3 are
dual licensed BSD.

Do all the existing license holders agree?

$ git grep -oh "SPDX.*$" Documentation/devicetree/bindings/ | \
  sort |
uniq -c | sort -rn
    269 SPDX-License-Identifier: GPL-2.0
     81 SPDX-
License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
     69 SPDX-License-
Identifier: (GPL-2.0 OR BSD-2-Clause)
     23 SPDX-License-Identifier:
GPL-2.0-only
      9 SPDX-License-Identifier: GPL-2.0+
      5 SPDX-
License-Identifier: GPL-2.0-or-later
      3 SPDX-License-Identifier:
(GPL-2.0+ OR X11)
      3 SPDX-License-Identifier: (GPL-2.0 OR MIT)
      
3 SPDX-License-Identifier: (GPL-2.0)
      2 SPDX-License-Identifier:
GPL-2.0-or-later OR BSD-2-Clause
      2 SPDX-License-Identifier: (GPL-
2.0-or-later OR BSD-2-Clause)
      2 SPDX-License-Identifier: GPL-2.0 OR
BSD-2-Clause
      1 SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
 
     1 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause

There would be way too many false positives given
the current licensing types in existing files.

Also, the link seems to show just a desire for an
OR BSD for this file not a desire for a treewide
change.

But:

Documentation/devicetree/bindings/submitting-patches.txt does show:

 3) DT binding files should be dual licensed. The preferred license tag is
     (GPL-2.0-only OR BSD-2-Clause).

So perhaps use code like:

				my $msg_level = \&WARN;
				$msg_level = \&CHK if ($file);
				if (&{$msg_level}("SPDX_LICENSE_TAG",
						  "The preferred bindings license is '(GPL-2.0-only OR BSD-2-Clause)'\n" . $herecurr)

so that when checkpatch is run over existing files,
this message is not emitted unless using --strict.

Maybe something like:
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f3b8434..1734c9b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3124,6 +3124,17 @@ sub process {
 					if (!is_SPDX_License_valid($spdx_license)) {
 						WARN("SPDX_LICENSE_TAG",
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
+					    }
+					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
+					    $spdx_license !~ /\(GPL-2\.0-only OR BSD-2-Clause\)/) {
+						my $msg_level = \&WARN;
+						$msg_level = \&CHK if ($file);
+						if (&{$msg_level}("SPDX_LICENSE_TAG",
+
+								  "DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)\n" . $herecurr) &&
+						    $fix) {
+							$fixed[$fixlinenr] =~ s/SPDX-License-Identifier: .*/SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)/;
+						}
 					}
 				}
 			}


