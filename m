Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C04C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B9424697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbgB0OqX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:46:23 -0500
Received: from mail-oln040092254022.outbound.protection.outlook.com ([40.92.254.22]:14640
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729755AbgB0OqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:46:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts2yrL6AqUiZhx6mDfEk2TFofhzDXx9gDbBo7gRnPm2nvdvMs5PSDPaA6jsY6fKaqItbvk5g7827T8FsftsBC9IQ5Nil5y/fzidKmlbqTOLUSgT8W6FdGnChpdD+OOBjIM4L/VuuOILUR/VNZV/T9U6n0S1dU093/kEAdYejw0DSVfDce5sShGdr/xjQgKEZ9yJ67HiAszZNb2PiuP20euzEc01mfaEshOPR+pSBSw48NEpgb5dWmgfUJYCAMoLajF3EF0clEi3FTfP1vtQfG2SX/Fltv11nSydBFCWpYOZtuob7nNfy+EyBF88h2SK8QkAIY9tr1IpSK68qUtr/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ntTQNy0CliiNY5nZR1pPxFaxTj7ROQ/IqebY5g1vTA=;
 b=Qb856NOj+DNVzINu7MH62VQ2ejI5FwaSbqna+B+zsQ1N/6SZjQyRZBsRsMVhSJzuqEhPBZi1owqneGFykYDnpOT5opfOPbv6cmb8pdzM+VXyiwtLQ/WkCrsUMBl1qrAZ34BjjtHsy9b9yvmf8pwf8NOZCuth1pVwDIUnRdopJ08HoLXWIP3WVaWiD++eaHJ/+FA4hdQaRGIjGfLS9adFsiSrNjyv1aCEM/2j7K6/44J0DTh4U8uQt9/i8iA8mMd8Rtr6geBmf56UssL0j7mnMizikRpBTb5/vRAImZPbXdpZp09ojE4iTlAZ9lYW4J95VZqRCQXDP5LqlmiYitjnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::3c) by
 PU1APC01HT069.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::303)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 14:46:16 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 14:46:16 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 14:46:16 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by MEAPR01CA0068.ausprd01.prod.outlook.com (2603:10c6:201:30::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 14:46:14 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 1/3] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v1 1/3] nvmem: Add support for write-only instances
Thread-Index: AQHV6znL/WLrUn36h0+sGzQwuak0Iqgr3jKAgAAsTQCAAAPEgIADFJEA
Date:   Thu, 27 Feb 2020 14:46:16 +0000
Message-ID: <PSXP216MB04381086B6856A80C95B95A580EB0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB043820B6E11AE4E78374C7F980EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200225125141.GA2667@lahna.fi.intel.com>
 <PSXP216MB0438D95E25CA8BA02A40735480ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200225154343.GG2667@lahna.fi.intel.com>
In-Reply-To: <20200225154343.GG2667@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0068.ausprd01.prod.outlook.com
 (2603:10c6:201:30::32) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:0487FF929C0969D716DB602668B3B9011A90CE5C8DB32499751E4413A5769976;UpperCasedChecksum:532D496379443EF09A82B909A6D766FBE901C370FF74B1CD776A87164CFDAFC2;SizeAsReceived:8085;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [51SMhO1osz6/rgBmq3IrEtAnAp/3sZWVflib8b69feg5889piDNWiMntVKUtvBAz]
x-microsoft-original-message-id: <20200227144606.GA1920@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: e0d42125-649c-4e24-7792-08d7bb93cc05
x-ms-traffictypediagnostic: PU1APC01HT069:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tchkhqNHE9C0z4BFJIMO5V0QpR75OE4w9KQNODgZ37usAHhVamTy/87YoI9C50m3WgVNcGjxgUdvLBvb9kMiS8+ZndxOhAQxBFH5DUl9p4DoiEMs15oCzgGWjlcsq1Uu45alm1F9NysZTrMImOuBqfVfHxR5tXxF2yVHji5jxVfkizmwx6x/w/dhu9xZeAab
x-ms-exchange-antispam-messagedata: SXxbuvlasFKNFzEmH2Ceuvqera+NsrkpEnm1xAJ7IvkkvokQRSHhXI2e2N23W/91gWAmzuZLSBFwpOkq41S/u9Uq1Cw3dmwx/LXn8B7xvEvuN8d7KPCTMxsw8hmUUS2OrZyoA4zeVjPnqACYaFuDUkycg9ruYEyTQrOhfBnHaGXlqwidPU36BzGISEbrqHBL+lkQt2wo+dpnHW/pPjhniA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19CB3C01094EF44D88B9BAE8D688C016@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d42125-649c-4e24-7792-08d7bb93cc05
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 14:46:16.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 05:43:43PM +0200, Mika Westerberg wrote:
> On Tue, Feb 25, 2020 at 03:30:22PM +0000, Nicholas Johnson wrote:
> > > Actually I think maybe we make this one only writeable by root, in other
> > > words it would always require ->root_only to be set.
> > There is a world-accessible rw entry already, which would, if anything, 
> > be even more dangerous than a world writable entry. However, there could 
> > be a hypothetical use case. I agree it is unlikely to be required, but 
> > who knows?
> 
> You mean 0644 entry? That should be fine as it is not writable by anyone
> else than the owner (root in this case).
Oops, you are right. I glossed over this and in my head thought it was 
0666 for some reason, and that is why mine was 0222. Sorry for the 
confusion. :(

My 0222 would have to become 0200 which would be the same as the 
root-only one, because 0244 would be utter nonsense.

> 
> > Based on your statement that no sysfs should ever be world-writable, 
> > should I be trying to remove the world-accessible rw as well?
> 
> No I don't think it is necesary. Just let's not add attributes that
> anyone can write without good reasoning ;-)
I can change nvmem_register() to return NULL if nvmem_sysfs_get_groups() 
returns NULL and that way I can return NULL from 
nvmem_sysfs_get_groups() in the instances we do not want to honour. This 
will also remove the need for me to WARN_ON when neither reg_read nor 
reg_write are provided - I can just return NULL.

I could also change the "root_only" flag to be named "world_readable" 
and invert the logic. That way I can deny world writable and still be in 
the clear. This would make me happy about denying world-writable 
requests, because the variable being false would no longer imply 
world-writable privileges. I feel like "world_readable" is a more 
accurate description of what the variable is intended for. This can be a 
single commit with no functional changes (easy sign-off) at the start of 
the series.

Srinivas, please offer your opinion on the above proposals, if you have 
one. :)

I will aim for 2020-03-02 (Monday) for PATCH v2, to give myself adequate 
time to reflect on feedback and to try to get it right.

Thanks!

Kind regards,
Nicholas
