Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26A3C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F97320674
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBESrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:47:47 -0500
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:33938 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbgBESrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:47:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CAF25181D303C;
        Wed,  5 Feb 2020 18:47:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ray91_43a11b80f6a52
X-Filterd-Recvd-Size: 2496
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Feb 2020 18:47:44 +0000 (UTC)
Message-ID: <76267eda365d7c5c0adc7dd16681973c5378df8e.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Prefer MAINTAINER address over S-o-b
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Wed, 05 Feb 2020 10:46:32 -0800
In-Reply-To: <20200205152429.ejgx2on2z4hoycus@kili.mountain>
References: <20200205152429.ejgx2on2z4hoycus@kili.mountain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 18:24 +0300, Dan Carpenter wrote:
> The get_maintainer.pl script looks at git history to create the CC list,
> but unfortunately sometimes those email addresses are out of date.  The
> script also looks at the MAINTAINERS file, of course, but if it already
> found an email address for a maintainer in the git history then the
> deduplicate_email() function will remove the second address.
> 
> It should save the MAINTAINERS address first, before loading the commit
> signer addresses.

Yeah, thanks.  This has been submitted already.
https://lore.kernel.org/patchwork/patch/1186249/

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> We will have to add a special case if the Dan Williamses ever decide
> to work on the same subsystem.
> 
>  scripts/get_maintainer.pl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 34085d146fa2..e5bdd3143a49 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -932,14 +932,14 @@ sub get_maintainers {
>  	}
>      }
>  
> -    foreach my $fix (@fixes) {
> -	vcs_add_commit_signers($fix, "blamed_fixes");
> -    }
> -
>      foreach my $email (@email_to, @list_to) {
>  	$email->[0] = deduplicate_email($email->[0]);
>      }
>  
> +    foreach my $fix (@fixes) {
> +	vcs_add_commit_signers($fix, "blamed_fixes");
> +    }
> +
>      foreach my $file (@files) {
>  	if ($email &&
>  	    ($email_git || ($email_git_fallback &&

