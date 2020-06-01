Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44533C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202BE206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgFAVZb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:25:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:52785 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbgFAVZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:25:29 -0400
IronPort-SDR: 0bseIB+4g3Kj71i1U2/yFAo76v7H7jXSpXPJzJcImMEX3al9rMoSu/a8tsiCT5/L3xjXVasNMr
 HRZxa+cUxtmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 14:25:28 -0700
IronPort-SDR: s1XBa8o+ziq5W75mwbzvp+/Z/bykPRU7jO6wJL6KeijgwGh2VJlFOxPrTFoiXevQpjqNFVRBxz
 2jC8piB35w8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="303770420"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2020 14:25:27 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 14:25:27 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX602.ger.corp.intel.com (10.184.107.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 2 Jun 2020 00:25:25 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Tue, 2 Jun 2020 00:25:25 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Dorian Stoll <dorian.stoll@tmsp.io>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: me: Add itouch device IDs for SPT / ICP
Thread-Topic: [PATCH] mei: me: Add itouch device IDs for SPT / ICP
Thread-Index: AQHWOC5DxbJKJY4NZEyE7jjAFJ52tKjD8m1A///d24CAAHKEYA==
Date:   Mon, 1 Jun 2020 21:25:25 +0000
Message-ID: <26b73aff781d417fbb93777e63501393@intel.com>
References: <20200601155954.764558-1-dorian.stoll@tmsp.io>
 <b22a353f4d4f47df9676c9572b6ac773@intel.com> <4082996.zthe6f22So@desktop>
In-Reply-To: <4082996.zthe6f22So@desktop>
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

> 
> >
> > > These device IDs can be found on Microsoft Surface devices.
> > >
> > > Signed-off-by: Dorian Stoll <dorian.stoll@tmsp.io>
> >
> > This need to be done differently because of the server platforms conflict.
> > I have patches for that I will post short, though we are not
> > officially supporting those devices under Linux, It will be hard to maintain,
> as currently on the MS surface enables it as far as I know.
> >
> 
> Thank you for your response!
> 
> If you don't mind, could you elaborate on these devices not being supported
> under Linux? Is it just that the functionality they provide (Intel Precise Touch
> & Stylus / iTouch / IPTS) won't be supported? Because that I already know,
> and it is not the intent of this patch. Or do you mean that the entire MEI
> interface won't be supported for these devices?

Just the iTouch.

> 
> Some context on this patch: I am part of a small team of volunteers who try
> to make the MS Surface devices usable under linux, including the
> touchscreen (which uses IPTS as of the Surface Pro 4).

Nice work.

> The IPTS driver connects to the device over the MEI bus, but the MEI device is
> provided by the iTouch devices. Currently we build our own kernels with this
> patch applied to allow the driver to work. All of this is loosely based on a
> driver that Intel published a few years ago.

Yes, I'm fully aware of that code base.
 
> Since the driver is otherwise pretty much standalone,
You do depend on i915, that's the hard part.
> my hope was that
> adding these IDs would make it easier to develop / install our driver without
> having to recompile the entire kernel (i.e. using DKMS). At least until the
> driver has matured enough and is ready for upstream submission itself.
> Especially since other iTouch devices have their device IDs added already.

Agree. 
 
> That this would cause conflicts is unfortunate. Judging purely by your words
> - without having any deeper knowledge about the MEI bus - it seems that it
> might be possible to fix these conflicts? If thats true, I hope it would also be
> possible to add these IDs, so that just the MEI interface to IPTS becomes
> supported - 

Yes, I'm working on that just now.

> I don't expect you to support the entire IPTS technology.

Yep, unfortunately it's not going to be funded by my wife.

> > > ---
> > >  drivers/misc/mei/hw-me-regs.h | 2 ++
> > >  drivers/misc/mei/pci-me.c     | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-
> > > regs.h index 9392934e3a06..90e7d3020fa5 100644
> > > --- a/drivers/misc/mei/hw-me-regs.h
> > > +++ b/drivers/misc/mei/hw-me-regs.h
> > > @@ -59,6 +59,7 @@
> > >
> > >  #define MEI_DEV_ID_SPT        0x9D3A  /* Sunrise Point */
> > >  #define MEI_DEV_ID_SPT_2      0x9D3B  /* Sunrise Point 2 */
> > > +#define MEI_DEV_ID_SPT_4      0x9D3E  /* Sunrise Point 4 (iTouch) */
> > >  #define MEI_DEV_ID_SPT_H      0xA13A  /* Sunrise Point H */
> > >  #define MEI_DEV_ID_SPT_H_2    0xA13B  /* Sunrise Point H 2 */
> > >
> > > @@ -90,6 +91,7 @@
> > >  #define MEI_DEV_ID_CDF        0x18D3  /* Cedar Fork */
> > >
> > >  #define MEI_DEV_ID_ICP_LP     0x34E0  /* Ice Lake Point LP */
> > > +#define MEI_DEV_ID_ICP_LP_4   0x34E4  /* Ice Lake Point LP 4 (iTouch)
> */
> > >
> > >  #define MEI_DEV_ID_JSP_N      0x4DE0  /* Jasper Lake Point N */
> > >
> > > diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> > > index
> > > a1ed375fed37..5e621e90d8d4 100644
> > > --- a/drivers/misc/mei/pci-me.c
> > > +++ b/drivers/misc/mei/pci-me.c
> > > @@ -68,6 +68,7 @@ static const struct pci_device_id mei_me_pci_tbl[]
> > > = {
> > >
> > >  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT, MEI_ME_PCH8_CFG)},
> > >  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
> > > +	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_4, MEI_ME_PCH8_CFG)},
> > >  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_CFG)},
> > >  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_CFG)},
> > >  	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_SPS_CFG)},
> @@ -94,6
> > > +95,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
> > >  	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_CFG)},
> > >
> > >  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
> > > +	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP_4, MEI_ME_PCH12_CFG)},
> > >
> > >  	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH15_CFG)},
> > >
> > > --
> > > 2.26.2
> > >
> >
> >

