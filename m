Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5CAC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0339F2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VkTFqo5h";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VkTFqo5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgCUPEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:04:31 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:17031
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgCUPEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2Zu+gEpEKHAzqnMYaRnTQYiaZ0Va+00bgQyGh2CxH4=;
 b=VkTFqo5h+b7HUO99bMPEi08a5k5ocH7UnL1OyCoBTkoMSl8YB90O1qrkxdUDNH/Cu3+SMSKol2HTiGZNpqvmYFN11PpmN0o2fN9WXFIQcvQl/16lJl0GhWmhJmTH6A/r5pVSKijmu4NIZ9vjES8ApH4+Ln0/l8mdMNY3TaKSGFo=
Received: from AM6P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::19)
 by DB7PR08MB3322.eurprd08.prod.outlook.com (2603:10a6:5:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Sat, 21 Mar
 2020 15:04:24 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::d0) by AM6P195CA0006.outlook.office365.com
 (2603:10a6:209:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Sat, 21 Mar 2020 15:04:24 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Sat, 21 Mar 2020 15:04:24 +0000
Received: ("Tessian outbound aed43bac6b97:v48"); Sat, 21 Mar 2020 15:04:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 93515262838abd49
X-CR-MTA-TID: 64aa7808
Received: from 99f556d6ac04.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 463ABF6D-3817-4EE0-9730-565F871AAE4E.1;
        Sat, 21 Mar 2020 15:04:17 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 99f556d6ac04.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 21 Mar 2020 15:04:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEffLlb70yVNTz9vlu/cVzxWUPd+uRY1TsO53tIPdVLp3T1JuJSKFkQkUO18Aif2BiMeptWXCYp4G37BorqOdv86UAHtF9LBXom1sAmyOG8oT20mknQcgYDOo86mhM4YjufoToGVajBD1Oh0lu5RpQ1sRNCyKDl1HjPOw6mbyRb61mLfiMOi0OHQaOUaZbfStglLpR7VnJfrkIHAj6XdRwBJPclunObRFp+o4hKddF3AT7Tx7aMUhRplGuh4khBBpjZ0RIhCr84/r8TKJNBmLVNOONU7TqUDpAdxSq3MkP88Y98gXO2fMLBoe+LSYXClYL4YlGhjrGWjV2cp2IirbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2Zu+gEpEKHAzqnMYaRnTQYiaZ0Va+00bgQyGh2CxH4=;
 b=n7z0lwCrx6R3Oh278itbCc9RO8R07JaSV3tmEJkLno5xV7gO0Ut0OZUDCdABoueIXMqfRq6R/r5PVvGVJekJHA0MjqKsYtkGBMEuFqMN2+AChepWbtZyf1hIUmnh7oVhnYoKOj3R+avFKzKtvWDbOqzrxolKdK4HRzGbevtT8Jtwbeb2EHfW7qDGN+uFb2N8aOAjWGh4LsqpRNlfoter3sQlxMAYRpINT1WNc5buQqpvU37nlzkbaXzI+WgfZTe92KPTJWeApWC4KJq3uzH8BwT0Dplo58HbYNWwGFE42Mgq7mFoehHKt3g9CKOnPG9xL5hp61baU1Z4kswydBmBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2Zu+gEpEKHAzqnMYaRnTQYiaZ0Va+00bgQyGh2CxH4=;
 b=VkTFqo5h+b7HUO99bMPEi08a5k5ocH7UnL1OyCoBTkoMSl8YB90O1qrkxdUDNH/Cu3+SMSKol2HTiGZNpqvmYFN11PpmN0o2fN9WXFIQcvQl/16lJl0GhWmhJmTH6A/r5pVSKijmu4NIZ9vjES8ApH4+Ln0/l8mdMNY3TaKSGFo=
Received: from DBBPR08MB4823.eurprd08.prod.outlook.com (10.255.78.22) by
 DBBPR08MB4428.eurprd08.prod.outlook.com (20.179.43.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Sat, 21 Mar 2020 15:04:15 +0000
Received: from DBBPR08MB4823.eurprd08.prod.outlook.com
 ([fe80::f46d:4b0d:d07d:949d]) by DBBPR08MB4823.eurprd08.prod.outlook.com
 ([fe80::f46d:4b0d:d07d:949d%6]) with mapi id 15.20.2835.021; Sat, 21 Mar 2020
 15:04:14 +0000
From:   Peter Smith <Peter.Smith@arm.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <jiancai@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Manoj Gupta <manojgupta@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH 0/3] ARM: make use of UAL VFP mnemonics when possible
Thread-Topic: [PATCH 0/3] ARM: make use of UAL VFP mnemonics when possible
Thread-Index: AQHV/5F6uBdROLXuBUO25GaNt3oLRA==
Date:   Sat, 21 Mar 2020 15:04:14 +0000
Message-ID: <DBBPR08MB4823E090A8C9C0B48CB35603F8F20@DBBPR08MB4823.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Peter.Smith@arm.com; 
x-originating-ip: [82.30.113.194]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ac389c9-63d0-4de7-e033-08d7cda92477
x-ms-traffictypediagnostic: DBBPR08MB4428:|DBBPR08MB4428:|DB7PR08MB3322:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB33225C93EE21ACC8EE222D08F8F20@DB7PR08MB3322.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 034902F5BC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(966005)(33656002)(478600001)(64756008)(52536014)(66556008)(6916009)(66446008)(4326008)(55016002)(9686003)(76116006)(91956017)(7416002)(66946007)(66476007)(26005)(186003)(81156014)(6506007)(8676002)(7696005)(8936002)(71200400001)(5660300002)(316002)(54906003)(86362001)(2906002)(81166006)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4428;H:DBBPR08MB4823.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4jUu/vvTga/F8MsK43egkld02CnIQhzRo7rBJanF2d0X8SrtAuOqNIg7UufnqNUqC11VdhDZGr8pjwgh9jw5Tm2dd50Xn8wkY1amTNADgbuxphaYgD8aC/Sp/Namf/7c/P48ILZU4fgOeVnAWyl2urkEHEmVcWqmVphhh4XZhsJE2ETLHteRXPuFDhVYmDb412V97556rc9VaYGucKMhr4GJZD8z8gwueLCDoMnSlWDIosZUaucfZbXwqDINos43rgwmVvTOsohPWub8IhI3I7Pr7tGqr5QqKy3gYi7sgJ2Coac7kr/Un7nyVokU7xQ38FbILW2pFybeAIJBfzg+2euTnp+a3a5y9ILmjyI2LIOawQvnvdUVFw5unJOGoE9fHy+7vc8UGdPzbcC8tyID2TeJfMPlS2pIV52u5XkjzOhAocBM+A35XiMHxc/WZnU3olryRww+wS+Q4nlgf7gpTOqVo+9UJXQQvdA8Vs8rgY99G1lggEYOKyH3aMmPTfByMStQgpmt2WjkRIWGG4lytw==
x-ms-exchange-antispam-messagedata: IWhxSGfmVH122DjMHZutJA50supiBXBJ6aNGyI4AsQhr8oUQJb21dUiRxKgwd036V4978XrwGHkuX6mss0uKRJd6f8ns/lV4Gqt1fQ5/FNtMgtpm6X2yY5lwaTx8JFJPz+wBSMGNtk8Ql6h6JSoK/A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4428
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Peter.Smith@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(199004)(46966005)(36906005)(86362001)(356004)(6862004)(81156014)(8676002)(8936002)(33656002)(2906002)(7696005)(316002)(81166006)(54906003)(966005)(186003)(26826003)(47076004)(55016002)(70586007)(70206006)(6506007)(4326008)(26005)(478600001)(9686003)(5660300002)(52536014)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3322;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: aa500a0c-699f-4b55-7bf3-08d7cda91ef0
X-Forefront-PRVS: 034902F5BC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8lnVR78gNSu+2lBwVMq5kdNETffZ/pL2G+iao3pvRDcrGM+7bE/QHpERzlO8ayHz6JXYbqkSbXC/keueGqbsHcWe1KohFkxmy9o7JzOGa+bMIYdHIyqILKD9LOzKtc6moD8hxa5KgWaBREpR7pZSpJ4e5APV9q5hXO3qCtf2QDup9BckH51Ou1Ytx8X2+dYr9OPs+kS0tVCAUCIwGTiUkpc2WPXLbgLGl64f5V6j27280AS7zns0qXLnOfAhA29l6AMp9P3tpeCXzvKatnUgERaCiv6wAw7i95anrBE3GOVOk4phikS9JLpdcLZAZlZ9rkJtcpnscLnp05rHX3tm75ewKsAVNOGAU34xvQI7P3m7MjU5pdgLRCHF8dKQhRm4Rl+N9Gonz6UN8HZNo0FDbYVvnz19+/F/cCQO9CicUmdoW4/Vvjv47DXnkjsoAzx6V5DViW/mousm99pHXIQ7Ppd+r4KABqNvJWtKHpqmWvogmAajFuzrSikYm6kV34TJ0RJrsiRgiHj3CMLaPUGZpDR0X/VZZ7MVwiXvRGiMjCUmiUcbiM5p3dCJg8cJUwzQZuTgoz6a0aVBofJla0TwA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2020 15:04:24.0176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac389c9-63d0-4de7-e033-08d7cda92477
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> To build the kernel with Clang's integrated assembler the VFP code needs=
=0A=
> to make use of the unified assembler language (UAL) VFP mnemonics.=0A=
> =0A=
> At first I tried to get rid of the co-processor instructions to access=0A=
> the floating point unit along with the macros completely. However, due=0A=
> to missing FPINST/FPINST2 argument support in older binutils versions we=
=0A=
> have to keep them around. Once we drop support for binutils 2.24 and=0A=
> older, the move to UAL VFP mnemonics will be straight forward with this=
=0A=
> changes applied.=0A=
>=0A=
> Tested using Clang with integrated assembler as well as external=0A=
> (binutils assembler), various gcc/binutils version down to 4.7/2.23.=0A=
> Disassembled and compared the object files in arch/arm/vfp/ to make=0A=
> sure this changes leads to the same code. Besides different inlining=0A=
> behavior I was not able to spot a difference.=0A=
>=0A=
=0A=
From the perspective of an Arm toolchain developer perspective the=0A=
substitutions in this patch series look correct to me.=0A=
=0A=
Some references I found helpful:=0A=
=0A=
The v8-A Arm Architecture Reference Manual chapter Legacy Instruction Synta=
x for=0A=
AArch32 Instruction Sets. Table K6-2 Pre-UAL instruction syntax for A32=0A=
floating-point instructions=0A=
=0A=
FMSR/FMRS is the pre-UAL name for VMOV (between general-purpose register an=
d=0A=
single-precision)=0A=
FMDRR/FMRRD is the pre-UAL name for VMOV (between two general-purpose=0A=
registers and a doubleword floating-point register)=0A=
FLDMIAD is the pre-UAL name for VLDMIA=0A=
FSTMIAD is the pre-UAL name for VSTMIA=0A=
=0A=
FLDMIAX and FSTMIAX has no UAL equivalent and is deprecated in ARMv6 and ab=
ove,=0A=
it is equivalent to pre-UAL FLDMIAD/FSTMIAD except that the imm8 field is s=
et=0A=
to twice the number of doubleword registers + 1, instead of twice the numbe=
r of=0A=
doubleword registers. This description is taken from A8.8.50 F*, former=0A=
Floating-point instruction mnemonics in the v7-A Arm Architecture reference=
=0A=
manual.=0A=
=0A=
The mrrc/mcrr and mcr/mcr correspond to a VMOV instruction. The mrrc/mcrr a=
nd=0A=
mcr/mcr set opc2 to #4 when accessing registers 16 to 31 as the instruction=
s=0A=
can only refer to 16 coprocessor registers. The same bit (7) in the VMOV=0A=
corresponds to N, with the register n =3D UInt(N:Vn) so VMOV can refer to 3=
2=0A=
registers.=0A=
=0A=
Ref: Arm V8-A https://static.docs.arm.com/ddi0487/fa/DDI0487F_a_armv8_arm.p=
df=0A=
Ref: Arm V7-A https://static.docs.arm.com/ddi0406/c/DDI0406C_C_arm_architec=
ture_reference_manual.pdf=0A=
=0A=
Hope this helps move this forward=0A=
=0A=
Peter=0A=
=0A=
> This replaces (and extends) my earlier patch "ARM: use assembly mnemonics=
=0A=
> for VFP register access"=0A=
> http://lore.kernel.org/r/8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266=
841.git.stefan@agner.ch=0A=
>=0A=
> --=0A=
> Stefan=0A=
>=0A=
> Stefan Agner (3):=0A=
>   ARM: use .fpu assembler directives instead of assembler arguments=0A=
>   ARM: use VFP assembler mnemonics in register load/store macros=0A=
>   ARM: use VFP assembler mnemonics if available=0A=
>=0A=
>  arch/arm/include/asm/vfp.h       |  2 ++=0A=
>  arch/arm/include/asm/vfpmacros.h | 31 ++++++++++++++++++++++---------=0A=
>  arch/arm/vfp/Makefile            |  5 ++++-=0A=
>  arch/arm/vfp/vfphw.S             | 31 ++++++++++++++++++++-----------=0A=
>  arch/arm/vfp/vfpinstr.h          | 23 +++++++++++++++++++----=0A=
>  5 files changed, 67 insertions(+), 25 deletions(-)=0A=
> =0A=
> -- =0A=
> 2.25.1=0A=
