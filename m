Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D963CC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56D121744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgBYPdE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:33:04 -0500
Received: from mail-oln040092253074.outbound.protection.outlook.com ([40.92.253.74]:35168
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731053AbgBYPdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:33:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKGdOBKIwDX6S0Kip9uWaFFk5wVqvIUj3pi0fyrOknMWqp1lMw3Y831jctfqHA6p8U88oXzLp5cMhCG0y2qrwa+PnmASb+qBc97Q6jiPmuLGqaTf8WkA7pAtAxnfRPiSNMmUOFi4shgxQ4OHVo5VHy/Z7nXMpugC7HeNfaDfbeLImEZU39h9miDbNF4APNDglEK7jQWC6VValw/VRGeCqdKTam1RK5Ba5+cPZAWJESREFkqFseBe+MvydNQkrM+KSQO4DUy9U/sjGzjH2dJHnuDRu0i/+J2djsYoWxHiQoiS3z8UHjwRogKtwk0QnaNZoLvxmqI/UVYMNcL/ovUZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd4FfUlUR061VGal7bxTqHbkYVODgNSjjcCH9spLMGo=;
 b=U70JVS3YP4kaiHA42aN8sHhSI2/8/Ck35c1Z2ZB1M4rmkyHPxQqUJG08VYCgoz6MnUbtDvtkMWkueXAslNxO8wotA0d8NMwDVXPHskDWgcH8OUesjvjUJbzIA74JQaIVBbKj9tuZJq3jg14r3So6dOqTDINKN2CDGqzigJkX+AQM1uB8ZZyMLZ8sc0cZDC43S1z4M0z9w9838IVmKFENOU3fBeCP1Fam7l1YVh4BRFZtz+6oxhwArMbihDHKEXCX0vvrz9XZGpeHIjDEFLL3IeMDrAETDfRdLthtzIzs5E/38PXmhc8TecuIduaI/eVMmAwQf+IK+zfhevDFJaRi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT047.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::33) by
 HK2APC01HT032.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::286)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Tue, 25 Feb
 2020 15:33:00 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.60) by
 HK2APC01FT047.mail.protection.outlook.com (10.152.249.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 15:33:00 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.012; Tue, 25 Feb 2020
 15:33:00 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0009.ausprd01.prod.outlook.com (2603:10c6:201:15::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 15:32:58 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 2/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Thread-Topic: [PATCH v1 2/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Thread-Index: AQHV6zneI6K1RjwByk+TFt04XZDxaagr34qAgAArsoA=
Date:   Tue, 25 Feb 2020 15:33:00 +0000
Message-ID: <PSXP216MB04387341897FDF77424BE82D80ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB04383751C15C4D66B59335DA80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200225125629.GB2667@lahna.fi.intel.com>
In-Reply-To: <20200225125629.GB2667@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:201:15::21) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:FFD64A55E7E74D7E24C92DC349F6EAC0CD53155278C1DEC0B6D95A5599AED940;UpperCasedChecksum:1F42FD9B5A06A6D846DD2586013383CFFEF8DCF94879563F52F8604EB6A9F799;SizeAsReceived:7986;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [CX/MIC/nSBxU82IOwMtvAfa+byOyhHxOHWourM0WcilCrNOVI+SmJqs0eLgKtoVx]
x-microsoft-original-message-id: <20200225153253.GC1740@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 75895552-6aa7-4ffe-7c61-08d7ba07feba
x-ms-traffictypediagnostic: HK2APC01HT032:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CyW+crcjpnRR5jHgHUGmqoXcr4hWG6kjlbVLYPF+cmNIIWaXegw+6BM5Zt90/gEjXBKP2fYM1upoRmEz2zmrrX+ZHQIBPttMAu1JVncgKTCf047Gv2PDyQT/Le+gpizcwhKKGDGZ3fdzSG0CMsP3A8agD9z8R2T3EMIDA12pcd+oHl4myE58oXlZ/fuGdYH
x-ms-exchange-antispam-messagedata: YT8l0dgaWC9q6E2bnHS8CJ0rwSPOLRVdqZklRV7KmQJCsDo1PN5uH/qvaEA46hp28BP3xeKimYEJCjqa4MVZVWgyftP/+ukfyjK8FoGXvszZZFR/HeWsxx6wNVct8sd9Nd65m1Dl4qHY/iL2Ff0/9VhhYXMa8Fn9ZdCMXPBBsVQyaGC95lpHMF6vzo7lez1uafU9XzmOCXJxze7IXdS/4Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <613B6465DA9E164AB5C884B14D654E22@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 75895552-6aa7-4ffe-7c61-08d7ba07feba
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 15:33:00.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:56:29PM +0200, Mika Westerberg wrote:
> On Mon, Feb 24, 2020 at 05:43:05PM +0000, Nicholas Johnson wrote:
> > This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.
> > 
> > Since commit cd76ed9e5913 ("nvmem: add support for write-only
> > instances"), this work around is no longer required, so drop it.
> 
> I don't think you can refer commits that only exists in your local tree.
> I would just say that "since NVMem subsystem gained support for
> write-only instances this workaround is not needed anymore" or somesuch.
Are the commit hashes changed when applied to the kernel? If so, oops!

I will remove it in PATCH v2.
> 
> Otherwise this looks good to me, no objections and thanks for doing this :)
Glad I can be of help. :)
