Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97738C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0482E206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgHFRZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:25:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:64102 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730283AbgHFRZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:25:45 -0400
IronPort-SDR: GiCGVqhsGD1OtAIvfDH+NGiGAbJAYdliFeJTqs1T5PMN8q4NBlNj0rmLqMt9obDhdg415mNNdF
 2k8Ru72/5I0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="170852068"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="170852068"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 04:39:11 -0700
IronPort-SDR: NTu3N6LJ5Wvo61B+4fxwImjZf/gwiJeMxDnfmY4s5sofJC5B/SgaPNs5YeCfL9O58bOjwnmVer
 N4GL+X13yszA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="397219766"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 06 Aug 2020 04:39:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 06 Aug 2020 14:39:07 +0300
Date:   Thu, 6 Aug 2020 14:39:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Message-ID: <20200806113907.GX883641@kuha.fi.intel.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com>
 <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730232504.GG3145664@google.com>
 <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
 <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 12:37:14PM -0700, Prashant Malani wrote:
> Hi Azhar,
> 
> 
> On Wed, Aug 5, 2020 at 12:22 PM Shaikh, Azhar <azhar.shaikh@intel.com> wrote:
> >
> > Hi Prashant,
> >
> > > Is this documented anywhere? Kindly provide the links to that if so. I wasn't
> > > aware of any ordering requirements (but I may be missing something).
> >
> > The configuration of the connector should always happen in the order defined in the
> > USB Type-C specification. Check ch. 2.3 (USB Type-C Spec R2.0). So that will basically give you:
> >
> > 1. orientation
> > 2. role(s)
> > 3. the rest.
> 
> Thanks for the link. Are you referring to Section 2.3 (Configuration
> Process) ? I couldn't find anything there which
> implied any required ordering (I'm reading Release 2.0, Aug 2019, so I
> don't know if something has been added since).
> Could you kindly point me to the appropriate subsection?

Please check the section 4.5.1.2 (Connecting Sources and Sinks). Check
the typical flow. You can also check the Connection State Machine
Requirements. The order should be clear from those as well.

1. Source/sink detection
2. Orientation
3. Data role
4. VCONN
5. VBUS (USB Type-C currents)
6. The connector is now configured. We can start the PD communication
   that should lead into configuration of the mux if we enter a mode.

The data role, the thing that we are talking about here, really should
be set before the mux is configured.

> Additionally, I think any ordering requirements there are already
> handled by the TCPM in the Chrome OS EC.

The TCPM does not execute the steps that configure the port on this
platform. The OS is the part that actually executes the steps.

That is one reason (but not the only one) why it is important that
both parts follow the order that is proposed in the spec. Otherwise we
may endup negotiating things with the partner in one order but then
actually executing those steps in some other.


thanks,

-- 
heikki
