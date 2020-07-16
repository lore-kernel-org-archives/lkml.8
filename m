Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582FBC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A2C206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK/rhBBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGPAVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgGPAVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:21:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0BFC061755;
        Wed, 15 Jul 2020 17:21:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so3931327pgk.4;
        Wed, 15 Jul 2020 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YQ5eiAsIpd1JXIIXN3G1WepaP3KLtbFt82v/ldZVpLQ=;
        b=rK/rhBBW1vS1KhQcrnAnKpEYWU5Nyw9AT4z81C5Q3SEPUybTrWtEfR2fMvfN2hJMgT
         jHvmP7hjwYfh5sXCMrxpkhUGNU0jz2BMw6ESTW6RHKfcFMwbkE+WWFJABTjL61QRWiop
         rMlthJ5XIaa6vjj3HHsgSUSc+LFO4CXlXciuiN2p+H3M1zBjgV9StQ/hTOlMIigK6mQW
         JPCS49Gbm/6Vy1qJbSlSKe2hROA+DKJYgTFYlU2Q86xX/kCulHbM6+s+528LyuhXiY3C
         UXYa9Nix+W/Aqv7qtHVrARpoy5I9QkTpSTdoxEeBQnf92k75jSAxLlxl9UeCVXZxotw9
         EIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=YQ5eiAsIpd1JXIIXN3G1WepaP3KLtbFt82v/ldZVpLQ=;
        b=h55V3EwNJqO4C2WaIGVMK2BQMR/PqS2clxHzU0+azM1E92wBUnlEKzdirAzDa0IBDM
         s1ei+VonL9JHi61qCj1alLQbMcncJPQisYiaTsnPMMW3Jlzbf7yAQ6L5aSpEMgeFm5FW
         vu1FBp6SiA5Ak0xhESk1ahp9xLAM5sNmUpn/Mq357l1bwqSe4fwpSS+vx2wht49yMNHF
         RLJGdxTK2b8nxAQWiy6loW4ac6Nx/TPUFQ0tkyFjfSyYpDTPC1GNSqqOyZ3OvQsMyQck
         p2EgR//YS8SMBoQ2ewHLZLd6Rdy+tNLVIKV6y5WOY5kM6vZLdWgJOB2e95Oq/1PlZZiz
         7pDA==
X-Gm-Message-State: AOAM533j+XIVVgYvQCI3kM1urRiTE8xebPFN9rUtsvjaGdauSivMt9Qw
        bWE93hzvByM9/eXkxQN+jbPCsA4s
X-Google-Smtp-Source: ABdhPJwMs00kb/MSHgucod5Ixa56PzHZOKT9lKJLAJ9d0xbCfvRJTEJadwEsGAEpLt4zo5NrgfTY1g==
X-Received: by 2002:a62:82ce:: with SMTP id w197mr1508138pfd.322.1594858912131;
        Wed, 15 Jul 2020 17:21:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v28sm3269689pgn.81.2020.07.15.17.21.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 17:21:51 -0700 (PDT)
Date:   Wed, 15 Jul 2020 17:21:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: corsair-cpro: Change to HID driver
Message-ID: <20200716002149.GA240862@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:31:46PM +0200, Marius Zachmann wrote:
> This changes corsair-cpro to a hid driver using hid reports.
> 
> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> 
Applied (squashed all patches together).

Thanks,
Guenter

> ---
> Changes from v2
> - add more explanatory comment to justify late_initcall
> 
> Changes from v1
> - add comment at the beginning about using hid and hidraw
> - use hwmon_device_register_with_info and hwmon_device_unregister
> - use a define for timeout
> 
> ---
>  drivers/hid/hid-quirks.c     |   2 -
>  drivers/hwmon/Kconfig        |   4 +-
>  drivers/hwmon/corsair-cpro.c | 127 ++++++++++++++++++++++++++---------
>  3 files changed, 98 insertions(+), 35 deletions(-)
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
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index fe625190e3a1..e8504267d0e8 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -2,16 +2,21 @@
>  /*
>   * corsair-cpro.c - Linux driver for Corsair Commander Pro
>   * Copyright (C) 2020 Marius Zachmann <mail@mariuszachmann.de>
> + *
> + * This driver uses hid reports to communicate with the device to allow hidraw userspace drivers
> + * still being used. The device does not use report ids. When using hidraw and this driver
> + * simultaniously, reports could be switched.
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
> @@ -20,6 +25,7 @@
>  #define OUT_BUFFER_SIZE		63
>  #define IN_BUFFER_SIZE		16
>  #define LABEL_LENGTH		11
> +#define REQ_TIMEOUT		300
> 
>  #define CTL_GET_TMP_CNCT	0x10	/*
>  					 * returns in bytes 1-4 for each temp sensor:
> @@ -62,7 +68,9 @@
>  #define NUM_TEMP_SENSORS	4
> 
>  struct ccp_device {
> -	struct usb_device *udev;
> +	struct hid_device *hdev;
> +	struct device *hwmon_dev;
> +	struct completion wait_input_report;
>  	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
>  	u8 *buffer;
>  	int pwm[6];
> @@ -75,7 +83,7 @@ struct ccp_device {
>  /* send command, check for error in response, response in ccp->buffer */
>  static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2, u8 byte3)
>  {
> -	int actual_length;
> +	unsigned long t;
>  	int ret;
> 
>  	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> @@ -84,26 +92,39 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
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
> +	t = wait_for_completion_timeout(&ccp->wait_input_report, msecs_to_jiffies(REQ_TIMEOUT));
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
> @@ -437,57 +458,101 @@ static int get_temp_cnct(struct ccp_device *ccp)
>  	return 0;
>  }
> 
> -static int ccp_probe(struct usb_interface *intf, const struct usb_device_id *id)
> +static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
> -	struct device *hwmon_dev;
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
> +		goto out_hw_close;
> +	ccp->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsaircpro",
> +							 ccp, &ccp_chip_info, 0);
> +	if (IS_ERR(ccp->hwmon_dev)) {
> +		ret = PTR_ERR(ccp->hwmon_dev);
> +		goto out_hw_close;
> +	}
> 
> -	hwmon_dev = devm_hwmon_device_register_with_info(&intf->dev, "corsaircpro", ccp,
> -							 &ccp_chip_info, 0);
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
> +	struct ccp_device *ccp = hid_get_drvdata(hdev);
> +
> +	hwmon_device_unregister(ccp->hwmon_dev);
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
> +/*
> + * When compiling this driver as built-in, hwmon initcalls will get called before the
> + * hid driver and this driver would fail to register. late_initcall solves this.
> + */
> +late_initcall(ccp_init);
> +module_exit(ccp_exit);
> --
> 2.27.0
