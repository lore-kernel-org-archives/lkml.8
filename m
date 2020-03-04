Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABACC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BA4215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgCDQHd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:07:33 -0500
Received: from mail-oln040092254020.outbound.protection.outlook.com ([40.92.254.20]:6026
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbgCDQHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:07:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejL4kL82ydNmmp604ozVAkutFX7o8RhwolCShkmRj/62RjT1ewgvqfIf2CdyWLf7Pa4+iJijesu1O0rfqp8WAJVGpblXSgxyT+Mj4pk1CDTCA3waGdgYQjWqHVMvSoXSp7wW29PN/In9800kBRFjl0CDzpVIAPBmOVw8wfOTUWPn/p94K4wp+7maDwLG6Qps5SL30p3qHmzFGQlDxRv+/MoOmRe79R6Kgk2Feqp5YX1QhsG+nmqFeA/0MYAIHzaYSB/tH7CKYREmw9fMshUDPhEDOOEh6bXHbEbQuWTXmmcUCfrozb0DcJIniC2pFPKBhLaYmnAMoec4UZGH1qnorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk3nu6xUqkAcH9iNL6rHQ5mFJvG7uers/+lKAEsEwJg=;
 b=PGOPKiZonXJn6XpcdAMeJxvbLRWslirhA+6lf63IOyTDZ4z4ZU5Em+jG2CpkAo3XTwxNzeKFBQOl5GOa1cwPZG6h1M1j228fOdk/uFnkNr7u9NXLB5VXOKATiRKBXie9mxAsjpQ0hAkEQ+U1stHikiccKzC+VGmqMOjjJFEPDrEFk7ryLoTRMVeOPMlejWVdi2TZua2Up9XdAGwlKKEVvIGeqxdtr4cJ+ZgW6mEtJzM858cseGEsByUmToBMrfbmrzkfRPTjJyFyPVZA/+/mBywsSaPoQPxlJaXqmY8Eg3j+bqi2fPX1EtK39BDJU2s42I40nl04A4ItyMf0Kqf2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::3a) by
 PU1APC01HT142.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 16:07:29 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:07:29 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:07:29 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME1PR01CA0115.ausprd01.prod.outlook.com (2603:10c6:200:19::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Wed, 4 Mar 2020 16:07:27 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 3/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Thread-Topic: [PATCH v2 3/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Thread-Index: AQHV8KlS3XYq90/jLkW1+zKh/mLy4qg2rPIAgAHvtAA=
Date:   Wed, 4 Mar 2020 16:07:29 +0000
Message-ID: <PSXP216MB04384541A10255DF4E70F4D480E50@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB04388C56BECC4CE5EC81EA2680E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200303103310.GN2540@lahna.fi.intel.com>
In-Reply-To: <20200303103310.GN2540@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME1PR01CA0115.ausprd01.prod.outlook.com
 (2603:10c6:200:19::24) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:DF1240B440FA8036B3F480089BA21868AB0A26136DAE31AAC04613F8D34D7595;UpperCasedChecksum:79325A480BF9D1B208EEE0CF560FE25011CD95D804F5DFA38BA8B7C96B7C8160;SizeAsReceived:7993;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [nXYBbVw5BgGnCgKUXFwNzz+Ddc3f43P5tqu7UkZvb2QD6wRzhOTFUknwhvLGiwto]
x-microsoft-original-message-id: <20200304160722.GB2300@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 53875f8f-c78b-4b6c-7416-08d7c0562360
x-ms-traffictypediagnostic: PU1APC01HT142:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zAYvY13HFp/M2YdStgohYQmG+u+9keCaQY4pb4cvnYTIg+iLLK55L3R3cK9/aguedq0O0mvRJ8x+eQ79zFC6n9H7eygOlzHfz3voOtiBw+Du7G794dzNbWYIYKRf7Zz81CkLsoa47FpicL8RHNOXzA3Xw9oXjfIINVisJNGYK1A4p0IVzwkrMBLrikMiOB59
x-ms-exchange-antispam-messagedata: GnPJp/vz8vJSoVkGpMlQPwGS/PTD6qR2FfxRTfQ067wGWqjXfNIv8tWzTCU+Dt507H82wgUcmFKqlngiQv+4+Awvibl4MMdYHp1idNjka+6rovEOzhATrHW6DltCLkbqkekyx9YRWn6zfiTo6PEv+FqR2y1GL/mI84+HLcMt+xnKVLoIzLhrDhR0PE8PszODhEufY0FO239oO2kwohH1Ug==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C04A619FB220342B3D49E1106EC935D@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 53875f8f-c78b-4b6c-7416-08d7c0562360
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:07:29.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:33:10PM +0200, Mika Westerberg wrote:
> On Mon, Mar 02, 2020 at 03:43:29PM +0000, Nicholas Johnson wrote:
> > This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.
> > 
> > Since NVMEM subsystem gained support for write-only instances, this
> > workaround is no longer required, so drop it.
> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> 
> Assuming this goes through The NVMem tree:
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> If that's not the case, please let me know. I can also take them through
> the Thunderbolt tree.
I do not know how this would normally work - I have not experienced much 
cross-subsystem work. Perhaps it should be taken through your tree. If 
it goes through your tree and not part of this series, perhaps it does 
not make sense for it to be authored by me, either. It's just a revert; 
it does not take a lot of effort or doing something original.

Cheers.
