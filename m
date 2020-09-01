Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830E6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404EE206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="KeMo35sL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="mnk/O4Hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgIAOiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:38:24 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:40990 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727964AbgIAOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:18:01 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081EDwhq007018;
        Tue, 1 Sep 2020 10:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=wrq69bcKBi62U/BP+7eeYW6ve3ZIW5ClbzNAApy08Tg=;
 b=KeMo35sLNZu8y72YV+Dcs23ooIgRs6RyzysiuwX3CH4+OrcmOzsJco+iwkTYwUY52oCR
 FCMHgJiPNzwHw8LvwOnjMj2lsc3Oz8DTKKJbZ3Zj4YJtmlvyQNKm7gHa0xj2Q8Iys3fX
 KSHRolVAYh2SpnjHi730kJHdLBfxNF4CdDin7T/zm6r355XkVbbcJNNzFBeWqZ2dw9PX
 tubSH4x8GaMybT4I9DVTuIfxeK/xHhpltdjU8N6/xkzwHaXT2fkZUSpQ/xDunCQDNWmO
 AqA/+ACAAx2LnTnKybMhDVasj/G7yWbuNLKYyb3H1vVFMRwmvVb3xP6LVUGuou94XK2e Cg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 337j8a15j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 10:17:44 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081EA9j2010725;
        Tue, 1 Sep 2020 10:17:44 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0b-00154901.pphosted.com with ESMTP id 339q10h24b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 10:17:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVBPzf1DC4WBDcdRY9Kk9Kd+vbKv81fM8C+EwH4ZmhMUf7GtJ0HwNa/PuZZ2lj2GQJdXrzeqlLKsqOTj1WBFwJ4BWAhVBqRkgwkMWbj3svgIwX0Ev8zVUUmt+cv3S/YXLfUUryQbEda7ptVNGOO2pPvToixpeFVYeTMB0gCfgbrh49X5c2+5QKUWoDwAVaVor58Jk+VifUxwFjI8bWiOmGmu3UmZ1W4Ft2xuOpIyoLm4S/GMoVOHjvTq9ByJ9e2jtsyTAvBAb+qtxXG2Cg+cpe6e2DJjzI8hfVHg82zNDO3zZmVA9oN6hk+FqV1Ofw/Qz6+Yjzqrt6sRNwzmvdeHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrq69bcKBi62U/BP+7eeYW6ve3ZIW5ClbzNAApy08Tg=;
 b=mpzCa6SJ8eGheeFPOC7tgTovoAqWVdZs0qA83OytkVblVqg7jzbRHFyqiPGp95ehwuXCRMyMjBu6OjL2skJX2vNCA0o0F3LapcylQ3wICw9ktAl3cEYTV/e4+/DB6QQLTOyiQXta5F6BLLP7nv1NGVq3BIg5CDtyw4RCpagMhOQY6RY7kwLBgv5cH2tEyUhJBR/Js0tdn6EgBnl04LMtvsxeI/cvfyQ35nmW/xHnkcT4H+QCwERp/sU5eaKN/h8p2gYIppVcf6omWQtL4xZtSMVl5aJ2zjMDsFRx9sfpcM2nez61+xVKWnYnmaQEQfTL5MpKUKQ2qE68NrlZsCOV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrq69bcKBi62U/BP+7eeYW6ve3ZIW5ClbzNAApy08Tg=;
 b=mnk/O4HhO3TwIJfTK8Y77rONqFzsGuzWVK0Z1yfFR2IQn4LpSlxS+yDBxrKfGM1hEwQwFX41kma5x7QOqwPPOZm6JiZw1QZeguHlUW6VZ6Zxbhav6xYR+uzKAaYDqvU8yCGBfEsZ3oojy1f81NfH+an2vEYzhCadtYQW9CFm1So=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB0091.namprd19.prod.outlook.com (2603:10b6:4:64::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 1 Sep
 2020 14:17:42 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 14:17:42 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        Richard Hughes <rhughes@redhat.com>,
        Jared Dominguez <jaredz@redhat.com>
Subject: RE: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Topic: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Index: AQHWZn4rqCTeVrGp2k+MCJMiO1QTGalTvXYAgABGkgA=
Date:   Tue, 1 Sep 2020 14:17:42 +0000
Message-ID: <DM6PR19MB26364970D0981212E811E1B0FA2E0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <d3de1d27-25ac-be43-54d8-dcbfffa31e1d@redhat.com>
In-Reply-To: <d3de1d27-25ac-be43-54d8-dcbfffa31e1d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-01T14:02:30.2236535Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=5d93c39a-01ad-4c64-b426-81a3305d2b78;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [172.58.99.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c74f7352-5083-40b2-b740-08d84e81ca44
x-ms-traffictypediagnostic: DM5PR19MB0091:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR19MB0091CD6C3AEC27416FAD07D3FA2E0@DM5PR19MB0091.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxFF6S5MPD+BRS42XH7hzACfrru5knb81wlkcKM11qyGjumP03mmu2gN7J1iZQtXbb6qOQH04zWwGcM+tGBVuwTf3OCgVv5eDWvEzWfW9UmuntYeO/SGaDJ2uzokwOOenBEORWRNATpQrb2lBR4fxRsWohOUUMC3X4ibkWdOjawoDIktJ1oYd3XPBGs5BKt9tw4KCfLUoBUdIERyaWi7yG7SRAOfZiWSHZ1uBJpOIAEgV5lVHOj0X2vBNIvIp0JWhriMCiw/9hrxDBOXtxl0VfV1r4jOcXeGJWPQPkKEFAHSTEAxfJf/br94sRBv89KQTkaVDT9RPqJQOm6sKpm4DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(66556008)(786003)(64756008)(54906003)(8676002)(6506007)(110136005)(66446008)(86362001)(83380400001)(5660300002)(4326008)(76116006)(316002)(8936002)(2906002)(52536014)(71200400001)(33656002)(66476007)(7696005)(9686003)(186003)(55016002)(478600001)(66946007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: w3PO/JStcPSf2hb4u8bT8nmfwhS7hqZhqgFV41v+9mTRG5sqPzFVZynlUNYAlfXLNCYD1CFNMX/HjCmtwQAxKeZc94HHGdlnhjizmmtlgNewZl86zkIYr0YEVbmT5j1V2o7QSpYgbUoKifudOYmRDVkmWMQ1oMHIWY/XzbM6pnGqDecSBvsHy6y3+3IOCQlyuGKLFr6b7UV5MZ0ze4wepqZktKQ04C0W+Ksl73Fa7O22RUVhMZHMHuGgyaLG4FtcH1n3+Sn1RQu5OrL53mWHF/6zVrfKmJZPSzM1iwSwCJJTBlycWsKhfvC9mVorHYjqb5yYgto0NELdiYXb4SZLBsLCNlq7xMcl2SOZu1XcaNf2YIPlV6F4c8TxCvovp+9wr/yE3cIPH58PE2sEIjoTGZ+Lf1iw/pVO56K0WVCXfMyMb3zhdD1DnZMLj1TNXIc6urwcP2rHGg1E8Avy9NhT5v7gxriEKymIj4UA5ETHK9yBy2iOLDbxo+iRHyrD62wnx1DwmoEIJCuZy7bpXFO4x5cNuoc32pNg3xQlx8Hl7PVGPcu5LLzv7qSp49KzebUvR3kQrN+UlluM+hsKsjvC9+pyjpLkJK13AgV16oEI+oNdVGQZsPdrkZ50wre5afQ/jSOMKL8Sw00LE7aPK6DV/A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74f7352-5083-40b2-b740-08d84e81ca44
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 14:17:42.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvtogskrPcq3wI0EBIZtK8ca+U+xry07N5Hci1wNjbIKnrYsGluTcd/84W3N/pO7eFb/qzOp3J3Kx87j2Ryq7VKB0Zly67X7OaJVx/fFB98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0091
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_08:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010119
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBHb2luZyBmb3J3YXJkIEkgd2lsbCBiZSBoZWxwaW5nIEFuZHkgYW5kIERhcnJlbiB3aXRoIG1h
aW50YWluaW5nIHRoZQ0KPiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni8qIGRyaXZlcnMuDQo+DQo+IFNv
IG9uZSBvZiB0aGUgZmlyc3QgdGhpbmdzIHdoaWNoIEknbSBkb2luZyB3aXRoIHRoYXQgaGF0IG9u
LA0KPiBpcyByZXZpZXcgdGhpcyBwYXRjaC4NCg0KQ29uZ3JhdHMgb24gdGhlIG5ldyByZXNwb25z
aWJpbGl0aWVzIDopDQoNCjxzbmlwPg0KDQo+DQo+IFNvIGZpcnN0IG9mIGFsbCBzb21lIGNvbW1l
bnRzIG9uIHRoZSB1c2Vyc3BhY2UgKHN5c2ZzKSBBUEkgZm9yIHRoYXQuIEdldHRpbmcNCj4gdGhp
cw0KPiBwYXJ0IHJpZ2h0IGlzIHRoZSBtb3N0IGltcG9ydGFudCBwYXJ0IG9mIHRoaXMgcGF0Y2gs
IGFzIHRoYXQgd2lsbCBiZSBzZXQgaW4NCj4gc3RvbmUNCj4gb25jZSBtZXJnZWQuDQo+DQo+IE15
IGZpcnN0IHJlYWN0aW9uIHRvIHRoZSBzdWdnZXN0IEFQSSBpcyB0aGF0IEkgZmluZCB0aGUgc29y
dGluZyBieSB0eXBlIHRoaW5nDQo+IHJlYWxseSB3ZWlyZCwNCj4gc28gaWYgSSB3ZXJlIHRvIGRv
Og0KPg0KPiBscyAvc3lzL2RldmljZXMvcGxhdGZvcm0vZGVsbC13bWktc3lzbWFuL2F0dHJpYnV0
ZXMvDQo+DQo+IEkgd291bGQgZ2V0IHRoZSBmb2xsb3dpbmcgYXMgb3V0cHV0Og0KPg0KPiBlbnVt
ZXJhdGlvbg0KPiBpbnRlZ2VyDQo+IHN0cmluZw0KPg0KPiBBbmQgdGhlbiB0byBzZWUgdGhlIGFj
dHVhbCBhdHRyaWJ1dGVzIEkgd291bGQgbmVlZCB0byBkbzoNCj4NCj4gbHMgL3N5cy9kZXZpY2Vz
L3BsYXRmb3JtL2RlbGwtd21pLXN5c21hbi9hdHRyaWJ1dGVzL3tlbnVtZXJhdGlvbixpbnRlZ2Vy
LHN0cmluZ30NCj4NCj4gVGhpcyBmZWVscyBsZXNzIHRoZW4gaWRlYWwgYm90aCB3aGVuIGludGVy
YWN0aW5nIGZyb20gYSBzaGVsbCwgYnV0IGFsc28gd2hlbg0KPiBlLmcuIGVudmlzaW9uaW5nIEMt
Y29kZSBlbnVtZXJhdGluZyBhdHRyaWJ1dGVzLg0KPg0KPiBJTUhPIGl0IHdvdWxkIGJlIGJldHRl
ciB0byBoYXZlOg0KPg0KPiAvc3lzL2RldmljZXMvcGxhdGZvcm0vZGVsbC13bWktc3lzbWFuL2F0
dHJpYnV0ZXMvPGF0dHI+L3R5cGUNCj4NCj4gV2hpY2ggY2FuIGJlIG9uZSBvZiAiZW51bWVyYXRp
b24saW50ZWdlcixzdHJpbmciDQo+DQo+IGFuZCB0aGVuIGhhdmUgdGhlIG90aGVyIHN5c2ZzIGZp
bGVzIChkZWZhdWx0X1ZhbHVlLCBjdXJyZW50X3ZhbHVlLCBtYXguLi4sIGV0Yy4pDQo+IGFzOg0K
Pg0KPiAvc3lzL2RldmljZXMvcGxhdGZvcm0vZGVsbC13bWktc3lzbWFuL2F0dHJpYnV0ZXMvPGF0
dHI+L2RlZmF1bHRfdmFsdWUNCj4gZXRjLg0KPg0KPiBXaGVyZSB3aGljaCBmaWxlcyBleGFjdGx5
IGFyZSBwcmVzZW50IGZvciBhIHNwZWNpZmljIDxhdHRyPiBkZXBlbmRzIG9uIHRoZSB0eXBlLg0K
Pg0KPiBUaGlzIHdpbGwgbWFrZSBlLmcgQy1jb2RlIGVudW1lcmF0aW5nIGFsbCBhdHRyaWJ1dGVz
IGJlIGEgc2luZ2xlIHJlYWRkaXIsDQo+IGZvbGxvd2VkDQo+IGJ5IHJlYWRpbmcgdGhlIHR5cGUg
Zm9yIGVhY2ggZGlyIGVudHJ5OyBhbmQgaWYgd2UgYWRkIGEgbmV3IHR5cGUgdGhlIEMtY29kZSBj
YW4NCj4gd2FybiB0aGUgdXNlciB0aGF0IGl0IGVuY291bnRlcmVkIGFuIGF0cmlidXRlIHdpdGgg
dW5rbm93biB0eXBlIDxuZXctdHlwZT4sDQo+IHJhdGhlciB0aGVuIG5vdCBiZWluZyBhd2FyZSB0
aGF0IHRoZXJlIGlzIGEgZm91cnRoIGRpciAoZm9yIHRoZSBuZXcgdHlwZSkgd2l0aA0KPiBhdHRy
aWJ1dGVzIHRvIGNoZWNrLg0KDQpJIGFncmVlIHRoaXMgaXMgdGhlIG1vc3QgaW1wb3J0YW50IHBh
cnQgdG8gZ2V0IGNvcnJlY3QuICBUaGlzIHByb3Bvc2FsIHNlZW1zIHByZXR0eQ0KZ29vZCB0byBt
ZS4NCg0KPg0KPiBPdGhlciB0aGVuIHRoYXQgdGhlIHN5c2ZzIGludGVyZmFjZSBnZW5lcmFsbHkg
bG9va3MgZ29vZCB0byBtZSwgZXhjZXB0IGZvcg0KPiBvbmUgb3RoZXIgYmlnIHRoaW5nIChhbmQg
b25lIHNtYWxsIHRoaW5nLCBzZWUgYmVsb3cpLg0KPg0KPiBUaGlzIGludGVyZmFjZSBzZWVtcyBw
cmV0dHkgZ2VuZXJpYyAod2hpY2ggaXMgYSBnb29kIHRoaW5nKSwgYnV0IHRoZW4gaGF2aW5nDQo+
IGl0IGxpdmUgaW4gdGhlIGhhcmRjb2RlZCAvc3lzL2RldmljZXMvcGxhdGZvcm0vZGVsbC13bWkt
c3lzbWFuL2F0dHJpYnV0ZXMNCj4gbmFtZS1zcGFjZSBzZWVtcyBsZXNzIHRoZW4gaWRlYWwuIEkg
YWxzbyBzZWUgaW4gdGhlIGNvZGUgdGhhdCB5b3UgYXJlIGNyZWF0aW5nDQo+IGEgZHVtbXkgcGxh
dGZvcm0gZGV2aWNlLCBqdXN0IHRvIGhhdmUgYSBwbGFjZS9wYXJlbnQgdG8gcmVnaXN0ZXIgdGhl
IGF0dHJpYnV0ZXMNCj4gZGlyIHdpdGguDQo+DQo+IENvbWJpbmluZyB0aGVzZSAyIHRoaW5ncyBJ
IHRoaW5rIHRoYXQgaXQgd291bGQgYmUgYmV0dGVyIHRvIG1ha2UgYSBuZXcgY2xhc3MNCj4gZm9y
IHRoaXMsIGxpa2UgaG93IHdlIGUuZy4gaGF2ZSBhIGJhY2tsaWdodCBjbGFzcyB1bmRlciAvc3lz
L2NsYXNzL2JhY2tsaWdodA0KPiB3ZSBjb3VsZCBoYXZlIGEgL3N5cy9jbGFzcy9maXJtd2FyZV9h
dHRyaWJ1dGVzIGNsYXNzIGFuZCB0aGVuIHdlIHdvdWxkIGdldA0KPiBhIGRlbGxfd21pIGVudHJ5
IHVuZGVyIHRoYXQgKGFuZCBkcm9wIHRoZSAiYXR0cmlidXRlcyIgZGlyKSwgc28gd2Ugd291bGQg
Z2V0Og0KPg0KPiAvc3lzL2NsYXNzL2Zpcm13YXJlX2F0dHJpYnV0ZXMvZGVsbF93bWkvPGF0dHI+
L3R5cGUNCj4NCj4gRXRjLg0KPg0KPiBTbyBpbnN0ZWFkIG9mIGNyZWF0aW5nIGEgZHVtbXkgcGxh
dGZvcm0gZGV2aWNlLCB5b3Ugd291bGQgY3JlYXRlIGENCj4gZmlybXdhcmVfYXR0cmlidXRlcw0K
PiBjbGFzcyBkZXZpY2UuDQo+DQo+IEkgdGhpbmsgaXQgaXMgbGlrZWx5IHRoYXQgb3RoZXIgdmVu
ZG9ycyBtYXkgZXZlbnR1YWxseSBhbHNvIHN1cHBvcnQgbW9kaWZ5aW5nDQo+IEJJT1Mgc2V0dGlu
Z3Mgd2l0aG91dCBnb2luZyBpbnRvIHRoZSBCSU9TIHNldHVwIG1lbnUgYW5kIEkgd291bGQgbGlr
ZSB1cyB0bw0KPiB1c2Ugb25lIHVuaWZpZWQgdXNlcnNwYWNlIEFQSSBmb3IgdGhpcy4gIE5vdGUg
dGhpcyBjaGFuZ2VzIGxpdHRsZSBmb3IgdGhlIERlbGwNCj4gY29kZSAvDQo+IHRoaXMgcGF0Y2gg
KGFsdGhvdWdoIGV2ZW50dWFsbHkgc29tZSBjb2RlIG1heSBiZSBtb3ZlZCBpbnRvIHNoYXJlZCBo
ZWxwZXJzKSwgYnV0DQo+IGl0IGRvZXMgYWxsb3cgdXNlcnNwYWNlIHRvIGRpc2NvdmVyIGlmIHRo
ZSBmaXJtd2FyZS1hdHRyIHN5c2ZzIEFQSSBpcyBzdXBwb3J0ZWQNCj4gaW4NCj4gYSB2ZW5kb3Ig
YWdub3N0aWMgQVBJIGJ5IGRvaW5nIGEgcmVhZGRpciBvbiAvc3lzL2NsYXNzL2Zpcm13YXJlX2F0
dHJpYnV0ZXMNCj4NCg0KVGhpcyBhcmVhIEknbSBub3Qgc3VyZSBJJ20gYWxpZ25lZC4gIFR3byBy
ZWFzb25zIGNvbWUgdG8gbWluZDoNCg0KMSkgVGhlIGludGVyZmFjZSB0aGF0IERlbGwgb2ZmZXJz
IGlzbid0IGd1YXJhbnRlZWQgdG8gd29yayB0aGUgc2FtZSBhcyBhbnkgb3RoZXINClZlbmRvcnMu
IERvIHdlIHdhbnQgdG8gZm9yY2UgdGhlbSB0byB1c2UgdGhlIHNhbWUgaW50ZXJmYWNlIGFzIERl
bGw/ICBGb3IgZXhhbXBsZSB3aGF0DQppZiBhbm90aGVyIHZlbmRvciBkb2Vzbid0IG9mZmVyIGFu
IGludGVyZmFjZSBmcm9tIHRoZWlyIGZpcm13YXJlIHRvIGVudW1lcmF0ZSBwb3NzaWJsZQ0Kb3B0
aW9ucyBmb3IgYW55IGF0dHJpYnV0ZSBidXQgeW91IGhhdmUgdG8ga25vdyB0aGVtIGluIGFkdmFu
Y2U/ICBXb3VsZCB0aG9zZSBwb3NzaWJsZSBvcHRpb25zDQpiZSBoYXJkY29kZWQgaW4gdGhlaXIg
a2VybmVsIGRyaXZlcj8gIERlbGwgc2V0cyBwcmVjZWRlbnQgaGVyZSBieSBoYXZpbmcgdGhlIGZp
cnN0IGRyaXZlci4NCg0KMikgRGVsbCBoYXMgc29tZSBleHRlbnNpb25zIHBsYW5uZWQgZm9yIG90
aGVyIGF1dGhlbnRpY2F0aW9uIG1lY2hhbmlzbXMgdGhhbiBwYXNzd29yZC4NClRoYXQgaXMgKmRl
ZmluaXRlbHkqIGdvaW5nIHRvIGJlIERlbGwgc3BlY2lmaWMsIHNvIHNob3VsZCBpdCBiZSBkb25l
IGluIHRoaXMgdmVuZG9yDQphZ25vc3RpYyBkaXJlY3Rvcnk/DQoNCj4gVGhlcmUgY291bGQgZXZl
biBiZSBtdWx0aXBsZSBpbnN0YW5jZXMgaW1wbGVtZW50aW5nIHRoaXMgaW50ZXJmYWNlLCBlLmcu
IGlmDQo+IHRoZWlyDQo+IGlzIGFuIGFkZC1vbiBjYXJkIHdpdGggaXRzIG93biBvcHRpb24tUk9N
LCBzZWUgZm9yIGlzY3NpIGJvb3RpbmcgdGhlbiB0aGUgaXNjc2kNCj4gYm9vdA0KPiBvcHRpb25z
IGNvdWxkIGJlIGF2YWlsYWJsZSB1bmRlcjoNCj4NCj4gL3N5cy9jbGFzcy9maXJtd2FyZV9hdHRy
aWJ1dGVzL2lzY3NpX2Jvb3RfbmljLzxhdHRyPi8qDQo+DQo+IFdoaWxlIHRoZSBtYWluIHN5c3Rl
bSBmaXJtd2FyZSBzZXR0aW5ncyB3b3VsZCBiZSBhdmFpbGFibGUgdW5kZXI6DQo+DQo+IC9zeXMv
Y2xhc3MvZmlybXdhcmVfYXR0cmlidXRlcy9kZWxsX3dtaS88YXR0cj4vKg0KPg0KPiBTaW5jZSB5
b3UgaGF2ZSBhbHJlYWR5IGRlc2lnbmVkIGEgbmljZSBnZW5lcmljIEFQSSBmb3IgdGhpcyBpdCBz
ZWVtcw0KPiBzZW5zaWJsZSB0byBtZSB0byBtYWtlIGl0IHBvc3NpYmxlIHRvIHVzZSB0aGlzIG91
dHNpZGUgdGhlIERlbGwgV01JIGNhc2UuDQo+DQo+DQo+IFNvIGFzIG1lbnRpb25lZCBJIGFsc28g
aGF2ZSBvbmUgc21hbGxlciBpc3N1ZSB3aXRoIHRoZSBBUEksIGhvdyBpcyBhDQo+IFVJIHN1cHBv
c2VkIHRvIHJlcHJlc2VudCBhbGwgdGhlc2UgYXR0cmlidXRlcz8gIEluIHRoZSBCSU9TIHNldHVw
IHNjcmVlbg0KPiB0aGV5IGFyZSB0eXBpY2FsbHkgZ3JvdXBlZCB0b2dldGhlciB1bmRlciBlLmcu
IENQVSBzZXR0aW5ncywgcG93ZXItbWFuYWdlbWVudA0KPiBzZXR0aW5ncywNCj4gZXRjLiAgSSB3
b25kZXIgaWYgaXQgd291bGQgYmUgcG9zc2libGUgdG8gYWRkIGEgImdyb3VwIiBzeXNmcyBmaWxl
IHRvIGVhY2gNCj4gYXR0cmlidXRlDQo+IHdoaWNoIHJlcHJlc2VudCB0aGUgdHlwaWNhbCBncm91
cGluZy4gRS5nLiBmb3IgcG0gcmVsYXRlZCBzZXR0aW5ncyB0aGUgZ3JvdXANCj4gZmlsZQ0KPiB3
b3VsZCBjb250YWluICJQb3dlciBNYW5hZ2VtZW50IiB0aGVuIGFuIHVzZXJzcGFjZSBVaSBjYW4g
ZW51bWVyYXRlIHRoZSBncm91cHMNCj4gYW5kDQo+IGhhdmUgZS5nLiAxIHRhYiBwZXIgZ3JvdXAs
IG9yIGEgdHJlZSB3aXRoIHRoZSBncm91cHMgYXMgcGFyZW50cyBvb2YgdGhlDQo+IGF0dHJpYnV0
ZXMNCj4gZm9yIGVhY2ggZ3JvdXAuIFRoaXMgaXMganVzdCBhbiBpZGVhIEkgZG9uJ3Qga25vdyBp
ZiBzdWNoIGdyb3VwaW5nIGluZm8gaXMNCj4gYXZhaWxhYmxlDQo+IGluIHRoZSBXTUkgaW50ZXJm
YWNlIGZvciB0aGlzLg0KDQpUaGlzIGluZm9ybWF0aW9uIGlzbid0IGF2YWlsYWJsZSBpbiB0aGUg
QUNQSS1XTUkgaW50ZXJmYWNlIHVuZm9ydHVuYXRlbHkuDQoNCjxzbmlwPg0KDQo+DQo+IEF0IGZp
cnN0IEkgd2FzIHRoaW5raW5nIHRoYXQgdGhpbmdzIGxpa2UgaXNfcGFzc3dvcmRfc2V0IHdvdWxk
IGxpdmUgZGlyZWN0bHkNCj4gdW5kZXINCj4gL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2RlbGwtd21p
LXN5c21hbi9hdHRyaWJ1dGVzL3Bhc3N3b3JkLyBzbyB3ZSB3b3VsZCBoYXZlOg0KPg0KPiAvc3lz
L2RldmljZXMvcGxhdGZvcm0vZGVsbC13bWktc3lzbWFuL2F0dHJpYnV0ZXMvcGFzc3dvcmQvaXNf
cGFzc3dvcmRfc2V0DQo+DQo+IEJ1dCBub3cgSSBzZWUgdGhhdCBwYXNzd29yZCByZWFsbHkgaXMg
anVzdCBhbm90aGVyIHR5cGUgb2YgYXR0cmlidXRlIGFuZCB3ZSB3aWxsDQo+IGhhdmU6DQo+DQo+
IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9kZWxsLXdtaS1zeXNtYW4vYXR0cmlidXRlcy9wYXNzd29y
ZC9TeXN0ZW0vaXNfcGFzc3dvcmRfc2V0DQo+DQo+IGFuZDoNCj4NCj4gL3N5cy9kZXZpY2VzL3Bs
YXRmb3JtL2RlbGwtd21pLXN5c21hbi9hdHRyaWJ1dGVzL3Bhc3N3b3JkL1VzZXIvaXNfcGFzc3dv
cmRfc2V0DQo+DQo+IFRoYXQgbWFrZXMgbW9yZSBzZW5zZSwgYW5kIHdpbGwgYWxzbyB3b3JrIHdl
bGwgd2l0aCB0aGUgY2hhbmdlcyBJIHN1Z2dlc3QgYWJvdmUuDQo+DQoNCkNvcnJlY3QuDQoNCj4N
Cj4gSSB3b3VsZCBsaWtlIHRvIHNwbGl0IHRoZSBvdmVyYWxsIGRpc2N1c3Npb24gb2YgdGhlIEFQ
SSwgdmVyc3VzIGRvaW5nIGENCj4gZGV0YWlsZWQgcmV2aWV3IG9mIHRoZSBjb2RlLCBzbyBJIHdp
bGwgcmV2aWV3IHRoZSBjb2RlIGluIGEgc2VwYXJhdGUgZW1haWwuDQoNClRoYW5rcywgSSB0aGlu
ayB0aGlzIGlzIGEgcHJvZHVjdGl2ZSB3YXkgdG8gcmV2aWV3IGl0Lg0KDQo8c25pcD4NCg==
