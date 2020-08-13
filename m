Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F9120781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHMIIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:08:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:31081 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMIIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:08:25 -0400
IronPort-SDR: 2UEceZJ7BT5XbioCmkxS/dXjKJTofHUFRQ5uaLFbFaKDiNJBHLk+f5l+fD7AN1MCupLYpmMjz4
 ZHmHQI3mn7dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="151825505"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="151825505"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 01:08:24 -0700
IronPort-SDR: 4LEJ3i2StXviShvyGgDfxT5+5ADtHCl7puZLj8WUzJyASpiwl9PoJcUGjt+Lx9GTEUAgYx2+uy
 HdZLe5cNIvsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="399094202"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Aug 2020 01:08:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Aug 2020 11:08:21 +0300
Date:   Thu, 13 Aug 2020 11:08:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: tcpm: Fix TDA 2.2.1.1 and TDA 2.2.1.2
 failures
Message-ID: <20200813080821.GD1169992@kuha.fi.intel.com>
References: <20200812025126.574519-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812025126.574519-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 11, 2020 at 07:51:26PM -0700, Badhri Jagan Sridharan wrote:
> >From the spec:
> "7.1.5 Response to Hard Resets
> Hard Reset Signaling indicates a communication failure has occurred and
> the Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin
> and Shall drive VBUS to vSafe0V as shown in Figure 7-9. The USB connection
> May reset during a Hard Reset since the VBUS voltage will be less than
> vSafe5V for an extended period of time. After establishing the vSafe0V
> voltage condition on VBUS, the Source Shall wait tSrcRecover before
> re-applying VCONN and restoring VBUS to vSafe5V. A Source Shall conform
> to the VCONN timing as specified in [USB Type-C 1.3]."

I really think you need to explain the patch at least a little.
Consider people who don't understand that much about USB PD. Open it
up somehow instead of just quoting the spec.

Can you please start by explaining what exactly is TDA 2.2.1.1 and TDA
2.2.1.2. Perhaps you could also consider a better subject line for
this?

thanks,

-- 
heikki
