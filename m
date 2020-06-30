Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD08AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A4C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbgF3OrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:47:01 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:59642 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727016AbgF3OrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:47:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 15CD8100E7B40;
        Tue, 30 Jun 2020 14:47:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scarf61_370d38626e78
X-Filterd-Recvd-Size: 2299
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Jun 2020 14:46:58 +0000 (UTC)
Message-ID: <39ba164ba44be848feac831f2f21effca92bfc96.camel@perches.com>
Subject: Re: [PATCH] checkpatch: prevent reporting C99_COMMENTS error for
 SPDX tag in .c file
From:   Joe Perches <joe@perches.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vadim Bendebury <vbendeb@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 30 Jun 2020 07:46:57 -0700
In-Reply-To: <20200630143525.13869-1-quentin@isovalent.com>
References: <20200630143525.13869-1-quentin@isovalent.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Vadem Bendebury who added the tolerance test)

On Tue, 2020-06-30 at 15:35 +0100, Quentin Monnet wrote:
> When checkpatch.pl is invoked with "--ignore C99_COMMENT_TOLERANCE", it
> reports C99-style comments found in the code, by matching on the
> double-slash pattern "//". This includes the leading slashes before the
> SPDX tags that are now used in a majority of C files.
> 
> Such tags are commented with the double-slash on purpose, and should not
> trigger errors from checkpatch. Let's ignore them when searching for
> C99-style comments to report.
> 
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

I think this unnecessary as perhaps those that want no
c99 comments likely _really_ want no c99 comments.

> ---
>  scripts/checkpatch.pl | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3cacc122c528..67f350c580ea 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3983,7 +3983,10 @@ sub process {
>  		}
>  
>  # no C99 // comments
> -		if ($line =~ m{//}) {
> +		if ($line =~ m{//} &&
> +		    !($rawline =~ m{// SPDX-License-Identifier:} &&
> +		      $realfile =~ /\.c$/ &&
> +		      $realline == $checklicenseline)) {
>  			if (ERROR("C99_COMMENTS",
>  				  "do not use C99 // comments\n" . $herecurr) &&
>  			    $fix) {

