Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9145C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51CE20775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588126568;
	bh=XPRSra4YU5LgYp0Jl2N2h9TJHKIKMK+z0DfTjvEKq4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WFNfFvWFyocrHsfYoZwEY/N6+pHjidDkvjnvAYBC8m5LB3rKuMdagsCft/qSyDG1G
	 Nxn5KKKs+UNs32xqHpxo2MxrDD3LMaymzg1ZjGko73i3AxyLPxQIEU57Uij/MW1OBr
	 jDCVoWb+aTmC5iZ6aoHgAqcDba2qjUv2Kb9ukZA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgD2CQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgD2CQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:16:07 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E7520730;
        Wed, 29 Apr 2020 02:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588126567;
        bh=XPRSra4YU5LgYp0Jl2N2h9TJHKIKMK+z0DfTjvEKq4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHISQqdxwa5G8CAirvaFShcr2ButdFkuOXnCWWMaOkbQcg8W++EwGIT5mxst7gAjo
         ErOXATSXEwfkR0BeuGYx7ZxCfY3NTmvTEeoLurS/3eYQryxo3yiAPrqMojA4dNOj4q
         VzZ+hGhBKuLNsnXOvSazC7WENPdQcLUNXLyVH0Ts=
Date:   Wed, 29 Apr 2020 10:16:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 08/13] dt-bindings: clocks: imx8mp: Add ids for
 audiomix clocks
Message-ID: <20200429020237.GG32592@dragon>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
 <1586937773-5836-9-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586937773-5836-9-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:02:48AM +0300, Abel Vesa wrote:
> Add all the clock ids for the audiomix clocks.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Applied, thanks.
