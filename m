Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FEEC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D79F222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583917615;
	bh=bl70ZTDTBge6jnrLfGymPXU8SZtUF9eRxaWa5J+K1hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gZDTJK3iCy2qaHBh8QFg3Ez+Drde0Jzob5Rpw4J0vvkjOICnhQQZ/VKiCMWNSkGSZ
	 70Du0l473VQIqzWBmUNPvEDdaKugdBrydp36YK+Yi4rxWdOz/+w8OeLqq+wB17XhPM
	 6M+wiDxTANAfdCzDxbXTd70OQ0LLwVKV+qRutjB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgCKJGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:06:53 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBDE2192A;
        Wed, 11 Mar 2020 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583917612;
        bh=bl70ZTDTBge6jnrLfGymPXU8SZtUF9eRxaWa5J+K1hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNw2LHdEFw/xpNtVwu2diZ3DRw+K+MH0wUGaGW/1+kXqIiJdFyOFWYI0OSfjRWrn4
         vifhKaDjZQLTumfVGM1bpw1aX1cX0RjsO0y51ws7FEH7Gu2kKgDcjROJ6oRdOFpx2M
         504YdyX1JF09LzSjpbqvzLlFrbzOv+SAWxGDa2MA=
Date:   Wed, 11 Mar 2020 17:06:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] drivers: soc: Fix COMPILE_TEST for IMX SCU
Message-ID: <20200311090646.GJ29269@dragon>
References: <20200306113119.56577-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306113119.56577-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 11:31:19AM +0000, Vincenzo Frascino wrote:
> IMX SCU SoCs support COMPILE_TEST that allows to compile the driver on a
> different platform for development purposes.
> These SoCs depend on a firmware interface that is not built on COMPILE_TEST
> mode. This results in triggering the following errors at compile time (on
> arm64):
> 
> aarch64-none-linux-gnu-ld:
> drivers/soc/imx/soc-imx-scu.o: in function `imx_scu_soc_probe':
> soc-imx-scu.c:(.text+0x24): undefined reference to `imx_scu_get_handle'
> aarch64-none-linux-gnu-ld:
> soc-imx-scu.c:(.text+0xac): undefined reference to `imx_scu_call_rpc'
> aarch64-none-linux-gnu-ld:
> soc-imx-scu.c:(.text+0xd8): undefined reference to `imx_scu_call_rpc'
> linux/Makefile:1078: recipe for target 'vmlinux' failed
> make[1]: *** [vmlinux] Error 1
> Makefile:180: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> 
> Enable the relevant compilation units in the Makefile when the config option
> is selected to address the issue.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks for the patch.  But we already queued Peng's version [1].

Shawn

[1] https://www.spinics.net/lists/arm-kernel/msg787548.html
