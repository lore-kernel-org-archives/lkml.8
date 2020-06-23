Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A324C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3932073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbgFWOc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:32:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:55089 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732730AbgFWOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:32:58 -0400
IronPort-SDR: XlvIVJFRxEVcsDqphPxg7BIfqKu+OtOymrNXraMqEWG962vtcSKxdeTn4zHP7GydxI29ghMlw3
 Gi/I1oT9ezpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="132488527"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="132488527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 07:32:57 -0700
IronPort-SDR: XGxWnCjKu/7n+SsNBino2LCkS4z7BxUSo1KDZv9hAE+NQ+SJ0nHyc2evAPgwZaCHSMBplIcI56
 T08ex4XTHmDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="384863507"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 23 Jun 2020 07:32:52 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 23 Jun 2020 17:32:52 +0300
Date:   Tue, 23 Jun 2020 17:32:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] thunderbolt: Add support for separating the flush
 to SPI and authenticate
Message-ID: <20200623143252.GD2795@lahna.fi.intel.com>
References: <20200622185758.28145-1-mario.limonciello@dell.com>
 <20200622185758.28145-2-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622185758.28145-2-mario.limonciello@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:57:57PM -0500, Mario Limonciello wrote:
> This allows userspace to have a shorter period of time that the device
> is unusable and to call it at a more convenient time.
> 
> For example flushing the image may happen while the user is using the
> machine and authenticating/rebooting may happen while logging out.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  .../ABI/testing/sysfs-bus-thunderbolt         | 11 ++++-
>  drivers/thunderbolt/nvm.c                     |  1 +
>  drivers/thunderbolt/switch.c                  | 42 ++++++++++++-------
>  drivers/thunderbolt/tb.h                      |  2 +
>  4 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> index bd504ed323e8..7d0500b4d58a 100644
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
> +		- Writing "2" will run some basic validation on the image
> +		and flush it to the storage area.
> +
>  		When read holds status of the last authentication
>  		operation if an error occurred during the process. This
>  		is directly the status value from the DMA configuration
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index 4c6aa06ab3d5..29de6d95c6e7 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -100,6 +100,7 @@ int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
>  			return -ENOMEM;
>  	}
>  
> +	nvm->flushed = false;

This means every write invalidates the "flushed" state, right?

>  	nvm->buf_data_size = offset + bytes;
>  	memcpy(nvm->buf + offset, val, bytes);
>  	return 0;
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 817c66c7adcf..bbfbfebeee7f 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -26,6 +26,11 @@ struct nvm_auth_status {
>  	u32 status;
>  };
>  
> +enum nvm_write_ops {
> +	WRITE_AND_AUTHENTICATE = 1,
> +	WRITE_ONLY = 2,
> +};
> +
>  /*
>   * Hold NVM authentication failure status per switch This information
>   * needs to stay around even when the switch gets power cycled so we
> @@ -155,8 +160,12 @@ static int nvm_validate_and_write(struct tb_switch *sw)
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
> @@ -1488,7 +1497,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
>  	struct device_attribute *attr, const char *buf, size_t count)
>  {
>  	struct tb_switch *sw = tb_to_switch(dev);
> -	bool val;
> +	int val;
>  	int ret;
>  
>  	pm_runtime_get_sync(&sw->dev);
> @@ -1504,25 +1513,28 @@ static ssize_t nvm_authenticate_store(struct device *dev,
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
> index 736d1589c31e..43a8ca2eb3d8 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -42,6 +42,7 @@
>   *
>   * The user of this structure needs to handle serialization of possible
>   * concurrent access.
> + * @flushed: The image has been flushed to the storage area

This should go below the @authenticating description.

>   */
>  struct tb_nvm {
>  	struct device *dev;
> @@ -53,6 +54,7 @@ struct tb_nvm {
>  	void *buf;
>  	size_t buf_data_size;
>  	bool authenticating;
> +	bool flushed;
>  };
>  
>  #define TB_SWITCH_KEY_SIZE		32
> -- 
> 2.25.1
