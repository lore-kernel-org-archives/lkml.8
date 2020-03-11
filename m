Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D184C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDED2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NkaJLzGh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Z2FIPjfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgCKU6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:58:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43022 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbgCKU63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:58:29 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 233AFC0F71;
        Wed, 11 Mar 2020 20:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583960308; bh=RD+d7RV6+v/1Va4YA/+qNQEtN8lG+sQTsu/lyFwY02k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NkaJLzGhLUcWke5LmwcMLKz0FUofyGOYhtWQZBpsyAfeMOKx6gacOFxPuwKJunDkh
         8XMSe0794yN4n25/0+SEy9OI6eQmB4lM6u7tsGjyNThZ8b147MD6wfm0Pk+W5mn8Dl
         MpRg6hH7FE4Q+syNgw0qEmgDEX81hZD2fdEun1y3FVbayAunmeK6+rC7LE64WAUqDx
         2zAXqWl0rLbC97c6TMOlcNZUklCXiGWHvIHa1iz1ChUXPl/PKCoa5waNNouyh2rumh
         AtfYKRApb8wiQT15b7GRygYITMN+ebYUzFWBI7I8lpTglnQMKKVf6JXgGOK0ye91ad
         lfxDbC3t9NT8w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AE35DA006A;
        Wed, 11 Mar 2020 20:58:27 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Mar 2020 13:58:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 11 Mar 2020 13:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRC3NLVz1o6GPB/Ji5vmOBfRs3/ArvYBcJIJhxL/sk8bLlGyJx+FMVwz3+cUvhFgnkXe30RE7Sy7pknK/kjOyi2PiRvbsz4o1+gSzcqrw+Yb7wlYgk2VrR+h0QkzQnhePMNUs0FG/dRy6QvhTeunHODxfIzxyy1iAtsPKyrzpFlZdoUbMP3PAvK98NBCO3x/hF6JBAYCFUPBTqirsclNVmFUTMOi/3sTCLduwwnFrz7TeWdVWGAbUt+dVZa7jE9GWkiMct86AndlW8N076/r/rtOqsht8xlUy9Cj9VVgNwY/nfW7EvZYtN4CwgV+EV5xwuvx14FsAlZQNdAkRiTCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb9tdOnqxgpA0HtpEEJGKN6131sq7lDi/t+wRTKebY8=;
 b=mIZh6BFoIVEW1AoJL3nJ5OWl7/n4XbFRzERF+a72L4LtCq89vov1JT1f0CcIA+0W/a7DiaDIyPkygo4mo+yQFlrKmanAGY5C5mNfAR4TC5+sdzkzAtv9alMlTBcRZdk6aJop1W4jPy0Mvng4dTlOG6QEXd0+fb/t1XtAnd7Mg+mU7ec2Hs/JBA374HhsrcE30NyyrqfjnZDrSkXIx9GnDHEGMUWeYPMzB9CyXR5fx0Fq0Qigd+s2x1pOra4vtLPbs43nyN3fvqb4ziW90rPw3oztWqNh8Z7iiU1Gi1EP8jdVlpTKqjFh5ml1L/hGI6hHUY1msWVShP4y+ocqoecjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb9tdOnqxgpA0HtpEEJGKN6131sq7lDi/t+wRTKebY8=;
 b=Z2FIPjfuvX3XwnJ7XwYntEnCZJk16fnK4bWt84ijGXG/y9ysXANvWuFdfw+aIoSehNTvd8qRpfWkjzfGHu6yZoTn/h9SK96bRU6FTBq89kQMHhWXTQochasFVwCRFc3jvWYFKWaRMe0dmm4t2H82THFllAXXpeVrm1Ud9ZxvzOs=
Received: from BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 20:58:14 +0000
Received: from BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a]) by BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 20:58:14 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 2/2] ARC: don't align ret_from_exception function
Thread-Topic: [PATCH 2/2] ARC: don't align ret_from_exception function
Thread-Index: AQHV98HujcRrFCa3G0K90e5pOjYelKhDqFKAgAAx9ms=
Date:   Wed, 11 Mar 2020 20:58:14 +0000
Message-ID: <BY5PR12MB40348292DA303489C1DA2B66DEFC0@BY5PR12MB4034.namprd12.prod.outlook.com>
References: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
 <20200311162644.7667-2-Eugeniy.Paltsev@synopsys.com>,<448ba208-56a5-d8b2-9675-7be03b872c23@synopsys.com>
