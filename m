Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4D6C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBCD20825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598071145;
	bh=u0ARyHoe/q0GF5AUrK5En0djwtUiP/IUJLs7gd5smHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jp9uiF0f0j83Zsoh7upfc8jVDqGYcRlAOsJmGsogEW+t2Ek5hFC3xNip0EToWGuyn
	 zlUGoeFnH8kuNptGTGLFaRuJrwHIvSn8UYNL8KC1dJuN+FDf4zzClKtYBGY4N5GlrX
	 BTQB5CgcDSdkz8RwnW4zYw4QFRVBSjXk0HSZ1n8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgHVEjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgHVEjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:39:03 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB9420720;
        Sat, 22 Aug 2020 04:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598071142;
        bh=u0ARyHoe/q0GF5AUrK5En0djwtUiP/IUJLs7gd5smHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivXyupBicmYnhkyJ4QjTa+EJuNcACyQJ1wc8vV1N/R3vm0AT9JaJ2uC+5wegLetxd
         MFFhEmJfiNIDpLwsIHJWI13VZX8fmIMvYHT3gtiWw4TlT/XiFFTVjYDYnTzH0qGi7k
         7Phu/exZ3JiYgy3gf4igNt4dr1dX2CuX54rkW7n0=
Date:   Sat, 22 Aug 2020 12:38:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        arnd@arndb.de, peng.fan@nxp.com, abel.vesa@nxp.com,
        fugang.duan@nxp.com, daniel.baluta@nxp.com, yuehaibing@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V9 0/6] Support building i.MX ARMv8 platforms clock
 driver as module
Message-ID: <20200822043847.GE27575@dragon>
References: <1596072174-16358-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596072174-16358-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:22:48AM +0800, Anson Huang wrote:
> Nowdays, there are more and more requirements of building SoC specific drivers as
> modules, such as Android GKI (generic kernel image), this patch set supports building
> i.MX ARMv8 SoCs clock drivers as modules,
> 
> The CLK_IMXxxx is introduced for i.MX ARMv7 platforms in order to make the build options
> aligned, the reason why i.MX ARMv7 platforms clock driver do NOT support module build
> and COMPILE_TEST is because, some drivers like i.MX GPT timer driver depends on clock
> driver to be ready before it, GPT driver uses TIMER_OF_DECLARE(), while i.MX6/7 clock
> drivers use CLK_OF_DECLARE(), and GPT driver is critical for i.MX6/7 platforms kernel
> boot up, so GPT driver needs to be changed to support loadable clock driver first,
> then the i.MX6/7 clock drivers can support loadable module, this will be done later.
> 
> Changes since V8:
> 	- explicitly include linux/bits.h in patch #1.
> 
> Anson Huang (6):
>   clk: imx6sl: Use BIT(x) to avoid shifting signed 32-bit value by 31
>     bits
>   clk: composite: Export clk_hw_register_composite()
>   clk: imx: Support building i.MX common clock driver as module
>   clk: imx: Add clock configuration for ARMv7 platforms
>   clk: imx8m: Support module build
>   clk: imx8qxp: Support building i.MX8QXP clock driver as module

Applied all, thanks.
