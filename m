Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1ECC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62DA20769
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIsfgDQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDGDMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:12:41 -0400
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:13430
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbgDGDMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 23:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVLdCXOqRvcRCi3/VAFhJxcDCUGeW0rSUfDUhcguuQw3OzwUSa4bvC9X0aXpfti9HOsK7OMmgdEji/k2WfRHrWDN0VZdCUcFvd7DL+jnLsfvL8/JctIjd5QLxz95tcOzdAqVcp1CkWFeGTRLTTw9nP2UUtcqjgls//nV7Vjh2lfkBivAuEmG/80wor7DA5zsjQt80qh5rtD6+vc8X4RI0k8Ill/MTaFaGe3AtzxqjyjVq6vqJhOK2T0jmNecYEKWogjFEd6v3fvxWwrDEAkJ50vHU4Xt6hGxK7Xv1ambKV/5jDCvaW5c3uwS+Ev36yAouelrwwVId67UPktv02QjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ji6VisXZora5ClGlNIdl1ByO9zzFLePAYCb0aGTAPY=;
 b=CRGe1lxcMLGv/Mm0bxit8UWL5nOVpkq/bZ335vxXU86PpQV/EPIW+t9S4dfSaOpRn+tVi/0lV/MAzyBSpaWfIYj+ddw40rF1PF87PP/W8mVC8ZK7/EaNWPRbMWkCnFoO3CLfDWERF9igyKs7H4r7U8zNhVxw5EDqz+GOdqdl2QlfWxHlbN6byw+qYmw7fM9lxYdTWmgE1f800QlxPlWc7PCmTf0VmpHZuS6sCvCRt6FasPskf5fhOPIK4P4BdQjbdlLRt8tkenLKYQRR7USe5pUeWXekdG8G3WE48ejjmptwWBz5OPutc+l1TAQPCeo1fMDaOaKxdmz1n18Re3d3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ji6VisXZora5ClGlNIdl1ByO9zzFLePAYCb0aGTAPY=;
 b=GIsfgDQuCDJj3de12kZ4W3uXjclrV40xxsgO+dMwea5GQMxwoj3/wTAlYdRkxny5xYt1IEvADorPtY5ESk0iaAaRwPZMWuh3Mg5C+TMQdXFH2Bikfrb65vJ1NVNBfaInt+SOdK7qZBQqrKjUIXX5AH09uHA2eKkb2pBXlHXw1lk=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 03:12:37 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::902c:71:6377:4273]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::902c:71:6377:4273%5]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 03:12:37 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 5/5] usb: chipidea: allow disabling glue drivers if
 EMBEDDED
Thread-Topic: [PATCH 5/5] usb: chipidea: allow disabling glue drivers if
 EMBEDDED
Thread-Index: AQHWChQAjD6RZ55p5EW1wRD2DjJFfqhtALoA
Date:   Tue, 7 Apr 2020 03:12:36 +0000
Message-ID: <20200407031300.GB26899@b29397-desktop>
References: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
 <1bf89d4301baa8632daf48b3e28858aff5371954.1585958250.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <1bf89d4301baa8632daf48b3e28858aff5371954.1585958250.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3126266-f0c8-4c0f-4f8b-08d7daa18616
