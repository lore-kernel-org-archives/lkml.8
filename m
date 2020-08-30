Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B56CC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFDD207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598793319;
	bh=L0UEGoE0XoSNof1CQ/i74GslohOVgHMvBPV1kDOSfnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=THke+/ADru9TM9lbnoND4O0pI5ButdSc2t4w+4CC5KnMV/iRIN+yXCiToWUTvmcP4
	 0n3ddaa5PZrQ0J8lwinJr4869fYhQaFYAs6Xck+sQ9I8GKCqORWuy4y4iF9Ew/SzJl
	 caf/7lhHZKVodrN8FugL8tfKYPcQIxkG+k/C0P1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgH3NPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgH3NPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:15:08 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A6F20757;
        Sun, 30 Aug 2020 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598793308;
        bh=L0UEGoE0XoSNof1CQ/i74GslohOVgHMvBPV1kDOSfnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOsVjxFZfIg3lmX6HYHO4XnTxB1AmjIMBHVW9wIhWgdRFAlvmOTZEiEohhDB0fnhM
         Vj3IHebJ8V227P9Mas3YeSwE63uuNRMbV1i/wsdVZ8zJLjgRp0IwlyKWT2TQ4UJ0pH
         yNd8Hd2zn5RR+RfqgSMvi1ZrxaFFfqTKHz/QJZGk=
Date:   Sun, 30 Aug 2020 21:15:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@puri.sm, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        mchehab@kernel.org, Anson.Huang@nxp.com, agx@sigxcpu.org,
        angus@akkea.ca, broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/3] MAINTAINERS: Add Purism Librem 5 section to the
 list
Message-ID: <20200830131459.GL32096@dragon>
References: <20200821121755.24599-1-martin.kepplinger@puri.sm>
 <20200821121755.24599-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821121755.24599-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 02:17:54PM +0200, Martin Kepplinger wrote:
> Add development information for the devicetree files for hardware
> by Purism SPC.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

I decided to drop this patch from my queue, as I took the suggestion
from Joe and sent a patch to have get_maintainer report email address
in the dts file.

Shawn

[1] https://lkml.org/lkml/2020/8/30/118

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac79fdbdf8d0..70a09eb3e6d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14061,6 +14061,13 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/admin-guide/media/pulse8-cec.rst
>  F:	drivers/media/cec/usb/pulse8/
>  
> +PURISM LIBREM 5
> +M:	Purism Kernel Team <kernel@puri.sm>
> +S:	Supported
> +B:	https://source.puri.sm/Librem5/linux-next/issues
> +T:	https://source.puri.sm/Librem5/linux-next
> +F:	arch/arm64/boot/dts/freescale/imx8mq-librem5*
> +
>  PVRUSB2 VIDEO4LINUX DRIVER
>  M:	Mike Isely <isely@pobox.com>
>  L:	pvrusb2@isely.net	(subscribers-only)
> -- 
> 2.20.1
> 
