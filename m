Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DC7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651DD20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCMMna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:43:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53290 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:43:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 198612970C5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 3/3] platform/chrome: notify: Pull PD_HOST_EVENT status
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     furquan@chromium.org, Benson Leung <bleung@chromium.org>
References: <20200312100809.21153-1-pmalani@chromium.org>
 <20200312100809.21153-4-pmalani@chromium.org>
Message-ID: <d03c96c0-ea23-5b4e-0be0-0a1a296eeaeb@collabora.com>
Date:   Fri, 13 Mar 2020 13:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312100809.21153-4-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 12/3/20 11:08, Prashant Malani wrote:
> Read the PD host even status from the EC and send that to the notifier
> listeners, for more fine-grained event information.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_usbpd_notify.c | 87 ++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> index d2dbf7017e29c..3d9db4146217e 100644
> --- a/drivers/platform/chrome/cros_usbpd_notify.c
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -53,11 +53,91 @@ void cros_usbpd_unregister_notify(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
>  
> +/**
> + * cros_ec_pd_command - Send a command to the EC.
> + *
> + * @ec_dev: EC device
> + * @command: EC command
> + * @outdata: EC command output data
> + * @outsize: Size of outdata
> + * @indata: EC command input data
> + * @insize: Size of indata
> + *
> + * Return: 0 on success, < 0 on failure.
> + */
> +static int cros_ec_pd_command(struct cros_ec_device *ec_dev,
> +			      int command,
> +			      uint8_t *outdata,
> +			      int outsize,
> +			      uint8_t *indata,
> +			      int insize)
> +{
> +	int ret;
> +	struct cros_ec_command *msg;

Reverse x-mas tree, please.

struct cros_ec_command *msg;
int ret;

> +
> +	msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
> +	if (!msg)
> +		return -EC_RES_ERROR;

Use standard linux error codes please, in that case -ENOMEM.

> +
> +	msg->command = command;
> +	msg->outsize = outsize;
> +	msg->insize = insize;
> +
> +	if (outsize)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +	if (ret < 0)
> +		goto error;
> +
> +	if (insize)
> +		memcpy(indata, msg->data, insize);
> +	ret = EC_RES_SUCCESS;

Standard linux error codes, just return what cros_ec_cmd_xfer_status returns.

> +error:
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static void cros_usbpd_get_event_and_notify(struct device  *dev,
> +					    struct cros_ec_device *ec_dev)
> +{
> +	struct ec_response_host_event_status host_event_status;
> +	u32 event = 0;
> +	int ret;
> +
> +	/*
> +	 * We still send a 0 event out to older devices which don't
> +	 * have the updated device heirarchy.
> +	 */
> +	if (!ec_dev) {

Ok, remembering my comment in previous patch it makes sense to check for ec_dev,
but see below ...

> +		dev_dbg(dev,
> +			"EC device inaccessible; sending 0 event status.\n");
> +		goto send_notify;
> +	}
> +
> +	/* Check for PD host events on EC. */
> +	ret = cros_ec_pd_command(ec_dev, EC_CMD_PD_HOST_EVENT_STATUS,
> +				 NULL, 0,
> +				 (uint8_t *)&host_event_status,
> +				 sizeof(host_event_status));
> +	if (ret < 0) {
> +		dev_warn(dev, "Can't get host event status (err: %d)\n", ret);

This print is unneeded, a error will be printed already if it fails.

> +		goto send_notify;
> +	}
> +
> +	event = host_event_status.status;
> +
> +send_notify:
> +	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> +}
> +
>  #ifdef CONFIG_ACPI
>  
>  static void cros_usbpd_notify_acpi(acpi_handle device, u32 event, void *data)
>  {
> -	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> +	struct cros_usbpd_notify_data *pdnotify = data;
> +
> +	cros_usbpd_get_event_and_notify(pdnotify->dev, pdnotify->ec);
>  }
>  
>  static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
> @@ -144,6 +224,8 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
>  				  unsigned long queued_during_suspend,
>  				  void *data)
>  {
> +	struct cros_usbpd_notify_data *pdnotify = container_of(nb,
> +			struct cros_usbpd_notify_data, nb);
>  	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
>  	u32 host_event = cros_ec_get_host_event(ec_dev);
>  

Not related to this patch but as you introduced the possibility to have ec_dev
NULL, crash here.


> @@ -151,8 +233,7 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
>  		return NOTIFY_BAD;
>  
>  	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> -		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> -					     host_event, NULL);
> +		cros_usbpd_get_event_and_notify(pdnotify->dev, ec_dev);
>  		return NOTIFY_OK;
>  	}
>  	return NOTIFY_DONE;
> 
