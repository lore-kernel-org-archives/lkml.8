Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA4C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EB32080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgCXOY2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:28 -0400
Received: from mail-oln040092253077.outbound.protection.outlook.com ([40.92.253.77]:16787
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbgCXOY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7fKdZ0/I0cJkN7/o0ibSGnTsConnSPf/NF6le/07+fUHs6e+s7IGM20VSTy1o9aALFDzvQGfhLMGHrhrCOEbA4zuz3/VdK2Dh/ZLODf0ts3f3le5QJR0FfYPEnx5CFQFxhrTDwKXy3ruFhe1EEUhTFKJ9qsIMXEjZhpYwYv1yGsFK5LnNUX4QoSuJO4ROPTeuuBnAzz5iKwzlIzOU72WZoj2OR/ks6bDY/Cfff9OHBwR37h79SXf4DWGye8KnJk1W0uyiY0qFzzF3nB4alCfUBw2HexYTBt2VOVbmoO4xWAkhmlOvtRv/QWZLoxANQmBkP/u5pIxwLdb9hL3yFwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jADZf31CgsvlW0Yn9CC6gPLuP8QiBUboyrkrdDrIME=;
 b=mKCNXPk7g/gfuJkGCqUpWnaogzU3QjRrkYz6pke6INnsl+YgXQ9nJiwRp/hqv1cf1riWQcIIbNg1NDvEfDnINxcXqHv/xzMGE4LeDtUK7wIUqE+kaUsb5KoSENUotfRPoN1OF8kY6DIQ9lyOTGOueiaB6A5ZBb4tCku8a+65hgcMYZaQdoAOF70jHBF1A6yLWQqMmJ9WKfAt4+S2N61OtvUxsqPYBIXZfjSIVYkQVjL7zw3kv/3/wPD7PK5qm70BufHDHnNZmLwNUIo7qfgsMF6evfb8xvf/AHGk7Yb8rhk9qAlNxFFR2HjckExrYiqzNwN82SrpFr+n/CqKQWbILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT062.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::33) by
 PU1APC01HT196.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::408)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Tue, 24 Mar
 2020 14:24:21 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.56) by
 PU1APC01FT062.mail.protection.outlook.com (10.152.253.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 14:24:21 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ddc:43b7:a639:8184]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ddc:43b7:a639:8184%9]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 14:24:21 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by SY3PR01CA0137.ausprd01.prod.outlook.com (2603:10c6:0:1b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 14:24:18 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
Thread-Topic: [PATCH 5/5] nvmem: Add support for write-only instances
Thread-Index: AQHWASPKeVmn6yF+NkittHqcSfj/BahWiaSAgAEiRgCAAAGUgIAAD60AgAAQVAA=
Date:   Tue, 24 Mar 2020 14:24:21 +0000
Message-ID: <PSXP216MB04387C07F1E4C827245DE98380F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
 <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
 <20200324122939.GA2348009@kroah.com>
 <300e8095-3af4-15a2-069f-87ac7cbb83bb@linaro.org>
In-Reply-To: <300e8095-3af4-15a2-069f-87ac7cbb83bb@linaro.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0137.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::22) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:36AEC87AFA384AE02622DCBA92A3329C9DC7D23EEBF78E6B475F1C4A69FB9B0E;UpperCasedChecksum:CC2E67C6B54EE22C0746090D39BA456E2456ECC01BA84189C2FE2698610FA31F;SizeAsReceived:8016;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [VrHv3cdpfqyC2U8pI2MJbEQCVib6uQB6KO+DhEOOb/9JEg16lh3u4/0P3wj+K3uf]
x-microsoft-original-message-id: <20200324142412.GA3564@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 9bb22140-69c4-43e4-4ab4-08d7cfff0aa2
x-ms-traffictypediagnostic: PU1APC01HT196:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LMmeACotuULUxEfTzbiIzajCIR59c3tjQzu7VMGHxqVUWoM0JDY9kuc3URi62bl193AykDf5G6IY7l+QVU0pG3gAtJnry+oxH0GSQDfYSzv9+Ex8r7YSfNCiNkAjkQu0LnwFsw5JSN8idj8BcATFdePQY/Zny1aFCEjBl6dMgsARC9kL5zmgTCVwqL7OTyJ0
x-ms-exchange-antispam-messagedata: kD937kK+sPbEoFq9KccnaeAdhA35gNe7eXTcT/bqRZMxj20IkJYc9AavUBWAdb6d+PSSGs/lmt/WaMNHAjU46X8xN+EplAQrJ8WweHYBi8MHWLO3n7m5cnN2Kulj+xcw+lUKlMZOZlpibpHzaktYyYcHLSoijuDPGA8s+z0QAq5iYwF627CYblMfZEDFfFr38zV58bMzvx4sNviRvCblTg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF4ACAD0E7D1104DA06001D97CD6B181@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb22140-69c4-43e4-4ab4-08d7cfff0aa2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 14:24:21.1726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 01:25:46PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 24/03/2020 12:29, Greg KH wrote:
> > > But the Idea here is :
> > > We ended up with providing different options like read-only,root-only to
> > > nvmem providers combined with read/write callbacks.
> > > With that, there are some cases which are totally invalid, existing code
> > > does very minimal check to ensure that before populating with correct
> > > attributes to sysfs file. One of such case is with thunderbolt provider
> > > which supports only write callback.
> > > 
> > > With this new checks in place these flags and callbacks are correctly
> > > validated, would result in correct file attributes.
> > Why this crazy set of different groups?  You can set the mode of a sysfs
> > file in the callback for when the file is about to be created, that's so
> > much simpler and is what it is for.  This feels really hacky and almost
> > impossible to follow:(
> Thanks for the inputs, That definitely sounds much simpler to deal with.
> 
> Am guessing you are referring to is_bin_visible callback?
> 
> I will try to clean this up!
I am still onboard and willing do the work, but we may need to discuss
to be on the same page with new plans. How do you wish to do this?

Does this new approach still allow us to abort if we receive an invalid
configuration? Or do we still need to have something in nvmem_register()
to abort in invalid case?

The documentation of is_bin_visible says only read/write permissions are 
accepted. Does this mean that it will not take read-only or write-only? 
That is one way of interpreting it.

I am further studying up on what was said in this email chain.

Regards,
Nicholas

> 
> thanks,
> srini
> > 
> > thanks,
> > 
> > greg k-h
