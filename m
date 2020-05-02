Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DB6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD3F20735
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgEBTHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 15:07:21 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:51698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728450AbgEBTHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 15:07:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A59AC181D337B;
        Sat,  2 May 2020 19:07:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: line91_3ff29e6200207
X-Filterd-Recvd-Size: 2796
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 19:07:19 +0000 (UTC)
Message-ID: <ed8ade7265429ab6fdeb2c4d05c02c67bcc57737.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix can't check for too long invalid commit
 id
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Date:   Sat, 02 May 2020 12:07:18 -0700
In-Reply-To: <20200502185041.GA9082@udknight>
References: <20200502185041.GA9082@udknight>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-03 at 02:50 +0800, Wang YanQing wrote:
> The current UNKNOWN_COMMIT_ID doesn't check for 41+ length commit id,
> and although GIT_COMMIT_ID will check for 41+ length commit id, but
> it willn't warn anything about it due to 41+ length commit will never
> be defined.
> 
> This patch moves the unknown commit id check for normal commit description
> to GIT_COMMIT_ID, and uses ERROR instead of WARN, because unknown commit
> id is total useless to track change history in changelog, it deserves the
> ERROR.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Hi again.  Trivial notes:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2865,8 +2865,18 @@ sub process {
>  			($id, $description) = git_commit_info($orig_commit,
>  							      $id, $orig_desc);
>  
> +			if (!defined($id)) {
> +			    if ($long) {
> +				ERROR("GIT_COMMIT_ID",
> +				      "Unknown commit id '$orig_commit' is too long, maybe misspelled?\n" . $herecurr);

checkpatch always uses tab indentation.
Please convert from 4 spaces to 1
tab and reindent the rest.

"misspelled" word choice may not be the best here as a
SHA-1 isn't really something that is spelled.

Perhaps something like:
	"Invalid commit id '$orig_commit' length '" . length($orig_commit) . "' exceeds allowed maximum of 40\n",

Though maybe a recommended maximum of some constant should be used.

	my $recommended_sha_length = 12;


> @@ -2969,7 +2979,7 @@ sub process {
>  		}
>  
>  # check for invalid commit id
> -		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
> +		if ($in_commit_log && $line =~ /(^fixes:)\s+([0-9a-f]{6,40})\b/i) {

Likely this capture group around Fixes: isn't necessary any more.

>  			my $id;
>  			my $description;
>  			($id, $description) = git_commit_info($2, undef, undef);

$1 ?


