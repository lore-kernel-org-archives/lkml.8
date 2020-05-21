Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5555CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDA72072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgEUJVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:21:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgEUJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:21:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 366F92A317A
Subject: Re: [PATCH] platform: cros_ec_debugfs: control uptime information
 request
To:     Gwendal Grignou <gwendal@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, twawrzynczak@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20200521052832.66620-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e83f3849-9e2d-4919-1a65-35f63eabe993@collabora.com>
Date:   Thu, 21 May 2020 11:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521052832.66620-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Thank you for your patch.

On 21/5/20 7:28, Gwendal Grignou wrote:
> When EC does not support uptime command (EC_CMD_GET_UPTIME_INFO),
> return -EPROTO to read of /sys/kernel/debug/cros_ec/uptime without
> calling the EC after the first try.
> 
> The EC console log will not contain EC_CMD_GET_UPTIME_INFO anymore.
> 

Oh, what you mean with this? Uptime is only exposed via sysfs or I am missing
something.

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_debugfs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 6ae484989d1f5..70a29afb6d9e7 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -49,6 +49,8 @@ struct cros_ec_debugfs {
>  	struct delayed_work log_poll_work;
>  	/* EC panicinfo */
>  	struct debugfs_blob_wrapper panicinfo_blob;
> +	/* EC uptime */
> +	bool uptime_supported;

Ideally, if uptime can be supported or not we should only expose uptime when is
supported, so the sysfs entry should only be created when is supported, similar
to what we do with the console_log. See cros_ec_create_console_log()

If doing this doesn't break userspace, I'd prefer doing in that way.

Thanks,
 Enric


>  };
>  
>  /*
> @@ -256,12 +258,19 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
>  	char read_buf[32];
>  	int ret;
>  
> +	if (!debug_info->uptime_supported)
> +		return -EPROTO;
> +
>  	resp = (struct ec_response_uptime_info *)&msg.resp;
>  
>  	msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
>  	msg.cmd.insize = sizeof(*resp);
>  
>  	ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
> +	if (ret == -EPROTO && msg.cmd.result == EC_RES_INVALID_COMMAND) {
> +		debug_info->uptime_supported = false;
> +		return ret;
> +	}
>  	if (ret < 0)
>  		return ret;
>  
> @@ -434,6 +443,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>  	debug_info->ec = ec;
>  	debug_info->dir = debugfs_create_dir(name, NULL);
>  
> +	/* Give uptime a chance to run. */
> +	debug_info->uptime_supported = true;
> +
>  	ret = cros_ec_create_panicinfo(debug_info);
>  	if (ret)
>  		goto remove_debugfs;
> 
