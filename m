Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E78C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA89E20836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="gjPwtkCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgFZItS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:49:18 -0400
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:38518
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgFZItR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:49:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n64idGHCaEQvtQ6siBPzrQ1uPTGNcxCtrfD5kZfheak0uf5WvxhOUHE60y/QS+ylfD1TxvA4I+nNVFlhLWWDFJci92qvEcVxJrm/AVNcAiGVVuBzI+dKhGSoyXcQ72D0KK5/+mVG5KEPFPk2prQwi5Ae962VWBUQhG6K6xiknJGSWimZEwkcuxqCMgkX4rjmPOERFwg778XsEvhny7L3TyC/tgoUXdBfmsd84v/fB/5Qb2OOmNHugMvHHqD54uGxC6Vfm8M7Mtlv4x0fzdrgsDXdJVBfCYzmDkc8mvT8Vj0wv0muVp++IQLy3Y+X7fEz9P+phTFznWVu+vnFn3n5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEUBIbJU2uGicWkaQxmQNH39tUrJEparuVoLCvhI3ys=;
 b=TMHn9rgX3Mv8mt1oVj/oisG0LW/aHYNdgZO52FTEwoB0DXrIotmdLX7bLm6jYHT6XYxjcdDwL1FtVOMzRRQ2ZDU800OmV4qLoh5lbdwSrI6SWFqfovRK8bsYfnni+5JUbZPPyyQmDZhCkTO6o28l6YwI/o0uGl4VJhve4skbhTvFCrpyhp/Yg/PKRbxSw6f3IU//F/OQ19YA/x/NBmQe2GYusTuzI+sPUgqYtJf005g1iLgUARlHr/gKXddjxpKD0NFzxumbiRRlRT5ldIss0n3umuhYLAjiZJ25Ac1bEmHewzG+qP1mQeBRlOKlJM8vq3zMIaCBnMJvBNsAqYXJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEUBIbJU2uGicWkaQxmQNH39tUrJEparuVoLCvhI3ys=;
 b=gjPwtkCAEknVdHOhEVzYwz/hypeRZqFbupRq4i6T2276EImqvinMVTC63rveEDGbm+UooH3bRDrKTDIb66GtJowPB8vx/cVE1JNrre3btktfImHUEo+MFEH1uNwthPgHIb0G3piUdibDj/y+/F3i3bWO5VcdJEx+2yUa4bLHBhw=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB3078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:e5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 08:49:10 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d54:9ddd:f235:d379]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d54:9ddd:f235:d379%5]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 08:49:10 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND 09/10] regulator: da9063-regulator: Fix .suspend
 'initialized field overwritten' warnings
Thread-Topic: [RESEND 09/10] regulator: da9063-regulator: Fix .suspend
 'initialized field overwritten' warnings
Thread-Index: AQHWSyVDgRGRokKtEUSeT6UcQptSEKjqluIA
Date:   Fri, 26 Jun 2020 08:49:10 +0000
Message-ID: <AM6PR10MB2263AAC42CEE740F885526FA80930@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
 <20200625191708.4014533-10-lee.jones@linaro.org>
