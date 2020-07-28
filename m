Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6CC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC1620792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YF4aJH5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgG1HuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:50:10 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:24006
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbgG1HuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:50:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE9Y029tA2teavld/TOID9SHaPbT4632VO8TFYlnnVHy+nA8mmqSdC3HCpMM/+6GP727RKYLFM4caRtGaZdl5qH8dnkB1BKnGxHFZmllu6cgRXzFvowaJKPJKVBCgTN1TThMiLUCLlFfGWISyNLDLT84ir1qttgYOQK67p2DNuFSiaKJHBSxqWtxaKEWcRcqR43UfMeoFzyn7T9yQWwtfrVwJmA4TZ7Bk+LSepfYVn1UkfW0vBGip4XVgSk1659ACEMLlsgsRUGXZoANgY1kSu3SgRVyXVn39D4sTkzkJZFnAurwHXz9z7w6T2X8hxAtn3EfvgIU3XgXhlKWeg+Qjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3sMgkkIIUKSIam+VxSicDlPscmfna31UE+2Wt+B/cw=;
 b=eDGa5hjiyVbmr5rD+dtlBigPcXIIokchlPXTvmycNd5fn4TalAb+Od5e7vLQLCuAnk6Ipy7LPV+nVcGlwYO2wChgD66Ogn9hrrQUqh11uYRXwIZA47rLI4WbKUHBBEbM7SJjBLJVUC68v6VuQn98kExO3fucUq9vMtwBSJjZR+U/qrGqZZ6LbeHmLn8T1vOPrnFqoeo/dk7b1k8kQCGNLRpbU3QXo4VjrUexQ9ZJ+PAYyoliufU31ahoGKDYuIY7EeuOh75MHiKOqW0zWU7q7CPqkwHPjf2WI5sGK1GQnBGCBtlS79VGtQVDbnumL5l/pmZBvtdiaCvoQoQoiwR/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3sMgkkIIUKSIam+VxSicDlPscmfna31UE+2Wt+B/cw=;
 b=YF4aJH5GQh8/64dceE0EFbYd6/4BL62Rm6+LZ4oYPDgC5mZyJOB6a6LU/BvILDE13WLKr+GNFVlFeWUK8a5XW1ifTY1cNlS1G9WBQzjzyNu6T5MZdMf+dOF4TbaUcmYiTHcXpXrHnTx5IoTYV7lnVucngG3n3SNvnkZwtyljN44=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Tue, 28 Jul
 2020 07:50:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 07:50:04 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early boot
Thread-Topic: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early
 boot
Thread-Index: AQHWYY4eiJ2SF2lCSU+quq5ttXjJ16ka/gOAgAAAWJCAABTmgIAAFqiggAFz5oCAAAW9cA==
Date:   Tue, 28 Jul 2020 07:50:04 +0000
Message-ID: <DB6PR0402MB27603441BEE037ECCB3F021088730@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200727063839.kfgrtperzkygvjr2@pengutronix.de>
 <DB6PR0402MB2760FBC0109E98A447BB716588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727075441.lgscydoj3txupeay@pengutronix.de>
 <DB6PR0402MB27605640244CE751317E6DE888720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200728072651.zcflghll4wa7rm55@pengutronix.de>
