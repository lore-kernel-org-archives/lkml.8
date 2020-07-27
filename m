Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDDDC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F22E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g9Uy/93V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgG0JSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:18:36 -0400
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:5562
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbgG0JSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhDPYu+Da9uirHrIllS8rE8eeoWdCu5dJEDeWUoyU7rdBPT0xeQAo15aF8SQFOzZxfGzQYWHH4cALXUBbZK1yB40ELz/CbrTKZETiE1ZMtpwxygMHa8arcAMWNkpxa+mznMp1g28x69o1goxat+gom9Lomj05V/zTXukwvZV3sfiDQwWcLPXHrkmJhldjifSWx+k+ay3VFWaQsepWidwlcMlbxMnXag3uQO5G1+mllPZNml1Q5NtdcWg7mwXnosfe9/mMDF2B9s4CpLigPfMj2awZbduXcIjJDy9Ouq1L1U7CAhqCX0VGHVR8YjTBsnDlVZ5WdGyIpXmznSYyUWlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Lzeqa93p+X/h5Y4RUQeKFeGL0w6THTbKr+YPyINJ50=;
 b=NiLyB229ilt7dXesVeuph7nTRBchw98OV40ivL6rIt0Ny5HbG4uHoAtatV7upNlrMaGhdHYqCOfRJYd3PUTkQvxRdITKEv9xvcojP+nud+Qp1qal0kK6CTVgnWGfjMsspzuyvNf/+zbFu0qLH0aAAUPfj5RhTZHgu+fHsY191cxEummcPQMeQIpEMslDNcTkLtUkSYksiRIagPw0miN7lxo1Qouiqp4YWlWDGau+BlZJImuk5Ha0jdLwnOyVRPUts539t2GbyRZBLia6i9aPub84jWHVLYfyjujeolvGjXyWHnZOVD4qLAwn6JLZTGlujyw2cgfSulqKF+8jCPhNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Lzeqa93p+X/h5Y4RUQeKFeGL0w6THTbKr+YPyINJ50=;
 b=g9Uy/93VvAxah1ddNbgeBiFI+pd6l3P9EeL8rZ4A3ISWYMH/9l21N7N5yKcdGvbfsou1vlvYjrmUNy7adFFcBOjpmd23gyrRdxZwruDiBaHteL9pxdcmwmV4m7FOmuWqGQcjuJitG1bM+9cYa3uhT+NSggH4mZEYhhk2F3iVWgY=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6684.eurprd04.prod.outlook.com (2603:10a6:10:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Mon, 27 Jul
 2020 09:18:31 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 09:18:31 +0000
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
Thread-Index: AQHWYY4eiJ2SF2lCSU+quq5ttXjJ16ka/gOAgAAAWJCAABTmgIAAFqig
Date:   Mon, 27 Jul 2020 09:18:31 +0000
Message-ID: <DB6PR0402MB27605640244CE751317E6DE888720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200727063839.kfgrtperzkygvjr2@pengutronix.de>
 <DB6PR0402MB2760FBC0109E98A447BB716588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727075441.lgscydoj3txupeay@pengutronix.de>
In-Reply-To: <20200727075441.lgscydoj3txupeay@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a223ba01-2eae-4972-1641-08d8320e07bb
x-ms-traffictypediagnostic: DB8PR04MB6684:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6684AE2F933859FD5B6D21C188720@DB8PR04MB6684.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1NUNF6wBdbNmhh+oHaIjHleDo+fxj1HRYbjzKlf6teoze0FwfhZJpuGILd3Y7Zz42ojdoJtk1Z9kzrw9Fy/ToGlavOwO/Qa7m38oKLTob10jJ9+G8tCHeLGggoAoADd/M6iJIlWqbJqJJ9/g7cnwcBEgV8NjjoMCTbLmajN083E1D0pYrfxLBwOASf5x3iCo4ohX5PfVSGizuw4Txhkv8lePvINwOqiTkkx7vRrgACxppjXox5qhAqdM/LEh613e3jacukh2GisVd9dtnk/6hkqufNH4ywMNIyG5j62mdNfu4LM0ejDjEshzQigC/dbrFErvd7q27TcyWRBaF8yXAwLgf5I5U4/XVhcEunqs4Kx8LYFuL4KiLfVEuw5z5jUBYAZs6xmBZZxvRp7DX85ldWwCSKZAK4g4fAlbSmyXQIlkow83OYo95opamiwzexSa978x+TOezmMqqp4MRca8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(83080400001)(66946007)(83380400001)(86362001)(76116006)(2906002)(316002)(6916009)(4326008)(7696005)(71200400001)(6506007)(8936002)(33656002)(66446008)(64756008)(66556008)(66476007)(8676002)(7416002)(44832011)(5660300002)(26005)(54906003)(55016002)(966005)(478600001)(9686003)(52536014)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2J6iRr/RHN2D2SqkqAg9ENaajAsuDJWEv+XswZJ8xgr9hw/hw1jvJQuPdVLFQlQFzkcdpSvT46bpwQllDs2yw6lCa51xY+UwR6Iaw6tdPHw29jL3Qxl9ySYxcSIMLmaIRZj9VixcDqobaN9kecbdhviMZ0nmYTgmaGUmuSSHcR3EJqY7mpcN5U3GlZgOC9B1+C29uoUMFB6vxt0ouMzKoUPG5jwu5sL1ICEKkemqFsJNe36kU/tQJmY8Zy0enkZ5CZmYkBLhquhdXHUwcxYnW1ExGdqbi99t1s4s3xr6/5fvdsbE/axgw5GxoB/j2C+ewuSWfHjPGEVMMYY58v0BhmM32Ikv6URc/fS/m33poZ69rT5iqZk5HDkpzRCX2D3Cjmb6D5C1J5sDXm/hT04UBzey1XoxWGd1X6jsdeyeCOhdMzXLpykoNzsmmYu+59a5feG7V2jE+gjXmCcKqdiF3qD/Hj295Wk8PTlEbkxsJj2vdDgtZqmLrN2lRb9iTTAc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a223ba01-2eae-4972-1641-08d8320e07bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 09:18:31.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiMIii+VO7FKSvYsspCbtF0jy855dscll6VuNdjs28I3zD7prAb05Wq07vpsdvy6zwpYGoyY0uqjo+EmIglPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEwXSByZW1vdGVwcm9jOiBpbXhfcnByb2M6IHN1cHBv
cnQgaU1YOE0gYW5kIGVhcmx5DQo+IGJvb3QNCj4gDQo+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0
IDA2OjQ0OjMyQU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+IEhpIE9sZWtzaWosDQo+ID4N
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTBdIHJlbW90ZXByb2M6IGlteF9ycHJvYzog
c3VwcG9ydCBpTVg4TSBhbmQNCj4gPiA+IGVhcmx5IGJvb3QNCj4gPiA+DQo+ID4gPiBIaSwNCj4g
PiA+DQo+ID4gPiBPbiBGcmksIEp1bCAyNCwgMjAyMCBhdCAwNDowODowM1BNICswODAwLCBQZW5n
IEZhbiB3cm90ZToNCj4gPiA+ID4gVGhpcyBwYXRjaHNldCBpcyB0byBzdXBwb3J0IGkuTVg4TVEv
TSBjb3Byb2MgYm9vdGVkIGJlZm9yZSBsaW51eC4NCj4gPiA+ID4gU2luY2UgaS5NWDhNUS9NIHdh
cyBub3Qgc3VwcG9ydGVkLCBzZXZlcmFsIHBhdGNoZXMgYXJlIG5lZWRlZCB0bw0KPiA+ID4gPiBm
aXJzdCBzdXBwb3J0IHRoZSBwbGF0Zm9ybSwgdGhlbiBzdXBwb3J0IGVhcmx5IGJvb3QgY2FzZS4N
Cj4gPiA+ID4NCj4gPiA+ID4gSSBpbnRlbmRlZCB0byBpbmNsdWRlZCBpLk1YOFFNL1FYUCwgYnV0
IHRoYXQgd291bGQgaW50cm9kdWNlIGENCj4gPiA+ID4gbGFyZ2UgcGF0Y2hzZXQsIHNvIG5vdCBp
bmNsdWRlZC4gQnV0IHRoZSBjbGsvc3lzY29uIG9wdGlvbmFsIHBhdGNoDQo+ID4gPiA+IGZvciBp
Lk1YOFFNL1FYUCB3YXMgc3RpbGwga2VwdCBoZXJlIHRvIGF2b2lkIHJlYmFzZSBlcnJvci4NCj4g
PiA+DQo+ID4gPiBUaGFuayB5b3UgZm9yIHlvdXIgd29yay4NCj4gPiA+DQo+ID4gPiBDYW4geW91
IHBsZWFzZSBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgYmlnIHBpY3R1cmUgb2YgdGhp
cyB3b3JrLg0KPiA+ID4NCj4gPiA+IElmIEkgc2VlIGl0IGNvcnJlY3RseSwgd2UgaGF2ZSBoZXJl
IHN1cHBvcnQgZm9yIGkuTVg4TU0sIHdoaWNoIHNlZW1zDQo+ID4gPiB0byBiZSBhYmxlIHRvIGZ1
bGx5IGNvbnRyb2wgQ29ydGV4IE00IChlbmFibGUgQ1BVIGNvcmUsIGV0Yy4uLikuDQo+ID4NCj4g
PiBZZXMuDQo+IA0KPiBJbiB0aGlzIGNhc2UsIEkgd291bGQgcmVjb21tZW5kIHRvIG1haW5saW5l
IHRoZSBpLk1YOE1NIHBhcnQNCj4gZmlyc3Qvc2VwYXJhdGVseS4NCg0KT25seSB0aGUgbGFzdCBw
YXRjaCBpcyB0byBzdXBwb3J0IGVhcmx5Ym9vdCwgYWxsIG90aGVycyBpcyBpbXg4bW0gcGFydC4N
Cg0KPiANCj4gPiA+DQo+ID4gPiBBbmQgb3RoZXIgY2FzZSwgd2hlcmUgcmVtb3RlcHJvYyBpcyBy
dW5uaW5nIG9uIGFwcGxpY2F0aW9uIHByb2Nlc3Nvcg0KPiA+ID4gYW5kIGNhbid0IG9yIHNob3Vs
ZCBub3QgdG91Y2ggTTQgKGkuTVg3VUxQLCBpLk1YOFFNL1FYUC4uKS4gU2luY2UgTTQNCj4gPiA+
IHByb3ZpZGVzIHNvbWUgZnVuY3Rpb25hbGl0eSwgeW91IGFyZSB0cnlpbmcgdG8gcmV1c2UgcmVt
b3RlcHJvYw0KPiA+ID4gZnJhbWV3b3JrIHRvIGdldCByZXNvdXJjZSB0YWJsZSBwcmVzZW50IGlu
IEVMRiBoZWFkZXIgYW5kIHRvDQo+ID4gPiBkeW5hbWljYWxseSBsb2FkIHRoaW5ncy4gRm9yIHNv
bWUgcmVhc29ucyB0aGlzIGhlYWRlciBwcm92aWRlcyBtb3JlDQo+ID4gPiBpbmZvcm1hdGlvbiB0
aGVuIG5lZWRlZCwgc28geW91IGFyZSBjaGFuZ2luZyB0aGUgRUxGIHBhcnNlciBpbiB0aGUga2Vy
bmVsDQo+IHRvIHdvcmthcm91bmQgaXQuDQo+ID4NCj4gPiBOb3QgZXhhY3RseS4NCj4gPg0KPiA+
IEZvciBpLk1YOE1NLCB3ZSBzdXBwb3J0IHR3byBjYXNlcy4gTTQga2lja2VkIGJ5IFUtQm9vdCwg
TTQga2lja2VkIGJ5DQo+IExpbnV4IHJlbW90ZXByb2MuDQo+ID4gRm9yIGkuTVg4UU0vUVhQLCB0
aGUgdHlwaWNhbCB1c2VjYXNlIGlzIE00IGtpY2tlZCBieSBTQ0ZXLCBidXQgd2Ugd2lsbA0KPiA+
IGFsc28gYWRkIE00IGtpY2tlZCBieSBMaW51eCByZW1vdGVwcm9jLg0KPiA+IEZvciBpLk1YN1VM
UCwgSSB3b3VsZCBvbmx5IHN1cHBvcnQgTTQgZHVhbCBib290IGNhc2UsIE00IGNvbnRyb2wNCj4g
ZXZlcnl0aGluZy4NCj4gDQo+IEZyb20gY3VycmVudCBzdGF0ZSBvZiBkaXNjdXNzaW9uLCBpJ20g
bm90IHN1cmUgd2hhdCByb2xlIHBsYXlzIHJlbW90ZXByb2MgaW4NCj4gdGhlIHNjZW5hcmlvIHdo
ZXJlIE00IGlzIHN0YXJ0ZWQgYmVmb3JlIGxpbnV4LiBFc3BlY2lhbGx5IGlmIHdlIGFyZSBub3Qg
dXNpbmcNCj4gcmVzb3VyY2UgdGFibGUuDQoNCldlIGFyZSB1c2luZyByZXNvdXJjZSB0YWJsZSBm
cm9tIGFuIGFkZHJlc3MsIG5vdCBpbiBlbGYgZmlsZS4NClRoaXMgaXMgdGhlIG5ldyBmZWF0dXJl
IGluIExpbnV4LW5leHQgdG8gc3VwcG9ydCBjb3Byb2MgYm9vdGVkIGVhcmx5Lg0KDQo+IA0KPiA+
IFRoZSByZWFzb24gdGhlIGNoYW5nZSB0aGUgZWxmIHBhcnNlciBpcyB0aGF0IHdoZW4gTTQgZWxm
IGlzIGxvYWRlZCBieQ0KPiA+IExpbnV4IHJlbW90ZXByb2MsIEl0IHVzZSBtZW1zZXQgdG8gY2xl
YXIgYXJlYS4NCj4gDQo+IFRoZSB1c2Ugb2YgbWVtc2V0LCBkZXBlbmRzIG9uIEVMRiBmb3JtYXQu
IEZpeC9jaGFuZ2UgdGhlIGxpbmtlciBzY3JpcHQgb24NCj4geW91ciBmaXJtd2FyZSBhbmQgbWVt
c2V0IHdpbGwgYmUgbmV2ZXIgY2FsbGVkLg0KPiANCj4gPiBIb3dldmVyIHdlIHVzZSBpb3JlbWFw
LCBtZW1zZXQgb24gQVJNNjQgd2lsbCByZXBvcnQgY3Jhc2ggdG8gZGV2aWNlDQo+ID4gbkduUkUg
bWVtb3J5LiBBbmQgd2UgY291bGQgbm90IHVzZSBpb3JlbWFwX3djIHRvIFRDTSBhcmVhLCBzaW5j
ZSBpdA0KPiA+IGNvdWxkIGhhdmUgZGF0YSBjb3JyZWN0bHkgd3JpdHRlbiBpbnRvIFRDTS4NCj4g
DQo+IEkgaGF2ZSBzdHJvbmcgZmVlbGluZywgdGhhdCB3ZSBhcmUgdGFsa2luZyBhYm91dCBiYWRs
eSBvciBub3QgcHJvcGVybHkNCj4gZm9ybWF0dGVkIEVMRiBiaW5hcnkuIEkgd291bGQgcHJlZmVy
IHRvIGRvdWJsZSBjaGVjayBpdCwgYmVmb3JlIHdlIHdpbGwgYXBwbHkNCj4gZml4ZXMgb24gd3Jv
bmcgcGxhY2UuDQo+IA0KPiA+IE1haW50YWluZXIgbm90IHdhbm5hIHRvIGRyb3AgbWVtc2V0IGlu
IGNvbW1vbiBjb2RlLCBhbmQgVEkgZ3V5cw0KPiA+IHN1Z2dlc3QgYWRkIGkuTVggc3BlY2lmaWMg
ZWxmIHN0dWZmLiBTbyBJIGFkZCBlbGYgaGFuZGxlciBpbiBpLk1YIGNvZGUuDQo+IA0KPiBJIHRo
aW5rLCByZW1vdmluZyBtZW1zZXQgbWF5IGRhbWFnZSBjdXJyZW50IHVzZXJzIG9mIGlteF9ycHJv
YyBkcml2ZXIuDQo+IFNpbmNlLCBsaWtlIEkgc2FpZDogdGhlIHVzZSBvZiBtZW1zZXQgZGVwZW5k
cyBvbiBFTEYgZm9ybWF0Lg0KDQpJbiBteSBlbGYgZmlsZSwgdGhlIGxhc3QgUFRfTE9BRCBjb250
YWlucyBkYXRhL2Jzcy9oZWFwL3N0YWNrLiBJJ2xsIGNoZWNrDQp3aXRoIG91ciBNQ1UgZ3V5cywg
d2Ugb25seSBuZWVkIHRoZSBzcGVjaWZpYyBkYXRhIGxvYWRlZC4NCg0KRWxmIGZpbGUgdHlwZSBp
cyBFWEVDIChFeGVjdXRhYmxlIGZpbGUpDQpFbnRyeSBwb2ludCAweDFmZmUwMzU1DQpUaGVyZSBh
cmUgMyBwcm9ncmFtIGhlYWRlcnMsIHN0YXJ0aW5nIGF0IG9mZnNldCA1Mg0KDQpQcm9ncmFtIEhl
YWRlcnM6DQogIFR5cGUgICAgICAgICAgIE9mZnNldCAgIFZpcnRBZGRyICAgUGh5c0FkZHIgICBG
aWxlU2l6IE1lbVNpeiAgRmxnIEFsaWduDQogIExPQUQgICAgICAgICAgIDB4MDEwMDAwIDB4MWZm
ZTAwMDAgMHgxZmZlMDAwMCAweDAwMjQwIDB4MDAyNDAgUiAgIDB4MTAwMDANCiAgTE9BRCAgICAg
ICAgICAgMHgwMTAyNDAgMHgxZmZlMDI0MCAweDFmZmUwMjQwIDB4MDNlOTAgMHgwM2U5MCBSV0Ug
MHgxMDAwMA0KICBMT0FEICAgICAgICAgICAweDAyMDAwMCAweDIwMDAwMDAwIDB4MWZmZTQwZDAg
MHgwMDA2OCAweDBhZDAwIFJXICAweDEwMDAwDQoNCiBTZWN0aW9uIHRvIFNlZ21lbnQgbWFwcGlu
ZzoNCiAgU2VnbWVudCBTZWN0aW9ucy4uLg0KICAgMDAgICAgIC5pbnRlcnJ1cHRzDQogICAwMSAg
ICAgLnJlc291cmNlX3RhYmxlIC50ZXh0IC5BUk0gLmluaXRfYXJyYXkgLmZpbmlfYXJyYXkNCiAg
IDAyICAgICAuZGF0YSAuYnNzIC5oZWFwIC5zdGFjaw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0K
PiA+IFRoYW5rcywNCj4gPiBQZW5nLg0KPiA+DQo+ID4gPg0KPiA+ID4gQ29ycmVjdD8NCj4gPiA+
DQo+ID4gPiA+IFBlbmcgRmFuICgxMCk6DQo+ID4gPiA+ICAgZHQtYmluZGluZ3M6IHJlbW90ZXBy
b2M6IGlteF9ycHJvYzogYWRkIGkuTVg4TVEvTQ0KPiA+ID4gPiAgIHJlbW90ZXByb2M6IGlteF9y
cHJvYzogY29ycmVjdCBlcnIgbWVzc2FnZQ0KPiA+ID4gPiAgIHJlbW90ZXByb2M6IGlteDogdXNl
IGRldm1faW9yZW1hcA0KPiA+ID4gPiAgIHJlbW90ZXByb2M6IGlteF9ycHJvYzogbWFrZSBzeXNj
b24gb3B0aW9uYWwNCj4gPiA+ID4gICByZW1vdGVwcm9jOiBpbXhfcnByb2M6IG1ha2UgY2xrIG9w
dGlvbmFsDQo+ID4gPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBhZGQgbG9hZCBob29rDQo+
ID4gPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBhZGQgaS5NWCBzcGVjaWZpYyBwYXJzZSBm
dyBob29rDQo+ID4gPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBzdXBwb3J0IGkuTVg4TVEv
TQ0KPiA+ID4gPiAgIHJlbW90ZXByb2M6IGlteF9wcm9jOiBlbmFibGUgdmlydGlvL21haWxib3gN
Cj4gPiA+ID4gICByZW1vdGVwcm9jOiBpbXhfcnByb2M6IHN1cHBvcnQgY29wcm9jIGJvb3Rpbmcg
YmVmb3JlIExpbnV4DQo+ID4gPiA+DQo+ID4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9y
ZW1vdGVwcm9jL2lteC1ycHJvYy50eHQgICB8ICAgMyArDQo+ID4gPiA+ICBkcml2ZXJzL3JlbW90
ZXByb2MvaW14X3Jwcm9jLmMgICAgICAgICAgICAgICAgICAgICB8IDQwOQ0KPiA+ID4gKysrKysr
KysrKysrKysrKysrKystDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQwMSBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4xNi40
DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
DQo+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+ID4gPiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gUGVuZ3V0cm9uaXggZS5LLiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+IHwNCj4gPiA+IFN0ZXVlcndhbGRlciBTdHIu
IDIxICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gPiBodHRwOi8vd3d3LnBlbmd1dHJvbml4
LmRlLyAgfA0KPiA+ID4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAg
IHwgUGhvbmU6DQo+ID4gPiArNDktNTEyMS0yMDY5MTctMCAgICB8DQo+ID4gPiBBbXRzZ2VyaWNo
dCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6DQo+ID4gPiArNDktNTEyMS0y
MDY5MTctNTU1NSB8DQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiB8DQo+IFN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+IGh0dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUvICB8DQo+IDMxMTM3IEhpbGRl
c2hlaW0sIEdlcm1hbnkgICAgICAgICAgICAgICAgICB8IFBob25lOg0KPiArNDktNTEyMS0yMDY5
MTctMCAgICB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8
IEZheDoNCj4gKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0K
