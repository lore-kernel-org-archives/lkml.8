Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E0BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52658207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgBRMZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:25:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:36582 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgBRMZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:25:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 04:25:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="348688175"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 18 Feb 2020 04:25:46 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 Feb 2020 14:25:45 +0200
Date:   Tue, 18 Feb 2020 14:25:45 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 5/9] usb: roles: Provide the switch drivers handle to the
 switch in the API
Message-ID: <20200218122545.GF28776@kuha.fi.intel.com>
References: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
 <20200213132428.53374-6-heikki.krogerus@linux.intel.com>
 <20200213133239.GN1498@kuha.fi.intel.com>
 <20200218072341.GA30350@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218072341.GA30350@b29397-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 18, 2020 at 07:23:41AM +0000, Peter Chen wrote:
> > > @@ -1118,6 +1119,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> > >  	}
> > >  
> > >  	if (ci_role_switch.fwnode) {
> > > +		ci_role_switch.driver_data = ci;
> > >  		ci->role_switch = usb_role_switch_register(dev,
> > >  					&ci_role_switch);
> 
> Why the struct usb_role_switch_desc needs drvdata, the struct
> usb_role_switch has already one?

I'm assuming that you are asking why not just register the switch,
and then call usb_role_switch_set_drvdata(), right?

That may create a race condition where the switch is accessed before
the driver data is available. That can happen for example if the
switch is exposed to the user space.

To play it safe, supplying the driver data as part of the descriptor.
That way we can be sure that the driver data is always available
the moment the switch is registered.

thanks,

-- 
heikki
