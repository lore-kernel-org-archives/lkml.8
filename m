Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B44C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E2F2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594878657;
	bh=K5M9VEUTLX2kdCyJTiXSp+ySzNwauaOQDdXxsbEw4Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xFyIKtZtMFPApu99igAnL/gtgS79O2iDm+RMA9ucbnMfhJypLo3MKM2vgbZaT9z8I
	 qRfXT7uQmi+R3OqRr1rf1Gna9m4iiGENXycKSycqxiJl/x0YjrZSjAdaSD98F5jgRs
	 h0OzKbg6NTHh2zg3o7SmUZwQUszFNtYACFlO5vvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGPFu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgGPFuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:50:55 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5122065E;
        Thu, 16 Jul 2020 05:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594878655;
        bh=K5M9VEUTLX2kdCyJTiXSp+ySzNwauaOQDdXxsbEw4Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juZS0NKwsR33k8Y4iWXZk8HbFaogclJ9Cw5A9iVAP32qqQG4Unc1rqMDeuesHXXQc
         WfRrqJAYpIBDMBSmaOLVp7vHEFdDlHXzanW6eW0Nb3vNuFUfzjmYgYh2EcQIHvtNs2
         rhejvi6M+Qshdsw1P7jATHZ7BUqn8U+VoZ9CBWWw=
Date:   Thu, 16 Jul 2020 11:20:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4] phy: samsung: Use readl_poll_timeout function
Message-ID: <20200716055050.GE55478@vkoul-mobl>
References: <20200713074243.530-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713074243.530-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-20, 07:42, Anand Moon wrote:
> Instead of a busy waiting while loop using udelay
> use readl_poll_timeout function to check the condition
> is met or timeout occurs in crport_handshake function.
> readl_poll_timeout is called in non atomic context so
> it safe to sleep until the condition is met.
> 
> Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes v4:
> Rebased on to of patch [0] https://patchwork.kernel.org/patch/11651673/
> --Fix the commit message.
> --Fix the error timeout condition for -ETIMEDOUT
> ---
> Changes v3:
> --Fix the commit message.
> --Drop the variable, used the value directly.
> Changes v2:
> --used the default timeout values.
> --Added missing Fixed tags.
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 39 ++++++++----------------
>  1 file changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 7f6279fb4f8f..ad81aa65cdff 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/iopoll.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
> @@ -556,41 +557,25 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
>  static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
>  			    u32 val, u32 cmd)
>  {
> -	u32 usec = 100;
>  	unsigned int result;
> +	int err;
>  
>  	writel(val | cmd, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
>  
> -	do {
> -		result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
> -		if (result & PHYREG1_CR_ACK)
> -			break;
> -
> -		udelay(1);
> -	} while (usec-- > 0);
> -
> -	if (!usec) {
> -		dev_err(phy_drd->dev,
> -			"CRPORT handshake timeout1 (0x%08x)\n", val);
> -		return -ETIME;
> +	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
> +			result,	(result & PHYREG1_CR_ACK), 1, 100);

pls align this line to opening brace of preceding line:

        err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
                                 result, (result & PHYREG1_CR_ACK), 1, 100);

This is recommended way of splitting lines, see
Documentation/process/coding-style.rst and run checkpatch.pl with
--strict option

thanks
-- 
~Vinod
