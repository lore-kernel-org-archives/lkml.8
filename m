Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B3FC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFDF207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UozhcoZA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eezT0Tt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgEPAZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:25:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58810 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbgEPAZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:25:17 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 28C3B4017E;
        Sat, 16 May 2020 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589588716; bh=Ppioo1qPqoN8KABlMN54YIR9s56fg0WLwysQlXwu9IY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UozhcoZA8lm08R6Qk236wr5Iv97q9wXAPNYLCuHi0sQD8X5gLOyWNlfSVZsMpiwZ4
         nLcvy7ttxuVICqaRVSfZfGlLxO4kzxc1B3th5KokdU/a9Fc33hCx6BQjeQOkaIDGb5
         32r2LghsSL/Z5XSP7ueM6vfoMY1qpjj8wjAZOS5hewxY/Yv3709dZ/nLZykUNN3s80
         rtyIcAKHztXutgKyJ3OYwB+iSxf/KltCuvhq/eVnfR58LMrfk/IJkqeKbcQIPofPjw
         x18MD9vRyC8sXiPEEQgToYFbfUmYi3TDoEWPLaPjEzErLt1NluxbwYWqvxid1Dj2G1
         Atlj7nlCh+hAw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7E885A0071;
        Sat, 16 May 2020 00:25:12 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 May 2020 17:25:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Fri, 15 May 2020 17:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcU9ld32NINvYzjJcQynyEB8URhZ3JheUSLxKRC25skOV0fZgQqZ/5/EYXiSO2ZiGTxW4AIxQweR4vMSmRe659iLF446RSt0la+blHAWEaH7F/x7S263LIRKPKsiwAGJdY1YE2/lueT7oNMzjcpGOEy6mX1Ee4RdkKHTEAo2in9OXzV0g1+pvSfV7CNN+SZl13OnQj6GjAT5GB8IOSXUUFUFNZJUg6f+150BjgWVgzLSnpc4C4BB0r0AkaD/o4g/7nLsuwF6+GNbcqz20SgnD/j6gHG8mlBOBPF04gAARfzSCuv2Oc0+CCT3ktq0xCvToJcegZ1J+F/D+04kyYSnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppioo1qPqoN8KABlMN54YIR9s56fg0WLwysQlXwu9IY=;
 b=VPx9TrNKl5C0Xek7ZNV6G4yXWfGIH2nN5+thZ9+Gn6OZfKNP4sgwdaN1lUsIFJhDm6Y5wjfR27FI/i8MyLoNPZzDCIfa8hd01IVrozKjLfpepHxgj5gbfjeI6BO6o4vGKeMPVlC6oSyz4Aw7fQzI7jPKYo/+KUqw7FJSONil/tVSiHbQ+mTScUUnwWbHzF2Z+dsIFD/umDsZV+0O2LO7hnE7I3MTIktYUgVRfI3Wk3RjuSgqwK1KKUQ2VXDO2kOUMAe1E66s/d45891AUgY8surq7U+alyrdpFzEYx18M+7hYYI7+2kMDYccrAYhjPy8jLr+CVoukCeLoKAB92JSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppioo1qPqoN8KABlMN54YIR9s56fg0WLwysQlXwu9IY=;
 b=eezT0Tt/UzdwcWLRtdqB1tVka3WSOyxuCk88SNtKi+Bpi5BA9WTLh7V/MCvFx01mE9YVuoVVxvxxPeJAhXbJaBimfF2HbpBMBFDiPJlZ9Cil9qXcpqSfOFRZjjXptzuBO8mTJbSi/H0kqL+8ucgc8xmCBhq1FMHFHbjnEipq9Q8=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3413.namprd12.prod.outlook.com (2603:10b6:a03:ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Sat, 16 May
 2020 00:25:10 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248%7]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 00:25:10 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jun Li <jun.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Jun Li <lijun.kernel@gmail.com>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Topic: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Index: AQHVjdstgzFrMkrXvkaRRkMvFUhS+Kio62yAgAAEAECAAiXGgA==
Date:   Sat, 16 May 2020 00:25:10 +0000
Message-ID: <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <87h7wqmwrv.fsf@kernel.org>
 <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
 <87imgx35pg.fsf@kernel.org>
 <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.7.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63e80c3c-53df-4d44-f652-08d7f92f982a
