Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B7C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033A52083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAQPAR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:00:17 -0500
Received: from mail-oln040092253056.outbound.protection.outlook.com ([40.92.253.56]:21248
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbgAQPAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgF4WCQai/uEY6yuINJyws2GFOXPfZIXtgZTHCuLWugFKXcUE+xbpDPhCdL/Wij4GiJvf474SnMeUsBojVmW6dioLHu3IVso9AseLNGbvcC+dVChL81LgbgD9U0/bxQ6esBZJbRip3Yvq/H3afyr7QHTz8tGl8jx0VNb5iupRsd20TtAi+5GIT3fijMZRtzfeUjsM/banz5DCR77tazR2opQpVD9lfmwBe9CH+lQZbRB6kmGKE2dimhATDmBYiNckdlKDVFk4IbpgfkSS7JnMh7ziL7ATtwj4gwQNpId1gGvIQKtiCpYC+6ffxLoB2DWoNSojXHF4URobuDPcYZ0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfPYtg8TPalTot3l1+3czeDMdyQ01cNVyKE4vNrnRFA=;
 b=JxJXStNs4HzgTjJ/UWXXbAXFhlGKGACQazCpqUy3wAmdwr7OucmOXO1aKCZmFTULcS3kLaNDqgJ7qpOwEHca/EFwWC0VB3AX9vHkguRNSTZNX3n/O6QkJsscCyO02GPtSyA/6d7ekXaCD8n4G6sRqdKYuuIyWKubz9903WvmcpE+zbDs8um+o+OBg2v7MOSU2J1IXkBGp2xzBMi+l8TMnPp+mPlgktfQemP4px/6q52f0FRqS+jGwinO320Jf+BEsY4ENX9gi6QVkx+enVC76y6zB0aOSuhEfK0WkigutTci3raOMz1CfzKjc0wy18RRa1mOsAZvPBrTR9tOzTDa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT008.eop-APC01.prod.protection.outlook.com
 (10.152.252.52) by PU1APC01HT138.eop-APC01.prod.protection.outlook.com
 (10.152.253.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Fri, 17 Jan
 2020 15:00:11 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT008.mail.protection.outlook.com (10.152.252.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 15:00:11 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 15:00:11 +0000
Received: from nicholas-dell-linux (49.196.159.155) by ME2PR01CA0072.ausprd01.prod.outlook.com (2603:10c6:201:2b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Fri, 17 Jan 2020 15:00:08 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [[RFC PATCH v1] 1/1] PCI: Add pci=nobbn to ignore ACPI _BBN
 method to override host bridge bus window
Thread-Topic: [[RFC PATCH v1] 1/1] PCI: Add pci=nobbn to ignore ACPI _BBN
 method to override host bridge bus window
Thread-Index: AQHVrtfd0zl4YBZzg0+ke2KUWaAOxqfuFpmAgAEZTQA=
Date:   Fri, 17 Jan 2020 15:00:11 +0000
Message-ID: <PSXP216MB043839BFAE70C02DB13DEA4A80310@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438F3D8C09957C6A45BC43D80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <87muandp8m.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87muandp8m.fsf@nanos.tec.linutronix.de>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0072.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::36) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:9E2DE0EEE5EBA2860F55747633ED9323CB0D7F884FCC4558F3BB4C2FCC5DDCAA;UpperCasedChecksum:E4A733694392F32FD1DA42F414CB586320203186BE1D247AAD92F43E0749A6CD;SizeAsReceived:7889;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [gvFW3KW/Agtjmr410ipGXVFUDYaPHjUV]
x-microsoft-original-message-id: <20200117150002.GA1622@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 8e58252b-d22e-4226-2243-08d79b5df310
x-ms-traffictypediagnostic: PU1APC01HT138:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: toOQ7ptIEpz90LZzI4bj5y70+tRN7SsozI4s2A7q0glIErPb2ZJNfZ7wb9KrUIiEgoErbv22W7/noy3GHKtuhR2y86mCl5xUnOdgH8VJ+kncw/0qVcoJ+VrSmmm8oUaZpZXRfxzGTkXPFwpjwvCAeZHWW5dBV8bEmFexOGX/ZLNbU4nEQDyVssW6jjV9T9t4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A547A4B8312A654F9B1403E8D3C0AE80@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e58252b-d22e-4226-2243-08d79b5df310
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 15:00:11.6525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:13:13PM +0100, Thomas Gleixner wrote:
> Nicholas,
> 
> Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> writes:
> 
> > Add pci=nobbn kernel parameter.
> >
> > Override the host bridge bus resource to [bus 00-ff] when specified.
> 
> Fine, but you completely fail to explain why this is useful and why
> someone would utilize this command line parameter.
There are motherboards with single PCIe root complex which give 
significantly less than [bus 00-ff] via CRS. I own one with [bus 00-7f] 
and have seen some with significantly less.

A user who wants to use more busses than the motherboard advertises will 
want to use this kernel parameter, for instance if they have a lot of 
PCIe switches or Thunderbolt 3 devices.

This is similar to how we have pci=nocrs to override motherboards with 
issues. The bus resource is not overridden by pci=nocrs, even though it 
will usually come from the same method. However, I believe it would be 
unwise to change pci=nocrs to include bus resource, as detailed in my 
original RFC.

> 
> Thanks,
> 
>         tglx

Thanks,
Nicholas
