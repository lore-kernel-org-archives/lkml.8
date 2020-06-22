Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34DEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0112075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgFVQmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:42:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:58691 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbgFVQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:42:46 -0400
IronPort-SDR: Rg+V7VWu6t7EYNsRUv5RNq9RBlYDWehaNYm7PZwIaDwxuCOmVDs+3J4sfJVHaBwYMfYZbY9Iha
 P3u1KcesnNpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131210074"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="131210074"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 09:42:45 -0700
IronPort-SDR: gaYMqP2V1KwAfir4L5ydt9BBuc2TvmxqdG2SQGf1qUALVlhGLlRIwYLSpFYY1dpGKRIwSXFvxB
 HkYjSAbofpaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="278820561"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga006.jf.intel.com with SMTP; 22 Jun 2020 09:42:42 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Jun 2020 19:42:41 +0300
Date:   Mon, 22 Jun 2020 19:42:41 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: Add support for separating the flush to
 SPI and authenticate
Message-ID: <20200622164241.GW2795@lahna.fi.intel.com>
References: <20200622143035.25327-1-mario.limonciello@dell.com>
 <20200622143035.25327-2-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622143035.25327-2-mario.limonciello@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 09:30:34AM -0500, Mario Limonciello wrote:
> This allows userspace to have a shorter period of time that the device
> is unusable and to call it at a more convenient time.
> 
> For example flushing the image may happen while the user is using the
> machine and authenticating/rebooting may happen while logging out.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  .../ABI/testing/sysfs-bus-thunderbolt         | 11 ++++-
>  drivers/thunderbolt/switch.c                  | 43 ++++++++++++-------
>  drivers/thunderbolt/tb.h                      |  1 +
>  3 files changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> index 82e80de78dd0..26b15cbc9881 100644
> --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> @@ -178,11 +178,18 @@ KernelVersion:	4.13
>  Contact:	thunderbolt-software@lists.01.org
>  Description:	When new NVM image is written to the non-active NVM
>  		area (through non_activeX NVMem device), the
> -		authentication procedure is started by writing 1 to
> -		this file. If everything goes well, the device is
> +		authentication procedure is started by writing to
> +		this file.
> +		If everything goes well, the device is
>  		restarted with the new NVM firmware. If the image
>  		verification fails an error code is returned instead.
>  
> +		This file will accept writing values "1" or "2"
> +		- Writing "1" will flush the image to the storage
> +		area and authenticate the image in one action.
> +		- Writing "2" will only flush the image to the storage
> +		area.

Does this ("2") also do the basic validation? I think it does so
probably good to mention that here.

> +
>  		When read holds status of the last authentication
>  		operation if an error occurred during the process. This
>  		is directly the status value from the DMA configuration
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index d7d60cd9226f..4c476a58db38 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -27,6 +27,11 @@
>  #define NVM_MIN_SIZE		SZ_32K
>  #define NVM_MAX_SIZE		SZ_512K
>  
> +enum nvm_write_ops {
> +	WRITE_AND_AUTHENTICATE = 1,
> +	WRITE_ONLY = 2,
> +};
> +
>  static DEFINE_IDA(nvm_ida);
>  
>  struct nvm_auth_status {
> @@ -164,8 +169,12 @@ static int nvm_validate_and_write(struct tb_switch *sw)
>  	}
>  
>  	if (tb_switch_is_usb4(sw))
> -		return usb4_switch_nvm_write(sw, 0, buf, image_size);
> -	return dma_port_flash_write(sw->dma_port, 0, buf, image_size);
> +		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
> +	else
> +		ret = dma_port_flash_write(sw->dma_port, 0, buf, image_size);
> +	if (!ret)
> +		sw->nvm->flushed = true;
> +	return ret;
>  }
>  
>  static int nvm_authenticate_host_dma_port(struct tb_switch *sw)
> @@ -371,6 +380,7 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
>  		}
>  	}
>  
> +	sw->nvm->flushed = false;
>  	sw->nvm->buf_data_size = offset + bytes;
>  	memcpy(sw->nvm->buf + offset, val, bytes);
>  
> @@ -1536,7 +1546,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
>  	struct device_attribute *attr, const char *buf, size_t count)
>  {
>  	struct tb_switch *sw = tb_to_switch(dev);
> -	bool val;
> +	int val;
>  	int ret;
>  
>  	pm_runtime_get_sync(&sw->dev);
> @@ -1552,25 +1562,28 @@ static ssize_t nvm_authenticate_store(struct device *dev,
>  		goto exit_unlock;
>  	}
>  
> -	ret = kstrtobool(buf, &val);
> +	ret = kstrtoint(buf, 10, &val);
>  	if (ret)
>  		goto exit_unlock;
>  
>  	/* Always clear the authentication status */
>  	nvm_clear_auth_status(sw);
>  
> -	if (val) {
> -		if (!sw->nvm->buf) {
> -			ret = -EINVAL;
> -			goto exit_unlock;
> -		}
> -
> -		ret = nvm_validate_and_write(sw);
> -		if (ret)
> -			goto exit_unlock;
> +	if (val > 0) {
> +		if (!sw->nvm->flushed) {
> +			if (!sw->nvm->buf) {
> +				ret = -EINVAL;
> +				goto exit_unlock;
> +			}
>  
> -		sw->nvm->authenticating = true;
> -		ret = nvm_authenticate(sw);
> +			ret = nvm_validate_and_write(sw);
> +			if (ret || val == WRITE_ONLY)
> +				goto exit_unlock;
> +		}
> +		if (val == WRITE_AND_AUTHENTICATE) {
> +			sw->nvm->authenticating = true;
> +			ret = nvm_authenticate(sw);
> +		}
>  	}
>  
>  exit_unlock:
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 2eb2bcd3cca3..222ec19737fa 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -40,6 +40,7 @@ struct tb_switch_nvm {
>  	void *buf;
>  	size_t buf_data_size;
>  	bool authenticating;
> +	bool flushed;

Please add kernel-doc about this.

>  };
>  
>  #define TB_SWITCH_KEY_SIZE		32
> -- 
> 2.25.1
