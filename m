Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3C8C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4069320801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="VISDvLIX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="MdBVD4Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgBTG4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:56:41 -0500
Received: from mail-am6eur05on2065.outbound.protection.outlook.com ([40.107.22.65]:6051
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgBTG4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g335xwYBUt+rCE+YVjmF38K3osI4p9T1tvg0u7DI3/A=;
 b=VISDvLIXTonKxwKg5+Vo3+xRfWZz7X9ImKSjF3HUIf+NeYCXF1z0+qNfRGD+pBsxViFHDjGJBnxZ6Sg8RQ71RHZvsG11hIXS4byWvl7ykv2l/xjOStYCpPg+9knHu6e+vH9ovsJw7/GZzvleTYlQUPcV9qv5ve5xOyh1OIgvVr4=
Received: from AM5PR0402CA0002.eurprd04.prod.outlook.com
 (2603:10a6:203:90::12) by AM0PR04MB5186.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 06:56:34 +0000
Received: from VE1EUR01FT057.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e01::208) by AM5PR0402CA0002.outlook.office365.com
 (2603:10a6:203:90::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Thu, 20 Feb 2020 06:56:34 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=fail (signature did
 not verify) header.d=topicbv.onmicrosoft.com;vger.kernel.org; dmarc=temperror
 action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 VE1EUR01FT057.mail.protection.outlook.com (10.152.3.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 06:56:32 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.54) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 20 Feb 2020 06:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR+RZ3Mlsdabhv+gDhZGy5X0mF5skTOoGBBOTwNDVY060C+utz6gHt3xzCd4YfzGs7NtfFqJ/XZpAonbkhFYpXQEYHCIOdFPHzxhn7NwBUjK7nKk2EVnc3E1i59vafaVa+7R4yxlfvfG7EB3w6LzQiD/SOwavJg3VxjlePStKyuc/UWI1Z2GOphmXkBTyQ5q87PUbj16hqCnc5ptQ0101HMDqog1q50rtU/NtA5hPKYGYTUYHfRc8r+wbgbd7dsbQBlNVgkUcY7LCF7EDXDRPA7t7Q6k03pQ6G/4tCPG7TLIzZStpzBoAPHtcSwN4PW4TzwzMQLCG0Lig1H/vte26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoNnuSGgS4a1JvTPbOIZxrO+DZllWiUjEm7W9HtTbQc=;
 b=atyp9qu+qRBH7fdG2jegprH8daEXILTUZhea58kmA+R9kKdp2jhlPvDyKkeGBlJ7szECumdY5ewGaO2aRIeb1zoMVVGLdxGsvvru/jKNIkV5HBkJcAmz5h0+0RRppTvuW85ToFvWevmjboXYo+jU7SxP0Wl9NbuZ8jvxnm0ZSZW9xWY+5Hu3EOtpgGx2gqXMRGzP1gS7tG34WMieahVKsIffSWI4Y596QKQrGIOCyozaGVXHh3ZiohPun0/7s3dQ9rxVduJbBDGhEvH7vUCw1l9KRHzEKK4A0YkMjShwEoPKTGc30vZfXaunLeZnyXdUmI66WrRXkAHZcMlaAd7CDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoNnuSGgS4a1JvTPbOIZxrO+DZllWiUjEm7W9HtTbQc=;
 b=MdBVD4ZipqP2aqwjUbHNqTVtX8TY6gP8EVn/K79a5WuVgX2x5Cy9uVMemLXCPQARuK4ZseR/9UABg+/ngd+Rt3kFfxeO3fV2i5epdJwqrumWmIJmgXrQvcJu1zyWZdvnfn8hIombFqZJdJMV0S43AZnWS2SkE8MFQnqlI6348e8=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3851.eurprd04.prod.outlook.com (52.134.73.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Thu, 20 Feb 2020 06:56:29 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::2921:6c3f:a653:732a]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::2921:6c3f:a653:732a%6]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 06:56:28 +0000
