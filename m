Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5093C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB95D24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="A87wtMVv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="lPYn2VcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBTIBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:01:17 -0500
Received: from mail-vi1eur05on2042.outbound.protection.outlook.com ([40.107.21.42]:33632
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbgBTIBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPRENELmRkR+6I2a17hK6bof9j4uHnE2cA0fosT2zC0=;
 b=A87wtMVvtshm85yOgaIVJIyIw1eZrWBSs7GCEXl1MJwMxPTGjiTXAW7SbQbhzSSbgm44r4+Zldc5xv7qe4syws8zICa+wNMsG/0hDWgx4++RVK7vp/bi6GpmBCnYhL2dHDiQMNCxYcrCXOOQQYVbnKWYzHOOiYOkXu7aSYAijp8=
Received: from AM7PR04CA0023.eurprd04.prod.outlook.com (2603:10a6:20b:110::33)
 by VI1PR0402MB2941.eurprd04.prod.outlook.com (2603:10a6:800:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Thu, 20 Feb
 2020 08:01:10 +0000
Received: from HE1EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::205) by AM7PR04CA0023.outlook.office365.com
 (2603:10a6:20b:110::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend
 Transport; Thu, 20 Feb 2020 08:01:10 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=fail (signature did
 not verify) header.d=topicbv.onmicrosoft.com;vger.kernel.org; dmarc=none
 action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 HE1EUR01FT064.mail.protection.outlook.com (10.152.1.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.19 via Frontend Transport; Thu, 20 Feb 2020 08:01:10 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.170) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 20 Feb 2020 08:01:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJLFbL0DQXeuIuJkeo3ffX7MB7i0y2EyMjwkb0Cu/jeNqw4CP6dBRU/Eivg5odTiiHZajfzVun2s6a8ecW4o6uXMggToAIutMqO0ycbDv3ff7FCmuWz32AiyWgxecexhLPNjsNGZl6vvTGnlm0gUeCdx93qUEBgC1xNyN4BunqbRuuUnCQtv+N9gOJ7sCBHPEKWV1HeSKGUj84fwDtrOPbGhQ+VpeelDRN1HqB3sB5eGGg3f7pNeVRzSHZhZbRopAK1r1FlDjsLnF08GjiiACdxcdfDdevTAVZOO9OVjrOBUNGao34MPYwmmScpU7mPBjeRsWxk5ZFeAp7XiJMt3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2c5C6SflPV2ydCHfr/IqTDUoeXFZyYdWh3vROc9fbA=;
 b=fMm9ISi5+ZfZgXNv9YHWqnVoyeHLQbLddJ14fUDqRuykhycQj7YPaMBhT0ShBC4AbAjJ/nFsC42CB1N4GSRCTfGwJhvQHl4m7zX+ZehG1l+fDdGIfPHSj43IcaoBcpTcUD0o7Bsq6jrnHTW2PDqbMFrY7BECeazJ5N9TA9r3CxMCzwQfIOauaPQxx6jXdU9sh3OXseVG560nUn4ZjFguF125W+QiY2KvduPHPHP8n5GWc3S608N4fm37WH/MRs488Phk6SLPrJaJhN49JGSxmnNJP7viZyB0J1kE0waFObt/DJ+zNKwFhUidyCdTJCbxwVWWnCnTSZrTYKH7m/85JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2c5C6SflPV2ydCHfr/IqTDUoeXFZyYdWh3vROc9fbA=;
 b=lPYn2VcCM8r4Ch1Aq22OU+HHaa8JU5GcN2yu35NbjVhxWDqs8ENDyqTjtEINjKTSnvgWeOC05UKHmpDeBmBLU6r5AgAmp1lWZ/NS7lmdTpnlHR2v1xTIGKs0SPBkxK7y9NvUXBnr1V71ZL8rc8r5NbNpsGj/JTmjmGhEcqri2ks=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Thu, 20 Feb 2020 08:01:03 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::2921:6c3f:a653:732a]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::2921:6c3f:a653:732a%6]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 08:01:03 +0000
