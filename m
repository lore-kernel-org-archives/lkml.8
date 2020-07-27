Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CD9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D8F20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgG0GOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:14:46 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:36592 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgG0GOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:14:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BE710182CED5B;
        Mon, 27 Jul 2020 06:14:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: start73_170cec826f5f
X-Filterd-Recvd-Size: 2345
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jul 2020 06:14:43 +0000 (UTC)
Message-ID: <66bbaec73d8f69541535db5390c0f12b304c0467.camel@perches.com>
Subject: Re: [PATCH] checkpatch: disable commit log length check warning for
 signature tag
From:   Joe Perches <joe@perches.com>
To:     Nachiket Naganure <nachiketun8@gmail.com>, apw@canonical.com,
        lukas.bulwahn@gmail.com, skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Sun, 26 Jul 2020 23:14:42 -0700
In-Reply-To: <20200727055458.559558-1-nachiketun8@gmail.com>
References: <20200727055458.559558-1-nachiketun8@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-27 at 11:24 +0530, Nachiket Naganure wrote:
> Disable commit log length check in case of signature tag. If the commit
> log line has valid signature tags such as "Reported-and-tested-by" with
> more than 75 characters, suppress the long length warning.
> 
> For instance in commit ac854131d984 ("USB: core: Fix misleading driver bug
> report"), the corresponding patch contains a "Reported by" tag line which
> exceeds 75 chars. And there is no valid way to shorten the length.
> 
> Signed-off-by: Nachiket Naganure <nachiketun8@gmail.com>
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 197436b20288..46237e9e0550 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2806,6 +2806,8 @@ sub process {
>  					# filename then :
>  		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
>  					# A Fixes: or Link: line
> +		      $line =~ /$signature_tags/ ||
> +					# Check for signature_tags
>  		      $commit_log_possible_stack_dump)) {
>  			WARN("COMMIT_LOG_LONG_LINE",
>  			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);

OK, but the test should be:

		      $line =~ /^\s*$signature_tags/ ||

so the line has to start with a signature and
it won't match on signature tags in the middle
of other content on the same line.


