Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE584C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE47206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgBUOwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:52:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43573 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgBUOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:52:18 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j59eZ-0000J6-Uu; Fri, 21 Feb 2020 15:51:43 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j59eX-0003X7-KU; Fri, 21 Feb 2020 15:51:41 +0100
Date:   Fri, 21 Feb 2020 15:51:41 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1] lib/vsprintf: update comment about
 simple_strto<foo>() functions
Message-ID: <20200221145141.pchim24oht7nxfir@pengutronix.de>
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Feb 21, 2020 at 10:57:23AM +0200, Andy Shevchenko wrote:
> The commit 885e68e8b7b1 ("kernel.h: update comment about simple_strto<foo>()
> functions") updated a comment regard to simple_strto<foo>() functions, but
> missed similar change in the vsprintf.c module.
> 
> Update comments in vsprintf.c as well for simple_strto<foo>() functions.
> 
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 7c488a1ce318..d5641a217685 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -58,7 +58,7 @@
>   * @endp: A pointer to the end of the parsed string will be placed here
>   * @base: The number base to use
>   *
> - * This function is obsolete. Please use kstrtoull instead.
> + * This function has caveats. Please use kstrtoull instead.
>   */

I wonder if we instead want to create a set of functions that is
versatile enough to cover kstrtoull and simple_strtoull. i.e. fix the
rounding problems (that are the caveats, right?) and as calling
convention use an errorvalued int return + an output-parameter of the
corresponding type.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
