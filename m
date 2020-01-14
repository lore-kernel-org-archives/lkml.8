Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3430BC33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9009C2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pF7+Rf1U";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="iAbPKJ6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgANJGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:06:32 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48330 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729015AbgANJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:06:30 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00E93UnE013025;
        Tue, 14 Jan 2020 01:06:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=eGRMpttwQEV1JdfCUvbbGyrBTrnGIesheGQgQrLH95w=;
 b=pF7+Rf1UdTYmSjDgjt3HjOBYukVSWKF/hGuApKzDnWgSKRA2fNpF/KTZz+GCjFBjlwW0
 eo6ATezLwjRD8nl6chn2x+snFVQt8sWHUcxaUjrDaYOGHpY3nB54Rro2JjazX8wRdEsy
 DwAroPxSvUwnlWHA/8HeSBzplUWs+3Mgv1JROPMiiJip5QtjVIUMa10ywi+D8ManJM8F
 n3LE2xoFsMLl+rwWO25pbkIC+WbtrBV3TO913wQAhLMmv7xejGLD4K4vDwaWM0AYj7TN
 siWh3USWLIGRPb9GoVODboYIcoX5fu4G1SueFtuYZpoJem/OdxwEFj+guAhEbjSEXe6P SQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xfbt38q6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 01:06:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuEs/Ir44IRZAqb0t3UVpFyaWB9b5pptVWNLODcGVUZWhRKGwkAkdCWV8xmLn/CDNoXm5S2/7ISEz66J9507Yt4OHOksleLQYbmSM4oEIbd/7V1jes3RNCd29rMS93mOqr9P7io07zOkXKdEvDouLA4bpkX32JkYvdmRO0iNV/+UL8eKGS1aJIa3DcLsXaNeLrieCDvV42C/iVZZtSiApVUkHh3r1NI3xe+5zC3Sj59tZIZsKZcLz2+SxM/sGwiARnqQ3MqWFCDC0Ick0PY/Ze8Yk/WKe3KYyzoA9qIQJ1FwmHewUwlHkeE9MdwxWH6/7e74G8k+qfZDunxe8ITKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGRMpttwQEV1JdfCUvbbGyrBTrnGIesheGQgQrLH95w=;
 b=jRyx4iRshitMKA/4V//bfBoUJiPNNHu4bDzlTFSWj8DdMSlmslC4ERe8PnprqIxdzQAulVAY3cXdm6/kMOm3bGRJYXyQE+3dcm78UXVqbS6s2Na0T5rdJOrfcayBzpOd33bz2kGjjdmL3TY/d+X8BolQm8UyhnDQzIPJkKy9S4f4CsByF8Moac7unnd/TV7PRqo3qa2+38r/F3XxQ8DtmEob/njuOvBOEfVz1RBJzQe/lp7prgr49lUIcQ6IdI3R6f1hG2Sz4cd2sE2XGm4kw3T1tkm/Qgo86zqlj5LI8ke1wwVnYTUN6SJ6CM6WVXR4Lkw4dAvNCOu/nZIx8DIP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGRMpttwQEV1JdfCUvbbGyrBTrnGIesheGQgQrLH95w=;
 b=iAbPKJ6Pi9nkjoCOx57yBCqi+R+4Msy+jhtxtVSn2VhyY5N/BMZZkBtCHZsmTJqda5vzegqwDWrNtFxP26qh29bfcXMb2fHUS9O8QIzyXzxrN+DGMbvY1ql02xP0S+wpAnEMlNFtRqzmU1F2krdR3tu2WxEcVVL1ylV3QJCe58c=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5176.namprd07.prod.outlook.com (20.177.125.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 09:06:20 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 09:06:19 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <hzpeterchen@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Peter Chan <peter.chan@nxp.com>
Subject: RE: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Topic: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Index: AQHVxhgd/L7cK1vWyke0JuU/54YkXqfg05qAgADt7MCAACEmgIAAGtLAgAAXVgCAB9A3gIAAAI2w
Date:   Tue, 14 Jan 2020 09:06:19 +0000
Message-ID: <BYAPR07MB47094299C2ABDC08AD5B56D2DD340@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20200108113719.21551-1-pawell@cadence.com>
 <20200108142829.GB2383861@kroah.com>
 <BYAPR07MB4709983A2DF70AA0058C737FDD390@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20200109063841.GA2579094@kroah.com>
 <BYAPR07MB4709AA109700B4BCAD1C1ED8DD390@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20200109093812.GC44349@kroah.com>
 <CAL411-pE7QheAEQf+ki8auChWP6MOWxaaAA3xkkdweWn=q_0wA@mail.gmail.com>
In-Reply-To: <CAL411-pE7QheAEQf+ki8auChWP6MOWxaaAA3xkkdweWn=q_0wA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMWM2ZTllZTgtMzZhZC0xMWVhLTg3NTItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDFjNmU5ZWVhLTM2YWQtMTFlYS04NzUyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjQwNiIgdD0iMTMyMjM0NjYzNzMyNjQ1Mzc1IiBoPSJEODIvTzFaYnViY3dldDV0WmF6cDBHODNMN009IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f470b005-eaad-452d-bd23-08d798d10516
x-ms-traffictypediagnostic: BYAPR07MB5176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB517615E95DF2B15134C98EBBDD340@BYAPR07MB5176.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(36092001)(189003)(199004)(54906003)(26005)(8936002)(110136005)(71200400001)(5660300002)(52536014)(8676002)(81166006)(81156014)(316002)(2906002)(76116006)(66946007)(66556008)(7696005)(66476007)(186003)(33656002)(9686003)(6506007)(66446008)(55016002)(4326008)(64756008)(86362001)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5176;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYIMLTj8LQrJQr65/N3oSzaUeQ0sQ6260i6NHtsM5lcSwQFAzVXw/WbFqR/+d43ASynpUHIxo/rCa579ikPfU6PtbSdTuSTAwUdjWUP9C1jmZ/bvK7kdOcCF2F5jMOKViS608E5/lEUvmhQxQjKOftHfW2inbGjEmiKTAlgzMPJ+m2ikTdOZMVjBcOOPFpV0CRVOXvSZs5SGp6XgKjq9R8LKsbx93/nKQkzaR0ZCYhOPSV1RfPkM0/0klyzlcPv1KvicFd2KhtbZCGj8AGhTmE5uIX9sEmFp3UctqgH9jgkOYcc5At+2beiUx1KwshhvBLpGQ1nTbi+XTJrNFafY21pvq9a+BJr1WzFEoY45PiG6GpFBByzP0m7QTjBKcBcFMqOCmJRn3in1MjBPo2Cnr4hlQAPV6i4ng34o/EFYyjQMPkV5CVMT7xZWUr8UCbeKHmUJsXHOEv9PU6uDky/oTqjyor/dlfzl2B8NExtqIefsN7E+m3nob5aArCd8K857
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f470b005-eaad-452d-bd23-08d798d10516
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 09:06:19.5448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4ADFLgLUXtEHariMWdPVBKnsTvUlimBiTNydGJka6bwAybLs8sE590DueIe/5ETzawtEwl6LOzbVtTESLw/LHCm8FZfaMk9Y1Ahy4dkoZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5176
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_02:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 spamscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPk9uIFRodSwgSmFuIDksIDIwMjAgYXQgNTozOSBQTSBHcmVnIEtIIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+Pg0KPj4gT24gVGh1LCBKYW4gMDksIDIwMjAgYXQgMDg6
MzQ6MTJBTSArMDAwMCwgUGF3ZWwgTGFzemN6YWsgd3JvdGU6DQo+PiA+ID4NCj4+ID4gPk9uIFRo
dSwgSmFuIDA5LCAyMDIwIGF0IDA2OjI3OjAyQU0gKzAwMDAsIFBhd2VsIExhc3pjemFrIHdyb3Rl
Og0KPj4gPiA+PiA+PiArICAgICAgIHdyaXRlbChFUF9DTURfRVBSU1QsICZwcml2X2Rldi0+cmVn
cy0+ZXBfY21kKTsNCj4+ID4gPj4gPj4gKw0KPj4gPiA+PiA+PiArICAgICAgIHJldCA9IHJlYWRs
X3BvbGxfdGltZW91dF9hdG9taWMoJnByaXZfZGV2LT5yZWdzLT5lcF9jbWQsIHZhbCwNCj4+ID4g
Pj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICEodmFsICYgKEVQ
X0NNRF9DU1RBTEwgfCBFUF9DTURfRVBSU1QpKSwNCj4+ID4gPj4gPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDEsIDEwMDApOw0KPj4gPiA+PiA+PiArDQo+PiA+ID4+
ID4+ICsgICAgICAgaWYgKHVubGlrZWx5KHJldCkpDQo+PiA+ID4+ID4NCj4+ID4gPj4gPlVubGVz
cyB5b3UgY2FuIG1lYXN1cmUgdGhlIGRpZmZlcmVuY2Ugb2YgdXNpbmcvbm90IHVzaW5nIGENCj4+
ID4gPj4gPnVubGlrZWx5L2xpa2VseSBtYXJrLCBORVZFUiB1c2UgaXQuICBUaGUgY29tcGlsZXIg
YW5kIGNwdSBjYW4gYWxtb3N0DQo+PiA+ID4+ID5hbHdheXMgZG8gYmV0dGVyIHRoYW4geW91IGNh
biwgd2UgaGF2ZSB0aGUgdGVzdHMgdG8gcHJvdmUgaXQuDQo+PiA+ID4+ID4NCj4+ID4gPj4NCj4+
ID4gPj4gVGhlIGJvdGggb2YgdGhlIGFib3ZlIHRpbWVvdXQgc2hvdWxkIG5ldmVyIG9jY3VyLiBJ
ZiB0aGV5IG9jY3VycmVkIGl0IHdvdWxkIGJlIGENCj4+ID4gPj4gY3JpdGljYWwgY29udHJvbGxl
ciBidWcuIEluIHRoaXMgY2FzZSBkcml2ZXIgY2FuIG9ubHkgaW5mb3JtICBhYm91dCB0aGlzIGV2
ZW50Lg0KPj4gPiA+DQo+PiA+ID4iU2hvdWxkIG5ldmVyIG9jY3VyIiBpcyBhIGZ1biB0aGluZyB0
byBzYXkgOikNCj4+ID4gPg0KPj4gPiA+SWYgaXQgY2FuIG5ldmVyIG9jY3VyLCB0aGVuIGRvbid0
IGV2ZW4gY2hlY2sgZm9yIGl0Lg0KPj4gPg0KPj4gPiBZZXMsIG9uIGV4aXN0aW5nIHBsYXRmb3Jt
cyBpdCBjYW4gbmV2ZXIgb2NjdXIuDQo+PiA+DQo+PiA+ID4NCj4+ID4gPklmIGl0IGNhbiwgdGhl
biBjaGVjayBmb3IgaXQgYW5kIGhhbmRsZSBpdCBwcm9wZXJseS4NCj4+ID4gPg0KPj4gPiA+V2hh
dCBhYm91dCB0aGlzIGNvbnRyb2xsZXIgaW4gc3lzdGVtcyB3aXRoIHJlbW92YWJsZSBidXNzZXMg
KGxpa2UgUENJPykNCj4+ID4gPldoYXQgaGFwcGVucyB0aGVuIChoaW50LCBJIGJldCB0aGlzIGNv
dWxkIG9jY3VyLi4uKQ0KPj4gPg0KPj4gPiBJdCdzIGdvb2QgcXVlc3Rpb24uICBOb2JvZHkgZnJv
bSBvdXIgY3VzdG9tZXIgY3VycmVudGx5IHVzZSBzdWNoIHN5c3RlbS4NCj4+ID4gVGhlIG9ubHkg
cGxhdGZvcm0gd2l0aCBQQ0kgaXMgdXNlZCBieSBtZSBmb3IgdGVzdGluZyBwdXJwb3NlLg0KPj4N
Cj4+IFNvIGlmIHlvdSBkbyBoYXZlIGEgUENJIGRldmljZSwgdGhlbiB5b3UgbmVlZCB0byBoYW5k
bGUgUENJIHJlYWRzDQo+PiBmYWlsaW5nIGFuZCByZXR1cm5pbmcgYWxsIDFzLiAgSG9wZWZ1bGx5
IHlvdSBjYW4gZ3JhY2VmdWxseSBoYW5kbGUgdGhpcyA6KQ0KPj4NCj4+IEFkZGluZyB0aW1lb3V0
IGhhbmRsaW5nIGhlcmUsIHdoZXJlIGl0IGlzIHRvdGFsbHkgb2J2aW91cyB0byBkbyBzbywNCj4+
IHdvdWxkIGJlIGEgZ29vZCB0aGluZy4NCj4+DQo+PiB0aGFua3MsDQo+Pg0KPj4gZ3JlZyBrLWgN
Cj4NCj5IaSBQYXdlbCwNCj4NCj5NeSBlbWFpbCBpczogcGV0ZXIuY2hlbkBueHAuY29tLCBwbGVh
c2UgY2hhbmdlIGl0IHdoZW4geW91ciBzZW5kIG5leHQgdmVyc2lvbi4NCg0KSGkgUGV0ZXIsIA0K
DQpJJ20gc29ycnkgZm9yIHRoYXQuDQoNCkJUVy4gSSBuZWVkIHBvc3Rwb25lIHNlbmRpbmcgdGhl
IG5leHQgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIGJlY2F1c2UgdGhlcmUgaXMgc29tZSBpc3N1ZSB3
aXRoIHN5bmNocm9uaXphdGlvbiBvZiByZXBvc2l0b3JpZXMgIHJlZ2FyZGluZyB0aGUgcGF0Y2gg
InVzYjogY2RuczM6IEFkZCBzdHJlYW1zIHN1cHBvcnQgdG8gY2FkZW5jZSBVU0IzIERSRCBkcml2
ZXIiDQpJIGRvbid0IHdhbnQgZ2VuZXJhdGUgbmV3IGNvbmZsaWN0cy4gDQoNClJlZ2FyZHMsDQpQ
YXdlbGwNCj4NCj5QZXRlcg0K
