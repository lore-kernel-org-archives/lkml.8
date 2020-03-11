Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B5C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CD42074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BY5Zqe/V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="QS2Tijn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgCKW2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:28:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45436 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729739AbgCKW2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:28:32 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C5FB443B7F;
        Wed, 11 Mar 2020 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583965711; bh=BiNVAdbK+A1R/lPYTrFzffTI+1jbUtSxZ9RiC4mCU7I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BY5Zqe/VOMdKM2grcglJN85M12vliRaOjflPU3sQUHwzVY991ALLG5GgxJYcH/aAr
         0rh2JoqRbnxxM/AGiMhM0OHSYENFS82H0KTpHHoZF0uCn8rdYNhD6JN8pT4WBhDbcJ
         PfcQEbCYuAtfQOKn1STAwFINV+nIerGDUT8dc+j/zHmdH9geVxt1qMGosFMwKXI0xg
         GYUaZnWcfVf89JxEbhdtwoBySD/czCdl2KtebQdOAvo4M79NeklfUHldft3eJ8eT1o
         DGXLyJdzhoDSmG4yUEp7Tr7OEoS4s6HaU6B7vyQN8vRoePwfrNNeAgb1ZJxG3tQZIo
         NDey7/n9G0wvw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6923CA006B;
        Wed, 11 Mar 2020 22:28:31 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Mar 2020 15:28:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 11 Mar 2020 15:28:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXqaV6PdbMlnBOhuUiDwH0/kwDyjmCRyif9yoIBlj9UZuo8K2MZ/dKAoLoUrGMylnm+pFFvMQqTaPKjfIFe8dsZF+1MG/Os/mVLNz47G+asOV5ORlcu7WfGD5IImR/0Oj798QgZvooxVjGD5Z4wE14Fe2LkjO22V0HA2KkKPQs0Yls9cHMksnnqE40MgEQGLpgcCpXBKmoHAtN//4BCXhlSZF35fGsF6+B7zaezBw0fAd4pjgtud6IZs2Pe1+8rD1Z1WVVOjNShzRhJFu8W3YEtU9312U4OZkCy4y5BtLpfi5TPvqMaNyW/jSQlxps626DcXs8qJrrs5f9Hv8QpPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fny7KRQP4uBnThTLczWdStc/0xLHYugn1KHKDnM5D1w=;
 b=DlSXS6XuwLCJT7TD6+t02gn9nm++oKNUU4LQ59wJkDVLko5vD117IiSX0RQmttjXg7a7Hd7JM239x9iWqTJzedz/xrziEEYOQgihv7/LyzIjVKjqZkRvKLclLg/aOsQ0O7phJ+nlKYhkjAReWzlcQFWFvhFb3NQH4BLFLxntUbNKkJmuNYFlWPB7qD8PTnx1grFmpz7PwIqiZOzB6vVwGYKHC3ovAepHJEWcx80oJrANzRpYjl7xzPLOzxQ/d8MyKKbAAVlOaYebA7lwXQem1RI5ZIBTQVHWIBSg89tou2R0s65RhlL1WyA1gBXPo/zGI0NbQW4IREE6vDR/RbP2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fny7KRQP4uBnThTLczWdStc/0xLHYugn1KHKDnM5D1w=;
 b=QS2Tijn2TSwKsszBA+UflbUIkx+YAHQ3UEBFOFdlur/zb6IHxLxEVopm4Ww0UNl6TskKTeDnqiJ1fyYOAqWiTWonPNsmoQi5DGzH80VJbvBzsZrM7y7jk3fpBFaPo5uPS4F1HppaP9+8Yc4jU/RJvWsXNoMpybXAB3wP5w6l6Ks=
Received: from BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 by BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 11 Mar
 2020 22:28:03 +0000
