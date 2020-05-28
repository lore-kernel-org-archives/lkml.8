Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99320C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FA220776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yKoo5vgs";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yKoo5vgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgE1IFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:05:25 -0400
Received: from mail-am6eur05on2055.outbound.protection.outlook.com ([40.107.22.55]:57984
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbgE1IFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaXZ81rLzF61I6IkFwOAIbQsBICY+2mt4KwFZh0eGho=;
 b=yKoo5vgsOv/7WB+Q4nv8Ex3oCjqDj/oDwAmJzlHanVP0kxgt3YDqrBUUIEaE97kR03oe+WiNzB7fe2tMS6VUM9PmXIKRJtPBjIFRcFK60Ure7G2P2kffsccERgdyWe4oH5DJ7VCsdZ/XgCGBYsVMIfmG3XeTNSs5SkXvKHnAc/M=
Received: from DB6PR0601CA0007.eurprd06.prod.outlook.com (2603:10a6:4:7b::17)
 by AM6PR08MB4865.eurprd08.prod.outlook.com (2603:10a6:20b:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 28 May
 2020 08:05:18 +0000
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::8d) by DB6PR0601CA0007.outlook.office365.com
 (2603:10a6:4:7b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Thu, 28 May 2020 08:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 28 May 2020 08:05:17 +0000
Received: ("Tessian outbound cff7dd4de28a:v57"); Thu, 28 May 2020 08:05:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8285a24a9476a3dd
X-CR-MTA-TID: 64aa7808
Received: from e130019a319d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 88D329E4-E172-4F29-9631-357FABE9F141.1;
        Thu, 28 May 2020 08:05:11 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e130019a319d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 28 May 2020 08:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dykZE4usDVP/Jl8pEaFt38fxAsq1XZymHxPa/GpIpYFIW4eIXbOALrjteGQUdlsXca8kcScHZcjQe0v7MhYyfuB7Nn1egV2oUQXtfcqENrnV3hlAOOrHFJt1Vr1pICCyDDS0vi5Z4Ygqm9Fo+2zeHevzXvSN3vLlM3cpsBz+HWln/k0N+6ablJDyn8RbjjkBJg1OSoT61UIb/xywJCsiWisin7tUCpzSgagjwU45dGwkAEr7pHC/2/wWHsMXdmh48wGL0nAdTSdtZkEVrD3UdJnsV5H5+LRoGYaPjWxduWX5wQ/c7NYRQvKya0CACGJlifpbB/xiRqiUSfvhkLtfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaXZ81rLzF61I6IkFwOAIbQsBICY+2mt4KwFZh0eGho=;
 b=J154Wm7WP94M2Lu/uLSLJ/p/k42QtXbvVwtzopIPvd9sMR6KD5lNrz3hT2dSLu/BBzUMJ108ErW0zzJKntNrvZQ590xk/QqmG4WMb0nfgmnR5cdeSw1LCuKi18qiMQisOUIsXU3Xd39jn3Mmk+foUxkn85XOW4oR7F4UmrDulBsVEUbvwUOvoyvahZzTLvfS4wh/qjengv7VlF2BNzV31ZI3Q0pphp+8bKtbIWd5E4clQFRMHr7xDLj2eRAwpP9Q3glAbp5UhkzJBNwtqPxuyv7ZkV0aUmq+pbBeNFnR98mvvFlDG784QzTz2ChCcr/mQfNxV7FdXW+H95bCuZyrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaXZ81rLzF61I6IkFwOAIbQsBICY+2mt4KwFZh0eGho=;
 b=yKoo5vgsOv/7WB+Q4nv8Ex3oCjqDj/oDwAmJzlHanVP0kxgt3YDqrBUUIEaE97kR03oe+WiNzB7fe2tMS6VUM9PmXIKRJtPBjIFRcFK60Ure7G2P2kffsccERgdyWe4oH5DJ7VCsdZ/XgCGBYsVMIfmG3XeTNSs5SkXvKHnAc/M=
Received: from VI1PR08MB3198.eurprd08.prod.outlook.com (2603:10a6:803:49::20)
 by VI1PR08MB3744.eurprd08.prod.outlook.com (2603:10a6:803:bc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Thu, 28 May
 2020 08:05:09 +0000
Received: from VI1PR08MB3198.eurprd08.prod.outlook.com
 ([fe80::dc32:9f26:4e3c:66d]) by VI1PR08MB3198.eurprd08.prod.outlook.com
 ([fe80::dc32:9f26:4e3c:66d%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 08:05:09 +0000
From:   Peter Smith <Peter.Smith@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <Robin.Murphy@arm.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Victor Campos <Victor.Campos@arm.com>,
        "david.spickett@linaro.org" <david.spickett@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
Thread-Topic: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
Thread-Index: AQHWNGXqzYQgzZxejUil5D7OLgL6P6i9G5wR
Date:   Thu, 28 May 2020 08:05:08 +0000
Message-ID: <VI1PR08MB319868AFBEDCD0925C53701AF88E0@VI1PR08MB3198.eurprd08.prod.outlook.com>
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com>
 <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com>
 <CAKwvOdn1W4C5HRJEch5PS-Atcmysh0UD+VZX_wi8tviGwhmM7Q@mail.gmail.com>,<CAKwvOd=Zxm9TDPNd4Qvn6Ru==FLasiP1xWXMM7ji08VWRjBu2g@mail.gmail.com>
In-Reply-To: <CAKwvOd=Zxm9TDPNd4Qvn6Ru==FLasiP1xWXMM7ji08VWRjBu2g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [217.140.106.52]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7984d5bd-7c98-4f74-91f6-08d802dddc3f
x-ms-traffictypediagnostic: VI1PR08MB3744:|AM6PR08MB4865:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4865E57E8CF4C137ED8B3404F88E0@AM6PR08MB4865.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:5797;
x-forefront-prvs: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: nQOA0ZpeIxEf6iTxOObyboE+CIdM7KRbDfyNS5HnoI6utvLyIMogx7c45nbl6dHNtWBgPloACdhOeiswe45pU0/NYobCV//o4IgwaFymxlqhRVHKj4+PGsL+AIWEPENQu1ohlS8oLPWgYOvYDfgKu2kX1AinaA2Cau+AVN3cNRgPL7iRkAXMOU/QqKdlTM4WT1NJIpZkRpEKxj83PF3C+ERbLBm0Y9/kPA4meG7A1k7bwkcLeX0KpaZLW9GKybVSD/DXsKqVCNtjenjuCPmhUrBUgHjJPyyEhnzqI2Dq2Ah2MhswPRGIJwlFFDCMX8C6XyfS2CUyq3tAsZNlGhdI+g2ZZbOhVIwbg8XM366lvE+kMkMRf3lxJZTwSVTeG3MDeDD+2AHmfbFgzkAX1OdvcQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3198.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(2906002)(53546011)(6636002)(4326008)(7696005)(478600001)(110136005)(54906003)(8936002)(83380400001)(8676002)(6506007)(66556008)(33656002)(9686003)(55016002)(52536014)(5660300002)(7416002)(86362001)(26005)(186003)(64756008)(316002)(966005)(76116006)(66446008)(66946007)(71200400001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ns0QJkr6cEXhuCenSd4UY7ytnRqp7TJwuOvc4LvapgmNuytYvvfwA8t+9rbTCPQngsGcIInL5uxIVyzB/30GfUhShj7sdVVqKuF10Pc/ZkcmAbxvg4KwumS45PK3LbNww4OuRWsZXO2WQs77JuEIfRB2SSKx3nBe7HQbV3ZRCPQA+soeivhCmIND0SVwswsUc3iIIsGXxFa+WLrfNL+ecDZJjzAC9NQcEWaV1lQFdm4rddvPeVnW9dn4wRWK5oD+FWBgbhZNLwGijOYe1rFxdcdzvsobcQ1bY+BCJnOMaNde1kXC1NZU+RtvAeXrFxnsz5y7cABf/yPDze5v6pi1J5n0/GSRW7j+b/dbiRwn4d1ozjaYHM2rZdhFFJcHReBMcHY2jrdGU2A31T7eBNYn1a2aKl9NYqE8ZHhVKTMfCUBr0//FQ//wIirFXbSofKrtdSEm6jHkJv2evPTus3KFAmqpKk/tHDV3mliwkgb1eVmw+uFZD6qgtkNHzwhsNceX
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3744
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(54906003)(8936002)(47076004)(5660300002)(53546011)(33656002)(82310400002)(86362001)(186003)(966005)(82740400003)(26005)(356005)(4326008)(478600001)(8676002)(316002)(81166007)(6506007)(70586007)(52536014)(70206006)(107886003)(110136005)(9686003)(83380400001)(55016002)(6636002)(336012)(7696005)(2906002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 283e9603-1c51-4f50-d034-08d802ddd6f8
X-Forefront-PRVS: 0417A3FFD2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lB2zQc9itfdoBrBZKF7bNLjmZa/ZmRWbtOQaN4XXBBbiFLUgVud7N7JNiIU1YP5KS35vPSOeT9Gc4fUBipGp9nT3phEva+JoS+PRf+W6KulklHGsDGQdZ3kDys8y9F5DX+EOu38VKfetnMyZFtNoEH/MXSMyBMD0yNyK+5bjCOBt4cUryQHqKWKLM7IyT4pj1ArSv5OERzuWXU9FuLU0dxuxr1A0L0O/5pyz4OCqxgu7mJPTWPclbXLgcG7fdYF/tWDiSiRpC8wlBv6zgIE3Yh57NJZ3xQr2yg3jn4EHsO7AVeM0P7XFRhd96a1uPTGQ0uYZOlQ1K4a94OLOfbobYwAysa7WKSqVagRfWAEKY1XNf8T8GpNHsxU/gLB7OeJglMmfx9q0By6Tow02dlcBPQhnWFh7LUcFZAPKVDAGJ52k3V+61joGqRZIfvSIhYLCBvKQ8YdpZ3iCIgPC5dJx6BrdbWBjkxijGt3kJbd2zS4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 08:05:17.9041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7984d5bd-7c98-4f74-91f6-08d802dddc3f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nick Desaulniers <ndesaulniers@google.com>=0A=
> Sent: 27 May 2020 21:31=0A=
> To: Robin Murphy=0A=
> Cc: Catalin Marinas; Will Deacon; Naohiro Aota; Stephen Boyd; Masahiro Ya=
mada; LKML; Manoj Gupta; Luis Lozano; Nathan Chancellor; Vincenzo Frascino;=
 Linux ARM; Kristof Beyls; Victor Campos; david.spickett@linaro.org; Arnd B=
ergmann; Peter Smith=0A=
> Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm=
=0A=
> =0A=
> On Wed, May 27, 2020 at 1:14 PM Nick Desaulniers=0A=
> <ndesaulniers@google.com> wrote:=0A=
> >=0A=
> > On Wed, May 27, 2020 at 12:28 PM Robin Murphy <robin.murphy@arm.com> wr=
ote:=0A=
> > >=0A=
> > > On 2020-05-27 18:55, Nick Desaulniers wrote:=0A=
> > > > On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com>=
 wrote:=0A=
> > > >>=0A=
> > > >> On 2020-05-26 18:31, Nick Desaulniers wrote:=0A=
> > > >>> Custom toolchains that modify the default target to -mthumb canno=
t=0A=
> > > >>> compile the arm64 compat vdso32, as=0A=
> > > >>> arch/arm64/include/asm/vdso/compat_gettimeofday.h=0A=
> > > >>> contains assembly that's invalid in -mthumb.  Force the use of -m=
arm,=0A=
> > > >>> always.=0A=
> > > >>=0A=
> > > >> FWIW, this seems suspicious - the only assembly instructions I see=
 there=0A=
> > > >> are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the=
=0A=
> > > >> -march=3Darmv7a baseline that we set.=0A=
> > > >>=0A=
> > > >> On a hunch, I've just bodged "VDSO_CFLAGS +=3D -mthumb" into my tr=
ee and=0A=
> > > >> built a Thumb VDSO quite happily with Ubuntu 19.04's=0A=
> > > >> gcc-arm-linux-gnueabihf. What was the actual failure you saw?=0A=
> > > >=0A=
> > > >  From the link in the commit message: `write to reserved register '=
R7'`=0A=
> > > > https://godbolt.org/z/zwr7iZ=0A=
> > > > IIUC r7 is reserved for the frame pointer in THUMB?=0A=
> > >=0A=
> > > It can be, if you choose to build with frame pointers and the common=
=0A=
> > > frame pointer ABI for Thumb code that uses r7. However it can also be=
=0A=
> > > for other things like the syscall number in the Arm syscall ABI too.=
=0A=
> >=0A=
> > Ah, right, with -fomit-frame-pointer, this error also goes away.  Not=
=0A=
> > sure if we prefer either:=0A=
> > - build the compat vdso as -marm always or=0A=
> > - disable frame pointers for the vdso (does this have unwinding implica=
tions?)=0A=
> > - other?=0A=
> >=0A=
> > > I=0A=
> > > take it Clang has decided that writing syscall wrappers with minimal=
=0A=
> > > inline asm is not a thing people deserve to do without arbitrary othe=
r=0A=
> > > restrictions?=0A=
> >=0A=
> > Was the intent not obvious? We would have gotten away with it, too, if=
=0A=
> > wasn't for you meddling kids and your stupid dog! /s=0A=
> > https://www.youtube.com/watch?v=3DhXUqwuzcGeU=0A=
> > Anyways, this seems to explain more the intentions:=0A=
> > https://reviews.llvm.org/D76848#1945810=0A=
> > + Victor, Kristof (ARM)=0A=
> =0A=
> And maybe some other useful data points regarding warning on use of r7=0A=
> and frame pointers.=0A=
> https://github.com/ClangBuiltLinux/linux/issues/701#issuecomment-59132575=
8=0A=
> https://bugs.llvm.org/show_bug.cgi?id=3D45826=0A=
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D94986=0A=
> =0A=
> + Peter (ARM)=0A=
> + David, Arnd (Linaro)=0A=
> --=0A=
> Thanks,=0A=
> ~Nick Desaulniers=0A=
=0A=
Hello Nick,=0A=
=0A=
The AAPCS has only recently (28th January 2020) been updated with a=0A=
specification of the frame pointer and frame chain.=0A=
=0A=
My understanding is that neither gcc nor clang implement this part yet.=0A=
Historically the frame pointer in Thumb has not been defined in the=0A=
AAPCS with implementations falling back to historic definitions of=0A=
fp =3D r7 in Thumb and fp =3D r11 in Arm. The use of different frame=0A=
pointer registers in Arm and Thumb state makes it difficult to=0A=
construct a frame chain with interworking. My understanding of the=0A=
AAPCS is that it has been changed to make the frame pointer r11 on=0A=
both Arm and Thumb to make unwinding possible, at the expense of r11=0A=
being harder to access from 16-bit Thumb instructions. There are 4=0A=
levels of conformance with respect to construction of frame records=0A=
and frame chain as it is likely some platforms will want to persist=0A=
with r7.=0A=
=0A=
An implementation of the latest version of the AAPCS would permit=0A=
a frame pointer and use of r7 as a reserved register. Although as=0A=
you'll need to support older compilers this may not be an option.=0A=
I suggest using Arm if you need a frame pointer, and disable the=0A=
frame pointer if you want/need to use Thumb. My understanding is that=0A=
runtime unwinding using the frame pointer in Thumb is already difficult=0A=
due to Arm and Thumb functions using different registers for the frame=0A=
pointer.=0A=
=0A=
Hope this helps=0A=
=0A=
Peter=0A=
