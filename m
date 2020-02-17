Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FD5C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F80B2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgBQJQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:16:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:37103 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbgBQJQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:16:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 01:16:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,451,1574150400"; 
   d="scan'208";a="348459901"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 17 Feb 2020 01:16:44 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 Feb 2020 11:16:43 +0200
Date:   Mon, 17 Feb 2020 11:16:43 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/9] usb: roles: Leave the private driver data pointer to
 the drivers
Message-ID: <20200217091643.GC28776@kuha.fi.intel.com>
References: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
 <20200213132428.53374-5-heikki.krogerus@linux.intel.com>
 <1581758398.3473.3.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581758398.3473.3.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 05:19:58PM +0800, Chunfeng Yun wrote:
> On Thu, 2020-02-13 at 16:24 +0300, Heikki Krogerus wrote:
> > Adding usb_role_switch_get/set_drvdata() functions that the
> > switch drivers can use for setting and getting private data
> > pointer that is associated with the switch.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/roles/class.c | 22 ++++++++++++++++++++++
> >  include/linux/usb/role.h  | 16 ++++++++++++++++
> >  2 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> > index 63a00ff26655..f3132d231599 100644
> > --- a/drivers/usb/roles/class.c
> > +++ b/drivers/usb/roles/class.c
> > @@ -329,6 +329,7 @@ usb_role_switch_register(struct device *parent,
> >  	sw->dev.fwnode = desc->fwnode;
> >  	sw->dev.class = role_class;
> >  	sw->dev.type = &usb_role_dev_type;
> > +	sw->dev.driver_data = desc->driver_data;
> How about use dev_set_drvdata()? will keep align with
> usb_role_switch_set/get_drvdata(), 

Yes, makes sense. I'll change that.

Thanks,

-- 
heikki
