Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E85C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6020736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbgCLC15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:27:57 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:43998 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387608AbgCLC14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:27:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D282A75BA;
        Thu, 12 Mar 2020 02:27:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jelly92_ae878a33e84c
X-Filterd-Recvd-Size: 1807
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 02:27:54 +0000 (UTC)
Message-ID: <2c4b42d1fb0bdb6604a72b2a10d49f9eae4b0ff4.camel@perches.com>
Subject: Re: [PATCH] checkpatch: always allow C99 SPDX License Identifer
 comments
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date:   Wed, 11 Mar 2020 19:26:12 -0700
In-Reply-To: <20200311191128.7896-1-scott.branden@broadcom.com>
References: <20200311191128.7896-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 12:11 -0700, Scott Branden wrote:
> Always allow C99 comment styles if SPDK-License-Identifier is in comment
> even if C99_COMMENT_TOLERANCE is specified in the --ignore options.

Why is this useful?

> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a63380c6b0d2..c8b429dd6b51 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3852,8 +3852,8 @@ sub process {
>  			}
>  		}
>  
> -# no C99 // comments
> -		if ($line =~ m{//}) {
> +# no C99 // comments except for SPDX-License-Identifier
> +		if ($line =~ m{//} && $rawline !~ /SPDX-License-Identifier:/) {
>  			if (ERROR("C99_COMMENTS",
>  				  "do not use C99 // comments\n" . $herecurr) &&
>  			    $fix) {

