Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8497C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D96620768
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599484265;
	bh=plJYBTK5bUNxyxURzDCboq7ma2r5yOFIVgai1JrZhl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=THyxv9OsIcJjAr7S27IX0rs46e3kNW2CYp3UafUqkxXaM0rE4MN9CjbGvoUPidPQw
	 WEsPBu6tUbJCOe0Zmw/gEldNh/Zb8dKBZag24A/fVnfWaTYsJ4CRlma5cul1sQiey5
	 p0LKqG0fQ7n1jpa8ctkM30K3m7yO6DkIdvsSlNb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgIGNK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbgIGNGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:06:39 -0400
Received: from coco.lan (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE722166E;
        Mon,  7 Sep 2020 13:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599483998;
        bh=plJYBTK5bUNxyxURzDCboq7ma2r5yOFIVgai1JrZhl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mjQ7fmAG8j41NK4PC9LP/LDYfnLgHl5FoTrO3Rnj7J/aH6Yl3nkQstzwtEadHarbn
         +GsSF9ViYV51wGytn7dmXXxtUyipWlqAN+3Q9dQHEaj8dkaXYKji0n8Muy5n6Ns/nH
         bpZX+LFvxIx0f9aV/TdfJXHus5+lq1XvA8MQdfvY=
Date:   Mon, 7 Sep 2020 15:06:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Yu Chen <chenyu56@huawei.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 04/13] usb: dwc3: Add splitdisable quirk for
 Hisilicon Kirin Soc
Message-ID: <20200907150631.70e1bce0@coco.lan>
In-Reply-To: <20190420064019.57522-5-chenyu56@huawei.com>
References: <20190420064019.57522-1-chenyu56@huawei.com>
        <20190420064019.57522-5-chenyu56@huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe/Greg,

What's the status of this patch? 

I tested here, together with the Hikey 970 phy RFC patches I sent
last week.

Without this patch, the USB HID driver receives -EPROTO from
submitted URBs, causing it to enter into an endless reset cycle
on every 500 ms, at the hid_io_error() logic.

Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

If you prefer, I can re-submit this one with my SOB.

Thanks,
Mauro

Em Sat, 20 Apr 2019 14:40:10 +0800
Yu Chen <chenyu56@huawei.com> escreveu:

> SPLIT_BOUNDARY_DISABLE should be set for DesignWare USB3 DRD Core
> of Hisilicon Kirin Soc when dwc3 core act as host.
> 
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v4:
> * Add dwc3_complete definition while CONFIG_PM_SLEEP does not defined.
> * Add description for 'dis_split_quirk'.
> ---
> ---
>  drivers/usb/dwc3/core.c | 26 ++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |  7 +++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a1b126f90261..c3ef6bd2b0d4 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -117,6 +117,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  	struct dwc3 *dwc = work_to_dwc(work);
>  	unsigned long flags;
>  	int ret;
> +	u32 reg;
>  
>  	if (dwc->dr_mode != USB_DR_MODE_OTG)
>  		return;
> @@ -169,6 +170,11 @@ static void __dwc3_set_mode(struct work_struct *work)
>  			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>  			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>  			phy_calibrate(dwc->usb2_generic_phy);
> +			if (dwc->dis_split_quirk) {
> +				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
> +				reg |= DWC3_GUCTL3_SPLITDISABLE;
> +				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
> +			}
>  		}
>  		break;
>  	case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -1306,6 +1312,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	dwc->dis_metastability_quirk = device_property_read_bool(dev,
>  				"snps,dis_metastability_quirk");
>  
> +	dwc->dis_split_quirk = device_property_read_bool(dev,
> +				"snps,dis-split-quirk");
> +
>  	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>  	dwc->tx_de_emphasis = tx_de_emphasis;
>  
> @@ -1825,10 +1834,27 @@ static int dwc3_resume(struct device *dev)
>  
>  	return 0;
>  }
> +
> +static void dwc3_complete(struct device *dev)
> +{
> +	struct dwc3	*dwc = dev_get_drvdata(dev);
> +	u32		reg;
> +
> +	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
> +			dwc->dis_split_quirk) {
> +		dev_dbg(dwc->dev, "set DWC3_GUCTL3_SPLITDISABLE\n");
> +		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
> +		reg |= DWC3_GUCTL3_SPLITDISABLE;
> +		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
> +	}
> +}
> +#else
> +#define dwc3_complete NULL
>  #endif /* CONFIG_PM_SLEEP */
>  
>  static const struct dev_pm_ops dwc3_dev_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
> +	.complete = dwc3_complete,
>  	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
>  			dwc3_runtime_idle)
>  };
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 1528d395b156..28475e301ad9 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -136,6 +136,7 @@
>  #define DWC3_GEVNTCOUNT(n)	(0xc40c + ((n) * 0x10))
>  
>  #define DWC3_GHWPARAMS8		0xc600
> +#define DWC3_GUCTL3		0xc60c
>  #define DWC3_GFLADJ		0xc630
>  
>  /* Device Registers */
> @@ -370,6 +371,9 @@
>  /* Global User Control Register 2 */
>  #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
>  
> +/* Global User Control Register 3 */
> +#define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
> +
>  /* Device Configuration Register */
>  #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
>  #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
> @@ -1030,6 +1034,7 @@ struct dwc3_scratchpad_array {
>   * 	2	- No de-emphasis
>   * 	3	- Reserved
>   * @dis_metastability_quirk: set to disable metastability quirk.
> + * @dis_split_quirk: set to disable split boundary.
>   * @imod_interval: set the interrupt moderation interval in 250ns
>   *                 increments or 0 to disable.
>   */
> @@ -1216,6 +1221,8 @@ struct dwc3 {
>  
>  	unsigned		dis_metastability_quirk:1;
>  
> +	unsigned		dis_split_quirk:1;
> +
>  	u16			imod_interval;
>  };
>  



Thanks,
Mauro