In-Reply-To: <448ba208-56a5-d8b2-9675-7be03b872c23@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [5.18.243.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10db636b-68e5-4f40-076e-08d7c5feea96
x-ms-traffictypediagnostic: BY5PR12MB4116:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4116E7B86AB2C69366511D8EDEFC0@BY5PR12MB4116.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(7696005)(54906003)(26005)(186003)(316002)(110136005)(8676002)(6506007)(52536014)(9686003)(81156014)(33656002)(55016002)(71200400001)(86362001)(8936002)(107886003)(4326008)(478600001)(66446008)(5660300002)(66556008)(76116006)(91956017)(66476007)(64756008)(81166006)(2906002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR12MB4116;H:BY5PR12MB4034.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcXWAPTouO03hsMReeDFu1aQEmQXaGXtzLCGSBkqO7RO14CgdL+ZTUhLjbdT8nehSji/9Xjvw+EnFywhfcqrwEht5afDpuVGNmaqR1x0/L6RMOU5L+A0fSMs4uAuSTTOo7D3ahyDS0eqFfLyqnE9cVNNDXm2H8BTeHOwtl5yYFg+h7UDRqLhJWOng9cyER2LTh7N4uGx+k/X2JUqC5/4rKtCrcGKzAhSfOlwsV9qH5ByYhVSZhviRrC6CM3kHNxv2p2tTzUkySWDABltFMazNOK4ZoBdpkyT4kdWeZuBwhalkZ9v53FmIve1vcbXZ/SujVlLOKCFpBldMf3caF1myUp/vmVnYmiVWVoBGx5flU7kCJMmqm9RlU0V4ScSkbBgrqk2q0Hjqk9+nuqVHKsuG0GgOnHaIL1Xbu+RGG63wb36A56OImR5aZdQ3BxN4k7V
x-ms-exchange-antispam-messagedata: 9FDC/y7xqGBiYkz1Wc21iIT9qC2uTMgaUC/A5K6CBByMiKS8bv0sGG9znZ/AoYqyPF9DUZ6jFae9sCMfYuDKUxi94JKQ6rSPFMWRR1FVbXbk5QJ4XSfRqNUwm+erJDhGnrnMSRuoHGhp/OEuifqMjQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10db636b-68e5-4f40-076e-08d7c5feea96
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 20:58:14.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UZ4rBgcxIolD2q/00Kqojx153uKIGWk4RzCZen7sbbxeRZBOpoPrTpLj/TPYCYK/dxNuRMJu1EsDdBAtdvGfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Vineet Gupta <vgupta@synopsys.com>=0A=
>Sent: Wednesday, March 11, 2020 20:38=0A=
>To: Eugeniy Paltsev; linux-snps-arc@lists.infradead.org=0A=
>Cc: linux-kernel@vger.kernel.org; Alexey Brodkin=0A=
>Subject: Re: [PATCH 2/2] ARC: don't align ret_from_exception function=0A=
>=0A=
>On 3/11/20 9:26 AM, Eugeniy Paltsev wrote:=0A=
>> ARC have a tricky implemented ret_from_exception function.=0A=
>> It is written on ASM and can be called like regular function.=0A=
>> However it has another 'entry point' as it can be called as a=0A=
>> continuation of EV_Trap function.=0A=
>=0A=
>It is not really intended / needed to be called form outside ASM - but has=
 to be=0A=
>spread across 2 asm files as it is mostly target isa independent, while th=
e=0A=
>callers are in separate target isa specific files.=0A=
>The ENTRY/END annotations are simply for the dwarf unwinder to stop gracef=
ully.=0A=
>=0A=
>> As we declare "ret_from_exception" using ENTRY macro it may align=0A=
>> "ret_from_exception" by 4 bytes by adding padding before it.=0A=
>> "ret_from_exception" doesn't require alignment by 4 bytes=0A=
>> (as it doesn't go to vector table, etc...) so let's avoid aligning=0A=
>> it by switch from ENTRY (which is alias for SYM_FUNC_START) to=0A=
>> SYM_FUNC_START_NOALIGN macro.=0A=
>=0A=
>I would like to keep it aligned.=0A=
>=0A=
>ARC700 definitely has penalty for unaligned branch targets, so it will def=
initely=0A=
>suffer there.=0A=
=0A=
Do you know some exact numbers? I'm not an expert in ARC700 (fortunately =
=3D)=0A=
=0A=
>=0A=
>For HS, unaligned branch targets have no penalty (for the general case atl=
east),=0A=
>but if it does get unaligned, the entire entry prologue code will be - i.e=
. each=0A=
>one of the subsequent 130 or so instructions. That doesn't seem like a goo=
d idea=0A=
>in general to me.=0A=
=0A=
I really don't insist about applying this patch but I don't understand your=
=0A=
argumentation about ARC HS like at all. Could you please explain in more de=
tail what=0A=
130 instructions you are talking about?=0A=
=0A=
>What's weird is I never hit the original problem you ran into - are you us=
ing a=0A=
>toolchain with the branch relaxation stuff  ?=0A=
=0A=
Looks like we just were lucky enough and didn't change this code a lot.=0A=
I faced with this issue when I was developing DSP-related stuff. Initially =
I=0A=
triggered it when I replaced 'mov r10, 0' instruction with 'mov_s r10, 0' a=
nd got=0A=
weird kernel crush.=0A=
=0A=
It can be reproduced with any toolchain (it's not related to branch relaxat=
ion stuff).=0A=
=0A=
>I faked it using a nop_s and the SYM_FUNC_START_NOALIGN( ) annotation and =
can see=0A=
>all instructions getting unaligned.=0A=
=0A=
What is the problem with it? It's totally valid and fine for ARC HS to have=
 instructions=0A=
aligned by 2 byte. Or are you talking about ARC700 again?=0A=
=0A=
>Before;=0A=
>=0A=
>921238e4 <ret_from_exception>:=0A=
>921238e4:    ld    r8,[sp,124]=0A=
>921238e8:    bbit0.nt    r8,0x7,212=0A=
>...=0A=
>92123ac8:    rtie=0A=
>92123acc <debug_marker_ds>:=0A=
>92123acc:    ld    r2,[0x927d81d8]=0A=
>92123ad4:    add    r2,r2,0x1=0A=
>92123ad8:    st    r2,[0x927d81d8]=0A=
>92123ae0:    bmskn    r11,r10,0xf=0A=
>92123ae4:    sr    r11,[aux_irq_act]=0A=
>92123ae8:    b    -140    ;92123a5c=0A=
>=0A=
>After:=0A=
>=0A=
>9212393c:    nop_s=0A=
>9212393e <ret_from_exception>:=0A=
>9212393e:    ld    r8,[sp,124]=0A=
>92123942:    bbit0.nt    r8,0x7,214=0A=
>...=0A=
>92123b22:    rtie=0A=
>92123b26 <debug_marker_ds>:=0A=
>92123b26:    ld    r2,[0x927d81d8]=0A=
>92123b2e:    add    r2,r2,0x1=0A=
>92123b32:    st    r2,[0x927d81d8]=0A=
>92123b3a:    bmskn    r11,r10,0xf=0A=
>92123b3e:    sr    r11,[aux_irq_act]=0A=
>92123b42:    b    -138    ;92123ab6 <debug_marker_syscall>=0A=
>92123b46:    nop_s=0A=
>=0A=
>> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
>> ---=0A=
>>  arch/arc/kernel/entry-arcv2.S | 2 +-=0A=
>>  arch/arc/kernel/entry.S       | 3 +--=0A=
>>  2 files changed, 2 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2=
.S=0A=
>> index 12d5f12d10d2..d482e1507f56 100644=0A=
>> --- a/arch/arc/kernel/entry-arcv2.S=0A=
>> +++ b/arch/arc/kernel/entry-arcv2.S=0A=
>> @@ -260,4 +260,4 @@ debug_marker_ds:=0A=
>>       sr      r11, [AUX_IRQ_ACT]=0A=
>>       b       .Lexcept_ret=0A=
>>=0A=
>> -END(ret_from_exception)=0A=
>> +SYM_FUNC_END(ret_from_exception)=0A=
>> diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S=0A=
>> index 60406ec62eb8..79409b518a09 100644=0A=
>> --- a/arch/arc/kernel/entry.S=0A=
>> +++ b/arch/arc/kernel/entry.S=0A=
>> @@ -280,7 +280,7 @@ END(EV_Trap)=0A=
>>  ;=0A=
>>  ; If ret to user mode do we need to handle signals, schedule() et al.=
=0A=
>>=0A=
>> -ENTRY(ret_from_exception)=0A=
>> +SYM_FUNC_START_NOALIGN(ret_from_exception)=0A=
>>=0A=
>>       ; Pre-{IRQ,Trap,Exception} K/U mode from pt_regs->status32=0A=
>>       ld  r8, [sp, PT_status32]   ; returning to User/Kernel Mode=0A=
>> @@ -373,4 +373,3 @@ resume_kernel_mode:=0A=
>>       b       .Lrestore_regs=0A=
>>=0A=
>>  ##### DONT ADD CODE HERE - .Lrestore_regs actually follows in entry-<is=
a>.S=0A=
>> -=
