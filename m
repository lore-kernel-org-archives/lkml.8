Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7B0C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0252924686
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCJMnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:43:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:62686 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbgCJMnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:43:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 05:43:05 -0700
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="235924495"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 05:43:03 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id BEA8F209DF; Tue, 10 Mar 2020 14:43:01 +0200 (EET)
Date:   Tue, 10 Mar 2020 14:43:01 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH] media: i2c: ov5645: Add virtual_channel module parameter
Message-ID: <20200310124301.GD5379@paasikivi.fi.intel.com>
References: <20200228164126.17517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200305114314.GP5379@paasikivi.fi.intel.com>
 <CA+V-a8tGEYT7sOqzLRu8cx3u1DySt4mOz0UujU57SZSGqXB=Pw@mail.gmail.com>
 <CA+V-a8sXP98EkrvepX6hqj8oNE8c5o5PUtU306V_QYb1Bowjpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8sXP98EkrvepX6hqj8oNE8c5o5PUtU306V_QYb1Bowjpw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:17:10AM +0000, Lad, Prabhakar wrote:
> Hi Sakari,
> 
> On Fri, Mar 6, 2020 at 10:18 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Sakari,
> >
> > On Thu, Mar 5, 2020 at 11:43 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > On Fri, Feb 28, 2020 at 04:41:26PM +0000, Lad Prabhakar wrote:
> > > > OV5645 can operate in virtual channel 0-3 in CSI2 interfaces, this patch
> > > > adds support for module parameter virtual_channel to select the required
> > > > channel. By default OV5645 operates in virtual channel 0.
> > >
> > > What's your use case for different virtual channels?
> > >
> > Just ability to switch to different virtual channel, based on ov5640
> > driver. The rcar-csi2
> > has capability to capture  from multiple channels so that we can
> > capture simultaneously
> > from two sensors.
> >
> Any thoughts on how this could be handled ?

A module parameter to support sending the pixel data on virtual channels is
certainly a hack. You couldn't support the same kind of sensors with
different virtual channel configuration in a deterministic way nor the
receiver would have an ability to verify the hardware is properly
configured.

The multiplexed streams patchset (subject "[PATCH v3 00/31] v4l: add
support for multiplexed streams" on LMML) adds support for CSI-2 virtual
channels and data types. It's been a while since a version of that was
posted though.

Jacopo, what are your plans regarding that set?

-- 
Kind regards,

Sakari Ailus
