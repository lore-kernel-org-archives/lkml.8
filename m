Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421A02084C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGNLOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:14:41 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:57282 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726041AbgGNLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:14:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7DE5D100E7B43;
        Tue, 14 Jul 2020 11:14:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mom61_3f0063526ef0
X-Filterd-Recvd-Size: 1811
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Jul 2020 11:14:38 +0000 (UTC)
Message-ID: <cd892c33922c477622ede83d80592e71098c4dc2.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Allow '+' in compatible strings
From:   Joe Perches <joe@perches.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2020 04:14:36 -0700
In-Reply-To: <20200714094141.147418-1-thierry.reding@gmail.com>
References: <20200714094141.147418-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 11:41 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The current checks will interpret a '+' character as special because
> they use regular expression matching. Escape the '+' character if it
> appears in a compatible string.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thanks

> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4c820607540b..8104d0736e7f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3145,6 +3145,7 @@ sub process {
>  			my $vp_file = $dt_path . "vendor-prefixes.yaml";
>  
>  			foreach my $compat (@compats) {
> +				$compat =~ s/\+/\\+/;

This changes the @compats array for each line
>  				my $compat2 = $compat;
>  				$compat2 =~ s/\,[a-zA-Z0-9]*\-/\,<\.\*>\-/;
>  				my $compat3 = $compat;

