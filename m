Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4165CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B103206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgFOOqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:46:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:49470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730213AbgFOOqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:46:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AB2A6AC84;
        Mon, 15 Jun 2020 14:46:51 +0000 (UTC)
Date:   Mon, 15 Jun 2020 16:46:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 11/24] dyndbg: accept 'file foo.c:func1' and 'file
 foo.c:10-100'
Message-ID: <20200615144646.GH31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-12-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-12-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:25, Jim Cromie wrote:
> Accept these additional query forms:
> 
>    echo "file $filestr +_" > control
> 
>        path/to/file.c:100	# as from control, column 1
>        path/to/file.c:1-100	# or any legal line-range
>        path/to/file.c:func_A	# as from an editor/browser
>        path/to/file.c:drm_\*	# wildcards still work
                            ^

Should the backslash be there?

>        path/to/file.c:*_foo	# lead wildcard too
> 
> 1st 2 examples are treated as line-ranges, 3,4 are treated as func's

There is also 5th example.

> Doc these changes, and sprinkle in a few extra wild-card examples and
> trailing # explanation texts.
> ---
>  .../admin-guide/dynamic-debug-howto.rst       |  5 +++++
>  lib/dynamic_debug.c                           | 20 ++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 1423af580bed..6c04aea8f4cd 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -164,6 +164,7 @@ func
>      of each callsite.  Example::
>  
>  	func svc_tcp_accept
> +	func *recv*		# in rfcomm, bluetooth, ping, tcp
>  
>  file
>      The given string is compared against either the src-root relative
> @@ -172,6 +173,9 @@ file
>  
>  	file svcsock.c
>  	file kernel/freezer.c	# ie column 1 of control file
> +	file drivers/usb/*	# all callsites under it
> +	file inode.c:start_*	# parse :tail as a func (above)
> +	file inode.c:1-100	# parse :tail as a line-range (above)
>  
>  module
>      The given string is compared against the module name
> @@ -181,6 +185,7 @@ module
>  
>  	module sunrpc
>  	module nfsd
> +	module drm*	# both drm, drm_kms_helper
>  
>  format
>      The given string is searched for in the dynamic debug format
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index f87a7bef4204..784c075c7db9 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -322,6 +322,8 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
>  	} else {
>  		query->last_lineno = query->first_lineno;
>  	}
> +	vpr_info("parsed line %d-%d\n", query->first_lineno,
> +		 query->last_lineno);

Is this supposed to be in the final code?
I do not see such messages printed for other parsed variants.

>  	return 0;
>  }
>  
> @@ -358,6 +360,7 @@ static int ddebug_parse_query(char *words[], int nwords,
>  {
>  	unsigned int i;
>  	int rc = 0;
> +	char *fline;
>  
>  	/* check we have an even number of words */
>  	if (nwords % 2 != 0) {
> @@ -374,7 +377,22 @@ static int ddebug_parse_query(char *words[], int nwords,
>  		if (!strcmp(words[i], "func")) {
>  			rc = check_set(&query->function, words[i+1], "func");
>  		} else if (!strcmp(words[i], "file")) {
> -			rc = check_set(&query->filename, words[i+1], "file");
> +			if (check_set(&query->filename, words[i+1], "file"))
> +				return -EINVAL;

There is no reason to hard code the error code. It should look like:

			rc = check_set(&query->filename, words[i+1], "file");
			if (rc)
				return rc;
> +
> +			/* tail :$info is function or line-range */
> +			fline = strchr(query->filename, ':');
> +			if (!fline)
> +				break;
> +			*fline++ = '\0';
> +			if (isalpha(*fline) || *fline == '*' || *fline == '?') {

I would do the oposite and check whether is starts with number.

> +				/* take as function name */
> +				if (check_set(&query->function, fline, "func"))
> +					return -EINVAL;
> +			} else {
> +				if (parse_linerange(query, fline))
> +					return -EINVAL;
> +			}

Also I would hide this into another function:

			rc = parse_filenane(...);


>  		} else if (!strcmp(words[i], "module")) {
>  			rc = check_set(&query->module, words[i+1], "module");
>  		} else if (!strcmp(words[i], "format")) {
> -- 
> 2.26.2

Best Regards,
Petr
