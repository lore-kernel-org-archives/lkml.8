Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB1AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9834C207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgFON27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:28:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730147AbgFON26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:28:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65B3EACE1;
        Mon, 15 Jun 2020 13:29:01 +0000 (UTC)
Date:   Mon, 15 Jun 2020 15:28:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 09/24] dyndbg: add maybe(str,"") macro to reduce code
Message-ID: <20200615132856.GF31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-10-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-10-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:23, Jim Cromie wrote:
> reduce word count via macro, no actual object change.
> 
> OTOH, maybe() could be scrubbed if printk's default printing (iirc) of
> "(null)" pointers is deemed appropriate for the log-msg.
> ---
>  lib/dynamic_debug.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 31d3be30776e..20b712652ee4 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -114,6 +114,7 @@ do {								\
>  #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
>  #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
>  
> +#define maybe(str, empty)	( str ? str : empty )
>  static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>  {
>  	/* trim any trailing newlines */
> @@ -127,10 +128,10 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>  
>  	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
>  		 msg,
> -		 query->function ? query->function : "",
> -		 query->filename ? query->filename : "",
> -		 query->module ? query->module : "",
> -		 fmtlen, query->format ? query->format : "",
> +		 maybe(query->function, ""),
> +		 maybe(query->filename, ""),
> +		 maybe(query->module, ""),
> +		 fmtlen, maybe(query->format, ""),

From my POV this makes the code less readable. Open coding is much
more clear than an ambiguous macro name.

Best Regards,
Petr
