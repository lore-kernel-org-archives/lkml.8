Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A755124125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579700184;
	bh=pT+FhKqL+xwq8TFC25pdySbjxEKNna4NUMwXPcYjpr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nnUtLx7fjIj3wTC5NfGyL+ErmmXV7A7lEyA5Exr1YJ1NLRc3OxFInSPa/6ySy/rDN
	 Es2JDCYTBm9h9WCPfdYVI5FMRM8nh544i8PSvJ9C1gxedHWAPjwvdJLF9S9B+EPsV6
	 JAoH9fCr6k86EqfL6JRZgWpePQ0gqvgYeHsfOD4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAVNgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVNgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:36:23 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1898820704;
        Wed, 22 Jan 2020 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579700183;
        bh=pT+FhKqL+xwq8TFC25pdySbjxEKNna4NUMwXPcYjpr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKyDmfZVH1R0wDI6Gy24BoJ/RMMCc8Y6MOmjxx5dU7QOwf0PQI//+R4wF+aJccoyv
         +hpmyczUGJGP6hkBd6WwliNjT5rqnWDO+I1svdzMOP2I1oT/JbPf47AmVWQygt9SJ/
         NsT65SL0fw794cf/kzK4EL74m2zN/clm5evD+2io=
Date:   Wed, 22 Jan 2020 14:36:19 +0100
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
Subject: Re: [PATCH v4 11/38] platform/x86: intel_scu_ipc: Drop
 intel_scu_ipc_raw_command()
Message-ID: <20200122133619.GB4963@kroah.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-12-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121160114.60007-12-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:00:47PM +0300, Mika Westerberg wrote:
> There is no user for this function so we can drop it from the driver.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_scu_ipc.h |  2 -
>  drivers/platform/x86/intel_scu_ipc.c | 63 ----------------------------
>  2 files changed, 65 deletions(-)

These first 11 patches are fine, why didn't you just submit them as
cleanups/fixes and then build on them with the rest?  Having to wade
through 38-patch series is a pain...

thanks,

greg k-h
