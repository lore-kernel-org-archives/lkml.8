Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07830C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA43C206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgBQOIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:08:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:46221 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgBQOIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:08:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 06:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="433801867"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2020 06:08:50 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j3h4t-002ozz-Do; Mon, 17 Feb 2020 16:08:51 +0200
Date:   Mon, 17 Feb 2020 16:08:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/19] platform/x86: intel_scu_ipc: Log more
 information if SCU IPC command fails
Message-ID: <20200217140851.GC10400@smile.fi.intel.com>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
 <20200217131446.32818-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217131446.32818-3-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 04:14:29PM +0300, Mika Westerberg wrote:
> Currently we only log an error if the command times out which makes it
> hard to figure out the failing command. This changes the driver to log
> command and subcommand with the error code which should make debugging
> easier. This also allows us to simplify the callers as they don't need
> to log these errors themselves.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 19c2cc41fb05..7512d550b375 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -147,7 +147,6 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
>  		usleep_range(50, 100);
>  	} while (time_before(jiffies, end));
>  
> -	dev_err(&scu->dev, "IPC timed out");
>  	return -ETIMEDOUT;
>  }
>  
> @@ -156,10 +155,8 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
>  {
>  	int status;
>  
> -	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT)) {
> -		dev_err(&scu->dev, "IPC timed out\n");
> +	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT))
>  		return -ETIMEDOUT;
> -	}
>  
>  	status = ipc_read_status(scu);
>  	if (status & IPC_STATUS_ERR)
> @@ -331,6 +328,7 @@ EXPORT_SYMBOL(intel_scu_ipc_update_register);
>  int intel_scu_ipc_simple_command(int cmd, int sub)
>  {
>  	struct intel_scu_ipc_dev *scu;
> +	u32 cmdval;
>  	int err;
>  
>  	mutex_lock(&ipclock);
> @@ -339,9 +337,12 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
>  		return -ENODEV;
>  	}
>  	scu = ipcdev;
> -	ipc_command(scu, sub << 12 | cmd);
> +	cmdval = sub << 12 | cmd;
> +	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);
>  	mutex_unlock(&ipclock);
> +	if (err)
> +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
>  	return err;
>  }
>  EXPORT_SYMBOL(intel_scu_ipc_simple_command);
> @@ -362,6 +363,7 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
>  			  u32 *out, int outlen)
>  {
>  	struct intel_scu_ipc_dev *scu;
> +	u32 cmdval;
>  	int i, err;
>  
>  	mutex_lock(&ipclock);
> @@ -374,7 +376,8 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
>  	for (i = 0; i < inlen; i++)
>  		ipc_data_writel(scu, *in++, 4 * i);
>  
> -	ipc_command(scu, (inlen << 16) | (sub << 12) | cmd);
> +	cmdval = (inlen << 16) | (sub << 12) | cmd;
> +	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);
>  
>  	if (!err) {
> @@ -383,6 +386,8 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
>  	}
>  
>  	mutex_unlock(&ipclock);
> +	if (err)
> +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
>  	return err;
>  }
>  EXPORT_SYMBOL(intel_scu_ipc_command);
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko


