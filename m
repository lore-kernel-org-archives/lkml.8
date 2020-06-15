Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BF9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123BC207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgFOPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:37:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgFOPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0592AAD0D;
        Mon, 15 Jun 2020 15:37:32 +0000 (UTC)
Date:   Mon, 15 Jun 2020 17:37:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 15/24] dyndbg: extend ddebug_parse_flags to accept
 optional leading filter-flags
Message-ID: <20200615153727.GK31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-16-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-16-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:29, Jim Cromie wrote:
> change ddebug_parse_flags to accept optional filterflags before OP.
> this now sets the parameter added in ~1

What is "~1", please?

> ---
>  .../admin-guide/dynamic-debug-howto.rst       | 18 +++++++----
>  lib/dynamic_debug.c                           | 30 ++++++++++---------
>  2 files changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 6c04aea8f4cd..4f343e6036f5 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -217,13 +217,19 @@ line
>  	line -1605          // the 1605 lines from line 1 to line 1605
>  	line 1600-          // all lines from line 1600 to the end of the file
>  
> -The flags specification comprises a change operation followed
> -by one or more flag characters.  The change operation is one
> -of the characters::

This removes rather useful information and there is no replacement.

> +Flags Specification::
>  
> -  -    remove the given flags
> -  +    add the given flags
> -  =    set the flags to the given flags
> +  flagspec	::= filterflags? OP modflags
> +  filterflags	::= flagset
> +  modflags	::= flagset
> +  flagset	::= ([pfmltu_] | [PFMLTU_])+	# also cant have pP etc
> +  OP		::= [-+=]

I have to say that dynamic debug interface always looked pretty
complicated to me. But I have no idea what the above means.

It explans some syntax. But it does not explain what filterfalgs
and modflags mean and how they would affect the operation.

Also some examples would be very useful.

Best Regards,
Petr