Subject: Re: [PATCH] devicetree: zynqmp.dtsi: Add bootmode selection support
To:     Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
CC:     m.tretter@pengutronix.de, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200219122036.24575-1-mike.looijmans@topic.nl>
 <07c68809-f65f-91ff-62eb-f12aa8960634@gmail.com>
 <85a5807e-1d66-867f-1d83-36e8a054a511@topic.nl>
 <f2592ed7-9f1b-9a23-a6bd-ed8773a7873e@xilinx.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <a4fa4009-8d1e-1e5c-2b5c-0f9f1209e78d@topic.nl>
Date:   Thu, 20 Feb 2020 09:01:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <f2592ed7-9f1b-9a23-a6bd-ed8773a7873e@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::37) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
Received: from [192.168.80.121] (81.173.50.109) by AM6P195CA0024.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 08:01:03 +0000
X-Originating-IP: [81.173.50.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4094d0b3-db27-4dcc-5e8e-08d7b5db0c2e
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3899:|VI1PR0402MB2941:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2941A3E65908789C86DC9AC496130@VI1PR0402MB2941.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(366004)(346002)(199004)(189003)(31696002)(26005)(31686004)(7416002)(8676002)(81166006)(5660300002)(8936002)(52116002)(36916002)(508600001)(81156014)(53546011)(16576012)(2906002)(110136005)(6486002)(16526019)(4326008)(956004)(66556008)(36756003)(44832011)(186003)(66476007)(66574012)(2616005)(66946007)(42882007)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SbgDvGHO+dDwHJ2LU7u+LYRhQswd1/JjBG8CHB5ZobL/NXCYIlg3/TxKmDWvtgDKMpwniYjU8GxeDtlsbTlMM9u8XueuwzyDSWWHZf3vqvdWd4EGhRWqutwQ78f96ULLbSM97OG2Xqg/fodiAC77gEaJp7UIZCg+IUsS4//UfNe/SoJTKtWhzNyipA0MvIbgZZ4bVhbAKgHRlIqLcrNSj8dLoEp2G+RZk76IscBPPkYhNErrWaNSEK02gVjAq464C3131jCL3RiU8WdvgD8wzhSabeQvGYPBQ2uM5fRwgmSSpSjGbxkAawPCtcSLaO61EGcBSaOLMMCaqAThPh/jK5OK8+TEG/2SvhqVFwShwlwQuzTuLAXnA9K9bD0tWdsazoEugWl731Iaz+vwB9kc7ykoEl/gLXRT2zWMyI9S9htX+xRMGLGfGziNuO6NhbI4B72wguqmJMii2FOxn2gHlDGKpnjgbksSjemFIX7EFHOpN4uFnQEwYMECQgoh+LuJ
X-MS-Exchange-AntiSpam-MessageData: 0BU/SS89HA1Mo86jygs2ZdiWj5K3TIufWdu84DXdYqdJlQalnjvOH4xl3zXDMza90v2TnHKQtVFpreVVh3XIWcrTBU9JAiAi9GR845jdSeix27hdjjYfMmprAQa4xu5FFpy6zEpAtYYFrZRb4muKmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
X-CodeTwo-MessageID: 66a409fa-f0be-477d-9749-7a5dde6b3438.20200220080107@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(199004)(189003)(42882007)(336012)(26005)(7636002)(7596002)(246002)(31686004)(4326008)(36916002)(186003)(16526019)(82310400001)(6486002)(2906002)(356004)(8676002)(5660300002)(66574012)(53546011)(36756003)(508600001)(44832011)(16576012)(31696002)(110136005)(7416002)(70586007)(70206006)(956004)(2616005)(8936002)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2941;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d42a32fe-a9af-4adc-aa2f-08d7b5db0824
X-Forefront-PRVS: 031996B7EF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mj2xnUtmA4FZUsk2o5wjUtXFqfZC54gyiiQdI2VugXu5dU/4UOPfTQ07mafSxwDJFxULd7BHiDsj1mfoGDElN1trE7uz+hWYg1e635si8p1vyIGi6QsHzXtKRL9Hd9BrQATaNTIMjp7meclL/A9xNpmujEnEe8STMIDEAq2/DCtE39wiLGQPtTQfBOqPwnh9xnGZJ7hJOudBU75E7zllTv2bjsFvi9AOhS5oRKrO/PSeWHp3RoJdAj2dj+JxLUq0Zz/nOHH+abC7Ku5SItd3voKxDS4UxlmA62SPjg87cwjpOce8uCG3fg6tyqGyJPkoHPwPQhXjVEerhd3Jcvs8k9PvKn3SmJMrWGgEpufDz2AHhDsu4D68OP1rBhYKKXLGvGBIYKQP77EMz4CMTi48EO8h4RiKZezWcPho3tEj61XkOF/U0vCwSJTAIFKD4Dd8R+V+8k72+L7pJ6NrCb85JX88epCqxXcu6nDNvCyw9f0LNLMvDIIchXkOm3w59WQ
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 08:01:10.0096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4094d0b3-db27-4dcc-5e8e-08d7b5db0c2e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-2020 08:01, Michal Simek wrote:
> On 20. 02. 20 7:56, Mike Looijmans wrote:
>> On 19-02-2020 19:23, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote:
>>> Hi Mike,
>>>
>>> On 19.2.2020 14.20, Mike Looijmans wrote:
>>>> Add bootmode override support for ZynqMP devices. Allows one to select
>>>> a boot device by running "reboot qspi32" for example. Activate config
>>>> item CONFIG_SYSCON_REBOOT_MODE to make this work.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>> ---
>>>>  =C2=A0 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++++++++=
++++++
>>>>  =C2=A0 1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> index 26d926eb1431..4c38d77ecbba 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> @@ -246,6 +246,30 @@
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 };
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Clock and Reset control=
 registers for LPD */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpd_apb: apb@ff5e0000 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpatible =3D "syscon", "simple-mfd";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