x-ms-traffictypediagnostic: BYAPR12MB3413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3413512694AA3419B6013694AABA0@BYAPR12MB3413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Y/tuNV20j5b1nbfJY3HQvogHdD6yuBu5X2MxXXBbXVHjoh5P3mN2Umlg5T9VqlM+8KoVxuj//YjH3QNBSQbcaeY0J/pPsjWe3+pA5WvZc9tMie0gHn1KMRPAHXV3HkIZO9smJmdUtBg6Q54AyRmSU0mX7xmpbJhAXzbgPhMakVyhRVt7Yhidlbex8zSHVnCXppbKYw1+SuHfCxiipmINbSM1f7ytOqjNr/aHp6dwWBFxvISRa3BXKaR25OvjT+ivfaP9x9MmCbgZJfNSlOdNTgNenkUnWOfEuWHjU2XYiD4eAQWlS5sXYa68CAwW35h0IiVZufn6APD6CaogJFa5Ijb2Lqtp4E45rGdKIERSFLWWrRg6BrHOC+69y79PKr96NLep7p6LZK7/oWl8S+nQhmLCoeE5s1bE/h0lhnn8ECpeGzWK3HK5+ARCJcEgrukLFyv9Z07sRnTWYt5hAtp+Jx1DnfcWECe5CKeIAoVIzbXNj4W31esALzBrdNZNnoa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(136003)(366004)(39860400002)(110136005)(54906003)(76116006)(107886003)(4326008)(5660300002)(36756003)(64756008)(316002)(86362001)(478600001)(66556008)(31686004)(66446008)(66476007)(66946007)(8676002)(2906002)(31696002)(26005)(186003)(7416002)(8936002)(6486002)(6506007)(6512007)(53546011)(2616005)(71200400001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7lw6C1v2teQQiK2TvBP+DQEA7UfOB/7dme1sBPVDABXHHmdoBgdIKR3afJGj99478/dfRzQCH8BhrlcWoGHeoEyPE1TiDSADwnEDF74Re1H8CNX/sa3/dFdXVOWDJ/hri7KzE0pFsfBdMxiFJbHhlwePY897vE62HQ/Egl5sZpzvojAspaE62V2SFOw3qz4RB+xOG2/lymf1r60+wl6RbBVU9MetKYuDjDF9bTXXNrEaFnGlTpp3AZ+GZ4x+j5XstOXCPfmLN0f1DpAiKoHIY1zjC1Gl/ZZsumDS/7TLWVrveOKmelNOJjPBIZe7cNmUgFQdHuWVMdoXFrkjwT0QCTwubPjJZ/4ilm+TAfnzT1tIrBTtqIEFa9hTH2SdDy8GVKVR7sjqbrF8YLv3TFHMahu8L/bPAVHHHqzB3BilY5VPqFheyB4zaQx4AOPmfJbUHJEEBntOJ422B8s7xqj7ciM3fS0SocxHfiW0cl4xLhE=
Content-Type: text/plain; charset="gb2312"
Content-ID: <12013CF3FA11E945A11A7CB2CDE497B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e80c3c-53df-4d44-f652-08d7f92f982a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 00:25:10.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIBPL7ZqoiI6zDe+UC5cUkode8nTa/wQBDoS2cIWbllXG5MQtGOBqUWESEq/EZFQUbxOKDBXOG4lGKfbX3JoRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3413
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkp1biBMaSB3cm90ZToNCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBG
cm9tOiBGZWxpcGUgQmFsYmkgPGJhbGJpZkBnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBGZWxpcGUg
QmFsYmkNCj4+IFNlbnQ6IDIwMjDE6jXUwjE1yNUgMTc6MzENCj4+IFRvOiBKdW4gTGkgPGxpanVu
Lmtlcm5lbEBnbWFpbC5jb20+DQo+PiBDYzogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFy
by5vcmc+OyBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgWXUNCj4+IENoZW4g
PGNoZW55dTU2QGh1YXdlaS5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPjsgUm9iDQo+PiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJr
IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgU2h1RmFuIExlZQ0KPj4gPHNodWZhbl9s
ZWVAcmljaHRlay5jb20+OyBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5p
bnRlbC5jb20+Ow0KPj4gU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT47
IENodW5mZW5nIFl1bg0KPj4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+OyBIYW5zIGRlIEdv
ZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+PiA8YW5keS5zaGV2
Y2hlbmtvQGdtYWlsLmNvbT47IFZhbGVudGluIFNjaG5laWRlciA8dmFsZW50aW4uc2NobmVpZGVy
QGFybS5jb20+Ow0KPj4gSmFjayBQaGFtIDxqYWNrcEBjb2RlYXVyb3JhLm9yZz47IExpbnV4IFVT
QiBMaXN0IDxsaW51eC11c2JAdmdlci5rZXJuZWwub3JnPjsgb3Blbg0KPj4gbGlzdDpPUEVOIEZJ
Uk1XQVJFIEFORCBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklORElOR1MgPGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnPjsNCj4+IFBldGVyIENoZW4gPHBldGVyLmNoZW5AbnhwLmNvbT47IEp1biBM
aSA8anVuLmxpQG54cC5jb20+OyBUaGluaCBOZ3V5ZW4NCj4+IDxUaGluaC5OZ3V5ZW5Ac3lub3Bz
eXMuY29tPg0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAzLzldIHVzYjogZHdjMzogSW5jcmVh
c2UgdGltZW91dCBmb3IgQ21kQWN0IGNsZWFyZWQgYnkgZGV2aWNlDQo+PiBjb250cm9sbGVyDQo+
Pg0KPj4NCj4+IEhpLA0KPj4NCj4+IEp1biBMaSA8bGlqdW4ua2VybmVsQGdtYWlsLmNvbT4gd3Jp
dGVzOg0KPj4+PiBAQCAtMzk3LDEyICs0MDcsMTggQEAgaW50IGR3YzNfc2VuZF9nYWRnZXRfZXBf
Y21kKHN0cnVjdCBkd2MzX2VwICpkZXAsIHVuc2lnbmVkDQo+PiBjbWQsDQo+Pj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBkd2MzX2dhZGdldF9lcF9nZXRfdHJhbnNmZXJfaW5kZXgoZGVwKTsN
Cj4+Pj4gICAgICAgICAgfQ0KPj4+Pg0KPj4+PiAtICAgICAgIGlmIChzYXZlZF9jb25maWcpIHsN
Cj4+Pj4gKyAgICAgICBpZiAoc2F2ZWRfaHNfY29uZmlnKSB7DQo+Pj4+ICAgICAgICAgICAgICAg
ICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpOw0KPj4+
PiAtICAgICAgICAgICAgICAgcmVnIHw9IHNhdmVkX2NvbmZpZzsNCj4+Pj4gKyAgICAgICAgICAg
ICAgIHJlZyB8PSBzYXZlZF9oc19jb25maWc7DQo+Pj4+ICAgICAgICAgICAgICAgICAgZHdjM193
cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApLCByZWcpOw0KPj4+PiAgICAgICAg
ICB9DQo+Pj4+DQo+Pj4+ICsgICAgICAgaWYgKHNhdmVkX3NzX2NvbmZpZykgew0KPj4+PiArICAg
ICAgICAgICAgICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RM
KDApKTsNCj4+Pj4gKyAgICAgICAgICAgICAgIHJlZyB8PSBzYXZlZF9zc19jb25maWc7DQo+Pj4+
ICsgICAgICAgICAgICAgICBkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RM
KDApLCByZWcpOw0KPj4+PiArICAgICAgIH0NCj4+Pj4gKw0KPj4+PiAgICAgICAgICByZXR1cm4g
cmV0Ow0KPj4+PiAgIH0NCj4+PiBVbmZvcnR1bmF0ZWx5IHRoaXMgd2F5IGNhbid0IHdvcmssIG9u
Y2UgdGhlIFNTIFBIWSBlbnRlcnMgUDMsIGRpc2FibGUNCj4+PiBzdXNwZW5kX2VuIGNhbid0IGZv
cmNlIFNTIFBIWSBleGl0IFAzLCB1bmxlc3MgZG8gdGhpcyBhdCB0aGUgdmVyeQ0KPj4+IGJlZ2lu
bmluZyB0byBwcmV2ZW50IFNTIFBIWSBlbnRlcmluZyBQMyhlLmcuIGFkZCAic25wcyxkaXNfdTNf
c3VzcGh5X3F1aXJrIiBmb3INCj4+IHRlc3QpLg0KPj4NCj4+IEl0IHNvdW5kcyBsaWtlIHlvdSBo
YXZlIGEgcXVpcmt5IFBIWS4NCj4gIEZyb20gd2hhdCBJIGdvdCBmcm9tIHRoZSBJQyBkZXNpZ24s
IHRoZSBiZWhhdmlvciBvZiBEV0MzX0dVU0IzUElQRUNUTF9TVVNQSFkNCj4gYml0IHNob3VsZCBi
ZSBhcyB3aGF0IEkgc2FpZCwgbm90IGEgcXVpcmt5Lg0KPg0KPiBIaSBUaGluaCwgY291bGQgeW91
IGNvbW1lbnQgdGhpcz8NCg0KWW91IG9ubHkgbmVlZCB0byB3YWtlIHVwIHRoZSB1c2IyIHBoeSB3
aGVuIGlzc3VpbmcgdGhlIGNvbW1hbmQgd2hpbGUgDQpydW5uaW5nIGluIGhpZ2hzcGVlZCBvciBi
ZWxvdy4gSWYgeW91J3JlIHJ1bm5pbmcgaW4gU1Mgb3IgaGlnaGVyLCANCmludGVybmFsbHkgdGhl
IGNvbnRyb2xsZXIgZG9lcyBpdCBmb3IgeW91IGZvciB1c2IzIHBoeS4gSW4gSnVuJ3MgY2FzZSwg
DQppdCBzZWVtcyBsaWtlIGl0IHRha2VzIGxvbmdlciBmb3IgaGlzIHBoeSB0byB3YWtlIHVwLg0K
DQpJTU8sIGluIHRoaXMgY2FzZSwgSSB0aGluayBpdCdzIGZpbmUgdG8gaW5jcmVhc2UgdGhlIGNv
bW1hbmQgdGltZW91dC4NCg0KQlIsDQpUaGluaA0KDQo=
