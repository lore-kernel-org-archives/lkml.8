Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05BBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33F62070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgGIHZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:25:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55216 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:25:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 093B02A1DD0
Subject: Re: [PATCH v1] platform/chrome: cros_ec_debugfs: conditionally create
 uptime node
To:     Eizan Miyamoto <eizan@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20200708145215.v1.1.I9d49b374536424fcc98bc6bd935cdab8fac2ae71@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e9cc90de-2bc8-a7ef-0577-6b86874913d1@collabora.com>
Date:   Thu, 9 Jul 2020 09:25:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708145215.v1.1.I9d49b374536424fcc98bc6bd935cdab8fac2ae71@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eizan,

Thank you for your patch

On 8/7/20 6:53, Eizan Miyamoto wrote:
> Before creating an 'uptime' node in debugfs, this change adds a check to
> see if a EC_CMD_GET_UPTIME_INFO command can be successfully run.
> 
> If the uptime node is created, userspace programs may periodically poll
> it (e.g., timberslide), causing commands to be sent to the EC each time.
> If the EC doesn't support EC_CMD_GET_UPTIME_INFO, an error will be
> emitted in the EC console, producing noise.
> 

A similar patch with the same purpose sent by Gwendal was already accepted and
queued for 5.9. See [1].


Thanks,
 Enric

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/commit/?h=for-next&id=d378cdd0113878e3860f954d16dd3e91defb1492



> Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
> ---
> 
>  drivers/platform/chrome/cros_ec_debugfs.c | 35 +++++++++++++++++------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index ecfada00e6c51..8708fe12f8ca8 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -242,17 +242,14 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
>  				       read_buf, p - read_buf);
>  }
>  
> -static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
> -				   size_t count, loff_t *ppos)
> +static int cros_ec_get_uptime(struct cros_ec_device *ec_dev,
> +			      uint32_t *uptime)
>  {
> -	struct cros_ec_debugfs *debug_info = file->private_data;
> -	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
>  	struct {
>  		struct cros_ec_command cmd;
>  		struct ec_response_uptime_info resp;
>  	} __packed msg = {};
>  	struct ec_response_uptime_info *resp;
> -	char read_buf[32];
>  	int ret;
>  
>  	resp = (struct ec_response_uptime_info *)&msg.resp;
> @@ -264,8 +261,24 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n",
> -			resp->time_since_ec_boot_ms);
> +	*uptime = resp->time_since_ec_boot_ms;
> +	return 0;
> +}
> +
> +static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct cros_ec_debugfs *debug_info = file->private_data;
> +	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
> +	char read_buf[32];
> +	int ret;
> +	uint32_t uptime;
> +
> +	ret = cros_ec_get_uptime(ec_dev, &uptime);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n", uptime);
>  
>  	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
>  }
> @@ -425,6 +438,7 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>  	const char *name = ec_platform->ec_name;
>  	struct cros_ec_debugfs *debug_info;
>  	int ret;
> +	uint32_t uptime;
>  
>  	debug_info = devm_kzalloc(ec->dev, sizeof(*debug_info), GFP_KERNEL);
>  	if (!debug_info)
> @@ -444,8 +458,11 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>  	debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
>  			    &cros_ec_pdinfo_fops);
>  
> -	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
> -			    &cros_ec_uptime_fops);
> +	if (cros_ec_get_uptime(debug_info->ec->ec_dev, &uptime) >= 0)
> +		debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
> +				    &cros_ec_uptime_fops);
> +	else
> +		dev_dbg(ec->dev, "EC does not provide uptime");
>  
>  	debugfs_create_x32("last_resume_result", 0444, debug_info->dir,
>  			   &ec->ec_dev->last_resume_result);
> 