Received: from BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a]) by BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:28:03 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 2/2] ARC: don't align ret_from_exception function
Thread-Topic: [PATCH 2/2] ARC: don't align ret_from_exception function
Thread-Index: AQHV98HujcRrFCa3G0K90e5pOjYelKhDqFKAgAAx9muAAAkygIAADVOW
Date:   Wed, 11 Mar 2020 22:28:02 +0000
Message-ID: <BY5PR12MB403447EC9499A34209E12494DEFC0@BY5PR12MB4034.namprd12.prod.outlook.com>
References: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
 <20200311162644.7667-2-Eugeniy.Paltsev@synopsys.com>
 <448ba208-56a5-d8b2-9675-7be03b872c23@synopsys.com>
 <BY5PR12MB40348292DA303489C1DA2B66DEFC0@BY5PR12MB4034.namprd12.prod.outlook.com>,<a6728afe-10e4-ce85-b133-17395ac99b86@synopsys.com>
In-Reply-To: <a6728afe-10e4-ce85-b133-17395ac99b86@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [5.18.243.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 201f0cbb-aa8f-462c-f081-08d7c60b7685
x-ms-traffictypediagnostic: BY5PR12MB3956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3956FEAFFB88BC431E0D6E39DEFC0@BY5PR12MB3956.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(7696005)(316002)(107886003)(54906003)(5660300002)(33656002)(55016002)(110136005)(4326008)(71200400001)(9686003)(26005)(186003)(66946007)(76116006)(64756008)(66476007)(66556008)(66446008)(91956017)(478600001)(8676002)(81156014)(6506007)(52536014)(81166006)(8936002)(2906002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR12MB3956;H:BY5PR12MB4034.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O30cBYarrO6zuMv5YGqPcrYVHCqhdr1EbbAdHYeEIPRUU9IV9euQjBngzQzgK10vWyqAJXmFB1XQ9V7ICu48kpsTVPTiTw8aPylxoKtqHEE8jVnw0x1VRt6Z7yUY3FmVJMoTpo3+qGBwjTQT38nvRJjjhzP7g7on2ouuxbV7CXtfcWa0p98G5QiQUMKOJ2a2nX1bpP8dBRUc8lZbFZO7b2qRVdBlHAJVgSjW+zLa4Y3aHwXWjt1fbE5f3qVEQQpH0ubmXnTrFz0EzQwFosnT2Ejhm3sDJqg7nOxoTgaMd1A8aKMLs0TBqPWK6GMi1neCanc9L0l4QR8ic2gvtwkGW55rTzczC/oZ7l3o6l/XsFu5EGx1GetAQSbNxsoGtlhpRDsH0qp3KxH4aIDIXQPSWpb2Hij1iIcHbY3Kml5Zh9PTLhNmbaKmoiJNmbfLpaqi
x-ms-exchange-antispam-messagedata: wnwuv2PGy40FBVEDpKy08WJ/mg0o08a0i20XkIZ/ZWSa0fgznT02UfLIX0ChBBas/mnw99otP2nmnEZZnpmUDAsnpe89C35QBJv/0Gpx5HozHgCIkoWBrzFmKf42OySWf6ukcsH2xw8G76rkkQqQog==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f0cbb-aa8f-462c-f081-08d7c60b7685
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 22:28:02.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TiMv0aYj0X8RbIk3U82IuHlLGoVvDxdBwaNY8RRdcHk263WAT4sSfDycinD9nm45btMPUMBmTKVfr4SgiVidIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3956
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Vineet Gupta <vgupta@synopsys.com>=0A=
>Sent: Thursday, March 12, 2020 00:10=0A=
>To: Eugeniy Paltsev; linux-snps-arc@lists.infradead.org=0A=
>Cc: linux-kernel@vger.kernel.org; Alexey Brodkin=0A=
>Subject: Re: [PATCH 2/2] ARC: don't align ret_from_exception function=0A=
>=0A=
>On 3/11/20 1:58 PM, Eugeniy Paltsev wrote:=0A=
>>>=0A=
>>> I would like to keep it aligned.=0A=
>>>=0A=
>>> ARC700 definitely has penalty for unaligned branch targets, so it will =
definitely=0A=
>>> suffer there.=0A=
>>=0A=
>> Do you know some exact numbers? I'm not an expert in ARC700 (fortunately=
 =3D)=0A=
>=0A=
>I don't remember the exact numbers either.=0A=
>=0A=
>>> For HS, unaligned branch targets have no penalty (for the general case =
atleast),=0A=
>>> but if it does get unaligned, the entire entry prologue code will be - =
i.e. each=0A=
>>> one of the subsequent 130 or so instructions. That doesn't seem like a =
good idea=0A=
>>> in general to me.=0A=
>>=0A=
>> I really don't insist about applying this patch but I don't understand y=
our=0A=
>> argumentation about ARC HS like at all.=0A=
>=0A=
>I knew you would argue hence I already copy/pasted the start and end of th=
e=0A=
>epilogue already in my prev reply which you didn't care to read thru.=0A=
=0A=
Well, I beg to differ :)=0A=
=0A=
>If you start counting instructions from <ret_from_exception> all the way t=
o end of=0A=
><debug_marker_ds> there are over 130 instructions all of which can be rend=
ered=0A=
>unaligned by your patch. What is worse is that this would be unpredictable=
: the=0A=
>unaligned case will mostly NOT happen, but a new compiler or some subtle c=
ode=0A=
>change could causing potentially side-effects we won't even know where to =
look.=0A=
=0A=
I'm definitely missing something. Let's forget for a moment about our code=
=0A=
written in ASM and check the the binaries compiled from C sources.=0A=
The function is aligned by 4 bytes. However the function body contain the m=
ix of=0A=
16 bit, 32 bit, 48 bit and 64 bit instructions. So we have huge amount of=
=0A=
instructions with size > 16 bit which are aligned by 16 bit.=0A=
=0A=
I briefly checked our RPM but I don't see any note that it is OK to have=0A=
dozen of unaligned instructions but it is NOT OK to have a hundred of them.=
=0A=
=0A=
So, what are your concerns based on?=0A=
=0A=
>>> I faked it using a nop_s and the SYM_FUNC_START_NOALIGN( ) annotation a=
nd can see=0A=
>>> all instructions getting unaligned.=0A=
>>=0A=
>> What is the problem with it? It's totally valid and fine for ARC HS to h=
ave instructions=0A=
>> aligned by 2 byte. Or are you talking about ARC700 again?=0A=
>=0A=
>Yes I know that already. It is fine in general as I explained earlier, but=
 can=0A=
