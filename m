Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95285C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7941122B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGaUtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgGaUtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:49:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E8121744;
        Fri, 31 Jul 2020 20:49:01 +0000 (UTC)
Date:   Fri, 31 Jul 2020 16:49:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 3/3] lib/vsprintf: Force type of flags value for
 gfp_t
Message-ID: <20200731164900.3ece67fb@oasis.local.home>
In-Reply-To: <20200731180825.30575-3-andriy.shevchenko@linux.intel.com>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
        <20200731180825.30575-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 21:08:24 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Sparse is not happy about restricted type being assigned:
>   lib/vsprintf.c:1940:23: warning: incorrect type in assignment (different base types)
>   lib/vsprintf.c:1940:23:    expected unsigned long [assigned] flags
>   lib/vsprintf.c:1940:23:    got restricted gfp_t [usertype]
> 
> Force type of flags value to make sparse happy.
> 
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Petr or Sergey,

Want to take these through the printk tree?

-- Steve

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: used explicit type to be forced to (Steven)
>  lib/vsprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 182a3e2e1629..c155769559ab 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1937,7 +1937,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
>  		names = vmaflag_names;
>  		break;
>  	case 'g':
> -		flags = *(gfp_t *)flags_ptr;
> +		flags = (__force unsigned long)(*(gfp_t *)flags_ptr);
>  		names = gfpflag_names;
>  		break;
>  	default:

