Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A33C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1D320732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M7n8344L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wM3hWir8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgDMI44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:56:56 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51502 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727923AbgDMI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:56:55 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9CBBEC035F;
        Mon, 13 Apr 2020 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586768214; bh=1jIVRQoRrabhE8xDRa79uNiMv0EEEFimV9+XvP7bPh8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=M7n8344LdYyT6NyyMgGPbeMfjuKNsIsM4fdGYmdCHBi0y9SA7OhOX6CEA1Wz1nQNZ
         5JR/OAvK+o5Klt8mHfG1DISCNVHOmHqnL6JApKYFhouF37BbpmxN8njZ1ufhwDjxpY
         7b6r3UfB5OxZMyLc7iCcQAx9a/E7p41eMv54nIN4sNLFbr+brYUAGJbm79LeKyZ0tB
         H48FtlL9D2KJVuXMil0JAbrk1fnlpzwpR6SFo3qF0i72fYHVZAaJlCLbbz35pzs9iP
         ezmS1hWaUnjaRVZTggyRG/9N0HU3mnQx5rFNRc/rE3NcOnkG5h1OE6a5DHYbuBThnD
         wXUpIBvK+MdXA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E832CA0083;
        Mon, 13 Apr 2020 08:56:52 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 13 Apr 2020 01:56:52 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 13 Apr 2020 01:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx/l64YlBhIh3c1eYohsv6NTGNfugP5vGiN//DDZktaExOF7Rjxtx8pXOqNkMFqfio97lIRFoAWF4sddlx2uRgdq2YO9EzT7v0Ddp1T3ppyB4yaB7F9jDMl5WaByzMjfWidl8i1FEzFEW5YVzCJLK2eh/F6jXoTlD0Xibs8Xa3wvGciollcWNwytWWf7Q439MugATfSwq++gyLSorvypCK8INn8acUx7u8pjg5+baJuvKrC79D2vl4LHLvMfdqD3zd3pZl/Li9GrR9YqlShIU+8O4O3mpTaQlNCoAgG80NFqaOcIxWITsCJ8m4pw67iGV4R3fbv9QT8OtGSV2aDaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jIVRQoRrabhE8xDRa79uNiMv0EEEFimV9+XvP7bPh8=;
 b=VkRWwrgORMUXaV9YCp3YOcSer28R8mPjrENfY1itFFA4KVyLOl2DbZiFRLgwM8nQDGKkHc0UEp5F4DdU2mW/brvYmZjjM3N5yZdcMmM3VAPPVv+JcGGzpQGsVMPAHfv/4ccVmQfYGYW4YsJ2NkEKVGGDd6nx3ryEHloqBNvfShKfW83agx+++SJgoJg8Db7owUAL+IhqDhjoaDriv+C3wh9dfVU+glsAt9anyuLowVr55G4kvzmje5f8wQ7vBjMX5QKpBqWVX1h3cLFETxH1fgyBq0jTne1lqJDstcIph6PgzfrwqkK5p+Nin8DeQGAV5yjUOy7Ps9gRyFd1TZdYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jIVRQoRrabhE8xDRa79uNiMv0EEEFimV9+XvP7bPh8=;
 b=wM3hWir8sp3JriNTcYd2MvaosMfUfZYGU6Q/rq87grqZi9tk6tLid5Vf1w5XO/+ra0HrgiDur4eE1nsmr8YhdgPBTCvbG8r1OEMnp+eoDRPn7jnZFCinLjequCXqBSxX5WNTnRVBz68lqTHy7AGLmImIKBzW7mLcs5t5kuj+Hbo=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 08:56:30 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 08:56:30 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@ti.com" <balbi@ti.com>, John Youn <John.Youn@synopsys.com>,
        "gregory.herrero@intel.com" <gregory.herrero@intel.com>,
        "Grigor.Tovmasyan@synopsys.com" <Grigor.Tovmasyan@synopsys.com>,
        "amelie.delaunay@st.com" <amelie.delaunay@st.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] usb: dwc2: only prevent new request when power_down is
 possible
Thread-Topic: [PATCH] usb: dwc2: only prevent new request when power_down is
 possible
Thread-Index: AQHWD0T0RdlAD7M2/EyORKo3wzI3V6h2xE2A
Date:   Mon, 13 Apr 2020 08:56:30 +0000
Message-ID: <bb4e2781-4c4a-9a6b-c8d9-9cbe22269ab2@synopsys.com>
References: <1586529114-25211-1-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1586529114-25211-1-git-send-email-fabrice.gasnier@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec6ec8f5-ec06-463e-6cc1-08d7df888eed
x-ms-traffictypediagnostic: SN1PR12MB2381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB23819F4D2FDB833C577EC87BA7DD0@SN1PR12MB2381.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(4326008)(6512007)(2906002)(6506007)(53546011)(6916009)(81156014)(8676002)(54906003)(8936002)(316002)(66446008)(66556008)(64756008)(66476007)(5660300002)(26005)(91956017)(31696002)(76116006)(66946007)(2616005)(31686004)(86362001)(478600001)(36756003)(6486002)(71200400001)(186003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: doNUNBTgdye9nz2D/ALwrfMwipGOe81hNJ/1Y91XnA2SxvrzCELdsLdHbHgC9W3lUUM29ZMRt0/otDVvlqSr5txw7Ak6/jXtiSKV8CTVs+uys1+ERuhk5TgVxkmPsq1/33OH0yo429xcyDyc1EG0Kl/0AyD63hW1wBDLaNJOcV5NFyO/xuAYdlXASK1KVaASOblJiU6rSvTSSaTrbONLoaskGZnD6+n6y2HtT9SzD/Q9HuKE7H6WcTBtIeo26y2K5C26ClZR4a7wkgewYdg6qPCj1WWjaTr5iE1BBqOa0qQSEEPZUBohMGrW/n0CHob4a5YgWCHk4Rz0axUGjHmoayZJC3Ze1gZVgA3aronQ5iYL5XtAku3Lga0+Npn50l6qc3EC3wJm3/A8zzXZ588e1yx51zMYBMmyOwTsPPV4khWltco7bqJctFI6fxauHNjW
x-ms-exchange-antispam-messagedata: SJmWjO+BJxIG6dtWJ0Eix1nLtcp+m42Y3471Cv4Z3jD2ZzevjoO7HZBdAnX3gbwPpRXSkexmUdHYtq3uvYbWKeTvQZJo/xKgj1jsIvlgSHpcPgjvZOLGdM8TNoQQA7m+lA6BTkysi9xliZx+8BaMmg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <49563AF64B715C4BB27E2B7F178CF042@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6ec8f5-ec06-463e-6cc1-08d7df888eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 08:56:30.1406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1E+TAEuDH+FtEWyTDcihTWiagLa6sgJQmTGTvNwFefqloZjCDVOJL4skd/bfQwLZeZsTc+2JdUtj5MCNUKCT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2381
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDQvMTAvMjAyMCA2OjMxIFBNLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6DQo+IFdo
ZW4gY29udHJvbGxlciBpcyBzdXNwZW5kZWQsIHJlZ2lzdGVycyBtdXN0bid0IGJlIHRvdWNoZWQu
IFRoaXMgaXMgbm90DQo+IHRoZSBjYXNlIHdoZW4gJ3Bvd2VyX2Rvd24nIGlzIHNldCB0byBub25l
LiBJbiB0aGlzIGNhc2UsIHBvd2VyIHNhdmluZw0KPiByb3V0aW5lcyBhcmUgc2tpcHBlZC4NCg0K
SWYgY29yZSBpbiBzdXNwZW5kIG1vZGUgZXZlbiB3aXRoIGFueSBlbmFibGVkIHBvd2VyIHNhdmlu
ZyBtb2RlcyB0aGVuIA0KbHhfc3RhdGUgPSBEV0MyX0wyLiBJZiBwb3dlcl9kb3duICE9IERXQzJf
UE9XRVJfRE9XTl9QQVJBTV9OT05FIGl0IA0KZG9lc24ndCBtZWFuIHRoYXQgY29yZSBpbiBzdXNw
ZW5kIHN0YXRlIChEV0MyX0wyKSBhbmQgZGVjbGluaW5nIHJlcXVlc3QgDQppcyB3cm9uZy4gU28s
IGFkZGl0aW9uYWwgY2hlY2tpbmcgb2YgcGFyYW1zLnBvd2VyX2Rvd20gaGVyZSBpcyBub3QgY29y
cmVjdC4NCg0KPiANCj4gVGhpcyBmaXhlcyBhIGNhc2Ugd2hlcmUgZ2FkZ2V0IGRyaXZlciAoZl9h
Y20pIGdldHMgb3BlbmVkIChjYXQgL2Rldi90dHlHUzApDQo+IGJ1dCB0aGUgYnVzIGhhcyBiZWVu
IHN1c3BlbmRlZCBieSB0aGUgaG9zdDoNCj4gLSBjb25maWdmcy1nYWRnZXQgZ2FkZ2V0OiBhY20g
dHR5R1MwIGNhbid0IG5vdGlmeSBzZXJpYWwgc3RhdGUsIC0xMQ0KPiANCj4gRml4ZXM6IDdhYmFi
YTkyNmM2NiAoInVzYjogZHdjMjogZ2FkZ2V0OiBwcmV2ZW50IG5ldyByZXF1ZXN0IHN1Ym1pc3Np
b24gZHVyaW5nIHN1c3BlbmQiKQ0KPiBGaXhlczogODhiMDJmMmNiMWUxICgidXNiOiBkd2MyOiBB
ZGQgY29yZSBzdGF0ZSBjaGVja2luZyIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaWNlIEdh
c25pZXIgPGZhYnJpY2UuZ2FzbmllckBzdC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3
YzIvZ2FkZ2V0LmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRleCA5MmVkMzJlLi40NWE4Nzgy
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4gQEAgLTEzNzUsNyArMTM3NSw4IEBAIHN0YXRpYyBpbnQg
ZHdjMl9oc290Z19lcF9xdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0
ICpyZXEsDQo+ICAgCQlyZXEtPnplcm8sIHJlcS0+c2hvcnRfbm90X29rKTsNCj4gICANCj4gICAJ
LyogUHJldmVudCBuZXcgcmVxdWVzdCBzdWJtaXNzaW9uIHdoZW4gY29udHJvbGxlciBpcyBzdXNw
ZW5kZWQgKi8NCj4gLQlpZiAoaHMtPmx4X3N0YXRlICE9IERXQzJfTDApIHsNCj4gKwlpZiAoaHMt
PnBhcmFtcy5wb3dlcl9kb3duICE9IERXQzJfUE9XRVJfRE9XTl9QQVJBTV9OT05FICYmDQo+ICsJ
ICAgIGhzLT5seF9zdGF0ZSAhPSBEV0MyX0wwKSB7DQo+ICAgCQlkZXZfZGJnKGhzLT5kZXYsICIl
czogc3VibWl0IHJlcXVlc3Qgb25seSBpbiBhY3RpdmUgc3RhdGVcbiIsDQo+ICAgCQkJX19mdW5j
X18pOw0KPiAgIAkJcmV0dXJuIC1FQUdBSU47DQo+IA0K
