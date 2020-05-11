Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B5BC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25ED206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgEKRDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:03:37 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:39078 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730900AbgEKRDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:03:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B68D5100E7B51;
        Mon, 11 May 2020 17:03:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dog25_5922f49cb6a19
X-Filterd-Recvd-Size: 2052
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 17:03:32 +0000 (UTC)
Message-ID: <c4b600b5455fcb48975cfc9d8214cdbbc01f2e2f.camel@perches.com>
Subject: Re: [PATCH net-next v2] checkpatch: warn about uses of ENOTSUPP
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 10:03:31 -0700
In-Reply-To: <20200511165319.2251678-1-kuba@kernel.org>
References: <20200511165319.2251678-1-kuba@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 09:53 -0700, Jakub Kicinski wrote:
> ENOTSUPP often feels like the right error code to use, but it's
> in fact not a standard Unix error. E.g.:
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4199,6 +4199,17 @@ sub process {
>  			     "ENOSYS means 'invalid syscall nr' and nothing else\n" . $herecurr);
>  		}
>  
> +# ENOTSUPP is not a standard error code and should be avoided in new patches.
> +# Folks usually mean EOPNOTSUPP (also called ENOTSUP), when they type ENOTSUPP.
> +# Similarly to ENOSYS warning a small number of false positives is expected.
> +		if (~$file && $line =~ /\bENOTSUPP\b/) {

It's probably my typo or my brain thinking "not" and hitting
the tilde and not the bang, but this should be

		if (!$file & ...)

Otherwise:

Acked-by: Joe Perches <joe@perches.com>

> +			if (WARN("ENOTSUPP",
> +				 "ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP\n" . $herecurr) &&
> +			    $fix) {
> +				$fixed[$fixlinenr] =~ s/\bENOTSUPP\b/EOPNOTSUPP/;
> +			}
> +		}
> +
>  # function brace can't be on same line, except for #defines of do while,
>  # or if closed on same line
>  		if ($perl_version_ok &&