In-Reply-To: <20200728072651.zcflghll4wa7rm55@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01b9b0ba-bcd0-4258-17cf-08d832cad74b
x-ms-traffictypediagnostic: DB7PR04MB4089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4089A7C5C676F7BBB1172CEF88730@DB7PR04MB4089.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLs0atdhOzcyK5MB6tetZxRqL1v1TnJUNIhL81k5TNb26SQeYOs0CMKej/l7YfNntTrhLOKtTf1eaQFihrVcKgEw8gjaK58e3h2gAcgUbq9fGO7bhGykqneWuuLFnoSMKtVIYCMq1UY2fUq+I4jN5TCZvUBlDiJ1OJ1VemEs7/7zuGi6fjpNp7PgDIu9RQghJGkl/8enVCYGXljJ8Jnf3NwgIWeB6qPN0RsAGyzNz9Q+k/8quUVoQlHZjEFq6cT3orqFy8WIzMudMXXaa+F5/txRmskipho8i/d0gXvm/r2qzMc5K+9NuTx7wy9aojR+03LM0RjgUJiPEZvoYCdW+aZOVDYAafSZyHcsSOiCY/TRDSHfJwi2L1NUrXIrPbUL7j933diYRqGCXxrS4E/x9H3VDrZK/uSG1ptxP3RchSCHWeiqkHCmdpb479Breeo9dyVN59PXmlZQH7KAK/G9FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(86362001)(83080400001)(8936002)(478600001)(6506007)(6916009)(186003)(4326008)(7696005)(5660300002)(54906003)(33656002)(26005)(71200400001)(2906002)(8676002)(7416002)(66446008)(64756008)(66556008)(66476007)(66946007)(966005)(76116006)(52536014)(9686003)(316002)(44832011)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: o+GT9Nk6e0KGDoNEWrT9N33Xg/GPMidnbO9eoDDQ18K5LUZmcuKAljzdqtrlZAKkgG4wQ97KfUzy2112ve9K+pJWFVv5176JzuQJ1QfBc78et4ETwUGyOahpXFD24xmar5M9GwK7btknGH07LeXsHzXVej1y1mNkGFx08S3POYI/1aPxE+AG1iDIEs2tiFrfY86i5N6WVBixJgGmMFuSM2Ig/dQS/iqBQ7Lnh9ix66fnw0VGkihO91gJ5qiB508prKhsVUfX4/tGsp+5N2cVwnsDEz0brfy6mxGhhRe3hLWwpuHvosVG7HIwQZJ3n2gej4Wak77G7B0oZDCS0eli1hllfi9fQfic3XYRk6U8bGvkUjcNqLwTEhO7NM7yQm+KFYvKdz7HmOW9SfYLXhJRDI8uCw0kpIXTUtrAaUsbjTUmmfjMzhrkQ+J6wMyrXuDxl/I1fxko+RIfDl/I96TxVAZUT4Pa6roDtSwjXIX/pSg5U6DiMGkzwuiyMGH5VVe7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b9b0ba-bcd0-4258-17cf-08d832cad74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 07:50:04.8591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UDFtC+3Yy0AqRrpEBpytzqtyesUTa3bo4YHDVk2/dhXDfjD2U3Hnt+3hdDBTvaHPI0apaI/KpA86VgAQ+Wb9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEwXSByZW1vdGVwcm9jOiBpbXhfcnByb2M6IHN1cHBv
cnQgaU1YOE0gYW5kIGVhcmx5DQo+IGJvb3QNCj4gDQo+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0
IDA5OjE4OjMxQU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCAwMC8xMF0gcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBzdXBwb3J0IGlNWDhNIGFuZA0KPiA+
ID4gZWFybHkgYm9vdA0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDA2OjQ0
OjMyQU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gPiBIaSBPbGVrc2lqLA0KPiA+ID4g
Pg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTBdIHJlbW90ZXByb2M6IGlteF9y
cHJvYzogc3VwcG9ydCBpTVg4TQ0KPiA+ID4gPiA+IGFuZCBlYXJseSBib290DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBIaSwNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIEZyaSwgSnVsIDI0LCAyMDIw
IGF0IDA0OjA4OjAzUE0gKzA4MDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gPiA+ID4gVGhpcyBw
YXRjaHNldCBpcyB0byBzdXBwb3J0IGkuTVg4TVEvTSBjb3Byb2MgYm9vdGVkIGJlZm9yZSBsaW51
eC4NCj4gPiA+ID4gPiA+IFNpbmNlIGkuTVg4TVEvTSB3YXMgbm90IHN1cHBvcnRlZCwgc2V2ZXJh
bCBwYXRjaGVzIGFyZSBuZWVkZWQNCj4gPiA+ID4gPiA+IHRvIGZpcnN0IHN1cHBvcnQgdGhlIHBs
YXRmb3JtLCB0aGVuIHN1cHBvcnQgZWFybHkgYm9vdCBjYXNlLg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IEkgaW50ZW5kZWQgdG8gaW5jbHVkZWQgaS5NWDhRTS9RWFAsIGJ1dCB0aGF0IHdvdWxk
IGludHJvZHVjZSBhDQo+ID4gPiA+ID4gPiBsYXJnZSBwYXRjaHNldCwgc28gbm90IGluY2x1ZGVk
LiBCdXQgdGhlIGNsay9zeXNjb24gb3B0aW9uYWwNCj4gPiA+ID4gPiA+IHBhdGNoIGZvciBpLk1Y
OFFNL1FYUCB3YXMgc3RpbGwga2VwdCBoZXJlIHRvIGF2b2lkIHJlYmFzZSBlcnJvci4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IFRoYW5rIHlvdSBmb3IgeW91ciB3b3JrLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGJpZyBw
aWN0dXJlIG9mIHRoaXMNCj4gd29yay4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElmIEkgc2VlIGl0
IGNvcnJlY3RseSwgd2UgaGF2ZSBoZXJlIHN1cHBvcnQgZm9yIGkuTVg4TU0sIHdoaWNoDQo+ID4g
PiA+ID4gc2VlbXMgdG8gYmUgYWJsZSB0byBmdWxseSBjb250cm9sIENvcnRleCBNNCAoZW5hYmxl
IENQVSBjb3JlLCBldGMuLi4pLg0KPiA+ID4gPg0KPiA+ID4gPiBZZXMuDQo+ID4gPg0KPiA+ID4g
SW4gdGhpcyBjYXNlLCBJIHdvdWxkIHJlY29tbWVuZCB0byBtYWlubGluZSB0aGUgaS5NWDhNTSBw
YXJ0DQo+ID4gPiBmaXJzdC9zZXBhcmF0ZWx5Lg0KPiA+DQo+ID4gT25seSB0aGUgbGFzdCBwYXRj
aCBpcyB0byBzdXBwb3J0IGVhcmx5Ym9vdCwgYWxsIG90aGVycyBpcyBpbXg4bW0gcGFydC4NCj4g
DQo+IG9rDQo+IA0KPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFuZCBvdGhlciBjYXNlLCB3
aGVyZSByZW1vdGVwcm9jIGlzIHJ1bm5pbmcgb24gYXBwbGljYXRpb24NCj4gPiA+ID4gPiBwcm9j
ZXNzb3IgYW5kIGNhbid0IG9yIHNob3VsZCBub3QgdG91Y2ggTTQgKGkuTVg3VUxQLA0KPiA+ID4g
PiA+IGkuTVg4UU0vUVhQLi4pLiBTaW5jZSBNNCBwcm92aWRlcyBzb21lIGZ1bmN0aW9uYWxpdHks
IHlvdSBhcmUNCj4gPiA+ID4gPiB0cnlpbmcgdG8gcmV1c2UgcmVtb3RlcHJvYyBmcmFtZXdvcmsg
dG8gZ2V0IHJlc291cmNlIHRhYmxlDQo+ID4gPiA+ID4gcHJlc2VudCBpbiBFTEYgaGVhZGVyIGFu
ZCB0byBkeW5hbWljYWxseSBsb2FkIHRoaW5ncy4gRm9yIHNvbWUNCj4gPiA+ID4gPiByZWFzb25z
IHRoaXMgaGVhZGVyIHByb3ZpZGVzIG1vcmUgaW5mb3JtYXRpb24gdGhlbiBuZWVkZWQsIHNvDQo+
ID4gPiA+ID4geW91IGFyZSBjaGFuZ2luZyB0aGUgRUxGIHBhcnNlciBpbiB0aGUga2VybmVsDQo+
ID4gPiB0byB3b3JrYXJvdW5kIGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBOb3QgZXhhY3RseS4NCj4g
PiA+ID4NCj4gPiA+ID4gRm9yIGkuTVg4TU0sIHdlIHN1cHBvcnQgdHdvIGNhc2VzLiBNNCBraWNr
ZWQgYnkgVS1Cb290LCBNNCBraWNrZWQNCj4gPiA+ID4gYnkNCj4gPiA+IExpbnV4IHJlbW90ZXBy
b2MuDQo+ID4gPiA+IEZvciBpLk1YOFFNL1FYUCwgdGhlIHR5cGljYWwgdXNlY2FzZSBpcyBNNCBr
aWNrZWQgYnkgU0NGVywgYnV0IHdlDQo+ID4gPiA+IHdpbGwgYWxzbyBhZGQgTTQga2lja2VkIGJ5
IExpbnV4IHJlbW90ZXByb2MuDQo+ID4gPiA+IEZvciBpLk1YN1VMUCwgSSB3b3VsZCBvbmx5IHN1
cHBvcnQgTTQgZHVhbCBib290IGNhc2UsIE00IGNvbnRyb2wNCj4gPiA+IGV2ZXJ5dGhpbmcuDQo+
ID4gPg0KPiA+ID4gRnJvbSBjdXJyZW50IHN0YXRlIG9mIGRpc2N1c3Npb24sIGknbSBub3Qgc3Vy
ZSB3aGF0IHJvbGUgcGxheXMNCj4gPiA+IHJlbW90ZXByb2MgaW4gdGhlIHNjZW5hcmlvIHdoZXJl
IE00IGlzIHN0YXJ0ZWQgYmVmb3JlIGxpbnV4Lg0KPiA+ID4gRXNwZWNpYWxseSBpZiB3ZSBhcmUg
bm90IHVzaW5nIHJlc291cmNlIHRhYmxlLg0KPiA+DQo+ID4gV2UgYXJlIHVzaW5nIHJlc291cmNl
IHRhYmxlIGZyb20gYW4gYWRkcmVzcywgbm90IGluIGVsZiBmaWxlLg0KPiA+IFRoaXMgaXMgdGhl
IG5ldyBmZWF0dXJlIGluIExpbnV4LW5leHQgdG8gc3VwcG9ydCBjb3Byb2MgYm9vdGVkIGVhcmx5
Lg0KPiA+DQo+ID4gPg0KPiA+ID4gPiBUaGUgcmVhc29uIHRoZSBjaGFuZ2UgdGhlIGVsZiBwYXJz
ZXIgaXMgdGhhdCB3aGVuIE00IGVsZiBpcyBsb2FkZWQNCj4gPiA+ID4gYnkgTGludXggcmVtb3Rl
cHJvYywgSXQgdXNlIG1lbXNldCB0byBjbGVhciBhcmVhLg0KPiA+ID4NCj4gPiA+IFRoZSB1c2Ug
b2YgbWVtc2V0LCBkZXBlbmRzIG9uIEVMRiBmb3JtYXQuIEZpeC9jaGFuZ2UgdGhlIGxpbmtlcg0K
PiA+ID4gc2NyaXB0IG9uIHlvdXIgZmlybXdhcmUgYW5kIG1lbXNldCB3aWxsIGJlIG5ldmVyIGNh
bGxlZC4NCj4gPiA+DQo+ID4gPiA+IEhvd2V2ZXIgd2UgdXNlIGlvcmVtYXAsIG1lbXNldCBvbiBB
Uk02NCB3aWxsIHJlcG9ydCBjcmFzaCB0bw0KPiA+ID4gPiBkZXZpY2UgbkduUkUgbWVtb3J5LiBB
bmQgd2UgY291bGQgbm90IHVzZSBpb3JlbWFwX3djIHRvIFRDTSBhcmVhLA0KPiA+ID4gPiBzaW5j
ZSBpdCBjb3VsZCBoYXZlIGRhdGEgY29ycmVjdGx5IHdyaXR0ZW4gaW50byBUQ00uDQo+ID4gPg0K
PiA+ID4gSSBoYXZlIHN0cm9uZyBmZWVsaW5nLCB0aGF0IHdlIGFyZSB0YWxraW5nIGFib3V0IGJh
ZGx5IG9yIG5vdA0KPiA+ID4gcHJvcGVybHkgZm9ybWF0dGVkIEVMRiBiaW5hcnkuIEkgd291bGQg
cHJlZmVyIHRvIGRvdWJsZSBjaGVjayBpdCwNCj4gPiA+IGJlZm9yZSB3ZSB3aWxsIGFwcGx5IGZp
eGVzIG9uIHdyb25nIHBsYWNlLg0KPiA+ID4NCj4gPiA+ID4gTWFpbnRhaW5lciBub3Qgd2FubmEg
dG8gZHJvcCBtZW1zZXQgaW4gY29tbW9uIGNvZGUsIGFuZCBUSSBndXlzDQo+ID4gPiA+IHN1Z2dl
c3QgYWRkIGkuTVggc3BlY2lmaWMgZWxmIHN0dWZmLiBTbyBJIGFkZCBlbGYgaGFuZGxlciBpbiBp
Lk1YIGNvZGUuDQo+ID4gPg0KPiA+ID4gSSB0aGluaywgcmVtb3ZpbmcgbWVtc2V0IG1heSBkYW1h
Z2UgY3VycmVudCB1c2VycyBvZiBpbXhfcnByb2MgZHJpdmVyLg0KPiA+ID4gU2luY2UsIGxpa2Ug
SSBzYWlkOiB0aGUgdXNlIG9mIG1lbXNldCBkZXBlbmRzIG9uIEVMRiBmb3JtYXQuDQo+ID4NCj4g
PiBJbiBteSBlbGYgZmlsZSwgdGhlIGxhc3QgUFRfTE9BRCBjb250YWlucyBkYXRhL2Jzcy9oZWFw
L3N0YWNrLiBJJ2xsDQo+ID4gY2hlY2sgd2l0aCBvdXIgTUNVIGd1eXMsIHdlIG9ubHkgbmVlZCB0
aGUgc3BlY2lmaWMgZGF0YSBsb2FkZWQuDQo+ID4NCj4gPiBFbGYgZmlsZSB0eXBlIGlzIEVYRUMg
KEV4ZWN1dGFibGUgZmlsZSkgRW50cnkgcG9pbnQgMHgxZmZlMDM1NSBUaGVyZQ0KPiA+IGFyZSAz
IHByb2dyYW0gaGVhZGVycywgc3RhcnRpbmcgYXQgb2Zmc2V0IDUyDQo+ID4NCj4gPiBQcm9ncmFt
IEhlYWRlcnM6DQo+ID4gICBUeXBlICAgICAgICAgICBPZmZzZXQgICBWaXJ0QWRkciAgIFBoeXNB
ZGRyICAgRmlsZVNpeiBNZW1TaXoNCj4gRmxnIEFsaWduDQo+ID4gICBMT0FEICAgICAgICAgICAw
eDAxMDAwMCAweDFmZmUwMDAwIDB4MWZmZTAwMDAgMHgwMDI0MCAweDAwMjQwDQo+IFIgICAweDEw
MDAwDQo+ID4gICBMT0FEICAgICAgICAgICAweDAxMDI0MCAweDFmZmUwMjQwIDB4MWZmZTAyNDAg
MHgwM2U5MCAweDAzZTkwDQo+IFJXRSAweDEwMDAwDQo+ID4gICBMT0FEICAgICAgICAgICAweDAy
MDAwMCAweDIwMDAwMDAwIDB4MWZmZTQwZDAgMHgwMDA2OCAweDBhZDAwDQo+IFJXICAweDEwMDAw
DQo+ID4NCj4gPiAgU2VjdGlvbiB0byBTZWdtZW50IG1hcHBpbmc6DQo+ID4gICBTZWdtZW50IFNl
Y3Rpb25zLi4uDQo+ID4gICAgMDAgICAgIC5pbnRlcnJ1cHRzDQo+ID4gICAgMDEgICAgIC5yZXNv
dXJjZV90YWJsZSAudGV4dCAuQVJNIC5pbml0X2FycmF5IC5maW5pX2FycmF5DQo+ID4gICAgMDIg
ICAgIC5kYXRhIC5ic3MgLmhlYXAgLnN0YWNrDQo+IA0KPiBIZXJlIGlzIGFuIGV4YW1wbGUgb2Yg
Zm9ybWF0dGluZyBFTEYgZm9yIHJlbW90ZXByb2M6DQo+IGh0dHBzOi8vZ2l0LnBlbmd1dHJvbml4
LmRlL2NnaXQvb3JlL09TRUxBUy5CU1AtUGVuZ3V0cm9uaXgtRHVhbEtpdC90cmVlL2xvYw0KPiBh
bF9zcmMvcmVtb3RlcHJvYy1lbGYvbGlua2VyLmxkDQo+IGh0dHBzOi8vZ2l0LnBlbmd1dHJvbml4
LmRlL2NnaXQvb3JlL09TRUxBUy5CU1AtUGVuZ3V0cm9uaXgtRHVhbEtpdC90cmVlL2xvYw0KPiBh
bF9zcmMvcmVtb3RlcHJvYy1lbGYvaW14N200LlMNCj4gDQo+IEluIHRoaXMgZXhhbXBsZSBJIHBh
Y2sgbGludXggaW4gdG8gcmVtb3RlcHJvYyBlbGYgaW1hZ2UgYW5kIHN0YXJ0IGxpbnV4IG9uDQo+
IGlteDdkLW00IHBhcnQuDQo+IFdpbGwgYmUgaW50ZXJlc3RpbmcgaWYgeW91IGNhbiBkbyB0aGUg
c2FtZSBvbiBpbXg4KiBTb0NzIDspDQoNCkluIE5YUCByZWxlYXNlLCB0aGUgbTQgZWxmIGZpbGVz
IGhhdmUgZGF0YS9ic3MvaGVhcC9zdGFjayBpbiB0aGUgc2FtZQ0KZGF0YSBhcmVhLCBzbyB0aGUg
bGlua2VyIG1lcmdlZCB0aGVtIGludG8gb25lIHNlZ21lbnQgYW5kIGNhdXNlDQptZW1zeiA+IGZp
bGVzei4NCg0KSSB0aGluayBJIG5lZWQgdG8gcHJvcG9zZSBwbGF0Zm9ybSBzcGVjaWZpYyBlbGYg
bWVtc2V0L21lbWNweSwNCnN1Y2ggYXMgcnByb2NfZWxmX21lbWNweSwgcnByb2NfZWxmX21lbXNl
dCwNCg0KVG8gaS5NWCwgbmVlZCB1c2UgbWVtc2V0X2lvIGFuZCBtZW1jcHlfdG9pbywgdGFraW5n
IFRDTQ0KYXMgZGV2aWNlIG1lbW9yeS4NCg0KTm90ZTogbWVtc2V0IHdpdGhvdXQgaW8gd2lsbCBj
YXVzZSBhYm9ydCB3aGVuIG1lbXN6PmZpbGVzei4NClNvIHVzZSBtZW1zZXRfaW8gaXMgc2FmZS4N
Cg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gUmVnYXJkcywNCj4gT2xla3Npag0KPiAtLQ0KPiBQ
ZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiB8DQo+IFN0ZXVl
cndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAgICAgICAgICB8DQo+IGh0dHA6Ly93d3cucGVu
Z3V0cm9uaXguZGUvICB8DQo+IDMxMTM3IEhpbGRlc2hlaW0sIEdlcm1hbnkgICAgICAgICAgICAg
ICAgICB8IFBob25lOg0KPiArNDktNTEyMS0yMDY5MTctMCAgICB8DQo+IEFtdHNnZXJpY2h0IEhp
bGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8IEZheDoNCj4gKzQ5LTUxMjEtMjA2OTE3LTU1
NTUgfA0K
