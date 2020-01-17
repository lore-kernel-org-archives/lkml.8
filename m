Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698FCC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394C820663
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="b/n+rnpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgAQUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:15:48 -0500
Received: from first.geanix.com ([116.203.34.67]:55076 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgAQUPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:15:48 -0500
Received: from localhost (87-49-44-45-mobile.dk.customer.tdc.net [87.49.44.45])
        by first.geanix.com (Postfix) with ESMTPSA id 8A681AB7CF;
        Fri, 17 Jan 2020 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1579292096; bh=NyD2V5SZSfQVTYmJ6N+L70KBjajwnojRIy5BahhEoVQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=b/n+rnpA3v2O8rwAeqUqPDB/3pEwDc8aT2Fzok20ORw+bUJDTkgOWQJHZ3Eb86Nia
         h98IRvImFLnZ3NQRetCb6D/15fc32Ni9LV793Q5O3DKiP92rHDevyMv5bwJLFN0Ta6
         ctOCLIZmzJBbNrwj5Z2qa7uSVgnhjj37BGjVLtTy5oUdnotiRsWizk+MAELt9JT9KH
         GFdOjdO64TpbS+k62YS0jqpEbH46IEswdqmK+kaLNugVhwRmefu4zDFGZCI48g0Lsf
         W4gUgVPD8KoWVI0J28kJEVZhPwjJMfaGqologNqBxhwXb0FMrHeMhgdOTg9/hJ2g9S
         as4l4hd/ssMvQ==
From:   Esben Haabendal <esben@geanix.com>
To:     Han Xu <han.xu@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mtd: rawnand: gpmi: set the pinctrl state for suspend/reusme
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
        <1579038243-28550-7-git-send-email-han.xu@nxp.com>
Date:   Fri, 17 Jan 2020 21:15:44 +0100
In-Reply-To: <1579038243-28550-7-git-send-email-han.xu@nxp.com> (Han Xu's
        message of "Wed, 15 Jan 2020 05:44:03 +0800")
Message-ID: <87wo9pvnyn.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Han Xu <han.xu@nxp.com> writes:

> set the correct pinctrl state in system pm suspend/resume ops
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 73644c96fa9b..de1e3dbb2eb1 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/dma/mxs-dma.h>
>  #include "gpmi-nand.h"
>  #include "gpmi-regs.h"
> @@ -2692,6 +2693,7 @@ static int gpmi_pm_suspend(struct device *dev)
>  {
>  	int ret;
>  
> +	pinctrl_pm_select_sleep_state(dev);
>  	ret = pm_runtime_force_suspend(dev);
>  
>  	return ret;
> @@ -2708,6 +2710,8 @@ static int gpmi_pm_resume(struct device *dev)
>  		return ret;
>  	}
>  
> +	pinctrl_pm_select_default_state(dev);
> +
>  	/* re-init the GPMI registers */
>  	ret = gpmi_init(this);
>  	if (ret) {

Acked-by: Esben Haabendal <esben@geanix.com>
