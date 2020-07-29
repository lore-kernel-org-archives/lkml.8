Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF06C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC3F20786
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgG2GlZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgG2GlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:41:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2FDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:41:25 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k0fmD-0007tn-T3; Wed, 29 Jul 2020 08:41:21 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k0fmD-0003Ai-G8; Wed, 29 Jul 2020 08:41:21 +0200
Message-ID: <dd98ed496cedfceec3d41064e95f05b8d3adcca1.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Fix and extend kerneldoc
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Date:   Wed, 29 Jul 2020 08:41:21 +0200
In-Reply-To: <20200728171011.28412-1-krzk@kernel.org>
References: <20200728171011.28412-1-krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 2020-07-28 at 19:10 +0200, Krzysztof Kozlowski wrote:
> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     drivers/reset/core.c:50: warning: Function parameter or member 'array' not described in 'reset_control'
>     drivers/reset/core.c:50: warning: Function parameter or member 'deassert_count' not described in 'reset_control'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/reset/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 01c0c7aa835c..a2df88e90011 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -32,7 +32,8 @@ static LIST_HEAD(reset_lookup_list);
>   * @refcnt: Number of gets of this reset_control
>   * @acquired: Only one reset_control may be acquired for a given rcdev and id.
>   * @shared: Is this a shared (1), or an exclusive (0) reset_control?
> - * @deassert_cnt: Number of times this reset line has been deasserted
> + * @array: Is this an array of reset controls (1)?
> + * @deassert_count: Number of times this reset line has been deasserted
>   * @triggered_count: Number of times this reset line has been reset. Currently
>   *                   only used for shared resets, which means that the value
>   *                   will be either 0 or 1.

Thank you for the fix, applied to reset/next.

regards
Philipp
