Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84011C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCCD2245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgGaPex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgGaPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:34:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38438208E4;
        Fri, 31 Jul 2020 15:34:52 +0000 (UTC)
Date:   Fri, 31 Jul 2020 11:34:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 3/3] lib/vsprintf: Force type of flags for gfp_t
Message-ID: <20200731113450.4f31c3e6@oasis.local.home>
In-Reply-To: <20200731123145.22357-3-andriy.shevchenko@linux.intel.com>
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
        <20200731123145.22357-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 15:31:45 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Sparse is not happy about restricted type being assigned:
>   lib/vsprintf.c:1940:23: warning: incorrect type in assignment (different base types)
>   lib/vsprintf.c:1940:23:    expected unsigned long [assigned] flags
>   lib/vsprintf.c:1940:23:    got restricted gfp_t [usertype]
> 
> Force type of flags to make sparse happy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 90d818ef03c5..118e2727d058 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1937,7 +1937,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
>  		names = vmaflag_names;
>  		break;
>  	case 'g':
> -		flags = *(gfp_t *)flags_ptr;
> +		flags = (__force typeof(flags))(*(gfp_t *)flags_ptr);

Do we really need to say "typeof(flags)" ? What about simply using
flags' type?

		flags = (__force unsigned long)(*(gfp_t *)flags_ptr);

?

I mean, it's not like flags is a global. It's defined a few lines above.

-- Steve


>  		names = gfpflag_names;
>  		break;
>  	default:

