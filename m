Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1AF2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHUNhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:37:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:48118 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgHUNhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:37:00 -0400
IronPort-SDR: kIeZ5w89GPKH9q9wEw20j3D+K7iRb3DuDu3uKJJw6PfAlRmmjJmKh6ty5a8cWX6jPqZKZmgxyg
 sFI5GHWYwdfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="135066198"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="135066198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 06:36:59 -0700
IronPort-SDR: J8BiSU1r4xYz5lboXIEAsE4xxwmVqaVL0LhS3fUYg7t/ju84yrR9K+FXOBUUyXjFOUms+g0GBY
 ViuYTNio2VfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="401471701"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Aug 2020 06:36:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 21 Aug 2020 16:36:55 +0300
Date:   Fri, 21 Aug 2020 16:36:55 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>
Subject: Re: [PATCH v4 0/3] TypeC Connector Class driver improvements
Message-ID: <20200821133655.GA3632995@kuha.fi.intel.com>
References: <20200820233833.4551-1-azhar.shaikh@intel.com>
 <5010d4f3-ac59-2a06-051c-83c8a51c3f4b@collabora.com>
 <MWHPR11MB1518972F760485B74C8BAB11915B0@MWHPR11MB1518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1518972F760485B74C8BAB11915B0@MWHPR11MB1518.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 01:34:46PM +0000, Shaikh, Azhar wrote:
> Hi Enric,
> 
> Sure, I will rebase, test and upload a new revision.

I don't think I have anything to add, so FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Regards,
> Azhar Shaikh
> 
> > -----Original Message-----
> > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Sent: Friday, August 21, 2020 12:13 AM
> > To: Shaikh, Azhar <azhar.shaikh@intel.com>; bleung@chromium.org;
> > groeck@chromium.org; heikki.krogerus@linux.intel.com;
> > pmalani@chromium.org
> > Cc: linux-kernel@vger.kernel.org; Mani, Rajmohan
> > <rajmohan.mani@intel.com>; Patel, Utkarsh H <utkarsh.h.patel@intel.com>;
> > Bowman, Casey G <casey.g.bowman@intel.com>
> > Subject: Re: [PATCH v4 0/3] TypeC Connector Class driver improvements
> > 
> > Hi Azhar,
> > 
> > I got a merge conflict because I applied [1] before these patches, fix the
> > conflict is trivial but, as I can't test, can you rebase your patches on top of [1]
> > and test and resend to make sure everything is working?
> > 
> > Thanks,
> >  Enric
> > 
> > [1] https://lkml.org/lkml/2020/7/10/1063
> > 
> > 
> > On 21/8/20 1:38, Azhar Shaikh wrote:
> > > Changes in v4:
> > > * Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
> > >             usb_role_switch_set_role()"
> > >   - Remove extra line between Fixes and Signed-off tag.
> > >   - Added Reviewed-by and Cc tags from v1 and v2.
> > >
> > > * Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
> > >             during disconnect"
> > >   - Added Suggested-by from v2.
> > >
> > > * Patch 3: "platform/chrome: cros_ec_typec: Re-order connector
> > >             configuration steps"
> > >   - No change
> > >
> > > Changes in v3:
> > > * Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
> > >             usb_role_switch_set_role()"
> > >  - No change
> > >
> > > * Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
> > >             during disconnect"
> > >  - Move the location of calling usb_role_switch_set_role() to
> > >    end of function in cros_typec_configure_mux() to avoid any change
> > >    in code flow.
> > >
> > > * Patch 3: "platform/chrome: cros_ec_typec: Re-order connector
> > >             configuration steps"
> > >  - New patch added
> > >
> > > Changes in v2:
> > > * Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
> > >             usb_role_switch_set_role()"
> > >   - Update the commit message to change 'USB_ROLE_HOST in case of
> > >     UFP.'  to 'USB_ROLE_HOST in case of DFP.'
> > >
> > > * Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
> > >             during disconnect"
> > >   - New patch added.
> > >
> > > Azhar Shaikh (3):
> > >   platform/chrome: cros_ec_typec: Send enum values to
> > >     usb_role_switch_set_role()
> > >   platform/chrome: cros_ec_typec: Avoid setting usb role twice during
> > >     disconnect
> > >   platform/chrome: cros_ec_typec: Re-order connector configuration
> > > steps
> > >
> > >  drivers/platform/chrome/cros_ec_typec.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >

thanks,

-- 
heikki
