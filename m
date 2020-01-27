Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425C4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9842467B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgA0UED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:04:03 -0500
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:44179 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgA0UED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:04:03 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A8695100E7B47;
        Mon, 27 Jan 2020 20:04:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toad58_400ed4d2d0058
X-Filterd-Recvd-Size: 4073
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jan 2020 20:04:00 +0000 (UTC)
Message-ID: <f73727fb0bb8b718366064901fbd7c13035ca50d.camel@perches.com>
Subject: Re: [PATCH] scripts/get_maintainer.pl: Deprioritize old Fixes:
 addresses
From:   Joe Perches <joe@perches.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Jan 2020 12:02:56 -0800
In-Reply-To: <20200127095001.1.I41fba9f33590bfd92cd01960161d8384268c6569@changeid>
References: <20200127095001.1.I41fba9f33590bfd92cd01960161d8384268c6569@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-27 at 09:50 -0800, Douglas Anderson wrote:
> Recently, I found that get_maintainer was causing me to send emails to
> the old addresses for maintainers.  Since I usually just trust the
> output of get_maintainer to know the right email address, I didn't
> even look carefully and fired off two patch series that went to the
> wrong place.  Oops.
> 
> The problem was introduced recently when trying to add signatures from
> Fixes.  The problem was that these email addresses were added too
> early in the process of compiling our list of places to send.  Things
> added to the list earlier are considered more canonical and when we
> later added maintainer entries we ended up deduplicating to the old
> address.
> 
> Here are two examples using mainline commits (to make it easier to
> replicate) for the two maintainers that I messed up recently:
> 
> $ git format-patch d8549bcd0529~..d8549bcd0529
> $ ./scripts/get_maintainer.pl 0001-clk-Add-clk_hw*.patch | grep Boyd
> Stephen Boyd <sboyd@codeaurora.org>...
> 
> $ git format-patch 6d1238aa3395~..6d1238aa3395
> $ ./scripts/get_maintainer.pl 0001-arm64-dts-qcom-qcs404*.patch | grep Andy
> Andy Gross <andy.gross@linaro.org>
> 
> Let's move the adding of addresses from Fixes: to the end since the
> email addresses from these are much more likely to be older.
> 
> After this patch the above examples get the right addresses for the
> two examples.
> 
> Fixes: 2f5bd343694e ("scripts/get_maintainer.pl: add signatures from Fixes: <badcommit> lines in commit message")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I'm no expert at this script and no expert at Perl.  If moving this
> call like I'm doing is totally stupid then please let me know what a
> more proper fix is.  Thanks!

No, it's correct and I looked at exactly this
change after this email exchange but I haven't
posted it because there might a be better way to
restructure this to allow the deduplication to
be done properly.

https://lore.kernel.org/lkml/b72846874d5ee367bf86e787ca2152f90d814a34.camel@perches.com/

Anyway, for now, it's likely good enough so:

Acked-by: Joe Perches <joe@perches.com>

>  scripts/get_maintainer.pl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 34085d146fa2..7a228681f89f 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -932,10 +932,6 @@ sub get_maintainers {
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
> @@ -974,6 +970,10 @@ sub get_maintainers {
>  	}
>      }
>  
> +    foreach my $fix (@fixes) {
> +	vcs_add_commit_signers($fix, "blamed_fixes");
> +    }
> +
>      my @to = ();
>      if ($email || $email_list) {
>  	if ($email) {

