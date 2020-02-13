Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B34C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADFD20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgBMPqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:46:24 -0500
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:58096 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729347AbgBMP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3742A182CF66A;
        Thu, 13 Feb 2020 15:27:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brick88_5c65b482ae422
X-Filterd-Recvd-Size: 3028
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Feb 2020 15:27:14 +0000 (UTC)
Message-ID: <19c18048e1fdec0b3db5c9a1b58f2b83514a6419.camel@perches.com>
Subject: Re: [PATCH v2 1/1] checkpatch: support "base-commit:" format
From:   Joe Perches <joe@perches.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Feb 2020 07:25:57 -0800
In-Reply-To: <20200213055004.69235-2-jhubbard@nvidia.com>
References: <20200213055004.69235-1-jhubbard@nvidia.com>
         <20200213055004.69235-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-12 at 21:50 -0800, John Hubbard wrote:
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
> Update checkpatch.pl to include a special case for "base-commit:" (at
> the start of the line, possibly with some leading whitespace) so
> that that tag no longer generates a checkpatch error.
> 
> [1] https://lwn.net/Articles/811528/ "Better tools for kernel
>     developers"
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Suggested-by: Joe Perches <joe@perches.com>

Acked-by: Joe Perches <joe@perches.com>

Andrew, can you pick this up please?

> Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a63380c6b0d2..1e66fc7a2f2f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2761,7 +2761,7 @@ sub process {
>  
>  # Check for git id commit length and improperly formed commit descriptions
>  		if ($in_commit_log && !$commit_log_possible_stack_dump &&
> -		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
> +		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
>  		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
>  		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
>  		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&

