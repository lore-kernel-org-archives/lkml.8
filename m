Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6218C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925DA246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCBJRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:17:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:47928 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgCBJRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:17:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 01:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="351500767"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2020 01:17:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 02 Mar 2020 11:17:38 +0200
Date:   Mon, 2 Mar 2020 11:17:38 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v2 5/9] usb: roles: Provide the switch drivers handle to
 the switch in the API
Message-ID: <20200302091738.GB22243@kuha.fi.intel.com>
References: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
 <20200224121406.2419-6-heikki.krogerus@linux.intel.com>
 <20200224131442.GA5365@b29397-desktop>
 <20200302062302.GE3834@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302062302.GE3834@b29397-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 06:22:59AM +0000, Peter Chen wrote:
> > > @@ -613,9 +613,10 @@ static enum usb_role ci_usb_role_switch_get(struct device *dev)
> > >  	return role;
> > >  }
> > >  
> > > -static int ci_usb_role_switch_set(struct device *dev, enum usb_role role)
> > > +static int ci_usb_role_switch_set(struct usb_role_switch *sw,
> > > +				  enum usb_role role)
> > >  {
> > > -	struct ci_hdrc *ci = dev_get_drvdata(dev);
> > > +	struct ci_hdrc *ci = usb_role_switch_get_drvdata(sw);
> > >  	struct ci_hdrc_cable *cable = NULL;
> > >  	enum usb_role current_role = ci_role_to_usb_role(ci);
> > >  	enum ci_role ci_role = usb_role_to_ci_role(role);
> > > @@ -1118,6 +1119,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> > >  	}
> > >  
> > >  	if (ci_role_switch.fwnode) {
> > > +		ci_role_switch.driver_data = ci;
> 
> And chipidea code, better change it like cdns3's, otherwise, the
> switch desc for all controllers have the same driver_data.

That I'll skip after all...

Note that since the context of the switch descriptor is always copied
during registration, the driver_data is not going to be the same for
every switch.

The structure is actually filled in two separate functions, so the
change is not straightforward. We can still change that of course, but
it's out side the scope of this series, so it needs to be done
separately.


thanks,

-- 
heikki
