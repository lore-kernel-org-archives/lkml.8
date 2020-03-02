Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD95BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CC5246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCBHnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:43:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:42953 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBHnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:43:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2020 23:43:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="351483847"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 01 Mar 2020 23:43:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 02 Mar 2020 09:43:03 +0200
Date:   Mon, 2 Mar 2020 09:43:03 +0200
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
Message-ID: <20200302074303.GB27904@kuha.fi.intel.com>
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
> On 20-02-24 13:14:40, Peter Chen wrote:
> > >   */
> > > -static int cdns3_role_set(struct device *dev, enum usb_role role)
> > > +static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
> > >  {
> > > -	struct cdns3 *cdns = dev_get_drvdata(dev);
> > > +	struct cdns3 *cdns = usb_role_switch_get_drvdata(sw);
> > >  	int ret = 0;
> > >  
> > >  	pm_runtime_get_sync(cdns->dev);
> > > @@ -423,12 +423,6 @@ static int cdns3_role_set(struct device *dev, enum usb_role role)
> > >  	return ret;
> > >  }
> > >  
> > > -static const struct usb_role_switch_desc cdns3_switch_desc = {
> > > -	.set = cdns3_role_set,
> > > -	.get = cdns3_role_get,
> > > -	.allow_userspace_control = true,
> > > -};
> > > -
> > >  /**
> > >   * cdns3_probe - probe for cdns3 core device
> > >   * @pdev: Pointer to cdns3 core platform device
> > > @@ -437,6 +431,7 @@ static const struct usb_role_switch_desc cdns3_switch_desc = {
> > >   */
> > >  static int cdns3_probe(struct platform_device *pdev)
> > >  {
> > > +	struct usb_role_switch_desc sw_desc = { };
> > >  	struct device *dev = &pdev->dev;
> > >  	struct resource	*res;
> > >  	struct cdns3 *cdns;
> > > @@ -529,7 +524,12 @@ static int cdns3_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		goto err3;
> > >  
> > > -	cdns->role_sw = usb_role_switch_register(dev, &cdns3_switch_desc);
> > > +	sw_desc.set = cdns3_role_set,
> > > +	sw_desc.get = cdns3_role_get,
> > > +	sw_desc.allow_userspace_control = true,
> 
> Heikki, when I try to apply above, and compile, I find above issue,
> the end of code should be ";", but not ",".

OK. I'll fix that. I could have sworn that I tested that, but clearly
I have not done it.

> > > +	sw_desc.driver_data = cdns;
> > > +
> > > +	cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
> > >  	if (IS_ERR(cdns->role_sw)) {
> > >  		ret = PTR_ERR(cdns->role_sw);
> > >  		dev_warn(dev, "Unable to register Role Switch\n");
> > > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > > index 52139c2a9924..ae0bdc036464 100644
> > > --- a/drivers/usb/chipidea/core.c
> > > +++ b/drivers/usb/chipidea/core.c
> > > @@ -600,9 +600,9 @@ static int ci_cable_notifier(struct notifier_block *nb, unsigned long event,
> > >  	return NOTIFY_DONE;
> > >  }
> > >  
> > > -static enum usb_role ci_usb_role_switch_get(struct device *dev)
> > > +static enum usb_role ci_usb_role_switch_get(struct usb_role_switch *sw)
> > >  {
> > > -	struct ci_hdrc *ci = dev_get_drvdata(dev);
> > > +	struct ci_hdrc *ci = usb_role_switch_get_drvdata(sw);
> > >  	enum usb_role role;
> > >  	unsigned long flags;
> > >  
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

OK.

thanks,

-- 
heikki
