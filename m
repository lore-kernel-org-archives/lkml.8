Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB7720739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgFONUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:20:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbgFONUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:20:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8503BADE2;
        Mon, 15 Jun 2020 13:20:33 +0000 (UTC)
Date:   Mon, 15 Jun 2020 15:20:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 07/24] dyndbg: fix a BUG_ON in ddebug_describe_flags
Message-ID: <20200615132028.GE31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-8-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-8-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:21, Jim Cromie wrote:
> ddebug_describe_flags currently fills a caller provided string buffer,
> after testing its size (also passed) in a BUG_ON.  Fix this by
> replacing them with a known-big-enough string buffer wrapped in a
> struct, and passing that instead.
> 
> Also simplify the flags parameter, and instead de-ref the flags struct
> in the caller; this makes the function reusable (soon) where flags are
> unpacked.

In all patches is missing:

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

> ---
>  lib/dynamic_debug.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 9b2445507988..aaace13d7536 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -87,22 +87,22 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
>  	{ _DPRINTK_FLAGS_NONE, '_' },
>  };
>  
> +struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };

This looks too complicated. What about?

	typedef char flags_buf[ARRAY_SIZE(opt_array) + 1];
    used as
	flags_buf fb;


	#define FLAGS_BUF_SIZE (ARRAY_SIZE(opt_array) + 1)
    used as
	char flags_buf[FLAGS_BUF_SIZE];


Best Regards,
Petr
