Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B971C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D8A20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D2sz53Fv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="j2oxGcBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgAJOyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:54:43 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:54926 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728359AbgAJOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:54:42 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0646140600;
        Fri, 10 Jan 2020 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578668081; bh=Df8PkuFAzWMaYAJuSpSUc79b5Fm4t/LEGhAGQyGeXTo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=D2sz53FvPsKXPIEmjTdcWTl+3JCpk+x+bw9+hMfKgF6SftEH9PnZmhhKdgbMvc7If
         PLCGxmJMdzb2WEEM7HLRpEcOZLIpMhsv/SEwRgNQ8SAY5+ZKzORdYVeH05qokicFSl
         VxgNKlVf4SmOux5w3LmHz4o+qOq4ciTFpJ13+88DZVEVewh/Yd//0/GlQsoSxfFV+b
         Hm80mnxyCTvJiUt6C6isP9zstSTz4K8BAu48rSWolsgs1e4rSF5XO3sGlnLsdLyxFp
         miE259hv0e6HRd23fk3tkjG3sVW8eE18e8Y8/aXJ5lpr0cmv55hqcdlWPKcWBIPxX9
         SsNB1MHT0pVFA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C9B87A00B2;
        Fri, 10 Jan 2020 14:54:39 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 10 Jan 2020 06:54:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 10 Jan 2020 06:54:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STI3umO3zb5Mx2D7b/Mqv38DxZfO7zRbTWD1LrABAT6E58uJpuZIgRKHxnTtSpifpyl38kDVA6IdtTuU+rPAHtuW4a6I4yApE2F+7nn9lBYTzTiS1RzofhlXqh8Y8laQVp+mR33wpDE/sf36GVeDfTqgJ33Fhs0evsDNrE9Pm/PKttry0/kdXVFIbmnGkFZ0QP9eI7IXhz46DGqS1BlwZMipnyOkjsvKlwYE2XzFMLcogS/ORZyj3vLbyjzU+jUbcjryLwFxXAWOZNFRT+nksAzdEvJUWq29JvAvX8fcEg+HTiflL0KYpGcAtPAJV+5cI+If7iJ+CkQ8/r0lCU6g5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOmPZ4X5D74ikfkUPi93zppuuU1mGY7KSybBxS87670=;
 b=XSxMYcqXRF8SqBXqc65V8YWNG9euGttJWL5ab1zUCKqO2R/1J64rvRt1x0oIKBee1nN7wUwiXJUMML8IBsjasW8G68b9UBKpU/+l++zqBMKgic4Py/ZrhsiAYIB5hWyMsGsDBDa504hWOKEDswGtJoV/XFOdptwADDDaOQPKrpxqUImpCBQu8BSHBiCcRij7rWqdLGvQ8+gtjUNblanGzFjr2YxNNp2wN/+ZXhQUUhGrw1ST8X4NQjFBD2EqEvZG4cyF3qqJkvZc2ths4OJC8orxKZ2Il1ExLWdXxMgIcRzoHiWvcB3jaqt8CdyRmZOlt+cT4magJC9Wiq1VXSby6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOmPZ4X5D74ikfkUPi93zppuuU1mGY7KSybBxS87670=;
 b=j2oxGcBV9aaJdE8RZeYrtLvk/LP9SoUse13mLpCpzPbv2yTsnjp3qRkGlO68gb8g3QEUhL0CUKSMSKqjzmW76DOMGeuxw+OVxn1Wk9tX5o02ghAQc7Ke9RDv9ONaJSNJazGjbf074odxBCoQsHTG0KX/ZSUzzJpVvMSpnB+jSZI=
