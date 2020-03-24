Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3564BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC9F20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgCXQAD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:00:03 -0400
Received: from mail-oln040092255013.outbound.protection.outlook.com ([40.92.255.13]:40352
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727665AbgCXQAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:00:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKOJgDAHhc9aXDWrQpaTkfk/3wiZyu2uoNuOV2Y2msps13/BtTtwuXWkFgxcM9yCqUoO5hSLNliPCRHJZInPOm8ZLLbBw9dKS4ugetQ13kO+XSyu0BvX+vNweVvUh9pBpR1iqd1yt++LtUbKb+LmoQxhNcqQfSe+YwrcQi87GTb3s/mdn24k27LOw8Mtp8N7QuBltwmp5juvotEPdFossR+5/few2hcjbakbFSVu7hpJ6IoD3LOf55DLCpghv46xJxmDfZ5fq4rx0bTZZPMDaaI4ld9IVMqbGPeUlbuYkyCUulpj3YLk54buMbgRDIrMZJ76PW7r2QpWwjy9t7LLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elen3z5WK25/4nvI6ahXlZnuzbdsCqqwdDZ7jk7QHsM=;
 b=YacZsmao7ofdVmeZ8YECaKP10nhuxtEowYBKBZXO1z/GaGyo1ZBwwHaYG57ubCpmEakVPWMcMmmJrlM2ScaZr5vyeHnKN09NMPsyZq5J58fb2BLn13zcxZSwjtqfhFSwfWG/Xv1PKjsafN/wHFGc8bSYU9S8dDDe2I+RSTvGza33wL6PqI37V/hF5twzx/LEConVBbwJeziR6Vf4dbJQTWWBUl0b4I6WoHNjM9/rETy/CcXkQS7BsUy/TWYBKC8lwGzVqmyB/l24CjTwWyx5UT4Q9PR5MyxGm1fcGJ3kMAj6r6ypxUL2upSq4waAS2X9vUY/Hdq5Z9bpngbFxcTc2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT008.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::35) by
 PU1APC01HT194.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::434)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Tue, 24 Mar
 2020 15:59:58 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT008.mail.protection.outlook.com (10.152.252.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 15:59:58 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ddc:43b7:a639:8184]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ddc:43b7:a639:8184%9]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 15:59:58 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by SYXPR01CA0108.ausprd01.prod.outlook.com (2603:10c6:0:2d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend Transport; Tue, 24 Mar 2020 15:59:56 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
Thread-Topic: [PATCH 5/5] nvmem: Add support for write-only instances
Thread-Index: AQHWASPKeVmn6yF+NkittHqcSfj/BahWiaSAgAEiRgCAAAGUgIAAD60AgAAQVACAAA8tgIAAC4sA
Date:   Tue, 24 Mar 2020 15:59:58 +0000
Message-ID: <PSXP216MB0438A3D7BBFA080B7780436980F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
 <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
 <20200324122939.GA2348009@kroah.com>
 <300e8095-3af4-15a2-069f-87ac7cbb83bb@linaro.org>
 <PSXP216MB04387C07F1E4C827245DE98380F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200324151831.GA2510993@kroah.com>
In-Reply-To: <20200324151831.GA2510993@kroah.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0108.ausprd01.prod.outlook.com
 (2603:10c6:0:2d::17) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:8DA8BD08CF81D6947AF99FD218138E9765AE9F5C473414975B653C4ECEC02EB1;UpperCasedChecksum:052CC63B377F4C49EA0180F2433E897EDAC91D013A854CFD93FC2F92F96C1EF3;SizeAsReceived:8148;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [bPo0ay14/ZYG7GBfBAX+L9rGG1YrDjLu6qiApvnY85bJPGqtyd+g7R0lnLEmWwwW]
x-microsoft-original-message-id: <20200324155950.GA1803@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 9cd8c706-35a8-4f1c-b241-08d7d00c66be
x-ms-traffictypediagnostic: PU1APC01HT194:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKkqT3ODIJuZ8T4lVuE9U/6ODyb2hyuA9xctCl0jB/NT8QIBIcYfSbVimrTkHSMzzXmQmnBvTdeDlsGdSH7UFrg4ec0nN79eC9GWZY5gU94+Qjq3lklspfPN2l7hXwq1nqUNcfFWaOekEDD9r9FOPToQFC+8ilxlG/oIbUgE66W4qlWqDUxlstPE5vIGp962
x-ms-exchange-antispam-messagedata: 1/9dBWPYiybB0aooPQ9vSc9nrspCjJixCo7n4qGfH/nv2eDnE5soebST7FTHkwCKu82NVUDXzIv883SRZcLbli1juiRhUqHuUsHD4SoFlKqQSbb1t5knjUqtRSzYYxIxyJcSQr/jVFV1JsCO5Uq4rIzp+pqS2/SeYxe6qIVMw+cKBj91QwCFNlgYdZBM75aWGbByA45cR0d6lY+vuDuk2g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D588950A34DB3D4EBD8624E2FC641DAE@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd8c706-35a8-4f1c-b241-08d7d00c66be
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 15:59:58.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:18:31PM +0100, Greg KH wrote:
> On Tue, Mar 24, 2020 at 02:24:21PM +0000, Nicholas Johnson wrote:
> > On Tue, Mar 24, 2020 at 01:25:46PM +0000, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 24/03/2020 12:29, Greg KH wrote:
> > > > > But the Idea here is :
> > > > > We ended up with providing different options like read-only,root-only to
> > > > > nvmem providers combined with read/write callbacks.
> > > > > With that, there are some cases which are totally invalid, existing code
> > > > > does very minimal check to ensure that before populating with correct
> > > > > attributes to sysfs file. One of such case is with thunderbolt provider
> > > > > which supports only write callback.
> > > > > 
> > > > > With this new checks in place these flags and callbacks are correctly
> > > > > validated, would result in correct file attributes.
> > > > Why this crazy set of different groups?  You can set the mode of a sysfs
> > > > file in the callback for when the file is about to be created, that's so
> > > > much simpler and is what it is for.  This feels really hacky and almost
> > > > impossible to follow:(
> > > Thanks for the inputs, That definitely sounds much simpler to deal with.
> > > 
> > > Am guessing you are referring to is_bin_visible callback?
> > > 
> > > I will try to clean this up!
> > I am still onboard and willing do the work, but we may need to discuss
> > to be on the same page with new plans. How do you wish to do this?
> > 
> > Does this new approach still allow us to abort if we receive an invalid
> > configuration? Or do we still need to have something in nvmem_register()
> > to abort in invalid case?
> > 
> > The documentation of is_bin_visible says only read/write permissions are 
> > accepted. Does this mean that it will not take read-only or write-only? 
> > That is one way of interpreting it.
> 
> That's a funny way of interpreting it :)
Now that I look back, yes.

> 
> Please be sane, you pass back the permissions of the file, look at all
> of the places in the kernel is it used for examples...
It's more inexperience and sleep deprivation than insanity. I am working 
on those. :)

There is only one use of is_bin_visible but a lot for is_visible, so I 
will go off those.

Regards,
Nicholas

> 
> thanks,
> 
> greg k-h
