Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723CBC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB952083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KtAIEesx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sX1lB1Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgD2RM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:12:58 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54974 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbgD2RM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:12:57 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3019A406A8;
        Wed, 29 Apr 2020 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588180377; bh=vpABEJJcue5NcviL+CTqLQfa/fBlT2R72BAiMdLbc+M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KtAIEesxFbf8ZxPGzJ+bmszjCJODj2FJ8dzB4KnUPC3t5bVvfKwL0L/v28Fpbmb+z
         FMtwDlCWaAhfeXiVos+uOZOeZ+xfLVnPXQggTafNGd2a7NeIlnWMkOjC6hhgH5q8Vg
         lnqHfjxBZwWgHqJMZcixzo+e5aeq0ErJ+7xGwpwxsO7sLC5f+JtJmoUYVibKR0Ki4d
         IcFII5t+j5z0F2WWCb6eZClXPz16tSRCjtEZ4WR/Izdn127mgowe1hFBHaBVZXOQB6
         h5ovbuhjvrvfJ7ul+HzsFo8tmvckLcTje6A06J9YkbfBlGkiqXxPz9fzqyLd1l7DoC
         +2ok8Jq8Zyqrw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BD172A0067;
        Wed, 29 Apr 2020 17:12:56 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Apr 2020 10:12:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 29 Apr 2020 10:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chvS5p7r7nE4LR0bR+tFSQOINeME6C26NUBgh7SHmVytkU4dY2vreSeoouqpzWX4mLeKTplJ3ZQuhNsCoQNifAw33iNIVSQ28EBD5liMFikUk5+jGoIS7IZBOEZlg7zZaflBsJrELyTk0ffdeGLVT45to5YKJbHOCnFMPZXVJgIxMmBN+i63J1ThqLmt9S2FeAczAb0A2dkhDgjJ6e06IZE2UtM7KO4eDH/sD4tx55qqd7IS1A3lKyNIcxLKKyWJ8qYDPwqrAHBnWu4xPX1liE0WpqGTRq3Fm0FkAz3y78/AjyGkG5mFhoIhLSQBxd8u5jChDyPW6k6dHPGCm7pXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9s3JE/5q4l4x4IAU9AaCRJyn29hvFddfujRuzBjhqo=;
 b=fkQCmenLyEzN9etolvetvAo1qaIbFISFFweml7WZcsaaAv+2TnJGh+ljy2IMq/fBPChEP5IdD6bMhOSx5fkPrPG9CWozNVif6r5qLTZoaBjsnta09xbfhfshjQxvsMQVLztMF9F6HzHu1LEtSOJA+uH8YOfiR18eVU+wAY44P70QcRiDSWyYLcjOPYxgueWg9kh1EpU8kS+QMN3uek699ZFaV/srA5dKCwXavCY+JLPCbITz825yf1vTDxvXuKy6ct5T8DlHBIIm6PXF+eBzWIEhK0yU2GlX/EZOeq0QsF1rARwgWWAKwYO5AleZp8gzOqWsIhPlRwX4ZSIAO4bXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9s3JE/5q4l4x4IAU9AaCRJyn29hvFddfujRuzBjhqo=;
 b=sX1lB1Dlix5kIssb1K/aghmS4tjIAuhLcxatIAv7Vq6JdhTsA8lPRNDlS5DA8HpTfxA+rtdXFymr5k+8Cxumb/SStKHGArJD4BFOF06eMzMG/7zBT0nQcCA/c5+1ZV68/ydbPE0BPs27YSMu1T/PhHrGzQH/NFHvmYYNguSWIOU=
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB2519.namprd12.prod.outlook.com
 (2603:10b6:903:d7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 17:12:54 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09%8]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 17:12:54 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Topic: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Index: AQHWHY4Y5ZyBXjai50SPknapsyYH3KiO8C2AgAFm5lA=
