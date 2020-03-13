Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9C5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB2A20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCMMlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:41:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53264 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:41:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 905C727E99E
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 1/3] platform/chrome: notify: Add driver data struct
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     furquan@chromium.org, Benson Leung <bleung@chromium.org>
References: <20200312100809.21153-1-pmalani@chromium.org>
 <20200312100809.21153-2-pmalani@chromium.org>
Message-ID: <06d90fc3-c792-b85f-c4aa-923c5a7f5eea@collabora.com>
Date:   Fri, 13 Mar 2020 13:41:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312100809.21153-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 12/3/20 11:08, Prashant Malani wrote:
> Introduce a device driver data structure, cros_usbpd_notify_data, in
> which we can store the notifier block object and pointers to the struct
> cros_ec_device and struct device objects.
> 
> This will make it more convenient to access these pointers when
> executing both platform and ACPI callbacks.
> 
> While we are here, also add a dev_info print declaring successful device
> registration at the end of the platform probe function.
> 

This info can be obtained by other means, i.e function tracing or
initcall_debug. There is no need to repeat the same explicitly in the driver.

> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_usbpd_notify.c | 30 ++++++++++++++-------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> index 3851bbd6e9a39..edcb346024b07 100644
> --- a/drivers/platform/chrome/cros_usbpd_notify.c
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -16,6 +16,12 @@
>  
>  static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
>  
> +struct cros_usbpd_notify_data {
> +	struct device *dev;
> +	struct cros_ec_device *ec;
> +	struct notifier_block nb;
> +};
> +
>  /**
>   * cros_usbpd_register_notify - Register a notifier callback for PD events.
>   * @nb: Notifier block pointer to register
> @@ -98,23 +104,28 @@ static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> -	struct notifier_block *nb;
> +	struct cros_usbpd_notify_data *pdnotify;
>  	int ret;
>  
> -	nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> -	if (!nb)
> +	pdnotify = devm_kzalloc(dev, sizeof(*pdnotify), GFP_KERNEL);
> +	if (!pdnotify)
>  		return -ENOMEM;
>  
> -	nb->notifier_call = cros_usbpd_notify_plat;
> -	dev_set_drvdata(dev, nb);
> +	pdnotify->dev = dev;
> +	pdnotify->ec = ecdev->ec_dev;
> +	pdnotify->nb.notifier_call = cros_usbpd_notify_plat;
> +
> +	dev_set_drvdata(dev, pdnotify);
>  
>  	ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
> -					       nb);
> +					       &pdnotify->nb);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register notifier\n");
>  		return ret;
>  	}
>  
> +	dev_info(dev, "Chrome EC PD notify device registered.\n");
> +

This is only noise to the kernel log, remove it.

>  	return 0;
>  }
>  
> @@ -122,10 +133,11 @@ static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> -	struct notifier_block *nb =
> -		(struct notifier_block *)dev_get_drvdata(dev);
> +	struct cros_usbpd_notify_data *pdnotify =
> +		(struct cros_usbpd_notify_data *)dev_get_drvdata(dev);
>  
> -	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier, nb);
> +	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
> +					   &pdnotify->nb);
>  
>  	return 0;
>  }
> 
