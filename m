Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894FC2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbgG1SJQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:09:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:35867 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgG1SJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:09:16 -0400
IronPort-SDR: Podl3SA/hZga9EKXvSN8rXz1F468ZViZqC/EwUvTOhqxg+l9ab9JgazLT5GYJXvmM5T+5iVRZn
 2nD0QQsWkFAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="212815824"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="212815824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 11:09:15 -0700
IronPort-SDR: 90oPEjpQLzqV/BUf+NB161Qq2yRMD6UEpk3XbUOe8Xy6nygaTEfTAXwb7DRuF+he5bjqXFII5X
 PCG63b2wJ46w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="272389290"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2020 11:09:15 -0700
Received: from hasmsx603.ger.corp.intel.com (10.184.107.143) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 11:09:15 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX603.ger.corp.intel.com (10.184.107.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Jul 2020 21:09:12 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Tue, 28 Jul 2020 21:09:12 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: add device type
Thread-Topic: [char-misc-next] mei: add device type
Thread-Index: AQHWZPNjk3QaS6Bgd0uhPXjHTRu2T6kc8nYAgABXxkA=
Date:   Tue, 28 Jul 2020 18:09:12 +0000
Message-ID: <99bf1aa994d64699ab9722ef5db875d9@intel.com>
References: <20200728152546.3041841-1-tomas.winkler@intel.com>
 <20200728155408.GB4178776@kroah.com>
In-Reply-To: <20200728155408.GB4178776@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, July 28, 2020 18:54
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Usyskin, Alexander <alexander.usyskin@intel.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [char-misc-next] mei: add device type
> 
> On Tue, Jul 28, 2020 at 06:25:46PM +0300, Tomas Winkler wrote:
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > Some of the device heads are not generic and have specific purpose, we
> > need to announce it to the user space so it can detect and correct
> > device node via matching attributes.
> >
> > Generic devices are marked as 'mei' while special purpose their own
> > names. Currently we are adding 'itouch' string for Intel IPTS devices.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/misc/mei/hw-me.c   | 12 ++++++++++++
> >  drivers/misc/mei/hw-me.h   |  5 +++++
> >  drivers/misc/mei/hw-txe.c  |  1 +
> >  drivers/misc/mei/main.c    | 27 +++++++++++++++++++++++++++
> >  drivers/misc/mei/mei_dev.h |  4 ++++
> >  drivers/misc/mei/pci-me.c  |  8 ++++----
> >  6 files changed, 53 insertions(+), 4 deletions(-)
> 
> No Documentation/ABI/ update for this new sysfs file?

Hmm, looks like I've forgot to 'git add' 
Thanks
Tomas

