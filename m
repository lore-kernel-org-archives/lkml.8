Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2184AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0570B2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgFJVQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:16:07 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:52228 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbgFJVQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:16:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 39D731803F92D;
        Wed, 10 Jun 2020 21:16:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ants08_1b02dec26dce
X-Filterd-Recvd-Size: 2365
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 21:16:04 +0000 (UTC)
Message-ID: <673c2ebaf7a1ca93f3b1192a77ff62167badd896.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add check for
 NONNETWORKING_BLOCK_COMMENT_STYLE
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 14:16:03 -0700
In-Reply-To: <20200610202640.9020-1-scott.branden@broadcom.com>
References: <20200610202640.9020-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 13:26 -0700, Scott Branden wrote:
> NETWORKING_BLOCK_COMMENT_STYLE is supported by checkpatch but there
> doesn't seem to be any check for the standard block comment style.
> Add support for NONNETWORKING_BLOCK_COMMENT_STYLE to check for empty /*
> on first line of non-networking block comments.

I think there are _way_ too many instances of this form
in non-networking code to enable this.

$ git grep -P '^\s*/\*\s*\S.*[^\*][^\\]\s*$' -- '*.[ch]' | \
  grep -v -P '^(drivers/net/|net/)' | \
  wc -l
51407

(with a few false positives)

Does anyone really care if non-network code uses
this style?

	/* multiline
	 * comment
	 */

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3408,6 +3408,16 @@ sub process {
>  			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>  		}
>  
> +# Non-Networking with an empty initial /*
> +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> +		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]/ &&
> +		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
> +		    $rawline =~ /^\+[ \t]*\*/ &&
> +		    $realline > 2) {
> +			WARN("NONNETWORKING_BLOCK_COMMENT_STYLE",
> +			     "non-networking block comments use an empty /* on first line\n" . $hereprev);
> +		}
> +
>  # Block comments use * on subsequent lines
>  		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
>  		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*

