Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6BC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E964224655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCIWIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:08:19 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:55902 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgCIWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:08:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 47DD518021B9F;
        Mon,  9 Mar 2020 22:08:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boy57_657be7daf1149
X-Filterd-Recvd-Size: 2634
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 22:08:17 +0000 (UTC)
Message-ID: <524e6933c4082608895184dbb956f6ce0bb9226d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check proper licensing of Devicetree
 bindings
From:   Joe Perches <joe@perches.com>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 15:06:37 -0700
In-Reply-To: <20200309215153.38824-1-lkundrak@v3.sk>
References: <20200309215153.38824-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 22:51 +0100, Lubomir Rintel wrote:
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

Fine by me.
Andrew, please pick this up.

cheers, Joe

> ---
> Changes since v1:
> - Downgrade severity to CHECK when running against existing files [Joe
>   Perches]
> - Add --fix support [Joe Perches]
> Both changes are taken from here: https://lore.kernel.org/lkml/39042657067088e4ca960f630a7d222fc48f947a.camel@perches.com/
> ---
>  scripts/checkpatch.pl | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e2976c3fe5ff8..642e897f46e5c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3111,6 +3111,17 @@ sub process {
>  						WARN("SPDX_LICENSE_TAG",
>  						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
>  					}
> +					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
> +					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
> +						my $msg_level = \&WARN;
> +						$msg_level = \&CHK if ($file);
> +						if (&{$msg_level}("SPDX_LICENSE_TAG",
> +
> +								  "DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)\n" . $herecurr) &&
> +						    $fix) {
> +							$fixed[$fixlinenr] =~ s/SPDX-License-Identifier: .*/SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)/;
> +						}
> +					}
>  				}
>  			}
>  		}