Date:   Wed, 29 Apr 2020 17:12:54 +0000
Message-ID: <CY4PR1201MB013604A65801D2028225B20BDEAD0@CY4PR1201MB0136.namprd12.prod.outlook.com>
References: <20200428185024.5168-1-Eugeniy.Paltsev@synopsys.com>,<08a295ba-e6f0-65d2-cb64-3ea463797f6d@synopsys.com>
In-Reply-To: <08a295ba-e6f0-65d2-cb64-3ea463797f6d@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be569b07-73cf-4d4d-6da0-08d7ec608e8b
x-ms-traffictypediagnostic: CY4PR1201MB2519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2519AFB2E6F638B626B926C1DEAD0@CY4PR1201MB2519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(39860400002)(366004)(346002)(396003)(26005)(4326008)(6862004)(71200400001)(66946007)(5660300002)(76116006)(186003)(2906002)(55016002)(66556008)(8936002)(8676002)(66476007)(66446008)(64756008)(9686003)(53546011)(478600001)(6506007)(86362001)(52536014)(54906003)(316002)(6636002)(7696005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5KtjqmSEgVNdPNaTqEwRAIZap9jPQrDgKsnEELZIgz16mUPQpDbWWPCJESm4PoCfJfxiNIvQO5FOje/U8HxiUOWkE8t6z7NAFA21hr0lefko2gvn1l4GRQl0YYkuxIoV/kqD9T1BgTr5BP+FzCA+uDzFaupNSKEglxIJGuFGg7qqYHVYB9PvzB18/GgsC4xejEJClbIFb2UTSdjqNEM/W6Xr1DCqnEcwVBae0+X6TQ05AhsNmEDDGKZcLttozLjBJfb5lyZ7th5w6NNLs1JB8ps13kMawMu64mo/afsv1NYKUdJ6aBVCnvH4fyCUW0exH59HzezgISfdwQ3b1tesa2xbhVjifOAgC2K86BsnzbrOWCgtiANuxB1N0Fiw11cyqqFVW2s7FieLmLSkqRMnkuk5tGXl0FmqQnRDPV3Nl3GeG8ys1Oo5ctWUT4vZkF+1
x-ms-exchange-antispam-messagedata: oX/7Yv7iCoLECR/Ca9cVDN5iEGJs5HjQBwdAQxOaPNweCU7ryZSb0aRa8n0gAQMtt65uISncMc4ZPQi3TECF7SBuAuU0zYTPAfxYWztF2tiC6vSs0T8j0szAnB/6EY5I5FKyY5jqTakAziVqpqNHMhu8Rm4q6BuyexvmDcnyHpCDGxJaB/QVTRvOWUhukGchGaD6DTYoylWgVRW8kfCMJIC3ZD/3g090KU+/V1/9AXLoBlAdbt/fanItiocg0atB7YemOPLLxjeKn9kVMG5x+jtUxDmP0khj5iphsk4mSMq8qlzG6mAssYDrXZ5UpK89RhL1ocL5j2tqdeHwyX+U5Kj6g5IQO4upak8BY+mp2dbqKLe64BCwI8Ne551VpEUTPrkkyiC26VJHyBsCnsHGYR1qUkTs02Uz3GvwwynO7J1KsaHjI81cRnejn2IZehDO5uRR5+hKlgS9RxkoZ65/5sfSHQXo429pOqywP9mQnvGc8Mz0LRqWnB4k8ZfXFMBUOVrdpmabpvtGmWVhdM8BXUGEWFGvvZGd1Q6rC1MV+/sd7ybR0BB/4Cf1FhcxieZEZ6M7FLMEkWCPZowY4vaLuoW1fY7Nbav7h5L/PLHcyvImw23A2iJmyO8ysOXmCwPLnbW3d1/DxvpOgbkOmhMA4OShSnlRd1Ch6+qmBGEzG5PFJLDuOGvi1fvukFWjT8xa4SJUrIuzmk4RwBOf0VtIyO1cqeHb7ruW2S/RUxvmOnAdPbMMJQPazfnZwPySa8YoaFswyluMelJutArw2VavHghNoCog0dw4V4aCaszWZCw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be569b07-73cf-4d4d-6da0-08d7ec608e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 17:12:54.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LInRsfeZTaXdnm22TJ7nEad6YAB0N4y0FFgIF5x6FBl03pZ9qpEOz2n+xU+JGK2IEc5M1liZ+6fUTQm1z111Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet, =0A=
=0A=
> From: Vineet Gupta <vgupta@synopsys.com>=0A=
> Sent: Tuesday, April 28, 2020 22:46=0A=
> To: Eugeniy Paltsev; linux-snps-arc@lists.infradead.org=0A=
> Cc: Alexey Brodkin; linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH] ARC: guard dsp early init against non ARCv2=0A=
> =0A=
> On 4/28/20 11:50 AM, Eugeniy Paltsev wrote:=0A=
> > As of today we guard early DSP init code with=0A=
> > ARC_AUX_DSP_BUILD (0x7A) BCR check to verify that we have=0A=
> > CPU with DSP configured. However that's not enough as in=0A=
> > ARCv1 CPU the same BCR (0x7A) is used for checking MUL/MAC=0A=
> > instructions presence.=0A=
> >=0A=
> > So, let's guard DSP early init against non ARCv2.=0A=
> >=0A=
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> > ---=0A=
> >  arch/arc/include/asm/dsp-impl.h | 2 ++=0A=
> >  1 file changed, 2 insertions(+)=0A=
> >=0A=
> > diff --git a/arch/arc/include/asm/dsp-impl.h b/arch/arc/include/asm/dsp=
-impl.h=0A=
> > index e1aa212ca6eb..e64d945ae7df 100644=0A=
> > --- a/arch/arc/include/asm/dsp-impl.h=0A=
> > +++ b/arch/arc/include/asm/dsp-impl.h=0A=
> > @@ -15,12 +15,14 @@=0A=
> >=0A=
> >  /* clobbers r5 register */=0A=
> >  .macro DSP_EARLY_INIT=0A=
> > +#if defined(CONFIG_ISA_ARCV2)=0A=
> =0A=
> ifdef is the canonical way for a single macro to check.=0A=
> =0A=
> Also, this needs to be finer grained, i.e. CONFIG_ARC_DSP_KERNEL which is=
 already=0A=
> tied to ARCV2 only configs.=0A=
=0A=
We shouldn't limit the scope of this code part [dsp early init] to the case=
s=0A=
were DSP support is enabled in kconfig - and that is the reason why this co=
de=0A=
initially was guarded with BCR check only.=0A=
=0A=
So, I change the check to=0A=
=0A=
#if defined(CONFIG_ARC_DSP_HANDLED) || defined(CONFIG_ARC_DSP_NONE)=0A=
=0A=
which is actually the equivalent to=0A=
=0A=
#if defined(CONFIG_ISA_ARCV2)=0A=
=0A=
but I don't think it's worth thing to do.=0A=
=0A=
> =0A=
> >       lr      r5, [ARC_AUX_DSP_BUILD]=0A=
> >       bmsk    r5, r5, 7=0A=
> >       breq    r5, 0, 1f=0A=
> >       mov     r5, DSP_CTRL_DISABLED_ALL=0A=
> >       sr      r5, [ARC_AUX_DSP_CTRL]=0A=
> >  1:=0A=
> > +#endif=0A=
> >  .endm=0A=
> >=0A=
> >  /* clobbers r10, r11 registers pair */=0A=
=0A=
---=0A=
 Eugeniy Paltsev=