In-Reply-To: <20200625191708.4014533-10-lee.jones@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aed3ef35-8ddf-412a-df51-08d819adcb9a
x-ms-traffictypediagnostic: AM6PR10MB3078:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB307821737C537B6931EEB842A7930@AM6PR10MB3078.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FyiYVgTelaZD6WuYnWtfY7/+oWU+YJGuYM6Z+KIsDPn/da+sWDv11h2hZiRbKmT+XOp9LYsz+cFeybjG0yA+OphA/7b8olCBuFub6KQb4NLmiSx/m9IKPEu5+1IqUjuQpGLkCRPMc5xkeWDt3NkW/Cx//EkbSlsLDDaWKOV0rYgChVZ2d0qd8SnroQMUpMXDU/RZhGX/YW6JLAlmDDaNc8E7FGZ9/NL/l4O7SJIFfqgmC+FTxgiRa1rcThXW7fG1vZjiESZA7QhXTaGieezwPwY0+0yzEqbWXYVlp/AD3uYWXLExxe5nHwai7paqDwz795SaNuDaaMMpNMhzHer4JoC4POKgi9Zc5XTLK5guuCmApTJijbLAFIU3JLeDixxcBB+94NkLd2Vk7LN8GadwMaCTQjtcKnvWzJw9nF+FtzjA0547WxKwQzIih6F/b8E5wx1xPq7Gy8d1C8baEs55ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(186003)(76116006)(55016002)(966005)(478600001)(8936002)(316002)(7696005)(5660300002)(54906003)(71200400001)(86362001)(53546011)(55236004)(66946007)(9686003)(52536014)(110136005)(33656002)(26005)(6506007)(8676002)(15650500001)(64756008)(66446008)(66556008)(66476007)(83380400001)(2906002)(107886003)(4326008)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sGwjiBiZ+uhz/0lQh/X2rzHmvSrSlvoQ1n7/RoTlpuwtFkmk5htSgfWQRe9/5RXSlv70fh6JcRRRI9B5kmg/GziKLM93h0SLJRXyKPNwW9DDOfqm1RVSMXO64CTrvLC01tqQZFfGD+Gqbm5/H7SKgUYWOnnEms7wHCpk3pDoDlQJAjtNjfqZLsvV8874FLUTqb4EIcGo1qdJCIVSC8Ji4SMWs0028VRY0krhsQZJ82sTD6Gv6Xf1CuAQ+2W010C2yVqdXt0dl3QFWuLI0gVT80hWYmDD/FwH4t5bu7LVQHyKSSuYGqR8HbOKsjP8Ys6EcCvpfaxK30ISw/NeM6R87R16tIqO4zr6jkRcqvyJalG+0oTq3itKqYfrsn9bBeggX3yWvqnuo42pYN/jePpltdfY6OSwcQ5zqDgOu8xYJ1u7FNZmNntNhn/qpbkCB7WMxtTh3EXHNQrI5hIqKnzVEsXSiVvXMBicYEJT/xnNK5I/5QzzeC1BtmVfc3/ZfsBS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed3ef35-8ddf-412a-df51-08d819adcb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 08:49:10.8022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szizq3pHnIcMBV+7AmffQQqo+u5D5zsReUNmojpDL7a6lQjxy1Dcgkwa/dDSozMMF8P4AQMgVOBqfezuWQl4bhHf9P00TrzlAjW2oM0Vm7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUgSnVuZSAyMDIwIDIwOjE3LCBMZWUgSm9uZXMgd3JvdGU6DQoNCj4gTG9va3MgYXMgdGhv
dWdoIDk5Zjc1Y2U2NjYxOTkgKCJyZWd1bGF0b3I6IGRhOTA2MzogZml4IHN1c3BlbmQiKSBmYWls
ZWQNCj4gdG8gY2xlYW4tdXAgYWxsIG9mIHRoZSBleGlzdGluZyAuc3VzcGVuZCB2YXJpYWJsZSBp
bml0aWFsaXNhdGlvbnMuDQo+IFRoaXMgaGFzIGxlZCB0byBzb21lICdpbml0aWxpemVkIGZpZWxk
IG92ZXJ3cml0dGVuJyBpc3N1ZXMgbm93IHByZXNlbnQNCj4gaW4gVz0xIGJ1aWxkcy4NCg0KWW91
IHByb2JhYmx5IHdlcmUgbm90IG9uIHRoZSBDQyBidXQgSSBiZWxpZXZlIHRoZSBmb2xsb3dpbmcg
cGF0Y2ggaGFzIGFscmVhZHkNCnJlc29sdmVkIHRoaXMgaXNzdWUsIGFuZCBoYXMgYmVlbiBwdWxs
ZWQgYnkgTWFyazoNCg0KIFtQQVRDSF0gcmVndWxhdG9yOiBkYTkwNjM6IGZpeCBMRE85IHN1c3Bl
bmQgYW5kIHdhcm5pbmcuDQogDQogUmVwbzogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvYnJvb25pZS9yZWd1bGF0b3IuZ2l0Lw0KIEJyYW5jaDogZm9yLW5l
eHQNCiBDb21taXQ6IGQ3NDQyYmExM2Q2MmRlOWFmYzRlNTczNDRhNjc2ZjlmNDYyM2RjYWENCg0K
PiANCj4gVGhpcyBwYXRjaCBzcXVhc2hlcyB0aGUgZm9sbG93aW5nIGJ1aWxkIHdhcm5pbmdzOg0K
PiANCj4gIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL3JlZ3VsYXRvci9kYTkwNjMtcmVn
dWxhdG9yLmM6MTc6DQo+ICBpbmNsdWRlL2xpbnV4L3JlZ21hcC5oOjExMjQ6Mzc6IHdhcm5pbmc6
IGluaXRpYWxpemVkIGZpZWxkIG92ZXJ3cml0dGVuIFstDQo+IFdvdmVycmlkZS1pbml0XQ0KPiAg
MTEyNCB8ICNkZWZpbmUgUkVHX0ZJRUxEKF9yZWcsIF9sc2IsIF9tc2IpIHsgfCBeDQo+ICBkcml2
ZXJzL3JlZ3VsYXRvci9kYTkwNjMtcmVndWxhdG9yLmM6Mjc6Mjogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvDQo+IOKAmFJFR19GSUVMROKAmQ0KPiAgMjcgfCBSRUdfRklFTEQoX3JlZywgX19i
dWlsdGluX2ZmcygoaW50KV9tYXNrKSAtIDEsIHwgXn5+fn5+fn5+DQo+ICBkcml2ZXJzL3JlZ3Vs
YXRvci9kYTkwNjMtcmVndWxhdG9yLmM6NTE1OjE0OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFj
cm8NCj4g4oCYQkZJRUxE4oCZDQo+ICA1MTUgfCAuc3VzcGVuZCA9IEJGSUVMRChEQTkwNjNfUkVH
X0xETzlfQ09OVCwgREE5MDYzX1ZMRE85X1NFTCksDQo+ICB8IF5+fn5+fg0KPiAgaW5jbHVkZS9s
aW51eC9yZWdtYXAuaDoxMTI0OjM3OiBub3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3INCj4g
4oCYZGE5MDYzX3JlZ3VsYXRvcl9pbmZvWzExXS5zdXNwZW5k4oCZKQ0KPiAgMTEyNCB8ICNkZWZp
bmUgUkVHX0ZJRUxEKF9yZWcsIF9sc2IsIF9tc2IpIHsgfCBeDQo+ICBkcml2ZXJzL3JlZ3VsYXRv
ci9kYTkwNjMtcmVndWxhdG9yLmM6Mjc6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvDQo+
IOKAmFJFR19GSUVMROKAmQ0KPiAgMjcgfCBSRUdfRklFTEQoX3JlZywgX19idWlsdGluX2Zmcygo
aW50KV9tYXNrKSAtIDEsIHwgXn5+fn5+fn5+DQo+ICBkcml2ZXJzL3JlZ3VsYXRvci9kYTkwNjMt
cmVndWxhdG9yLmM6NTE1OjE0OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8NCj4g4oCYQkZJ
RUxE4oCZDQo+ICA1MTUgfCAuc3VzcGVuZCA9IEJGSUVMRChEQTkwNjNfUkVHX0xETzlfQ09OVCwg
REE5MDYzX1ZMRE85X1NFTCksDQo+ICB8IF5+fn5+fg0KPiANCj4gQ2M6IEtyeXN0aWFuIEdhcmJh
Y2lhayA8a3J5c3RpYW4uZ2FyYmFjaWFrQGRpYXNlbWkuY29tPg0KPiBDYzogU3VwcG9ydCBPcGVu
c291cmNlIDxzdXBwb3J0Lm9wZW5zb3VyY2VAZGlhc2VtaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9yZWd1
bGF0b3IvZGE5MDYzLXJlZ3VsYXRvci5jIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL2RhOTA2My1yZWd1
bGF0b3IuYyBiL2RyaXZlcnMvcmVndWxhdG9yL2RhOTA2My0NCj4gcmVndWxhdG9yLmMNCj4gaW5k
ZXggZTFkNmM4ZjZkNDBiYi4uZmU2NWI1YWNhZjI4MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9y
ZWd1bGF0b3IvZGE5MDYzLXJlZ3VsYXRvci5jDQo+ICsrKyBiL2RyaXZlcnMvcmVndWxhdG9yL2Rh
OTA2My1yZWd1bGF0b3IuYw0KPiBAQCAtNTEyLDcgKzUxMiw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZGE5MDYzX3JlZ3VsYXRvcl9pbmZvDQo+IGRhOTA2M19yZWd1bGF0b3JfaW5mb1tdID0gew0K
PiAgCX0sDQo+ICAJew0KPiAgCQlEQTkwNjNfTERPKERBOTA2MywgTERPOSwgOTUwLCA1MCwgMzYw
MCksDQo+IC0JCS5zdXNwZW5kID0gQkZJRUxEKERBOTA2M19SRUdfTERPOV9DT05ULA0KPiBEQTkw
NjNfVkxETzlfU0VMKSwNCj4gIAl9LA0KPiAgCXsNCj4gIAkJREE5MDYzX0xETyhEQTkwNjMsIExE
TzExLCA5MDAsIDUwLCAzNjAwKSwNCj4gLS0NCj4gMi4yNS4xDQoNCg==
