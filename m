Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED0BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D418620842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OjEfSere";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="F5mgBpq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbgCDLw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:52:27 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:59218 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387799AbgCDLw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:52:27 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8BC5243BC3;
        Wed,  4 Mar 2020 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583322746; bh=gUJfZOqxMZHRvVSob4pNXeapdizLwyfXwoq+HitBwtM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OjEfSereqBi9Sms9A2vR2sy0grPYWgu5aSfKAU6RuSGhAbp1NT77WorAAGRuVhPu+
         TgilfSB/EZsl8seCpyPjSERZYPoso/I28SPfkR1o3cYswlwX+2+2B+jZJJJlBs8YpB
         n+EQp77LX801kg1rcvOvrZaqTcEhZQAq1ZSWLWXO7tln/ueoBslwKXabiz4vepvmM/
         QK8Gp+FNx7qQ0xPBBGjLAoS4Zw2swrGVp9BOZEMY/v84emxwZ5UDyRQEmaG3tm43gB
         /ZnhdYmDlEOTn/g1WPoh06Efa23pXaSOIdgtLBJhultGj+05hI+NsbVzilZ/D6R2W+
         2k9V8tcHQIk8w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2C595A0067;
        Wed,  4 Mar 2020 11:52:12 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 4 Mar 2020 03:51:20 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 4 Mar 2020 03:51:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCW0RTVHBHyDRvCI5bdhdeTQhHcs8q+9jk0iTaosRLdlsJpNe8y0q+UIUOLsf99+sVaiECzvfNBL2xA3VhhndCKB6CcC/kpuC+wlTCwYVQgmETjYfzHT30DD1wZLZ4clGy3zeXtYY+0PIxXiI+pCMLAcW6oqvsj2Ue9TbB8072B06R5qUwxjGyds4mlN7XiD8QtIuYE79PoVTNPzStL+CNxnqHbCigNxkuNDrCcslhe4q6CvVQshkM0hHl7hO/Vl1LK2pJoWLMrZ4J9dO3e3BLqYtKWdOaF7UuCnJ2Bt1G8sr8rtT0KpvPKuzSoWv0XvgZTIwrK7zGWiwuyhBDW3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KGD6X7hDFtBjHnyiVjjRUbFoPV0Wrc7KFRr18idBWQ=;
 b=Q9+Z5mxKU60OciVBYnbH4mG/tue7uIEE1+HtTLEIBrMxVK2j3kz5Fe9ahKZmE9S3pzKyycW0RrbtYeU4jGZr7oduEx1TRwk2ejjUCcQ7wTluMLHj7dErsYDoAAKDRwbAmWLn1e36n8OWH04dFEJ9aU7cAGVSTVbMMYxZRKHGC1hAJaL5FALWQxKMvEFR51YkngyMvEP8ieFBXc8e2fW4vzIeDG1eJE8XZlXntiqIQ2OunoMZLMZAk9PFNADANpgOsOyYLtWDZdVMJ6ZCf17CqiGvuo32sEQgQIs88vjdpMDLl34EQPhOb0zv8P2Rm1j3sCTNRXF5rJmaBRW7PPQx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KGD6X7hDFtBjHnyiVjjRUbFoPV0Wrc7KFRr18idBWQ=;
 b=F5mgBpq0mrhTQHonBprPaPapqntF/zLBCBFqyhc9anlWs33Kt/gJTS9fqJ4seXjbxlhpEVxxcm9R2vey3Uxx7OzY9tH7SrIEQlOO6dnwA0CTqOUzskpUzn/Tn4vMYOjQDkVAK9R+0PZFRpcM532Zw4cHqL0yUA9evHTC8gU6Yo8=
Received: from BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Wed, 4 Mar
 2020 11:51:17 +0000
Received: from BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a]) by BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a%5]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 11:51:17 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 4/5] ARC: add support for DSP-enabled userspace
 applications
Thread-Topic: [PATCH 4/5] ARC: add support for DSP-enabled userspace
 applications
