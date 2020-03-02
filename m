Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C6124699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCBIBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:01:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:12695 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBIBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:01:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 00:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="351486608"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2020 00:01:46 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 02 Mar 2020 10:01:45 +0200
Date:   Mon, 2 Mar 2020 10:01:45 +0200
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
Message-ID: <20200302080145.GA22243@kuha.fi.intel.com>
References: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
 <20200224121406.2419-6-heikki.krogerus@linux.intel.com>
 <20200224131442.GA5365@b29397-desktop>
 <20200302062302.GE3834@b29397-desktop>
 <20200302074303.GB27904@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302074303.GB27904@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 09:43:07AM +0200, Heikki Krogerus wrote:
> > > > -	cdns->role_sw = usb_role_switch_register(dev, &cdns3_switch_desc);
> > > > +	sw_desc.set = cdns3_role_set,
> > > > +	sw_desc.get = cdns3_role_get,
> > > > +	sw_desc.allow_userspace_control = true,
> > 
> > Heikki, when I try to apply above, and compile, I find above issue,
> > the end of code should be ";", but not ",".

So it seems my compiler happily compiles the above :-)

I don't know what is going on with my compiler, but I'll fix that.


thanks,

-- 
heikki