x-ms-traffictypediagnostic: AM7PR04MB7141:
x-microsoft-antispam-prvs: <AM7PR04MB71418DF6B0D9DFE0025CFBD18BC30@AM7PR04MB7141.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(7916004)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(6512007)(33716001)(81156014)(8936002)(86362001)(6506007)(1076003)(186003)(81166006)(478600001)(26005)(53546011)(4326008)(5660300002)(8676002)(9686003)(44832011)(64756008)(33656002)(54906003)(76116006)(66476007)(6916009)(66556008)(66446008)(316002)(66946007)(6486002)(71200400001)(2906002)(91956017);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IvBUWk6FFqDn8q4Yyz9V6E9ZNSfqvyaYMlDc5PvLCrx2mvFWaZqzqmg9Z9sj8LZWC+dBJ0wQnI0NDMyGsrV2LpT7PqD2oRD2RvqkkZOXkW7SSlQ+ARcj7H83mWEgWXwwUZT+yAHkFtRlUdUQjnnN7UeuIDZQVSWNXpz3PWHw+ljc/RWjUScuU4ak8QqOZUBRPmOR8jq78OxTdCPLmMXGuulxa4iGWlhk/kzI+lAswXatT7QE4yCQAqMVkatJRd+VEIhVN83GbuDNyLlBz91S4twc5EGoO47B1eIwE76wiTozaxYdwiptTeKadio9H9tzWN6c8DOF+D/gdRw3NvoWc8OzVtwIaKJAV0haN+0Wt++aw2j6DVFUJbMBY+FAnzDipl8Rb6xUfXvrECrGJVtlcAZOWMept9Hy5FYWQFvjgLXaH2YCKPggRArCSndMKNEo
x-ms-exchange-antispam-messagedata: OxEd2tzQL0Mynelq6dTZGH37fR1NJ/daHgyzUn6A7aHZyXdmOtXSoL5mf7+p3IadVOvi5BZ/vfwtbhaFAwgmF5dwogPEwbPopzsTXw2x51nYWPgxSZAypiqh3hEbBL+enhGZGSvNORtaXJpIHiAKoQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A2FD01AB848AE45AB58D2CBB647B400@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3126266-f0c8-4c0f-4f8b-08d7daa18616
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 03:12:36.9895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5vTp0F5beD0Uj3pTnRQKuDc+vMqBGLmIPHCPSSsdr7R15yYuDvASm4s8AwxbQzhYPMhxonZI4SWuSA07tT7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAtMDQtMDQgMDI6MDA6MDYsIE1pY2hhxYIgTWlyb3PFgmF3IHdyb3RlOg0KPiBBbGxvdyB0
byBjdXQgZG93biBvbiBkcml2ZXIgc2l6ZSBmb3IgZW1iZWRkZWQgY29uZmlnLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPg0K
PiAtLS0NCj4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25maWcgIHwgMzcgKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL01ha2VmaWxl
IHwgMTIgKysrKystLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyks
IDE4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NoaXBpZGVh
L0tjb25maWcgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9LY29uZmlnDQo+IGluZGV4IGQ1M2RiNTIw
ZTIwOS4uOGJhZmNmYzYwODBkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9jaGlwaWRlYS9L
Y29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25maWcNCj4gQEAgLTE4LDE3
ICsxOCw2IEBAIGNvbmZpZyBVU0JfQ0hJUElERUENCj4gIA0KPiAgaWYgVVNCX0NISVBJREVBDQo+
ICANCj4gLWNvbmZpZyBVU0JfQ0hJUElERUFfT0YNCj4gLQl0cmlzdGF0ZQ0KPiAtCWRlcGVuZHMg
b24gT0YNCj4gLQlkZWZhdWx0IFVTQl9DSElQSURFQQ0KPiAtDQo+IC1jb25maWcgVVNCX0NISVBJ
REVBX1BDSQ0KPiAtCXRyaXN0YXRlDQo+IC0JZGVwZW5kcyBvbiBVU0JfUENJDQo+IC0JZGVwZW5k
cyBvbiBOT1BfVVNCX1hDRUlWDQo+IC0JZGVmYXVsdCBVU0JfQ0hJUElERUENCj4gLQ0KPiAgY29u
ZmlnIFVTQl9DSElQSURFQV9VREMNCj4gIAlib29sICJDaGlwSWRlYSBkZXZpY2UgY29udHJvbGxl
ciINCj4gIAlkZXBlbmRzIG9uIFVTQl9HQURHRVQNCj4gQEAgLTQzLDQgKzMyLDMwIEBAIGNvbmZp
ZyBVU0JfQ0hJUElERUFfSE9TVA0KPiAgCWhlbHANCj4gIAkgIFNheSBZIGhlcmUgdG8gZW5hYmxl
IGhvc3QgY29udHJvbGxlciBmdW5jdGlvbmFsaXR5IG9mIHRoZQ0KPiAgCSAgQ2hpcElkZWEgZHJp
dmVyLg0KPiArDQo+ICtjb25maWcgVVNCX0NISVBJREVBX1BDSQ0KPiArCXRyaXN0YXRlICJFbmFi
bGUgUENJIGdsdWUgZHJpdmVyIiBpZiBFTUJFRERFRA0KDQpXaHkgZGVwZW5kcyBvbiBFTUJFRERF
RCBmb3IgdGhpcyBkcml2ZXI/IE5vdCBldmVyeW9uZSBuZWVkcyB0aGlzDQpjb25maWd1cmF0aW9u
Lg0KDQpQZXRlcg0KPiArCWRlcGVuZHMgb24gVVNCX1BDSQ0KPiArCWRlcGVuZHMgb24gTk9QX1VT
Ql9YQ0VJVg0KPiArCWRlZmF1bHQgVVNCX0NISVBJREVBDQo+ICsNCj4gK2NvbmZpZyBVU0JfQ0hJ
UElERUFfTVNNDQo+ICsJdHJpc3RhdGUgIkVuYWJsZSBNU00gaHN1c2IgZ2x1ZSBkcml2ZXIiIGlm
IEVNQkVEREVEDQo+ICsJZGVmYXVsdCBVU0JfQ0hJUElERUENCj4gKw0KPiArY29uZmlnIFVTQl9D
SElQSURFQV9JTVgNCj4gKwl0cmlzdGF0ZSAiRW5hYmxlIGkuTVggVVNCIGdsdWUgZHJpdmVyIiBp
ZiBFTUJFRERFRA0KPiArCWRlcGVuZHMgb24gT0YNCj4gKwlkZWZhdWx0IFVTQl9DSElQSURFQQ0K
PiArDQo+ICtjb25maWcgVVNCX0NISVBJREVBX0dFTkVSSUMNCj4gKwl0cmlzdGF0ZSAiRW5hYmxl
IGdlbmVyaWMgVVNCMiBnbHVlIGRyaXZlciIgaWYgRU1CRURERUQNCj4gKwlkZWZhdWx0IFVTQl9D
SElQSURFQQ0KPiArDQo+ICtjb25maWcgVVNCX0NISVBJREVBX1RFR1JBDQo+ICsJdHJpc3RhdGUg
IkVuYWJsZSBUZWdyYSBVREMgZ2x1ZSBkcml2ZXIiIGlmIEVNQkVEREVEDQo+ICsJZGVwZW5kcyBv
biBPRg0KPiArCWRlcGVuZHMgb24gVVNCX0NISVBJREVBX1VEQw0KPiArCWRlZmF1bHQgVVNCX0NI
SVBJREVBDQo+ICsNCj4gIGVuZGlmDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jaGlwaWRl
YS9NYWtlZmlsZSBiL2RyaXZlcnMvdXNiL2NoaXBpZGVhL01ha2VmaWxlDQo+IGluZGV4IDk4NTY2
M2JhNmU2OC4uZmFlNzc5YTIzODY2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9jaGlwaWRl
YS9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9NYWtlZmlsZQ0KPiBAQCAt
OCwxMCArOCw4IEBAIGNpX2hkcmMtJChDT05GSUdfVVNCX09UR19GU00pCQkrPSBvdGdfZnNtLm8N
Cj4gIA0KPiAgIyBHbHVlL0JyaWRnZSBsYXllcnMgZ28gaGVyZQ0KPiAgDQo+IC1vYmotJChDT05G
SUdfVVNCX0NISVBJREVBKQkrPSBjaV9oZHJjX3VzYjIubw0KPiAtb2JqLSQoQ09ORklHX1VTQl9D
SElQSURFQSkJKz0gY2lfaGRyY19tc20ubw0KPiAtDQo+IC1vYmotJChDT05GSUdfVVNCX0NISVBJ
REVBX1BDSSkJKz0gY2lfaGRyY19wY2kubw0KPiAtDQo+IC1vYmotJChDT05GSUdfVVNCX0NISVBJ
REVBX09GKQkrPSB1c2JtaXNjX2lteC5vIGNpX2hkcmNfaW14Lm8NCj4gLW9iai0kKENPTkZJR19V
U0JfQ0hJUElERUFfT0YpCSs9IGNpX2hkcmNfdGVncmEubw0KPiArb2JqLSQoQ09ORklHX1VTQl9D
SElQSURFQV9HRU5FUklDKQkrPSBjaV9oZHJjX3VzYjIubw0KPiArb2JqLSQoQ09ORklHX1VTQl9D
SElQSURFQV9NU00pCQkrPSBjaV9oZHJjX21zbS5vDQo+ICtvYmotJChDT05GSUdfVVNCX0NISVBJ
REVBX1BDSSkJCSs9IGNpX2hkcmNfcGNpLm8NCj4gK29iai0kKENPTkZJR19VU0JfQ0hJUElERUFf
SU1YKQkJKz0gY2lfaGRyY19pbXgubyB1c2JtaXNjX2lteC5vDQo+ICtvYmotJChDT05GSUdfVVNC
X0NISVBJREVBX1RFR1JBKQkrPSBjaV9oZHJjX3RlZ3JhLm8NCj4gLS0gDQo+IDIuMjAuMQ0KPiAN
Cg0KLS0gDQoNClRoYW5rcywNClBldGVyIENoZW4=
