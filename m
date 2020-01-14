Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E53C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388422075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="e9G6iEAF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Nc62TiFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgANJJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:09:52 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:17320 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgANJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:09:51 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00E99ixD016779;
        Tue, 14 Jan 2020 01:09:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=vYku5FoNSTa48bAC7j1mKjAMoAgu86GipS9i3sWg8rk=;
 b=e9G6iEAFsPNJaeviOykUi0SWjX1aPFXwDHm4PfeG9tymDHGXyDuOYUgWyQLwSWreZ0PB
 0l+9MUNy4eNtkepQMZJSuSeuEz8zZ2Ozq0QDXg5qxXOG0AUv+QIZx9uk0ESu5j1i6McU
 Ozk5gd+w8OUgVT8E87zQOEw112P8nKY8cBY3j0xGe0AmUy7lQS838PNHqokquOuqipT/
 VRxKDJqmqf5hZTTvS+6V6Sn16f9d7Fzfati+CRX5CnCP8U6fqQNzu9MlhnlEdzchxbZV
 EugzRn1qYGSnmcKgZNz75BS7q12C0fpJlP7HUV4jZgkm+lCSqmCphFx4B+mKUzGvgNmZ ag== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xfau2gsr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 01:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv/cDaDceo91Ol+DHRe2E3QWYplXA8HeLQ9gRSeyXMtwK7CYvpCcNgM81aNU7dyvWC8OwrGepTLiCh0mu/WyuCiG45bCJ6r9IFUk2MbVpOiXLY/IaEjdqoxBciCI0O6cYNUz9N50umeA3XaeaXixspHQ78AbWTQMMDjZVT+hTMwftRPMZIWx1cs3yLVAOkdnRlVVciqJS+sx4apUAZq4l/PG5GIv8Nb+VQ/xvyld2UU++CuCcBPXyCmAMS20Wd6uhEvAt84A1HsFG2ulvfXyw1FjkqpAhTlrCHMG1cbtwj6ndNsrqfvHiY92VA1p9tREuWj3sgqYdF7vnbINUL1Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYku5FoNSTa48bAC7j1mKjAMoAgu86GipS9i3sWg8rk=;
 b=R0R/ogwtVQf03vRnSetQCSDBneCphkQoNSDcEyW0vitBO60fyfnBTd20V4k/ykznimq1NAcHU4ax0qr7EKiqmG4nC7GgDkK+SPmDP9fCIHH17peavbtAxoLo76pE3A4CPJ/0GhghLhlM3VMtNnL/qV4FsTkzeEvN/k20GSZpPYScM3unXrLDaCeJLzus2x/lAxJn0ZHCcIX499lumkZ0X34OE3sF9P6efnCwa9uBS99n8lKpBraFf1iuiF+QeiC/nnU+XA3PR5PmSX8v+kvNlGCvELNapyf7ij2j13M0J8ZXLG1xFNJ1oIkf4Qi0vzv0yUhVcAqJCuUJoRB1yzAvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYku5FoNSTa48bAC7j1mKjAMoAgu86GipS9i3sWg8rk=;
 b=Nc62TiFpY6i7beetMASx0LlGXBeXI/8Dslm4R+29y4/Dp4tJm7UMmoIPJ8TRD7Yt8YzXo1WaO4fjDcZdHudeh/qCOpBzQV52TCnXCAwmjYBD4VGXuTkb6MOQlI93qdf8S3lBrkAHFgzm7XkmWG5YE0CApNkB2NN7Kd5NeRpwFGg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5176.namprd07.prod.outlook.com (20.177.125.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 09:09:42 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 09:09:42 +0000
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
        "peter.chen@nxp.com" <peter.chen@nxp.com>
Subject: RE: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Topic: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Index: AQHVxhgd/L7cK1vWyke0JuU/54YkXqfg05qAgADt7MCAACEmgIAAGtLAgAAXVgCAB9A3gIAAAuyA
Date:   Tue, 14 Jan 2020 09:09:41 +0000
Message-ID: <BYAPR07MB470980796F605EF38D9E1C60DD340@BYAPR07MB4709.namprd07.prod.outlook.com>
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
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOTc4OGQxZWQtMzZhZC0xMWVhLTg3NTItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDk3ODhkMWVmLTM2YWQtMTFlYS04NzUyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjQxMiIgdD0iMTMyMjM0NjY1Nzk4MDI5NTk0IiBoPSJTK1owR3orY1dPLzRweklWRVF3UFh6KzdzSjA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2007695c-7957-4534-3d09-08d798d17dc9
x-ms-traffictypediagnostic: BYAPR07MB5176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB5176EC9AFC35E7F2FDC76F6FDD340@BYAPR07MB5176.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(36092001)(66476007)(186003)(33656002)(9686003)(6506007)(66446008)(66946007)(76116006)(7696005)(66556008)(86362001)(64756008)(478600001)(7416002)(55016002)(4326008)(52536014)(8676002)(26005)(8936002)(54906003)(5660300002)(71200400001)(110136005)(2906002)(316002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5176;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAerHmMPe31imsLsRN7GAlt/DqoodCEQ8dT3s77A2ZL74lxZ8++22XK5JkHh7cHldiCNsxxu4VXuG67axdUcipPDbULB8SopI+pl6fRJ0wW2oQ1/7J/oMT3Pu9w1ISfV1bQLd0t0KK7/CyGuj+Z2sq6Wx972RdmTA2UqfLnf5ONmTq68tOpmLt4EmQVSG0kj5YjfYYljvd8xt3o/P8BDl27PcAnIksqgzftX7WWcM/4RB4DdI/Rsi2gosdtc6mZ901u7CVaL0AMbQcI89UmJI8lUmyMuZIoy4SgmCcac7ZDG1HSZiT0svsTuxP1T9VK58H0Dv0A91beDhBLylMKN7u4hV8HhOtHmnkGEEmVXCQoxttzUFL4kEKgcoL7KdFXqztUN9mngeErdX8Ev16P6x90p9zKup8Pwe1TCaAmgd8cspxNlbVzQQLqCH5rXwky5JUmk4od/cIb30XsanKtyi133BZa43oQOSb5IyGojEYhpDCHsLWJrZtxd8mfGW994
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2007695c-7957-4534-3d09-08d798d17dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 09:09:41.9593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPnftkoM83CvPyKiSqaCwwXIusYipYeaSkOSCh1ti3rmzim2oI2qsK/cmT5TY8uFsO8S3I6Ms7TrvE1ff6kINqH9BZ5kCg4eZdtxWLQqZIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5176
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_02:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140081
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
YXdlbGwNCg0KPg0KPlBldGVyDQoNCg0K
