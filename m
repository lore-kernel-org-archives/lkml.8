Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E798C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E203B20674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXUrQE/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGOCgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOCgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:36:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83900C061755;
        Tue, 14 Jul 2020 19:36:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so1394815pgq.1;
        Tue, 14 Jul 2020 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1h8x5iFBVrI2txisetzzFlVtAcx/qnoB0Daw9m0+hj0=;
        b=vXUrQE/FgaTWsuEuCFEqQKUbC9oDuHTf0mVRxKrtG0m2wp06nnnoy33KpwkV2OISeq
         Oq8P7WuOE7Dbi8DWHG+myh/jgVJTp500qEiCBZU8tcGk2MKLViB0F1+S0jSv7kfoEMos
         R0gVp2TFbBRD3Y4wgFiO1Kv3F3yJjR9NiJeaBCZ9724wFWgq4Z4Dk4pPltrcY1eOkPpg
         uSWf5Q9Q4S//glbzUjwHLz1yQf3roA86qC60zt+lE3vDxi82EpIzeUlYd4pK2lUJeQvp
         Zxpj19V5p7gsS+mToXqvfebustyyTIkf8g0sUyIEfz1I52f18sEmYxXu9YX1Sn2zWsIi
         iFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1h8x5iFBVrI2txisetzzFlVtAcx/qnoB0Daw9m0+hj0=;
        b=OiK/3hmil3SaKzVXH09G3ri8MSB/VHZ6RYXkc/smT96Vcs0a+l6N71fNw/DUPXuxD0
         SAD/BNqBLrB7jAUSQXLcJibFyUJ8PjmoE329CCFWgSplLBG2ollMA3XbPwquonBHqvAh
         6UJhIKxkNf16wNP7WdeXNk977oS1WBnEI99CEHA1nQhz0A5noTcBgnrnkzW/pwhnYWy1
         4Sq08BiN87aXiLTpRQE/vb3vApv/cx88VGWA77UGxLEMP44erDtgxWK3bWjdyk8AhT/F
         htxpLyFvaeo0u3L6C7pka8OjmBZ6xTz702d755fFmoVcQe+RktN8Jp1Tnsk0Sl8cluEs
         XR/w==
X-Gm-Message-State: AOAM532TfkOC3mAWrvtEvzBKUi4LfJcKdIwzXuvQEORHkhqmKBVk4ZWx
        WGaonTskMIwz4q2E8UD5JHY=
X-Google-Smtp-Source: ABdhPJwlwny00gTNKe9Qnmz9IUlogsrmnbJAKGTpNyb0Nqhhh36ZxSwGmS8+y2p7Ea97ifyXd+lyBg==
X-Received: by 2002:a63:8ec8:: with SMTP id k191mr5972710pge.154.1594780583996;
        Tue, 14 Jul 2020 19:36:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n12sm381055pgr.88.2020.07.14.19.36.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:36:23 -0700 (PDT)
Date:   Tue, 14 Jul 2020 19:36:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-cpro: Change to hid driver
Message-ID: <20200715023622.GA164279@roeck-us.net>
References: <20200714105230.3126-1-mail@mariuszachmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714105230.3126-1-mail@mariuszachmann.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:52:30PM +0200, Marius Zachmann wrote:
> I found a project which uses hidraw to communicate with the device.
> Because I do not want to break any existing userspace code, I
> changed this to a hid driver, so hidraw can still be used.
> Do I need to include the hid maintainers for the undo in hid-quirks?
> 
That changelog needs some improvements. It should state what change
was made, and why, but not include any questions or personal statements
such as "I found ...".

You never really explained why you had changed the driver from hid to
usb. Maybe you can explain that decision now ?

Thanks,
Guenter

> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> ---
>  drivers/hid/hid-quirks.c     |   2 -
>  drivers/hwmon/Kconfig        |   4 +-
>  drivers/hwmon/corsair-cpro.c | 114 ++++++++++++++++++++++++++---------
>  3 files changed, 86 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 7b7bc7737c53..ca8b5c261c7c 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -699,8 +699,6 @@ static const struct hid_device_id hid_ignore_list[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AXENTIA, USB_DEVICE_ID_AXENTIA_FM_RADIO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, 0x0c10) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, 0x1d00) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI4713) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM109) },
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8b046a5dfa40..c603d8c8e3d2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -441,7 +441,7 @@ config SENSORS_BT1_PVT_ALARMS
> 
>  config SENSORS_CORSAIR_CPRO
>  	tristate "Corsair Commander Pro controller"
> -	depends on USB
> +	depends on HID
>  	help
>  	  If you say yes here you get support for the Corsair Commander Pro
>  	  controller.
> @@ -1716,7 +1716,7 @@ config SENSORS_ADS7871
> 
>  config SENSORS_AMC6821
>  	tristate "Texas Instruments AMC6821"
> -	depends on I2C
> +	depends on I2C
>  	help
>  	  If you say yes here you get support for the Texas Instruments
>  	  AMC6821 hardware monitoring chips.
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index fe625190e3a1..4310ee5aca24 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -5,13 +5,14 @@
>   */
> 
>  #include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/hid.h>
>  #include <linux/hwmon.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> -#include <linux/usb.h>
> 
>  #define USB_VENDOR_ID_CORSAIR			0x1b1c
>  #define USB_PRODUCT_ID_CORSAIR_COMMANDERPRO	0x0c10
> @@ -62,7 +63,8 @@
>  #define NUM_TEMP_SENSORS	4
> 
>  struct ccp_device {
> -	struct usb_device *udev;
> +	struct hid_device *hdev;
> +	struct completion wait_input_report;
>  	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
>  	u8 *buffer;
>  	int pwm[6];
> @@ -75,7 +77,7 @@ struct ccp_device {
>  /* send command, check for error in response, response in ccp->buffer */
>  static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2, u8 byte3)
>  {
> -	int actual_length;
> +	unsigned long t;
>  	int ret;
> 
>  	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> @@ -84,26 +86,39 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
>  	ccp->buffer[2] = byte2;
>  	ccp->buffer[3] = byte3;
> 
> -	ret = usb_bulk_msg(ccp->udev, usb_sndintpipe(ccp->udev, 2), ccp->buffer, OUT_BUFFER_SIZE,
> -			   &actual_length, 1000);
> -	if (ret)
> -		return ret;
> +	reinit_completion(&ccp->wait_input_report);
> 
> -	/* response needs to be received every time */
> -	ret = usb_bulk_msg(ccp->udev, usb_rcvintpipe(ccp->udev, 1), ccp->buffer, IN_BUFFER_SIZE,
> -			   &actual_length, 1000);
> -	if (ret)
> +	ret = hid_hw_output_report(ccp->hdev, ccp->buffer, OUT_BUFFER_SIZE);
> +	if (ret < 0)
>  		return ret;
> 
> +	t = wait_for_completion_timeout(&ccp->wait_input_report, msecs_to_jiffies(300));
> +	if (!t)
> +		return -ETIMEDOUT;
> +
>  	/* first byte of response is error code */
>  	if (ccp->buffer[0] != 0x00) {
> -		dev_dbg(&ccp->udev->dev, "device response error: %d", ccp->buffer[0]);
> +		hid_dbg(ccp->hdev, "device response error: %d", ccp->buffer[0]);
>  		return -EIO;
>  	}
> 
>  	return 0;
>  }
> 
> +static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
> +{
> +	struct ccp_device *ccp = hid_get_drvdata(hdev);
> +
> +	/* only copy buffer when requested */
> +	if (completion_done(&ccp->wait_input_report))
> +		return 0;
> +
> +	memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
> +	complete(&ccp->wait_input_report);
> +
> +	return 0;
> +}
> +
>  /* requests and returns single data values depending on channel */
>  static int get_data(struct ccp_device *ccp, int command, int channel)
>  {
> @@ -437,57 +452,96 @@ static int get_temp_cnct(struct ccp_device *ccp)
>  	return 0;
>  }
> 
> -static int ccp_probe(struct usb_interface *intf, const struct usb_device_id *id)
> +static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
>  	struct device *hwmon_dev;
>  	struct ccp_device *ccp;
>  	int ret;
> 
> -	ccp = devm_kzalloc(&intf->dev, sizeof(*ccp), GFP_KERNEL);
> +	ccp = devm_kzalloc(&hdev->dev, sizeof(*ccp), GFP_KERNEL);
>  	if (!ccp)
>  		return -ENOMEM;
> 
> -	ccp->buffer = devm_kmalloc(&intf->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
> +	ccp->buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
>  	if (!ccp->buffer)
>  		return -ENOMEM;
> 
> +	ret = hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> +	if (ret)
> +		return ret;
> +
> +	ret = hid_hw_open(hdev);
> +	if (ret)
> +		goto out_hw_stop;
> +
> +	ccp->hdev = hdev;
> +	hid_set_drvdata(hdev, ccp);
>  	mutex_init(&ccp->mutex);
> +	init_completion(&ccp->wait_input_report);
> 
> -	ccp->udev = interface_to_usbdev(intf);
> +	hid_device_io_start(hdev);
> 
>  	/* temp and fan connection status only updates when device is powered on */
>  	ret = get_temp_cnct(ccp);
>  	if (ret)
> -		return ret;
> +		goto out_hw_close;
> 
>  	ret = get_fan_cnct(ccp);
>  	if (ret)
> -		return ret;
> -
> -	hwmon_dev = devm_hwmon_device_register_with_info(&intf->dev, "corsaircpro", ccp,
> +		goto out_hw_close;
> +	hwmon_dev = devm_hwmon_device_register_with_info(&hdev->dev, "corsaircpro", ccp,
>  							 &ccp_chip_info, 0);
> +	if (IS_ERR(hwmon_dev)) {
> +		ret = PTR_ERR(hwmon_dev);
> +		goto out_hw_close;
> +	}
> +
> +	return 0;
> 
> -	return PTR_ERR_OR_ZERO(hwmon_dev);
> +out_hw_close:
> +	hid_hw_close(hdev);
> +out_hw_stop:
> +	hid_hw_stop(hdev);
> +	return ret;
>  }
> 
> -static void ccp_disconnect(struct usb_interface *intf)
> +static void ccp_remove(struct hid_device *hdev)
>  {
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
>  }
> 
> -static const struct usb_device_id ccp_devices[] = {
> -	{ USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_COMMANDERPRO) },
> -	{ USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_1000D) },
> +static const struct hid_device_id ccp_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_COMMANDERPRO) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_1000D) },
>  	{ }
>  };
> 
> -static struct usb_driver ccp_driver = {
> +static struct hid_driver ccp_driver = {
>  	.name = "corsair-cpro",
> +	.id_table = ccp_devices,
>  	.probe = ccp_probe,
> -	.disconnect = ccp_disconnect,
> -	.id_table = ccp_devices
> +	.remove = ccp_remove,
> +	.raw_event = ccp_raw_event,
>  };
> 
> -MODULE_DEVICE_TABLE(usb, ccp_devices);
> +MODULE_DEVICE_TABLE(hid, ccp_devices);
>  MODULE_LICENSE("GPL");
> 
> -module_usb_driver(ccp_driver);
> +static int __init ccp_init(void)
> +{
> +	return hid_register_driver(&ccp_driver);
> +}
> +
> +static void __exit ccp_exit(void)
> +{
> +	hid_unregister_driver(&ccp_driver);
> +}
> +
> +/* make sure, it is loaded after hid */
> +late_initcall(ccp_init);
> +module_exit(ccp_exit);
> --
> 2.27.0
