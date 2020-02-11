Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9E0C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D86220656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbgBKPlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:41:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:12385 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgBKPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:41:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 07:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="256505711"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2020 07:41:37 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1XfO-000lpL-Ny; Tue, 11 Feb 2020 17:41:38 +0200
Date:   Tue, 11 Feb 2020 17:41:38 +0200
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
Subject: Re: [PATCH v5 02/18] platform/x86: intel_scu_ipc: Log more
 information if SCU IPC command fails
Message-ID: <20200211154138.GE10400@smile.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211132603.73509-3-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:25:47PM +0300, Mika Westerberg wrote:
> Currently we only log an error if the command times out which makes it
> hard to figure out the failing command. This changes the driver to log
> command and subcommand with the error code which should make debugging
> easier. This also allows us to simplify the callers as they don't need
> to log these errors themselves.
> 

Thanks, my comments below.

...

>  	scu = ipcdev;
> -	ipc_command(scu, sub << 12 | cmd);
> +	cmdval = sub << 12 | cmd;
> +	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);

> +	if (err)
> +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval,
> +			err);

We may move it out of the mutex, right? Also, please keep it one line.

>  	mutex_unlock(&ipclock);
>  	return err;

...

>  	mutex_lock(&ipclock);

> +	cmdval = (inlen << 16) | (sub << 12) | cmd;
> +	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);
> -
> -	if (!err) {
> +	if (err) {
> +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval,
> +			err);
> +	} else {
>  		for (i = 0; i < outlen; i++)
>  			*out++ = ipc_data_readl(scu, 4 * i);
>  	}

It's not visible in this context but it looks like above applies here as well.

-- 
With Best Regards,
Andy Shevchenko


