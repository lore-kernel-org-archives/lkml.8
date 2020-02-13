Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1782C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891A1206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgBMBHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:07:39 -0500
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:40902 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729185AbgBMBHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:07:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 91339100E7B45;
        Thu, 13 Feb 2020 01:07:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: game83_861e6c704e14
X-Filterd-Recvd-Size: 2872
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Feb 2020 01:07:37 +0000 (UTC)
Message-ID: <a22937adb1bb364e4f5b8f30ee928a2df5cc226c.camel@perches.com>
Subject: Re: [PATCH 1/1] checkpatch: support "base-commit:" format
From:   Joe Perches <joe@perches.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Feb 2020 17:06:19 -0800
In-Reply-To: <20200212233221.47662-2-jhubbard@nvidia.com>
References: <20200212233221.47662-1-jhubbard@nvidia.com>
         <20200212233221.47662-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-12 at 15:32 -0800, John Hubbard wrote:
> In order to support the get-lore-mbox.py tool described in [1], I ran:
> 
>     git format-patch --base=<commit> --cover-letter <revrange>
> 
> ...which generated a "base-commit: <commit-hash>" tag at the end of the
> cover letter. However, checkpatch.pl generated an error upon encounting
> "base-commit:" in the cover letter:
> 
>     "ERROR: Please use git commit description style..."
> 
> ...because it found the "commit" keyword, and failed to recognize that
> it was part of the "base-commit" phrase, and as such, should not be
> subjected to the same commit description style rules.
> 
> Update checkpatch.pl to include a special case for "base-commit:", so
> that that tag no longer generates a checkpatch error.
> 
> [1] https://lwn.net/Articles/811528/ "Better tools for kernel
>     developers"
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a63380c6b0d2..f241865cedb3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2761,6 +2761,7 @@ sub process {
>  
>  # Check for git id commit length and improperly formed commit descriptions
>  		if ($in_commit_log && !$commit_log_possible_stack_dump &&
> +		    $line !~ /base-commit:/ &&

If this base-commit: entry is only at the start of line,
I presume this should actually be

		    $line !~ /^base-commit:/ &&
or maybe
		    $line !~ /^\s*base-commit:/ &&

>  		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
>  		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
>  		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||

