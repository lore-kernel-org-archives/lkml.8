Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB581C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B347C214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAWOtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:49:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:52063 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgAWOti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:49:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 06:49:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="220684143"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2020 06:49:34 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iudnb-0004EQ-Mf; Thu, 23 Jan 2020 16:49:35 +0200
Date:   Thu, 23 Jan 2020 16:49:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefani Seibold <stefani@seibold.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v5 6/7] gpiolib: add new ioctl() for monitoring
 changes in line info
Message-ID: <20200123144935.GV32742@smile.fi.intel.com>
References: <20200123140506.29275-1-brgl@bgdev.pl>
 <20200123140506.29275-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123140506.29275-7-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:05:05PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently there is no way for user-space to be informed about changes
> in status of GPIO lines e.g. when someone else requests the line or its
> config changes. We can only periodically re-read the line-info. This
> is fine for simple one-off user-space tools, but any daemon that provides
> a centralized access to GPIO chips would benefit hugely from an event
> driven line info synchronization.
> 
> This patch adds a new ioctl() that allows user-space processes to reuse
> the file descriptor associated with the character device for watching
> any changes in line properties. Every such event contains the updated
> line information.
> 
> Currently the events are generated on three types of status changes: when
> a line is requested, when it's released and when its config is changed.
> The first two are self-explanatory. For the third one: this will only
> happen when another user-space process calls the new SET_CONFIG ioctl()
> as any changes that can happen from within the kernel (i.e.
> set_transitory() or set_debounce()) are of no interest to user-space.

...

> +	ret = kfifo_in_spinlocked(&priv->events, &chg,
> +				  1, &priv->wait.lock);

At least 1 can be moved to previous line.
(No need for new version, I hope you can fix this when applying)

> +	if (ret)
> +		wake_up_poll(&priv->wait, EPOLLIN);
> +	else
> +		pr_debug_ratelimited("lineinfo event FIFO is full - event dropped\n");
> +
> +	return NOTIFY_OK;
> +}

-- 
With Best Regards,
Andy Shevchenko


