Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C006FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D12B2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfzQwEPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404988AbgE1QVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404897AbgE1QV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:21:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B9EC08C5C6;
        Thu, 28 May 2020 09:21:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s69so3372640pjb.4;
        Thu, 28 May 2020 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/TpSOpPfjAbInsdXSzd/U+2hODYwIo/1iYj6MRPinM=;
        b=QfzQwEPE0RpsYmgH93NkSOgO3V9AI0YQ/4pn48P2DojE/h/s0DhE2LzVJ6+IrKAZ8p
         Rfnvqcstk9ffl7UjD2ZaZMFJGL7nU9heJEWLDPaHZ255wpYWE1QGJ/t8YefCNGKHdX57
         UQQJwlSJjBC3ZJdq5eGJxqTAYC6SE2vUNvdSNLnUDQJd+6Tg75T25Dv7qCPg0qu0573q
         qxGX7QmhcI48HMW31fZDwO0jJqSM4ca3iGAAtpuCC13qVupJmLxpXbmH+pVAN1kBhKFK
         NP95BpnxyseRoKySamZ2uHVWCuCnHBPCBeujR0NNL2h0HOKzgUlW5rH/F7icl/3LFiiN
         f7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/TpSOpPfjAbInsdXSzd/U+2hODYwIo/1iYj6MRPinM=;
        b=UnBnyDJoNUL7mbJ0tD+eanzJWbQ5/sV4h/A1Rfw4o6jhAgNrbkeOBtAlJm5RhfTQC3
         uF1cztiQ6mIlLLpnfcf9PaLo2JS3MYHZB45MyjNcdS6qq6CyIqenSu7WhT1U7PR8sIeQ
         HkZjZ17U9rkCX2Pse6sSskf0yYfKqcfSvPBt1F3ywMuXjJElZphgkOGLl8608mcgDv4o
         f/+vhmjCliskUrVe1CTeekxiH/rVtwtQgC9bazQbcRhxL2hvkZzh7WMAi0aVH1JUSa0C
         3TTahKteZDPSDSyXNBw+E5hZj3tqviwHrn9FktCav7MCOCbt/NX+clRrVdT42EwuXoKW
         noQQ==
X-Gm-Message-State: AOAM533gbroSe6Pca67cEu9GVY1JL9NDuu8+3GvBdIQqf1kbYr5/WpPF
        j9wJA545jEz279JsVQ6pz8k=
X-Google-Smtp-Source: ABdhPJwV14t//jxXUelYECJKutnWKd7KqibycvPEjfNPI/taOoEkCxjfskgxiTlxVktGTCt35MtFnA==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr4207451pls.85.1590682885642;
        Thu, 28 May 2020 09:21:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2sm5101977pfg.98.2020.05.28.09.21.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 May 2020 09:21:25 -0700 (PDT)
Date:   Thu, 28 May 2020 09:21:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org, groeck@chromium.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] usb: dwc3: of-simple: Add extcon support
Message-ID: <20200528162123.GA22568@roeck-us.net>
References: <20200523041201.75217-1-pmalani@chromium.org>
 <20200523041201.75217-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523041201.75217-2-pmalani@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 09:12:02PM -0700, Prashant Malani wrote:
> Add optional extcon notifier support to enable the hotplug / unplug of
> the underlying PHY layer devices.
> 
> If supported, the Device Tree (DT) node for the device should include an
> "extcon" property which is a phandle to an extcon DT node.
> 
> This patch is an effort to incorporate the equivalent support from the
> Rockchip dwc3 driver implementation from Chrome OS [1] to the mainline.
> 
> [1] : https://chromium.googlesource.com/chromiumos/third_party/kernel/
> +/refs/heads/chromeos-4.4/drivers/usb/dwc3/dwc3-rockchip.c
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Couple of nitpicks, otherwise

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 149 +++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index e64754be47b4..28bde27cd1f9 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -11,6 +11,7 @@
>   * by Subbaraya Sundeep Bhatta <subbaraya.sundeep.bhatta@xilinx.com>
>   */
>  
> +#include <linux/extcon.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -29,8 +30,117 @@ struct dwc3_of_simple {
>  	struct reset_control	*resets;
>  	bool			pulse_resets;
>  	bool			need_reset;
> +	struct extcon_dev	*edev;
> +	struct notifier_block	nb;
> +	struct work_struct	work;
> +	/* Denotes whether child devices have been populated. */
> +	bool			populated;
> +	bool			suspended;
> +	spinlock_t		suspend_lock;
>  };
>  
> +static int dwc3_of_simple_populate(struct dwc3_of_simple *simple)
> +{
> +	struct device *dev = simple->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	ret = of_platform_populate(np, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to populate dwc3 devices.\n");
> +		return ret;
> +	}
> +	simple->populated = true;
> +	return 0;
> +}
> +
> +static void dwc3_of_simple_depopulate(struct dwc3_of_simple *simple)
> +{
> +	if (simple->populated) {
> +		of_platform_depopulate(simple->dev);
> +		simple->populated = false;
> +	}
> +}
> +
> +static void dwc3_of_simple_work(struct work_struct *work)
> +{
> +	struct dwc3_of_simple *simple = container_of(work,
> +					struct dwc3_of_simple, work);
> +	struct extcon_dev *edev = simple->edev;
> +
> +	if (extcon_get_state(edev, EXTCON_USB_HOST) > 0) {
> +		if (simple->populated)
> +			return;
> +
> +		dwc3_of_simple_populate(simple);
> +	} else {
> +		if (!simple->populated)
> +			return;
> +
> +		dwc3_of_simple_depopulate(simple);
> +	}
> +}
> +
> +static int dwc3_of_simple_notifier(struct notifier_block *nb,
> +			      unsigned long event, void *ptr)

Multi-line alignment is off.

> +{
> +	struct dwc3_of_simple *simple = container_of(nb, struct dwc3_of_simple,
> +						nb);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&simple->suspend_lock, flags);
> +	if (!simple->suspended)
> +		schedule_work(&simple->work);
> +	spin_unlock_irqrestore(&simple->suspend_lock, flags);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int dwc3_of_simple_extcon_register(struct dwc3_of_simple *simple)
> +{
> +	struct device		*dev = simple->dev;
> +	struct extcon_dev	*edev;
> +	int			ret;
> +
> +	edev = extcon_get_edev_by_phandle(dev, 0);
> +	if (IS_ERR(edev)) {
> +		/* The extcon property is optional. */
> +		if (PTR_ERR(edev) == -ENODEV)
> +			return 0;
> +		if (PTR_ERR(edev) != -EPROBE_DEFER)
> +			dev_err(dev, "Couldn't get extcon device.\n");
> +		return PTR_ERR(edev);
> +	}
> +
> +	INIT_WORK(&simple->work, dwc3_of_simple_work);
> +
> +	simple->nb.notifier_call = dwc3_of_simple_notifier;
> +	ret = devm_extcon_register_notifier(dev, edev, EXTCON_USB_HOST,
> +					&simple->nb);

Same here.

> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register notifier.\n");
> +		return ret;
> +	}
> +
> +	simple->edev = edev;
> +
> +	return 0;
> +}
> +
> +static void dwc3_of_simple_extcon_unregister(struct dwc3_of_simple *simple)
> +{
> +	if (!simple->edev)
> +		return;
> +
> +	/*
> +	 * We explicitly unregister the notifier to prevent races with
> +	 * the of_depopulate() call in remove().
> +	 */
> +	devm_extcon_unregister_notifier(simple->dev, simple->edev,
> +					EXTCON_USB_HOST, &simple->nb);
> +	cancel_work_sync(&simple->work);
> +}
> +
>  static int dwc3_of_simple_probe(struct platform_device *pdev)
>  {
>  	struct dwc3_of_simple	*simple;
> @@ -47,6 +157,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, simple);
>  	simple->dev = dev;
>  
> +	spin_lock_init(&simple->suspend_lock);
> +
>  	/*
>  	 * Some controllers need to toggle the usb3-otg reset before trying to
>  	 * initialize the PHY, otherwise the PHY times out.
> @@ -87,9 +199,24 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_resetc_assert;
>  
> -	ret = of_platform_populate(np, NULL, NULL, dev);
> -	if (ret)
> +	ret = dwc3_of_simple_extcon_register(simple);
> +	if (ret < 0) {
> +		dev_warn(dev, "No extcon device found, err: %d\n", ret);
>  		goto err_clk_put;
> +	}
> +
> +	if (!simple->edev) {
> +		ret = dwc3_of_simple_populate(simple);
> +		if (ret)
> +			goto err_clk_put;
> +	} else {
> +		/*
> +		 * Populate through worker to avoid race conditions against
> +		 * action scheduled through notifier.
> +		 */
> +		if (extcon_get_state(simple->edev, EXTCON_USB_HOST) > 0)
> +			schedule_work(&simple->work);
> +	}
>  
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> @@ -112,7 +239,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  
>  static void __dwc3_of_simple_teardown(struct dwc3_of_simple *simple)
>  {
> -	of_platform_depopulate(simple->dev);
> +	dwc3_of_simple_extcon_unregister(simple);
> +	dwc3_of_simple_depopulate(simple);
>  
>  	clk_bulk_disable_unprepare(simple->num_clocks, simple->clks);
>  	clk_bulk_put_all(simple->num_clocks, simple->clks);
> @@ -163,6 +291,13 @@ static int __maybe_unused dwc3_of_simple_runtime_resume(struct device *dev)
>  static int __maybe_unused dwc3_of_simple_suspend(struct device *dev)
>  {
>  	struct dwc3_of_simple *simple = dev_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&simple->suspend_lock, flags);
> +	simple->suspended = true;
> +	spin_unlock_irqrestore(&simple->suspend_lock, flags);
> +
> +	cancel_work_sync(&simple->work);
>  
>  	if (simple->need_reset)
>  		reset_control_assert(simple->resets);
> @@ -173,10 +308,18 @@ static int __maybe_unused dwc3_of_simple_suspend(struct device *dev)
>  static int __maybe_unused dwc3_of_simple_resume(struct device *dev)
>  {
>  	struct dwc3_of_simple *simple = dev_get_drvdata(dev);
> +	unsigned long flags;
>  
>  	if (simple->need_reset)
>  		reset_control_deassert(simple->resets);
>  
> +	spin_lock_irqsave(&simple->suspend_lock, flags);
> +	simple->suspended = false;
> +	spin_unlock_irqrestore(&simple->suspend_lock, flags);
> +
> +	if (simple->edev)
> +		schedule_work(&simple->work);
> +
>  	return 0;
>  }
>  
