Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074C921734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAVPEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:04:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:47395 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVPEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:04:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 07:04:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="284049874"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Jan 2020 07:04:05 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 22 Jan 2020 17:04:04 +0200
Date:   Wed, 22 Jan 2020 17:04:04 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/38] platform/x86: intel_scu_ipc: Introduce new SCU
 IPC API
Message-ID: <20200122150404.GZ2665@lahna.fi.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-15-mika.westerberg@linux.intel.com>
 <20200122134359.GE4963@kroah.com>
 <20200122144048.GV2665@lahna.fi.intel.com>
 <20200122144939.GA59473@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122144939.GA59473@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 03:49:39PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 22, 2020 at 04:40:48PM +0200, Mika Westerberg wrote:
> > On Wed, Jan 22, 2020 at 02:43:59PM +0100, Greg Kroah-Hartman wrote:
> > > > +	if (!scu->dev)
> > > > +		goto err_unlock;
> > > > +	if (!try_module_get(scu->dev->driver->owner))
> > > > +		goto err_unlock;
> > > > +	mutex_unlock(&ipclock);
> > > > +	return scu;
> > > 
> > > NO REFERENCE COUNT INCREMENT???
> > 
> > You mean increment the scu->dev reference count? I kind of thought that
> > the try_module_get() should make sure the thing stays there as long as
> > the caller has not called _put() but now when I think about it bit more
> > we would need to do device_get() here as well.
> 
> module reference counts handle _code_ while structure reference counts
> handle _data_.
> 
> You should almost never need to worry about module reference counts if
> your code is structured properly, only handle the reference counts on
> the pointers you throw around.
> 
> The fact that you are even calling try_module_get() is a huge flag that
> something is wrong here.

Thanks for the explanation! I'll keep this in mind and make sure the
next version has reference counting done accordingly.
