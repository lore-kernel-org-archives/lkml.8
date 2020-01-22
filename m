Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC935C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880482467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579704584;
	bh=YzGQHHuNBzeqfnOJVGKpDcH5nkWq3UPDi+bDM6C5ln8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BuV6ePEjKmMjkJ7N7hP8XG6LOPyTqxSIpn7+bsD3fZJkTS7jpyAwq8TiIiNC+ejM9
	 3nm44hj/C0Mw13GSJQ9O1HHd0eLWMgbArqwqcXb0zXRmolQSXE4e+Whdv2ll2Gn5sL
	 bIwxY9AAVFv5v0gEbOIrU1D9rmgTdgT4ZwQPEAuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAVOtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVOtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:49:43 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F83321835;
        Wed, 22 Jan 2020 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579704582;
        bh=YzGQHHuNBzeqfnOJVGKpDcH5nkWq3UPDi+bDM6C5ln8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3xy4VPwHJI5qA7vr/Pf/Y8BQEx8TCchvpzTuTFNyTDsd2yj01MajBw8JgI63jd5B
         WhtbDunGfk3PgKCy/jUoNY7gCqQWr+Ugi4hnkNs4hbvjs2x+RagMd4fxLwphwXzMTd
         4orYSuvtROZO0DwguPXdufU/lkahqofC+vKJG9gg=
Date:   Wed, 22 Jan 2020 15:49:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20200122144939.GA59473@kroah.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-15-mika.westerberg@linux.intel.com>
 <20200122134359.GE4963@kroah.com>
 <20200122144048.GV2665@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122144048.GV2665@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 04:40:48PM +0200, Mika Westerberg wrote:
> On Wed, Jan 22, 2020 at 02:43:59PM +0100, Greg Kroah-Hartman wrote:
> > > +	if (!scu->dev)
> > > +		goto err_unlock;
> > > +	if (!try_module_get(scu->dev->driver->owner))
> > > +		goto err_unlock;
> > > +	mutex_unlock(&ipclock);
> > > +	return scu;
> > 
> > NO REFERENCE COUNT INCREMENT???
> 
> You mean increment the scu->dev reference count? I kind of thought that
> the try_module_get() should make sure the thing stays there as long as
> the caller has not called _put() but now when I think about it bit more
> we would need to do device_get() here as well.

module reference counts handle _code_ while structure reference counts
handle _data_.

You should almost never need to worry about module reference counts if
your code is structured properly, only handle the reference counts on
the pointers you throw around.

The fact that you are even calling try_module_get() is a huge flag that
something is wrong here.

thanks,

greg k-h