g =3D <0x0 0xff5e0000 0x0 0x400>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
boot-mode {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 compatible =3D "syscon-reboot-mode";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 offset =3D <0x200>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mask =3D <0xf100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Bit(8) is the "force user" bit */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-normal =3D <0x0000>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-psjtag =3D <0x0100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-qspi24 =3D <0x1100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-qspi32 =3D <0x2100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-sd0=C2=A0=C2=A0=C2=A0 =3D <0x3100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-nand=C2=A0=C2=A0 =3D <0x4100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-sd1=C2=A0=C2=A0=C2=A0 =3D <0x6100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-emmc=C2=A0=C2=A0 =3D <0x6100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-usb0=C2=A0=C2=A0 =3D <0x7100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-pjtag0 =3D <0x8100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-pjtag1 =3D <0x9100>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mode-sd1ls=C2=A0 =3D <0xe100>;
>>>
>>> This kinda looks a bit misuse of reboot mode support.
>>>
>>> Usually you are signal with reboot-mode that you want to do factory
>>> reset, enter recovery mode or such things.
>>>
>>> Now this signaling here is telling that this is used for selecting
>>> from what device to boot from.
>>
>> On the ZynqMP this is the only way to communicate with the ROM.
>>
>>> Another problem is that this now modifies all Xilinx Zynq MPSoCs which
>>> is kinda wrong. This behavior should really be product/board specific
>>> and not common for all boards -- undoing this in product/board is
>>> somewhat cumbersome.
>>
>> The boot mode setting is in the SOC, and is not board specific. The ROM
>> interprets this field. The only board specific thing is that you may not
>> actually have a NAND chip attached to it.
>>
>> My idea was that a board could easily add say 'mode-recovery=3D<0x2100>;=
'
>> to make the QPSI boot the method of recovery. The bootloader also has
>> access to this register, so it can see that there was a boot mode
>> override in effect.
>>
>>> Now this change hijacks the "reboot <arg>" with this behavior which is
>>> not so nice.
>>
>> If anyone has a better suggestion as to where this should go, I'd be
>> more than happy to hear about it. It's the only interface that I could
>> find in the kernel to attach a bootmode override to.
>=20
> IIRC as the part of PSCI 1.1 spec is SYSTEM_RESET2 where you can device
> reset_type. IIRC that 0 as warm reset was coming based on discussion
> with Xilinx (and maybe others) and I think this is what Xilinx is still
> using. But didn't track it if that was really implemented or not.

I checked the arm-trusted-firmware code, there's no Xilinx vendor specific=
=20
implementation of SYSTEM_RESET2 today, so it will only do a generic warm=20
reboot and nothing else.

I'll move the patch to our BSP, we need the functionality for software=20
update/recovery mechanisms.


