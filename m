Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEC22465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAVR2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:28:02 -0500
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:55850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgAVR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:28:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 897D6182CED34;
        Wed, 22 Jan 2020 17:28:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: actor69_b97d50fdc604
X-Filterd-Recvd-Size: 2878
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Jan 2020 17:27:59 +0000 (UTC)
Message-ID: <e9de2dda118caca92e2cf678cccf76fa097cb734.camel@perches.com>
Subject: Re: [PATCH V2] checkpatch: fix minor typo and mixed space+tab in
 indentation
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 22 Jan 2020 09:26:58 -0800
In-Reply-To: <20200122163852.124417-2-borneo.antonio@gmail.com>
References: <20190508122721.7513-3-borneo.antonio@gmail.com>
         <20200122163852.124417-2-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-22 at 17:38 +0100, Antonio Borneo wrote:
> Fix spelling of "concatenation".
> Don't use tab after space in indentation.
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>

I've no objection to any of these 3 patches.
Andrew, might you pick them up please?

https://lore.kernel.org/patchwork/patch/1183806/
https://lore.kernel.org/patchwork/patch/1183805/
https://lore.kernel.org/patchwork/patch/1183804/

> ---
> 
> v1 -> v2
> 	rebased
> 
> ---
>  scripts/checkpatch.pl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 30da08d9646a..4c1be774b0ed 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4582,7 +4582,7 @@ sub process {
>  					    ($op eq '>' &&
>  					     $ca =~ /<\S+\@\S+$/))
>  					{
> -					    	$ok = 1;
> +						$ok = 1;
>  					}
>  
>  					# for asm volatile statements
> @@ -4917,7 +4917,7 @@ sub process {
>  			# conditional.
>  			substr($s, 0, length($c), '');
>  			$s =~ s/\n.*//g;
> -			$s =~ s/$;//g; 	# Remove any comments
> +			$s =~ s/$;//g;	# Remove any comments
>  			if (length($c) && $s !~ /^\s*{?\s*\\*\s*$/ &&
>  			    $c !~ /}\s*while\s*/)
>  			{
> @@ -4956,7 +4956,7 @@ sub process {
>  # if and else should not have general statements after it
>  		if ($line =~ /^.\s*(?:}\s*)?else\b(.*)/) {
>  			my $s = $1;
> -			$s =~ s/$;//g; 	# Remove any comments
> +			$s =~ s/$;//g;	# Remove any comments
>  			if ($s !~ /^\s*(?:\sif|(?:{|)\s*\\?\s*$)/) {
>  				ERROR("TRAILING_STATEMENTS",
>  				      "trailing statements should be on next line\n" . $herecurr);
> @@ -5132,7 +5132,7 @@ sub process {
>  			{
>  			}
>  
> -			# Flatten any obvious string concatentation.
> +			# Flatten any obvious string concatenation.
>  			while ($dstat =~ s/($String)\s*$Ident/$1/ ||
>  			       $dstat =~ s/$Ident\s*($String)/$1/)
>  			{

