Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933C2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC422072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgFJVJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:09:56 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:46734 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726327AbgFJVJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:09:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B460918074CAA;
        Wed, 10 Jun 2020 21:09:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crate24_3c11eaa26dce
X-Filterd-Recvd-Size: 1924
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 21:09:54 +0000 (UTC)
Message-ID: <1b2d9ead79a5a035a287b7ecba8655b2c633d5cd.camel@perches.com>
Subject: Re: [PATCH] checkpatch: ignore CamelCase for inttypes.h format
 specifiers
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 14:09:53 -0700
In-Reply-To: <20200610203307.9344-1-scott.branden@broadcom.com>
References: <20200610203307.9344-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 13:33 -0700, Scott Branden wrote:
> Ignore CamelCase for inttypes.h for fixed integer types format specifiers.
> (ex. PRIx32 for uint32_t).

Personally, I don't like those.

> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 899e380782c0..9fa90457b270 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5157,6 +5157,8 @@ sub process {
>  			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
>  #Ignore Page<foo> variants
>  			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
> +#Ignore inttypes.h scanf/printf format specifiers for fixed size integer types
> +			    $var !~ /^(?:PRI|SCN)[dxoui](8|16|32|64|PTR|MAX)?$/ &&
>  #Ignore SI style variants like nS, mV and dB
>  #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
>  			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&