Thread-Index: AQHVvOALEgJG1jhHKUKrXAMj7igcXqfflg6AgFkkVq8=
Date:   Wed, 4 Mar 2020 11:51:17 +0000
Message-ID: <BY5PR12MB4034D0D8EDD029E90642012EDEE50@BY5PR12MB4034.namprd12.prod.outlook.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-5-Eugeniy.Paltsev@synopsys.com>,<a3890ccb-e948-6ad6-c2ea-5b77b9d3a289@synopsys.com>
In-Reply-To: <a3890ccb-e948-6ad6-c2ea-5b77b9d3a289@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a6a5b96-e023-4643-2928-08d7c0325971
x-ms-traffictypediagnostic: BY5PR12MB4033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40334D9403AE9E1E3556CA0ADEE50@BY5PR12MB4033.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(2906002)(55016002)(9686003)(186003)(76116006)(91956017)(66946007)(107886003)(7696005)(8676002)(81166006)(8936002)(81156014)(478600001)(110136005)(66556008)(66446008)(54906003)(66476007)(64756008)(86362001)(6506007)(316002)(4326008)(71200400001)(26005)(52536014)(33656002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR12MB4033;H:BY5PR12MB4034.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ef9YTNImupAEO5xR6Xf4xCqGeKweYdqkEh63twaGWBiqq8Z/H0Wp66QhBY56HPVmfFFvKPhygrM7aamRzSmqaAVoj4JvjOJ8Ax5YKSEDt64Ya+E2HX66FpF7C0FfITXD76PoqJMLTmB+38zg/8nIlyVGdytrF9oy/V+3n0kJmjiZ3PU7dxa9dsgdGPp+SwwDXMK2cpr+xaJzsWmZgp3/BgGHsEQnWYOr3nkzxfsB1S7H0+YAQktuF3KSVCcR/63VyWo3rT3QwPbVPJvYAOfWnQxiqtIB8xs7IpJBHevAiK/UKd5gkNIvW582t7RsR2GRn1GsNPhB4SMG/hJN+43xZy+88aqMddD+eu6JQFKcbjtqzVkfGtpgSH8oZ9dr8eQcqcpPTJru4hf9Cd0Pnc49RezhHk6HNCjSLJxLsQivcjhnN/VxFgtkeIZU+yoRR0gt
x-ms-exchange-antispam-messagedata: H7lpur3VdtiSxLPk+BWWGZITTQUw7Iwoo4EUvl4dHF4CLeCQK0bT5oyFDCvVZWeJgc3+LzoEhejfJeACk+FNio3Nvkyzb3JuSWcbngXjOhIxZ5UluMTAs9igHhzOdCNihec/e7K4RDN8NKgSFH4adw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6a5b96-e023-4643-2928-08d7c0325971
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 11:51:17.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtN7uGzzC//AYCc4m+UOI/qOxduZ11ce+88THlwkfGPwjl197czqE57CRft+hFzYMczbFYW8cP5tLVwY9LAUoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,=0A=
=0A=
>From: Vineet Gupta <vgupta@synopsys.com>=0A=
>Sent: Tuesday, January 7, 2020 21:25=0A=
>To: Eugeniy Paltsev; linux-snps-arc@lists.infradead.org=0A=
>Cc: linux-kernel@vger.kernel.org; Alexey Brodkin=0A=
>Subject: Re: [PATCH 4/5] ARC: add support for DSP-enabled userspace applic=
ations=0A=
>> +/*=0A=
>> + * As we save new and restore old AUX register value in the same place =
we=0A=
>> + * can optimize a bit and use AEX instruction (swap contents of an auxi=
liary=0A=
>> + * register with a core register) instead of LR + SR pair.=0A=
>> + */=0A=
>> +#define AUX_SAVE_RESTORE(_saveto, _readfrom, _offt, _aux, _scratch)  \=
=0A=
>> +do {                                                                 \=
=0A=
>> +     __asm__ __volatile__(                                           \=
=0A=
>> +             "ld     %0, [%2, %4]                    \n"             \=
=0A=
>> +             "aex    %0, [%3]                        \n"             \=
=0A=
>> +             "st     %0, [%1, %4]                    \n"             \=
=0A=
>> +             :                                                       \=
=0A=
>> +               "=3D&r" (_scratch)      /* must be early clobber */     =
\=0A=
>> +             :                                                       \=
=0A=
>> +                "r" (_saveto),                                       \=
=0A=
>> +                "r" (_readfrom),                                     \=
=0A=
>> +                "I" (_aux),                                          \=
=0A=
>> +                "I" (_offt)                                          \=
=0A=
>> +             :                                                       \=
=0A=
>=0A=
>AEX with "I" constraint will likely be an 8 byte instructions always. Best=
 to give=0A=
>compiler wiggle room with "Ir"=0A=
=0A=
Could you please explain how "Ir" will work in this case?=0A=
Does this mean that compiler can pass the value either as constant ('I') or=
=0A=
via register ('r')?=0A=
=0A=
Note that in this case both _aux and _offt are compile-time constants -=0A=
_aux comes from define and _offt comes from offsetof().=0A=
=0A=
>> +               "memory"                                              \=
=0A=
>> +     );                                                              \=
=0A=
>> +} while (0)=0A=
>> +=
