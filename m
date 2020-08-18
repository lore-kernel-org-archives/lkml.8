Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2903DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4D320738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="MVcF6eC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRHuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRHuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:50:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6BC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:50:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so17283612wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fZ1BeW8VOC+hA9MKnc/D9SCIGFybsj4Ujy30wQvcOtY=;
        b=MVcF6eC7Aq5gX1Mi1yTI343wu/3W7v/5vogxthqYoEAfbSKGXI+gRuIx57aM++Yge6
         YM/xiGjtNRw9s8sTOYwsz5KtVWPsWVhnYrG2lyeWWVlspG5pcPGl3xeQXSpLv3Ez0TvC
         ui7b4ZWj2ba/5bpDfFEDmRnDyArevONCzhEWBvnERqr+WxD1VxyD5nc7udJfpT2yair5
         haSI24FrgOV0vP5C5uPX7vvdGjrG+l/yaAFmPh/qV38hXKSaF4T6GNXvaAhcM+26RYtH
         nzLGyhL0a3/QtEJWhdsZqZX//zeTyQF2xQS7g52KDh6vRY0fu9+QwWJVcPJFjLlHwMmV
         5Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZ1BeW8VOC+hA9MKnc/D9SCIGFybsj4Ujy30wQvcOtY=;
        b=mfeaqLzD1sunOl4NFd/0BcKgNZkAP52xgWS5Oj2soiuiWBVZOX7jbWXOtrK8nO/Kyg
         4xUeSxMh520QsNHzbYLxldA19h70gl7c00V7C+6tbWievY4QUUKeYZNBEVY1sE4cx1pk
         nv/NnZEGlhfA4DMV31ds0muIQ/mhsRLdFGAN4KBM3KDWqYcebTcOZqIPyYrkFvczZXiS
         9a7IIBDmrANU5z9C3fcx3PSsJIbbP44T5HrGTO9vo4WIacbJret+JVM/rL2flWG89WZL
         vZSSiapfGgGux+IpIyaY5CICZOXE6JNGv4mg04n4sydgi4tEwVo47N+jR+kb3G4rtn63
         4Vpw==
X-Gm-Message-State: AOAM5303S+ixEJdG7xhQNEdMvd+5LXywnfMisB+RfwyQQYxbdcyCMXOi
        XlMMPoRZz7wvZ9Yh3R8o+jUfJvkaPNB6KXet+Z/mjA==
X-Google-Smtp-Source: ABdhPJz3daSpl/dawmfPEEI70hSBq/yqZiY4kwArSCs57W5R/zSRz/nCwAqwTo9lq7baoRktjeJDgA==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr19208165wrs.361.1597737014128;
        Tue, 18 Aug 2020 00:50:14 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:8875:d92:eae5:ceb5? ([2a01:e0a:3cb:7bb0:8875:d92:eae5:ceb5])
        by smtp.gmail.com with ESMTPSA id c15sm31834432wme.23.2020.08.18.00.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 00:50:13 -0700 (PDT)
Subject: Re: [PATCH v3] checkpatch: add --kconfig-prefix
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
References: <20200817095056.31001-1-jerome@forissier.org>
 <20200818074349.726778-1-jerome@forissier.org>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <266350d9-c770-6a29-b784-46de2b005e39@forissier.org>
Date:   Tue, 18 Aug 2020 09:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818074349.726778-1-jerome@forissier.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/20 9:43 AM, Jerome Forissier wrote:
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

(Oh I forgot to add the link here :-/ sorry about that. Let me know if
you want me to resend.)

[1] https://github.com/OP-TEE/optee_os

> 
> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---
>  scripts/checkpatch.pl | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> v3:
> - Use ${CONFIG_} instead of $CONFIG_.
> - Expand the commit message to mention OP-TEE.
> 
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
> 
