Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B669C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD7A20775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgGAJLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGAJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:11:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A3CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:11:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 81E282A0D02
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Use workqueue for
 port update
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200629211329.2185342-1-pmalani@chromium.org>
Message-ID: <37673887-70a6-ed1e-b864-419e690899be@collabora.com>
Date:   Wed, 1 Jul 2020 11:11:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629211329.2185342-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the patch. And thanks to Guenter and Heikki for reviewing it.

On 29/6/20 23:13, Prashant Malani wrote:
> Use a work queue to call the port update routines, instead of doing it
> directly in the PD notifier callback. This will prevent other drivers
> with PD notifier callbacks from being blocked on the port update routine
> completing.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Applied for 5.9 both patches with the corresponding reviewed tags.

> ---
> 
> Changes in v4:
> - Removed extra newline.
> - Moved both variable declarations into one line.
> 
> Changes in v3:
> - Use new 100 character line length limit.
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0c041b79cbba..69c4118e280c 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -58,6 +58,7 @@ struct cros_typec_data {
>  	/* Array of ports, indexed by port number. */
>  	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
>  	struct notifier_block nb;
> +	struct work_struct port_work;
>  };
>  
>  static int cros_typec_parse_port_props(struct typec_capability *cap,
> @@ -619,18 +620,24 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>  	return 0;
>  }
>  
> -static int cros_ec_typec_event(struct notifier_block *nb,
> -			       unsigned long host_event, void *_notify)
> +static void cros_typec_port_work(struct work_struct *work)
>  {
> -	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
> -						     nb);
> -	int ret, i;
> +	struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
> +	int i, ret;
>  
>  	for (i = 0; i < typec->num_ports; i++) {
>  		ret = cros_typec_port_update(typec, i);
>  		if (ret < 0)
>  			dev_warn(typec->dev, "Update failed for port: %d\n", i);
>  	}
> +}
> +
> +static int cros_ec_typec_event(struct notifier_block *nb,
> +			       unsigned long host_event, void *_notify)
> +{
> +	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
> +
> +	schedule_work(&typec->port_work);
>  
>  	return NOTIFY_OK;
>  }
> @@ -689,6 +696,12 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	INIT_WORK(&typec->port_work, cros_typec_port_work);
> +
> +	/*
> +	 * Safe to call port update here, since we haven't registered the
> +	 * PD notifier yet.
> +	 */
>  	for (i = 0; i < typec->num_ports; i++) {
>  		ret = cros_typec_port_update(typec, i);
>  		if (ret < 0)
> 
