Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EF62065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbgG1TQ7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:16:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:37804 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbgG1TQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:16:58 -0400
IronPort-SDR: oYMgtKw7WgQxnshU1GNf4kwnMLpNCn0XkXiM6d43LFwgbHwPMIub4xSxvcS0VLgePv2QCz8iIa
 VW3NFTBXQ+/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="169415910"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="169415910"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 12:16:58 -0700
IronPort-SDR: GDgLdRPeToXtmqek9PW4+XwtLwt371zb5zT43jdHLEP6G6Lw3Ux25ZWb+bY/66WxbggDbwWWmT
 JfdQ1P5urrlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="490008716"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jul 2020 12:16:58 -0700
Received: from lcsmsx601.ger.corp.intel.com (10.109.210.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 12:16:58 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX601.ger.corp.intel.com (10.109.210.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Jul 2020 22:16:55 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Tue, 28 Jul 2020 22:16:55 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next V2] mei: add device kind to sysfs
Thread-Topic: [char-misc-next V2] mei: add device kind to sysfs
Thread-Index: AQHWZQzsP7MTlAgR70GuvAbRthg4rqkdJAuAgAA4N3A=
Date:   Tue, 28 Jul 2020 19:16:55 +0000
Message-ID: <8a88b1db0b9447ebaa37636a68e3b018@intel.com>
References: <20200728182836.3112138-1-tomas.winkler@intel.com>
 <20200728185219.GA332869@kroah.com>
In-Reply-To: <20200728185219.GA332869@kroah.com>
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
> On Tue, Jul 28, 2020 at 09:28:36PM +0300, Tomas Winkler wrote:
> > +/**
> > + * kind_show - display device kind
> > + *
> > + * @device: device pointer
> > + * @attr: attribute pointer
> > + * @buf: char out buffer
> > + *
> > + * Return: number of the bytes printed into buf or error
> 
> No need for kernel doc for static sysfs attributes, but ok...
> 
> > + */
> > +static ssize_t kind_show(struct device *device,
> > +			 struct device_attribute *attr, char *buf) {
> > +	struct mei_device *dev = dev_get_drvdata(device);
> > +	ssize_t ret = 0;
> 
> No need to initialize this.
Right, a leftover from an earlier version. 
> 
> > +
> > +	mutex_lock(&dev->device_lock);
> > +	if (dev->kind)
> > +		ret = sprintf(buf, "%s\n", dev->kind);
> > +	else
> > +		ret = sprintf(buf, "%s\n", "mei");
> > +	mutex_unlock(&dev->device_lock);
> 
> Why do you need a lock?  kind can not change, so what are you trying to
> protect from?
There might be firmware initiated reset but in this particular case you are right,  the lock is not needed.

Will resend. 

