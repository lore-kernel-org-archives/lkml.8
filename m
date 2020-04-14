Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949DC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3643720767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503149AbgDNR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:58:46 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:57432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729303AbgDNR6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:58:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 53DB2837F27B;
        Tue, 14 Apr 2020 17:58:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing26_ffa4eda79c27
X-Filterd-Recvd-Size: 1879
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Apr 2020 17:58:29 +0000 (UTC)
Message-ID: <9c633ea161df91265a338aaa93a78443894c268f.camel@perches.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Factor "tcs_reg_addr" and
 "tcs_cmd_addr" calculation
From:   Joe Perches <joe@perches.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mkshah@codeaurora.org, mka@chromium.org, swboyd@chromium.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Apr 2020 10:56:20 -0700
In-Reply-To: <20200414104120.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
References: <20200414104120.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-14 at 10:41 -0700, Douglas Anderson wrote:
> We can make some of the register access functions more readable by
> factoring out the calculations a little bit.

unrelated trivia:

> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
[]
>  static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
>  			       u32 data)
>  {
> -	writel(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
> +	writel(data, tcs_reg_addr(drv, reg, tcs_id));
>  	for (;;) {
> -		if (data == readl(drv->tcs_base + reg +
> -				  RSC_DRV_TCS_OFFSET * tcs_id))
> +		if (data == readl(tcs_reg_addr(drv, reg, tcs_id)))
>  			break;
>  		udelay(1);
>  	}

There a lockup potential here.

It might be better to use some max loop counter with
an error/warning emitted instead of a continuous retry.


