Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD77C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6EC20728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAQJQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:16:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41653 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgAQJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:16:07 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1isNjX-0007eJ-Le; Fri, 17 Jan 2020 10:16:03 +0100
Message-ID: <f1d39d02b558f2255ed3270110bbf051a8f76f6c.camel@pengutronix.de>
Subject: Re: [PATCH RESEND] MAINTAINERS: fix style in RESET CONTROLLER
 FRAMEWORK
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>, kernel@pengutronix.de,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Jan 2020 10:16:02 +0100
In-Reply-To: <20200116184836.10256-1-lukas.bulwahn@gmail.com>
References: <20200116184836.10256-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Thu, 2020-01-16 at 19:48 +0100, Lukas Bulwahn wrote:
> Commit 37859277374d ("MAINTAINERS: add reset controller framework
> keywords") slips in some formatting with spaces instead of tabs, which
> ./scripts/checkpatch.pl -f MAINTAINERS complains about:
> 
>   WARNING: MAINTAINERS entries use one tab after TYPE:
>   #14047: FILE: MAINTAINERS:14047:
>   +K:      \b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
> 
> Fixes: 37859277374d ("MAINTAINERS: add reset controller framework keywords")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on v5.5-rc6 and next-20200116
> Philipp, please pick this patch.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d2aa9db61ab6..83eae48ad4f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14067,7 +14067,7 @@ F:	include/dt-bindings/reset/
>  F:	include/linux/reset.h
>  F:	include/linux/reset/
>  F:	include/linux/reset-controller.h
> -K:      \b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
> +K:	\b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
>  
>  RESTARTABLE SEQUENCES SUPPORT
>  M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thank you, applied to reset/fixes now.

regards
Philipp