>potentially NOT when 130 instructions are unaligned.=0A=
>=0A=
>>> Before;=0A=
>>>=0A=
>>> 921238e4 <ret_from_exception>:=0A=
>>> 921238e4:    ld    r8,[sp,124]=0A=
>>> 921238e8:    bbit0.nt    r8,0x7,212=0A=
>>> ...=0A=
>>> 92123ac8:    rtie=0A=
>>> 92123acc <debug_marker_ds>:=0A=
>>> 92123acc:    ld    r2,[0x927d81d8]=0A=
>>> 92123ad4:    add    r2,r2,0x1=0A=
>>> 92123ad8:    st    r2,[0x927d81d8]=0A=
>>> 92123ae0:    bmskn    r11,r10,0xf=0A=
>>> 92123ae4:    sr    r11,[aux_irq_act]=0A=
>>> 92123ae8:    b    -140    ;92123a5c=0A=
>>>=0A=
>>> After:=0A=
>>>=0A=
>>> 9212393c:    nop_s=0A=
>>> 9212393e <ret_from_exception>:=0A=
>>> 9212393e:    ld    r8,[sp,124]=0A=
>>> 92123942:    bbit0.nt    r8,0x7,214=0A=
>>> ...=0A=
>>> 92123b22:    rtie=0A=
>>> 92123b26 <debug_marker_ds>:=0A=
>>> 92123b26:    ld    r2,[0x927d81d8]=0A=
>>> 92123b2e:    add    r2,r2,0x1=0A=
>>> 92123b32:    st    r2,[0x927d81d8]=0A=
>>> 92123b3a:    bmskn    r11,r10,0xf=0A=
>>> 92123b3e:    sr    r11,[aux_irq_act]=0A=
>>> 92123b42:    b    -138    ;92123ab6 <debug_marker_syscall>=0A=
>>> 92123b46:    nop_s=
