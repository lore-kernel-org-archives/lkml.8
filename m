Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1951720829
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgHRIDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:03:49 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:49320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbgHRIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:03:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A201D8384367;
        Tue, 18 Aug 2020 08:03:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pies26_2c05cea2701d
X-Filterd-Recvd-Size: 4674
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Aug 2020 08:03:44 +0000 (UTC)
Message-ID: <aab610ed4e35e55a3379284b725c9f26836a12a0.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add --kconfig-prefix
From:   Joe Perches <joe@perches.com>
To:     Jerome Forissier <jerome@forissier.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 18 Aug 2020 01:03:43 -0700
In-Reply-To: <20200818074349.726778-1-jerome@forissier.org>
References: <20200817095056.31001-1-jerome@forissier.org>
         <20200818074349.726778-1-jerome@forissier.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 09:43 +0200, Jerome Forissier wrote:
> Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
> environment variable. Out-of-tree projects may therefore use Kconfig
> with a different prefix, or they may use a custom configuration tool
> which does not use the CONFIG_ prefix at all. Such projects may still
> want to adhere to the Linux kernel coding style and run checkpatch.pl.
> 
> One example is OP-TEE [1] which does not use Kconfig but does have
> configuration options prefixed with CFG_. It also mostly follows the
> kernel coding style and therefore being able to use checkpatch is quite
> valuable.
> 
> To make this possible, add the --kconfig-prefix command line option.
> 
> Signed-off-by: Jerome Forissier <jerome@forissier.org>

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> v3:
> - Use ${CONFIG_} instead of $CONFIG_.
> - Expand the commit message to mention OP-TEE.

Thanks for the nit-work...

cheers, Joe

> v2:
> - Use a command-line/.checkpatch.conf option instead of the _CONFIG
>   environment variable.
> - Changed the patch subject (was: "checkpatch: get CONFIG_ prefix from
>   the environment").
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2cbeae6d9aee..fd65f8c774ed 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -65,6 +65,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
>  # git output parsing needs US English output, so first set backtick child process LANGUAGE
>  my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>  my $tabsize = 8;
> +my ${CONFIG_} = "CONFIG_";
>  
>  sub help {
>  	my ($exitcode) = @_;
> @@ -127,6 +128,8 @@ Options:
>    --typedefsfile             Read additional types from this file
>    --color[=WHEN]             Use colors 'always', 'never', or only when output
>                               is a terminal ('auto'). Default is 'auto'.
> +  --kconfig-prefix=WORD      use WORD as a prefix for Kconfig symbols (default
> +                             ${CONFIG_})
>    -h, --help, --version      display this help and exit
>  
>  When FILE is - read standard input.
> @@ -235,6 +238,7 @@ GetOptions(
>  	'color=s'	=> \$color,
>  	'no-color'	=> \$color,	#keep old behaviors of -nocolor
>  	'nocolor'	=> \$color,	#keep old behaviors of -nocolor
> +	'kconfig-prefix=s'	=> \${CONFIG_},
>  	'h|help'	=> \$help,
>  	'version'	=> \$help
>  ) or help(1);
> @@ -6528,16 +6532,16 @@ sub process {
>  		}
>  
>  # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
> -		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^CONFIG_/) {
> +		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^${CONFIG_}/) {
>  			WARN("IS_ENABLED_CONFIG",
> -			     "IS_ENABLED($1) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
> +			     "IS_ENABLED($1) is normally used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
>  		}
>  
>  # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
> -		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
> +		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(${CONFIG_}[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
>  			my $config = $1;
>  			if (WARN("PREFER_IS_ENABLED",
> -				 "Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE\n" . $herecurr) &&
> +				 "Prefer IS_ENABLED(<FOO>) to ${CONFIG_}<FOO> || ${CONFIG_}<FOO>_MODULE\n" . $herecurr) &&
>  			    $fix) {
>  				$fixed[$fixlinenr] = "\+#if IS_ENABLED($config)";
>  			}

