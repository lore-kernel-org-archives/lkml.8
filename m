Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645D8C35E08
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460A52072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgBYPXl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:23:41 -0500
Received: from mail-oln040092253026.outbound.protection.outlook.com ([40.92.253.26]:39686
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729048AbgBYPXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:23:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOlwAlViTMHcMb8TwaJRw2EvFI3ZIrGOga+6uBt6ES9FANHE6q8Q5g6KIag7pE6HmjvKL4K9OcnePtJPdN5+Hua4JIAXcNSKhuCVtB6bc+N7Tg4yb1Tb4/P1gr+ogdN1T17V2mrCF7zJLPEb6JnpttmqG+QxVjXALRHzv6GZ0mdzWVbYXoJZMTO3xD4qAy6qmvGBUeK+pinA/p2VL3Ttcf221U6LeKrntnFAOWNhmyWUKJse9QxZJEYq5u4kqJs2Zp6hMGKlsnPrfRNE4KwanSrbsJBWRIW51ujl0IDNg1LaakNig2AGSnzTeRe5oP128v5biL5LZaonqmB6vB1c6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKJhCE5kbVoTk5yDl4LWM5ExYV/GmsNLIcPIH+O3N3M=;
 b=P4GfI4w4elDio8wpdwhi8uj4a/5lNFwWAUdPitmjPuwEanweFboBcT9La3a9/dbnhYstcQOIJ8uzZqMfqZ0S2l5WhBBAqzS62ljimYcmGjSk3dkpdfFN3NKAkfH6ZWCk9lgLifstq/VRCYJSm2wGPVPqKyjbJEBk/LHUWPuvmpGuX3HZkVN0eusw2i9HOHyvXhiSzcRALkR6nkVF4dYKViXvR1575fxxFVbXKKU4UiKbQ+aHnm6oI01g2WMoTdW73HqTdGfvFkY5Cn/re2ixS/wt3fygo3NtTio1GVM3NBn2dRQR8XeOe6ukegAfsoOtKNX3gsf9ne0GEH13VxY1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT049.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::37) by
 HK2APC01HT123.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::365)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Tue, 25 Feb
 2020 15:23:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.54) by
 HK2APC01FT049.mail.protection.outlook.com (10.152.249.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 15:23:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.012; Tue, 25 Feb 2020
 15:23:34 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0006.ausprd01.prod.outlook.com (2603:10c6:201:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 15:23:32 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/3] nvmem: Add support for write-only instances, and
 clean-up
Thread-Topic: [PATCH v1 0/3] nvmem: Add support for write-only instances, and
 clean-up
Thread-Index: AQHV6zml/lsHzrfInUOXwCupSAP1TagsAfwAgAAGnQA=
Date:   Tue, 25 Feb 2020 15:23:34 +0000
Message-ID: <PSXP216MB043872618DA517085324FA0580ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <abdbeaf4-487d-8921-facc-b979421e97e7@linaro.org>
In-Reply-To: <abdbeaf4-487d-8921-facc-b979421e97e7@linaro.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0006.ausprd01.prod.outlook.com
 (2603:10c6:201:15::18) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:DD03F36D7A60CFA0367BFBCE10484E1080E74D4D27CA246CCCE4234CFD1D540C;UpperCasedChecksum:861F514FD307865C9C2B35B993AC6398C527F7166DB206D42A76D2C36EEA2356;SizeAsReceived:7894;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [oxpxtfnaU2gRSUWyCX/SGyYP8FZWOAZd0l6qqgVRpLUErr+gX/wq12dFWJYEXZ2C]
x-microsoft-original-message-id: <20200225152326.GA1740@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f785805e-8fac-4367-2074-08d7ba06ad6a
x-ms-traffictypediagnostic: HK2APC01HT123:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: peO+9qxDPuks6Gy2A0sED3zPYnYy3xteOPUfa54ZTH7bhONgIXUYBBf5hwGM3wyi5G47w9I3TDpYnH7dyJ7gGebYOyhGGTuRqTsKFOJ2pMnb8jTOk2rmRJwk1IxfYiOVdG313XQy+iaw1PbrhWxc0X3IbS7Qa/U4WU0bkf2bDFpUNZUMeasn+JzajHp73/tT
x-ms-exchange-antispam-messagedata: AOpCMAU51qOHKxrAYw+t9ttmIFvXyIKtiafcmXISMb2NT2ypqhgElbvna34Cw6rxe2E5o4dohDgsQXl2gmyMsvITZBzD9PMojz0et5704IbeiQaajh5iapdRU16AY3qa7QVmVveJgJzbtQvuUKAaEfKHDvYOVfmKi4miVG4+mSzZ7XBmwKDvPg+gjhTT6008K6rhwA5+4zp+kA/7owU+2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F711D26E6827524AA77FC45F6C373773@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f785805e-8fac-4367-2074-08d7ba06ad6a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 15:23:34.5224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:59:46PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 24/02/2020 17:41, Nicholas Johnson wrote:
> > [Based on Linux v5.6-rc3, does not apply successfully to Linux v5.6-rc2]
> > 
> > Hello all,
> > 
> > I offer the first patch in this series to support write-only instances
> > of nvmem. The use-case is the Thunderbolt driver, for which Mika
> > Westerberg needs write-only nvmem. Refer to 03cd45d2e219 ("thunderbolt:
> > Prevent crash if non-active NVMem file is read").
> > 
> 
> Had a look at the crash trace from the mentioned patch.
> 
> Why can not we add a check for reg_read in bin_attr_nvmem_read() before
> dereferencing it?
That can be easily done in PATCH v2. What error code should be returned?

> 
> The reason I ask this is because removing read_only is not that simple as
> you think.
> Firstly because a there is no way to derive this flag by just looking at
> read/write callbacks.
> Providers are much more generic drivers ex: at24 which can have read/write
> interfaces implemented, however read only flag is enforced at board/platform
> level config either via device tree property bindings or a write protection
> gpio.
> Removing this is also going to break the device tree bindings.
> 
> only alternative I can see ATM is the mentioned check.
> 
> --srini
Noted. However, the .read_only flag is only removed in the third patch, 
which can be discarded if you feel that is the best plan of action.

The write-only will not have a flag added, which should not be a 
problem, as nothing relies on there being one yet.

Regards,
Nicholas
