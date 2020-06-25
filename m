Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84192C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E1820857
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404449AbgFYLxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:53:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36056 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404406AbgFYLxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4EFF32A50E0
Subject: Re: [PATCH v2] platform: cros_ec_debugfs: control uptime information
 request
To:     Gwendal Grignou <gwendal@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, twawrzynczak@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20200526185328.231840-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <09ba7001-6a24-7d96-0328-4ae1d1c62520@collabora.com>
Date:   Thu, 25 Jun 2020 13:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200526185328.231840-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Thank you for your patch.

On 26/5/20 20:53, Gwendal Grignou wrote:
> When EC does not support uptime command (EC_CMD_GET_UPTIME_INFO),
> do not create the uptime sysfs entry point.
> User space application will not probe the file needlessly.
> 
> The EC console log will not contain EC_CMD_GET_UPTIME_INFO anymore.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Applied for 5.9

> ---
>  drivers/platform/chrome/cros_ec_debugfs.c | 24 +++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 6ae484989d1f5..303a8c4686f89 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -243,6 +243,25 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
>  				       read_buf, p - read_buf);
>  }
>  
> +static bool cros_ec_uptime_is_supported(struct cros_ec_device *ec_dev)
> +{
> +	struct {
> +		struct cros_ec_command cmd;
> +		struct ec_response_uptime_info resp;
> +	} __packed msg = {};
> +	int ret;
> +
> +	msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
> +	msg.cmd.insize = sizeof(msg.resp);
> +
> +	ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
> +	if (ret == -EPROTO && msg.cmd.result == EC_RES_INVALID_COMMAND)
> +		return false;
> +
> +	/* Other errors maybe a transient error, do not rule about support. */
> +	return true;
> +}
> +
>  static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
>  				   size_t count, loff_t *ppos)
>  {
> @@ -445,8 +464,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>  	debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
>  			    &cros_ec_pdinfo_fops);
>  
> -	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
> -			    &cros_ec_uptime_fops);
> +	if (cros_ec_uptime_is_supported(ec->ec_dev))
> +		debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
> +				    &cros_ec_uptime_fops);
>  
>  	debugfs_create_x32("last_resume_result", 0444, debug_info->dir,
>  			   &ec->ec_dev->last_resume_result);
> 
