Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8816DC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628D3207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgG1XIt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:08:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:10208 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729819AbgG1XIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:08:46 -0400
IronPort-SDR: YryL9kZQr6GOZIXivaA1dZndb7w2kQmqqzPIjc3bi743dSYNXvC8O20+R9pVIr9c9RTM7NILqQ
 80gqnZmCt5aQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="152569856"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="152569856"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 16:08:44 -0700
IronPort-SDR: YuITTUP33/44UGDYPUZ6p5FKgySuh6vNoAVz3Bhwrd4daAC6ofWlpUqO5V37J4jgNCGeMmrYhG
 6F15n4wp+kbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="273706883"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2020 16:08:44 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 16:08:44 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX602.ger.corp.intel.com (10.184.107.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 02:08:41 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 29 Jul 2020 02:08:41 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: RE: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Thread-Topic: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Thread-Index: AQHWZSfolBoy0+Wd50OY4DSCzkXDIakdV1+AgAAxzgD//9MtAIAAMULw///dJACAADLgQA==
Date:   Tue, 28 Jul 2020 23:08:41 +0000
Message-ID: <cbaded6deed64ad1a69ea99d2a235a54@intel.com>
References: <20200728214139.3129532-1-tomas.winkler@intel.com>
         <e80a9e75-4497-1587-deab-b5c6a0fcc48f@embeddedor.com>
         <8ec7601780b542c2bc0168e03749ec0e@intel.com>
         <d6ef8ca4-6e11-b758-0e24-75301e1a5303@embeddedor.com>
         <398e20e8c3f7436bb50d671b9aa9f809@intel.com>
 <90f4d174d8a2d50104ad52aa0bd4e0ece86f2e90.camel@perches.com>
In-Reply-To: <90f4d174d8a2d50104ad52aa0bd4e0ece86f2e90.camel@perches.com>
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

> On Tue, 2020-07-28 at 22:14 +0000, Winkler, Tomas wrote:
> > > -----Original Message-----
> > > From: Gustavo A. R. Silva <gustavo@embeddedor.com>
> []
> > > I'm using this command:
> > >
> > > $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback
> > >
> > > and this is the output for both files:
> > >
> > > $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback
> > > drivers/misc/mei/hdcp/mei_hdcp.c Arnd Bergmann <arnd@arndb.de>
> > > (supporter:CHAR and MISC DRIVERS) Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)
> > > linux- kernel@vger.kernel.org (open list) $
> > > scripts/get_maintainer.pl --nokeywords -- nogit --nogit-fallback
> > > drivers/misc/mei/hdcp/mei_hdcp.h Arnd Bergmann <arnd@arndb.de>
> > > (supporter:CHAR and MISC DRIVERS) Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)
> > > linux- kernel@vger.kernel.org (open list) For some reason you don't
> > > appear on the list above. Do you see anything wrong with the command
> I'm running to get the maintainers and lists?
> >
> > Not sure, it should be caught by drivers/misc/mei/* ?
> 
> No, this pattern matches _only_ files in that particular directory and not any
> files in any subdirectory.
> 
> > Maybe it is not recursive?
> 
> It depends on the pattern.
> Patterns with trailing slashes match subdirectories too.
> 
> from MAINTAINERS:
> 
> 	F: *Files* and directories wildcard patterns.
> 	   A trailing slash includes all files and subdirectory files.
> 	   F:	drivers/net/	all files in and below drivers/net
> 	   F:	drivers/net/*	all files in drivers/net, but not below
> 	   F:	*/net/*		all files in "any top level directory"/net
> 	   One pattern per line.  Multiple F: lines acceptable.
> 
> 
> > Need to check the script,
> > frankly I usually check this manually.  prob
> >
> > INTEL MANAGEMENT ENGINE (mei)
> > M:      Tomas Winkler <tomas.winkler@intel.com>
> > L:      linux-kernel@vger.kernel.org
> > S:      Supported
> > F:      Documentation/driver-api/mei/*
> > F:      drivers/misc/mei/*
> 
> You probably want:
> 
> F:	drivers/misc/mei/
Yes, thanks.
Tomas

