Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9A4217A0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIGUuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:50:17 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:43838 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgIGUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:50:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 056CB837F24D;
        Mon,  7 Sep 2020 20:50:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: size37_3508ebd270cf
X-Filterd-Recvd-Size: 4524
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 20:50:14 +0000 (UTC)
Message-ID: <beed63208cc412f122fe273602675801add08ede.camel@perches.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] checkpatch: GIT_COMMIT_ID:
 handle commit messages with multiple quotes
From:   Joe Perches <joe@perches.com>
To:     Ayush <ayush@disroot.org>, apw@canonical.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Sep 2020 13:50:13 -0700
In-Reply-To: <20200907151417.44453-1-ayush@disroot.org>
References: <20200907151417.44453-1-ayush@disroot.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-07 at 20:44 +0530, Ayush wrote:
> Commits which mentioned/referenced "revert commits" in their description will
> get error even if they follow the proper syntax.

I think all your examples are broken.

I think all should start with revert
i.e.: Reverts commit <SHA-1> ("description...")

> for reference:
> commit e8a170ff9a35 ("drm/amdgpu: enable -msse2 for GCC 7.1+ users")
> 
> This patch checks for quotes inside the commit message and adds it
> to $orig_desc.
> 
> Earlier, the script just won't update in case of such commit message.
> I modified old condition and added new conditions to check possible
> patterns.
> 
> Following patters are solved (commit taken as example):
> - commit 193392ed9f69 ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> 
> - commit 193392ed9f69 ("Revert
> "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> 
> - commit 193392ed9f69 ("Revert "drm/amd/display:
> add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> 
> - commit 193392ed9f69
> ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> 
> Signed-off-by: Ayush <ayush@disroot.org>
> ---
>  scripts/checkpatch.pl | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 149518d2a6a7..e90e13b013d3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2862,23 +2862,42 @@ sub process {
>  				$orig_desc = $1;
>  				$hasparens = 1;
>  			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
> -				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> +				 defined $rawlines[$linenr]) {
> +				if ($rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> +					$orig_desc = $1;
> +					$hasparens = 1;
> +				} elsif ($rawlines[$linenr] =~ /^\s*\("([^"]+"[^"]+[^"]")"\)/) {
> +					$orig_desc = $1;
> +					$hasparens = 1;
> +				}
> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> +				 defined $rawlines[$linenr]) {
> +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
>  				$orig_desc = $1;
> +				if($rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> +					$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> +					$orig_desc .= " " . $1;
>  				$hasparens = 1;
> -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> +				} elsif ($rawlines[$linenr] =~ /^\s*"[^"]+""\)/) {
> +					$rawlines[$linenr] =~ /^\s*("[^"]+")"\)/;
> +					$orig_desc .= " " . $1;
> +					$hasparens = 1;
> +				}
> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+"[^"]+[^"]")"\)/i) {
> +				$orig_desc = $1;
> +			    $hasparens = 1;
> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+"[^"]+$/i &&
>  				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> -				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
> +				 $rawlines[$linenr] =~ /^\s*[^"]+""\)/) {
> +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+"[^"]+)$/i;
>  				$orig_desc = $1;
> -				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> +				$rawlines[$linenr] =~ /^\s*([^"]+")"\)/;
>  				$orig_desc .= " " . $1;
>  				$hasparens = 1;
>  			}
>  
>  			($id, $description) = git_commit_info($orig_commit,
>  							      $id, $orig_desc);
> 
>  			if (defined($id) &&
>  			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
>  				ERROR("GIT_COMMIT_ID",

