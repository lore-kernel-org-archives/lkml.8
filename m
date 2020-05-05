Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7042EC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574E620735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgEET5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:57:42 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:52612 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEET5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:57:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C0BD518026A37;
        Tue,  5 May 2020 19:57:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: son84_5ff89f9aca943
X-Filterd-Recvd-Size: 3923
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 May 2020 19:57:39 +0000 (UTC)
Message-ID: <1b0b4e6562cbbf4621e71042e511ae3cd0b542f6.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, users@linux.kernel.org
Date:   Tue, 05 May 2020 12:57:37 -0700
In-Reply-To: <20200505132613.17452-1-geert+renesas@glider.be>
References: <20200505132613.17452-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 15:26 +0200, Geert Uytterhoeven wrote:
> While "git am" can apply an mbox file containing multiple patches (e.g.
> as created by b4[1], or a patch bundle downloaded from patchwork),
> checkpatch does not have proper support for that.  When operating on an
> mbox, checkpatch will merge all detected tags, and complain falsely
> about duplicates:
> 
>     WARNING: Duplicate signature
> 
> As modifying checkpatch to reset state in between each patch is a lot of
> work, a simple solution is splitting the mbox into individual patches,
> and invoking checkpatch for each of them.  Fortunately checkpatch can read
> a patch from stdin, so the classic "formail" tool can be used to split
> the mbox, and pipe all individual patches to checkpatch:
> 
>     formail -s scripts/checkpatch.pl < my-mbox
> 
> However, when reading a patch file from standard input, checkpatch calls
> it "Your patch", and reports its state as:
> 
>     Your patch has style problems, please review.
> 
> or:
> 
>     Your patch has no obvious style problems and is ready for submission.
> 
> Hence it can be difficult to identify which patches need to be reviewed
> and improved.
> 
> Fix this by replacing "Your patch" by (the first line of) the email
> subject, if present.
> 
> Note that "git mailsplit" can also be used to split an mbox, but it will
> create individual files for each patch, thus requiring cleanup
> afterwards.  Formail does not have this disadvantage.
> 
> [1] https://git.kernel.org/pub/scm/utils/b4/b4.git
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add more rationale,
>   - Refer to the new b4 tool.
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index eac40f0abd56a9f4..3355358697d9e790 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1057,6 +1057,10 @@ for my $filename (@ARGV) {
>  	}
>  	while (<$FILE>) {
>  		chomp;
> +		if ($vname eq 'Your patch') {
> +			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> +			$vname = '"' . $subject . '"' if $subject;
> +		}
>  		push(@rawlines, $_);
>  	}
>  	close($FILE);

There's a less cpu intensive way to do this,
for small patches, on my little laptop it's a
few dozen milliseconds faster, and for very
large patches multiple seconds faster to use
the following patch:

Substitute Geert's patch with the below but:

Acked-by: Joe Perches <joe@perches.com>

---

 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f0092104ff7b..29786a097862 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1062,6 +1062,7 @@ for my $filename (@ARGV) {
 	while (<$FILE>) {
 		chomp;
 		push(@rawlines, $_);
+		$vname = "\"$1\"" if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/);
 	}
 	close($FILE);
 

