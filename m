Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7479C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8373B2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgCDQDv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:03:51 -0500
Received: from mail-oln040092255080.outbound.protection.outlook.com ([40.92.255.80]:6071
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgCDQDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:03:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvdU18pJDxG2xXKore6ScpF8FP40Zn+LpdkQxqoFDfod5lu97gjKSCQGen07OQS09IGx/2pvcaUS+oLWMO3oPpbAqBkz0+qFYEUs3jXXXVesl/eCUnS56TZgym1ThgNBB185qrSWkreCCvmSpydknGZgN5oTbkzn+CletGq9SvWNJaFIIiVnmd5CkzYbzSOViKl2znj5/lot4bt/7wgYruqC2TAHDeBoBRcLuCOAlJyz+J74UXJAUlE/4I07wAxyKb9oY/dn7lEBRiCBVyG3qZ/pGecndLW/+2idRo/EDPz5+dgFlEI3HE8hPVaYv/l49aAf2/rSp61xf1+PyUBasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj9mH37PyE4LbLmwiC8aESnDN5mOjPxPLO0g1KgEY5g=;
 b=VpoZv3v7U6QqnvvwcR8QVVzREXCBPWVTICs3CDIcwadclhCzju8P+57ZNG0kiyMaktAdUGtz5fY87fbauQuXZMgWdlMv23EKC/jPagiW68Mhsj6eh1fNcnrdBGkwjNrSrdQSURux54J/JYA3j5l6VPqxtXAGZn9CEQ6j7bB7M7lCMRarBG67WpVJLuEPdwP115Z7IbA6LPoSUVeraZiTiX6LkLDZQY/LYQp9mlX6AOTek5OR1KUJsCkbZwhM0SdpkUTHIg20gyBK9VxcY8HJCqPKmzvLEJiEdh/yhIDvJ7RCbPmVd2hJvoHdiZWKrPhZKvgWe+S1ghMtJWbmmHylvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::3b) by
 PU1APC01HT014.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::150)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Wed, 4 Mar
 2020 16:03:46 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:03:46 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:03:46 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME1PR01CA0125.ausprd01.prod.outlook.com (2603:10c6:200:19::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 16:03:45 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/3] nvmem: check for NULL reg_read and reg_write
 before dereferencing
Thread-Topic: [PATCH v2 2/3] nvmem: check for NULL reg_read and reg_write
 before dereferencing
Thread-Index: AQHV8KlCqOzxWYRvokel+qEls5/4v6g2rAsAgAHvkoA=
Date:   Wed, 4 Mar 2020 16:03:46 +0000
Message-ID: <PSXP216MB0438A73D6C6EC2FF4EA102DE80E50@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB0438A1EEBF56DF852F18F14580E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200303102956.GM2540@lahna.fi.intel.com>
In-Reply-To: <20200303102956.GM2540@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME1PR01CA0125.ausprd01.prod.outlook.com
 (2603:10c6:200:19::34) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:26799587320B260C5796456294F272CEB29E74FEE3550B3E1BFB8F64F68DF513;UpperCasedChecksum:24F1C920A8D223B9EE6E4D3E074B56F3A38FAA1950D59266B3F981D79D2D5A1D;SizeAsReceived:7980;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [KPldaVRASJ6VtKyeZMSCASjVbzWwbdHUPfv/b/1HhTthXUKWpA8kbYX83w03E6gA]
x-microsoft-original-message-id: <20200304160339.GA2300@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 03e1d57e-6c06-4d45-f5d6-08d7c0559e99
x-ms-traffictypediagnostic: PU1APC01HT014:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/8MDeVwazpXfn7iIVFOTIZznE4ZUh7+6LbpJwB3g21hl/t4+4wfsuSuudwrUFKyNuXk2O/vE5aD9GbPwgRgGNHcrwEKcmDu0tFljqeGXYBrB93BKmSk8SmmVNhl1PKhss5WmSbvXmLSOGfDrtEP3V/0X0CgcTWlr1ZpBNdi/d9VS2oq1J/rZLxh7PsUjX8g
x-ms-exchange-antispam-messagedata: GOJic5IKNdanO653yzh44d5f0aH97ebGZus+YlYOtJOp1FhPOQ5SQuOTvCux/QCtSDJkpmosSvo+92Xw0y4lhTI7pKjkwtOJbnvu16bejfzD3eUp6I5bSNyXGMpP3UfyJQTVXgFdtZvZQsR5IR2T4fuuUWfc43Z/gx0xnZ9u/6ZwT+emPbEtKnkTRyDRjkzrY25bjBQZeHpXJxCT0Sr4rg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4F6E631FE9BA0478E51D3D908A715B2@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e1d57e-6c06-4d45-f5d6-08d7c0559e99
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:03:46.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:29:56PM +0200, Mika Westerberg wrote:
> On Mon, Mar 02, 2020 at 03:43:02PM +0000, Nicholas Johnson wrote:
> > Return -EPERM if reg_read is NULL in bin_attr_nvmem_read() or if
> > reg_write is NULL in bin_attr_nvmem_write().
> 
> Hmm, is this patch required at all since you already check the invalid
> combinations in the patch 1/3?
This is checked in nvmem_reg_read() and nvmem_reg_write() in 
drivers/nvmem/core.c - for consistency, perhaps both should be done. 
Also, defensive programming is a good idea, because code changes might 
allow for a NULL to slip through in the future. But you are correct, at 
this moment in time, we should not be able to cause a NULL dereference 
(at least as far as I can tell).

Srinivas can either apply this patch or not, so if it is decided this is 
not needed, I will not need to do a PATCH v3. Patch 3/3 does not 
conflict with this patch.

Cheers