Subject: Re: [PATCH] devicetree: zynqmp.dtsi: Add bootmode selection support
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        robh+dt@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org
CC:     m.tretter@pengutronix.de, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200219122036.24575-1-mike.looijmans@topic.nl>
 <07c68809-f65f-91ff-62eb-f12aa8960634@gmail.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <85a5807e-1d66-867f-1d83-36e8a054a511@topic.nl>
Date:   Thu, 20 Feb 2020 07:56:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <07c68809-f65f-91ff-62eb-f12aa8960634@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR0102CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::27) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
Received: from [192.168.80.121] (81.173.50.109) by AM0PR0102CA0050.eurprd01.prod.exchangelabs.com (2603:10a6:208::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 06:56:28 +0000
X-Originating-IP: [81.173.50.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e66adc1-56bd-497a-0dfe-08d7b5d20535
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3851:|AM0PR04MB5186:
X-Microsoft-Antispam-PRVS: <AM0PR04MB518633B88687013E75D4D98496130@AM0PR04MB5186.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39840400004)(376002)(189003)(199004)(508600001)(31696002)(4326008)(5660300002)(31686004)(8676002)(81166006)(81156014)(36756003)(66946007)(66476007)(66556008)(8936002)(6486002)(186003)(16526019)(316002)(2906002)(26005)(36916002)(66574012)(52116002)(16576012)(2616005)(956004)(7416002)(44832011)(42882007)(53546011)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3851;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6UGPPsP6GMuH4Wo3CN1mUPHOkOZclqKKUPhSmDDh0Atos9Cz8mQ5tc5vLjRUD4hHKH/a0pALm8jPTVtJbvPVn73Wx/HNCSvB+ONSSyjRKeFSUGV6rHJ6vjjLoJ3+mDIeoG8hqAPno9FqxK6jZBZiV7pt7N8I+5Ghr7TC6sBbmLW+CRwuRLf5g+7Ys+dssSRQ1+HUdzInHwMObqhKpAoEaKWE4B18YjfTn3DVsv4P56h12c/CPsVvypX04ei/IVAFlfY/BOECEjIqwtCHxb/KrGImcFx8aGAIP/AxImxDE8cOFMu6Dtf0zejWcAujks3LYVlFDgaByy9ddEYcoGCIax2z/a1bydiVdkMtILW4tOVdSsGKzAk2DVyBDwZLAUqSA3rf9IbuomPlqugoKvoVdCOkgFgO0MslWhZcuOOtfw+LDD7xESQyOLXYn10vI7oMUDqpU17fEOZZ0K5HxIwyFJWbq6tulHJkAqpf6P6JUpxcJNtM99WX8bgK0TcT1oaP
X-MS-Exchange-AntiSpam-MessageData: yuyLGNNvp6E/CPuvhKYLNJJZVFunBE+ajG9p1zGv9Ofu0ubWuB+SoD+9Q0GF8rjkLWXAXOsM28yu6AocMd0w5qwzcmhpykPlWA5W67SbY6BkfwN2Zi2foxNUPrRdJnt1Ga8pMoc3oi4S0cl9dpxc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3851
X-CodeTwo-MessageID: d334d320-cefd-44e7-9f9a-1f69678cb919.20200220065630@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT057.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39840400004)(396003)(376002)(346002)(136003)(189003)(199004)(36756003)(42882007)(7596002)(336012)(186003)(70206006)(16526019)(70586007)(6486002)(316002)(44832011)(956004)(7636002)(36916002)(5660300002)(63370400001)(2616005)(31696002)(31686004)(8936002)(53546011)(2906002)(8676002)(246002)(66574012)(16576012)(4326008)(356004)(26005)(7416002)(508600001)(82310400001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5186;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75b0d43c-6314-4b94-67c7-08d7b5d20282
X-Forefront-PRVS: 031996B7EF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwsniFGXMK7k3k9avVv7k4YDBTeaeIPOLouOH+QGQiTXHF7PNZ94CRVCzs8atK4XPyGKoAiP18nc/XdZAGgXv6OcdbliCi6hmm7Cg/y7P4u1nwGU0jeL7iU4Y20fjhs2wx7TwvDaUoHj8BTgfQfv47btaQxUKJuCOnCRwFwGxHGxhdFY4zdiwd15zoGGpfHDF6UPEVuFznt/R0+0h7Ob2navrj7RRq9gb7o8LnsmMsQeREovKKK1Hb+QPn+0lrtOLRXovLAbejP0xiQGAWSpAGGhdKFnRvOAa4y1OsbEXWRfqu73Pt2k+pDxbcuzC7Jwl/GoJkuiwqdjipI3WmIBXE5Lqf9E273KHpEBwabcnm/lmwIWXLwATWSljQT3foxkJYZoKdjzFhwOl6R2ZF7sVo3xbGwI3jXuYQzas4KO4sXDU/ApqDYllzhKjcpZvJvhnOEevKcvWlWPKLkVfKZ5fHVcuxwXmLlfitVCjye6QQPvEzL9EV/mvycnaMrHy07a
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 06:56:32.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e66adc1-56bd-497a-0dfe-08d7b5d20535
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-2020 19:23, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote:
> Hi Mike,
>=20
> On 19.2.2020 14.20, Mike Looijmans wrote:
>> Add bootmode override support for ZynqMP devices. Allows one to select
>> a boot device by running "reboot qspi32" for example. Activate config
>> item CONFIG_SYSCON_REBOOT_MODE to make this work.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> =C2=A0 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 +++++++++++++++++++++=
+++
>> =C2=A0 1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi=20
>> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 26d926eb1431..4c38d77ecbba 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -246,6 +246,30 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 };
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Clock and Reset control r=
egisters for LPD */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpd_apb: apb@ff5e0000 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comp=
atible =3D "syscon", "simple-mfd";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D <0x0 0xff5e0000 0x0 0x400>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rebo=
ot-mode {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 compatible =3D "syscon-reboot-mode";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 offset =3D <0x200>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mask =3D <0xf100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Bit(8) is the "force user" bit */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-normal =3D <0x0000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-psjtag =3D <0x0100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-qspi24 =3D <0x1100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-qspi32 =3D <0x2100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-sd0=C2=A0=C2=A0=C2=A0 =3D <0x3100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-nand=C2=A0=C2=A0 =3D <0x4100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-sd1=C2=A0=C2=A0=C2=A0 =3D <0x6100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-emmc=C2=A0=C2=A0 =3D <0x6100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-usb0=C2=A0=C2=A0 =3D <0x7100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-pjtag0 =3D <0x8100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-pjtag1 =3D <0x9100>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-sd1ls=C2=A0 =3D <0xe100>;
>=20
> This kinda looks a bit misuse of reboot mode support.
>=20
> Usually you are signal with reboot-mode that you want to do factory reset=
,=20
> enter recovery mode or such things.
>=20
> Now this signaling here is telling that this is used for selecting from w=
hat=20
> device to boot from.

On the ZynqMP this is the only way to communicate with the ROM.

> Another problem is that this now modifies all Xilinx Zynq MPSoCs which is=
=20
> kinda wrong. This behavior should really be product/board specific and no=
t=20
> common for all boards -- undoing this in product/board is somewhat cumber=
some.=20

The boot mode setting is in the SOC, and is not board specific. The ROM=20
interprets this field. The only board specific thing is that you may not=20
actually have a NAND chip attached to it.

My idea was that a board could easily add say 'mode-recovery=3D<0x2100>;' t=
o=20
make the QPSI boot the method of recovery. The bootloader also has access t=
o=20
this register, so it can see that there was a boot mode override in effect.

> Now this change hijacks the "reboot <arg>" with this behavior which is no=
t so=20
> nice.

If anyone has a better suggestion as to where this should go, I'd be more t=
han=20
happy to hear about it. It's the only interface that I could find in the=20
kernel to attach a bootmode override to.
