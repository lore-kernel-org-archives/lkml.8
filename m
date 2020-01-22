Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD44D24125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579700086;
	bh=d2mYPxa87MRYm5UwCu/FJrQarRLPYrf+VNX1F7YpAK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=enCM7DOb3zKCiqI5dmwHlKJd3bRHxHcbbuFOzL/CUwDr/ULqnPXnQuaU3YG7i+VlU
	 WUSBtd7Un9zDwxfNsgcVwe/YbOYMOjCuHdsJe+GLb0u17OmOGUng3jq4iCYiGQfwFh
	 qAzCntwpPTQa20KCx5FKsePP3r153zsmq+Ol+LMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAVNeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVNep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:34:45 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1FE820678;
        Wed, 22 Jan 2020 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579700085;
        bh=d2mYPxa87MRYm5UwCu/FJrQarRLPYrf+VNX1F7YpAK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFdPpZlo059AeOpfzlYQVpJtkvniTznRa3UGvuIcxh+wo99IRgeK6BEinpUQZfxTe
         iJn1fp4sXRDisbYhu0PKGdRkb1SQ5DCroTMfjMQHNzQJnbK5N7uAoRh3cVw7L3AcKR
         iQeI3Y8gzBi6UMy7Hk16aFfRCx3/kTrMVJQZcl20=
Date:   Wed, 22 Jan 2020 14:34:40 +0100
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
Subject: Re: [PATCH v4 06/38] platform/x86: intel_scu_ipc: Fix interrupt
 support
Message-ID: <20200122133440.GA4963@kroah.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-7-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121160114.60007-7-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:00:42PM +0300, Mika Westerberg wrote:
> Currently the driver has disabled interrupt support for Tangier but
> actually interrupt works just fine if the command is not written twice
> in a row. Also we need to ack the interrupt in the handler.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Why isn't this patch 1 of the series and cc:ed to stable?

thanks,

greg k-h
