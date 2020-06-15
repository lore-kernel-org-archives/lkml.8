Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E8BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5D32063A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgFOPOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:14:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbgFOPOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:14:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 60AF8AF3F;
        Mon, 15 Jun 2020 15:14:19 +0000 (UTC)
Date:   Mon, 15 Jun 2020 17:14:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 13/24] dyndbg: combine flags & mask into a struct, use
 that
Message-ID: <20200615151414.GI31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-14-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-14-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:27, Jim Cromie wrote:
> combine flags & mask into a struct, and replace those 2 parameters in
> 3 functions: ddebug_change, ddebug_parse_flags, ddebug_read_flags,
> altering the derefs in them accordingly.
> 
> This simplifies the 3 function sigs, preparing for more changes.
> We dont yet need mask from ddebug_read_flags, but will soon.
> ---
>  lib/dynamic_debug.c | 46 +++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 93c627e9c094..8dc073a6e8a4 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -62,6 +62,11 @@ struct ddebug_iter {
>  	unsigned int idx;
>  };
>  
> +struct flagsettings {

Please. use underscore to help with parsing such a long names.
I mean use: flags_settings.

> +	unsigned int flags;
> +	unsigned int mask;
> +};

static int ddebug_change(const struct ddebug_query *query,
> -			unsigned int pflags, unsigned int mask)
> +			 struct flagsettings *mods)

> -static int ddebug_read_flags(const char *str, unsigned int *flags)
> +static int ddebug_read_flags(const char *str, struct flagsettings *f)

> -static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
> -			       unsigned int *maskp)
> +static int ddebug_parse_flags(const char *str, struct flagsettings *mods)

What "mods" stands for, please?

I have to say that using a parameter called "mods" in a function
called parse_flags() is inconsistent and confusing.

Best Regards,
Petr
