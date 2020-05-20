Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A42C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444FA2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589936215;
	bh=Hy5gHGvZRPg1njiDXkxKfJSxprDz+YgRy8ChFWoLAcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gSBkWunsntFUVJyY6IAFdsE8ZKIZdHjoi9E3ATHSb1Sn/ibue1GubY+2ntPcpTzis
	 dzxWlzWrO+5HA0oXZdHjLEqMv+PWEvcUDr5IzMh7aNfv1X09GxZd8WglS2V331qCqt
	 4PYMyLnTndqQHu5xkikbCilhyAQtLAf3pr3mu6kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgETA4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgETA4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:56:54 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5814B20829;
        Wed, 20 May 2020 00:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589936213;
        bh=Hy5gHGvZRPg1njiDXkxKfJSxprDz+YgRy8ChFWoLAcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Liziulelwl882dZ/YkmzXxHxu0tMrl/admwNEYNpZ93OoTC1Ob9wzVzvsffrkYzAS
         3IHYeFUCRSiKngOHyuu/TBs2KsmN+TvAf5ktRitDbjPvzDNk/4eLVh8v6YtuxchYN+
         DKuTcK+YeD36oafP8DQkvoMY1dwq6+8OX2FsYE1U=
Date:   Wed, 20 May 2020 08:56:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, allison@lohutok.net, info@metux.net,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, git@andred.net,
        abel.vesa@nxp.com, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] ARM: imx: move cpu code to drivers/soc/imx
Message-ID: <20200520005638.GA11739@dragon>
References: <1588151843-2133-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588151843-2133-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 05:17:20PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Keep i.MX1/2/3/5 cpu type for completness
>  Correct return value in patch 1/3
>  use CONFIG_ARM to guard compile soc-imx.c in patch 3/3
> 
> V1:
> https://patchwork.kernel.org/cover/11433689/
> RFC version :
> https://patchwork.kernel.org/cover/11336433/
> 
> Nothing changed in v1, just rename to formal patches
> 
> Shawn,
>  The original concern has been eliminated in RFC discussion,
>  so this patchset is ready to be in next.
> Thanks.
> 
> Follow i.MX8, move the soc device register code to drivers/soc/imx
> to simplify arch/arm/mach-imx/cpu.c
> 
> I planned to use similar logic as soc-imx8m.c to restructure soc-imx.c
> and merged the two files into one. But not sure, so still keep
> the logic in cpu.c.
> 
> There is one change is the platform devices are not under
> /sys/devices/soc0 after patch 1/4. Actually ARM64 platform
> devices are not under /sys/devices/soc0, such as i.MX8/8M.
> So it should not hurt to let the platform devices under platform dir.
> 
> Peng Fan (3):
>   ARM: imx: use device_initcall for imx_soc_device_init
>   ARM: imx: move cpu definitions into a header
>   soc: imx: move cpu code to drivers/soc/imx

Applied all, thanks.
