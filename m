Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE2C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4BC20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBLLgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:36:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:38964 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBLLgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:36:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 03:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347499073"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 03:36:49 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Feb 2020 13:36:49 +0200
Date:   Wed, 12 Feb 2020 13:36:49 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20200212113649.GV2667@lahna.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-3-mika.westerberg@linux.intel.com>
 <20200211154138.GE10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211154138.GE10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:41:38PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2020 at 04:25:47PM +0300, Mika Westerberg wrote:
> > Currently we only log an error if the command times out which makes it
> > hard to figure out the failing command. This changes the driver to log
> > command and subcommand with the error code which should make debugging
> > easier. This also allows us to simplify the callers as they don't need
> > to log these errors themselves.
> > 
> 
> Thanks, my comments below.
> 
> ...
> 
> >  	scu = ipcdev;
> > -	ipc_command(scu, sub << 12 | cmd);
> > +	cmdval = sub << 12 | cmd;
> > +	ipc_command(scu, cmdval);
> >  	err = intel_scu_ipc_check_status(scu);
> 
> > +	if (err)
> > +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval,
> > +			err);
> 
> We may move it out of the mutex, right? Also, please keep it one line.

Yup.

> >  	mutex_unlock(&ipclock);
> >  	return err;
> 
> ...
> 
> >  	mutex_lock(&ipclock);
> 
> > +	cmdval = (inlen << 16) | (sub << 12) | cmd;
> > +	ipc_command(scu, cmdval);
> >  	err = intel_scu_ipc_check_status(scu);
> > -
> > -	if (!err) {
> > +	if (err) {
> > +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval,
> > +			err);
> > +	} else {
> >  		for (i = 0; i < outlen; i++)
> >  			*out++ = ipc_data_readl(scu, 4 * i);
> >  	}
> 
> It's not visible in this context but it looks like above applies here as well.

You mean move outside of the lock? This one calls ipc_data_readl()
which should be under the lock.