Received: from BY5PR12MB4034.namprd12.prod.outlook.com (52.135.53.73) by
 BY5PR12MB3924.namprd12.prod.outlook.com (10.255.139.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Fri, 10 Jan 2020 14:54:38 +0000
Received: from BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::21e8:207a:f5a0:e090]) by BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::21e8:207a:f5a0:e090%4]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 14:54:37 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 3/5] ARC: handle DSP presence in HW
Thread-Topic: [PATCH 3/5] ARC: handle DSP presence in HW
Thread-Index: AQHVvOAPYx4rnqnFdEKpMFBzanlxBKfecrQAgAWYjls=
Date:   Fri, 10 Jan 2020 14:54:37 +0000
Message-ID: <BY5PR12MB403418CCC56FE9E2EA3232D2DE380@BY5PR12MB4034.namprd12.prod.outlook.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-4-Eugeniy.Paltsev@synopsys.com>,<6b80df9d-d0f2-d1e1-8e4b-b65531b938d9@synopsys.com>
In-Reply-To: <6b80df9d-d0f2-d1e1-8e4b-b65531b938d9@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8458fbcd-7033-4629-937e-08d795dd03aa
x-ms-traffictypediagnostic: BY5PR12MB3924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB39246C0D225A73B639B9BBD9DE380@BY5PR12MB3924.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(52536014)(5660300002)(76116006)(91956017)(4326008)(66446008)(9686003)(66946007)(66476007)(107886003)(66556008)(55016002)(64756008)(71200400001)(33656002)(6506007)(2906002)(316002)(8936002)(26005)(86362001)(7696005)(8676002)(54906003)(478600001)(110136005)(81166006)(186003)(81156014)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR12MB3924;H:BY5PR12MB4034.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2CCDJ2Bk7MwbZtDTRQ/BxTjJJQct/yFZN0dVWinJiCpM8cwXenrQ3uF2Sp4TuWBKFtHlhlu4lxf4lgEe60qrx3mwxMN9XVQwAT8E4rucR/xQx3RB3xTDSeI0kDtFvF7jCkM52wRPT+e3OA0ny4/1Bv/IW31lgm/Hkg6lqE0nSj42MY67fWlxwWolHGfCN405CadBmoMpfcMvxnezr52+P5UjhLoNxJadr5fL46BOMLIhmj2pAdXSLYnYfOfALGDl2r8rYKAg2ceXWsrCdk3p4MX/vI3wO+65ZkrZjnTR9J1v5JuYGO46s/CqVX97sBmPdmzonfjGzHnwebysMQ6ki9jDSRAd9CBsscpYP1ZdB+bY5+TakWsoEyWFURDrjoHfrfP/hYQK0H2dvGoWHthlGAURQj6Pfjx2aJ+9Dpyldrr1jt49T16PJxD97wx0xpWbdaEe+Aa3LpbFCELJh+kpCKuggl68vzIPAAH1DtrKV9TNLovmJZb7IjKcWCYt5mT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8458fbcd-7033-4629-937e-08d795dd03aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 14:54:37.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SalSqSMhdVr0KQ9TH7YV2WBkbN29cY5yXg9vwVwra4x80xDcO8JnE813JMvFjEsZUp+1FclQreQ5MiFHxBfKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,=0A=
=0A=
>From: Vineet Gupta <vgupta@synopsys.com>=0A=
>Sent: Tuesday, January 7, 2020 04:03=0A=
>To: Eugeniy Paltsev; linux-snps-arc@lists.infradead.org=0A=
>Cc: linux-kernel@vger.kernel.org; Alexey Brodkin=0A=
>Subject: Re: [PATCH 3/5] ARC: handle DSP presence in HW=0A=
>[snip]=0A=
>> +static inline bool dsp_exist(void)=0A=
>> +{=0A=
>> +     struct bcr_generic bcr;=0A=
>> +=0A=
>> +     READ_BCR(ARC_AUX_DSP_BUILD, bcr);=0A=
>> +     return !!bcr.ver;=0A=
>=0A=
>open code these use once / one liners in the call site itself.=0A=
>=0A=
>>=0A=
>> @@ -444,6 +445,9 @@ static void arc_chk_core_config(void)=0A=
>>               /* Accumulator Low:High pair (r58:59) present if DSP MPY o=
r FPU */=0A=
>>               present =3D cpu->extn_mpy.dsp | cpu->extn.fpu_sp | cpu->ex=
tn.fpu_dp;=0A=
>>               CHK_OPT_STRICT(CONFIG_ARC_HAS_ACCL_REGS, present);=0A=
>> +=0A=
>> +             present =3D dsp_exist();=0A=
>=0A=
>Open code as suggested above.=0A=
>=0A=
>> +             CHK_OPT_STRICT(CONFIG_ARC_DSP_KERNEL, present);=0A=
>>       }=0A=
=0A=
My idea here is to encapsulate implementation of everything dsp-related in =
the=0A=
file with dsp code. So I'm even thinking about moving the config check itse=
lf=0A=
to some function like=0A=
'arc_chk_dsp_config' which will be located in dsp.x file=0A=
and call it from arc_chk_core_config in setup.c=0A=
=0A=
This requires to move config check helpers to separate file/header from the=
 setup.c=0A=
However this allows encapsulate all DSP code (and some new subsystems code =
later on) in its files instead of spread it across the arc code.=0A=
=0A=
What do you think about it? If you really dislike this idea I can drop it.=
=0A=
---=0A=
 Eugeniy Paltsev=0A=
