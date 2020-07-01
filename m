Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD757C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8896720748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oIKUstdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGADmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:42:45 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:50182
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgGADmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:42:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqJYUcZJFDmQrvxwvifZM1iLiZBj6RDxfjgiMZrupmw6noy3j+oiZgsX4t7LBBJbdyAm50FIciWz4AICo+flI9zl8DbTLo/pkuGw/kFLo7ysskUv01K5aDiw1xpyordN7dZEkWbq0zC5hI9wsBb67qmE6+jhl6NVfjxU16Tpn8KZpuzRMLkBII4Ujw+23NnDASz++6MOfx2HOJ6im/dcksuwCcd4rGwpXiT0qbqbOe+QFiFmxCiAvdc9gH4z6qrRjW+d1KkEAG4R9LuaTMWUAbtnDzACVAICYLRKNbgUEVZcJ+Ivp9u2LbA9wmp4gE+Rn3XKghXf/gp0nw+RJSxLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SySJeTfHJUxp3q7S1Sn8QT9JzqPjlApW88muzF85nwo=;
 b=mhrUgMNtk08nXu306bc5NlPjsMmp/6IRrr36sUgZfr+HtzNI3h2TJPHMBPfVTJ3j8C8PCJ7VpkVciqDP2lES/NtBmBqmAnXm1cpny/QDO/zIepL8iMsLfx31B3E9w82Xr2x67Vgw3XsERErNOcxLrPPvvu5tp5ECKVb5f2x5ko8otYWwZrpeqME8N/KL6SAh/zFI8RKNq9zuBbXosu8t3Vw8kEaHDRnx4zXyhOFTUNjuXOQ8SEHktNv6XdM9swRkpu/EEN6TqtNXE7UtLloevMQhVK+Nr1OzeZ6hntk1qHyUcsrgMewEOCn35rb3b3io/QEJR1XoSkILuwc50xz7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SySJeTfHJUxp3q7S1Sn8QT9JzqPjlApW88muzF85nwo=;
 b=oIKUstdv3Gr6w2VkwyXoUE4LVCrgJjfcmWGTYqVjGFIRmEUd3IJwnxUoyxF/OWJuN/Xpz4XcxLB8WzxJ0KwWzu/OtEEVOHngj+BAuNG+S1ZA9Ues53xhAJe2XT83SrCkS1a13NqeqUewigrS+fxsiESitzQoUqsmc2M0BeidUqQ=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB5544.eurprd04.prod.outlook.com
 (2603:10a6:20b:28::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 03:42:39 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 03:42:39 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Sven Van Asbroeck <thesven73@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Topic: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Index: AQHWThag/tmWe004ek+eXrutuxE1fajvmZEAgAAMoQCAAAM9gIABCdjwgACVb4CAAMUk8IAACGSAgAAAgUA=
Date:   Wed, 1 Jul 2020 03:42:39 +0000
Message-ID: <AM6PR0402MB360717519B42A48A754691C8FF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200625140105.14999-1-TheSven73@gmail.com>
 <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
 <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5B-XVaZ-t2T7UBdCqqde3bJREiQhR71ET8p=9EHJ-DQbA@mail.gmail.com>
In-Reply-To: <CAOMZO5B-XVaZ-t2T7UBdCqqde3bJREiQhR71ET8p=9EHJ-DQbA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a20599b3-fb76-4d40-9415-08d81d70cdd0
x-ms-traffictypediagnostic: AM6PR04MB5544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB554453F1C1907B518E609437FF6C0@AM6PR04MB5544.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i/famBOXIeTFu9C61VLluvILXlLV7FxMy9LhGjdzIfWdkn+Z42rWDNlc2BfVtyi4qubh11eAB1VMCimk/NWd/7tu6wbc/8fIXgt07cUKEelfwhaHNx8VPXqw9FvY8NL6rv5rB9h/az+eDCVDZJUsA0RjnAY3GZ++as5KX5YtIfYS3tRjHfFrt1LfDeY3JOIU1YF+sWaW1H+Vo+UJMUg1ht5r7xuArvhuKYtNQUDVxaACFvLIuag9Piu2t/BFY144bn1wP8sGA0pQzf049oTwwRGsf//N28kXKysoB6T69v1W7CQvuE4bIXstN5dnG96mcQNXrkMTFrSHgRVtwbpXNibOf+AmvX18wPz0Tdwtbpratw2bIxF3CkgLZquNVpob
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(53546011)(4744005)(26005)(478600001)(8936002)(8676002)(71200400001)(6506007)(86362001)(33656002)(186003)(83380400001)(7696005)(6916009)(316002)(66946007)(54906003)(76116006)(4326008)(52536014)(9686003)(2906002)(55016002)(64756008)(66446008)(66556008)(66476007)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2mrR3ElUru2gQcZew4L2Yfe7muY/GZefhuEKdXZ369vLEO/hKhVDLfgsCIBRVeNKSDB44cd50PO0cMoBzoYnu6BHdwgaTM/VgAe15SAwxqcPar9RnSF18EL/rqWkBZq4Cp5ZWPv5ihWzG82bh6cwilLPLYa3GgWcGCOk6gFm1f58gAIYyenydf+qLw7+FNrvKjSAKNwtwf5pPw2kOnKnCPGjZv7r3Ifl96b0DoXsMQaAHcRqBW6SbOIUJpmcGtCYithjpQygFNBZ4XnO+gKmi2dXPYI0HR+P5LbH83L0R0bHTsnST0xUX5GhCuAX7GQzY5JDyUXyVG69hF6P/HUTy3QLOEiUH8BVc8axOD2RcmhZg9Zut1MnRko4WmP2yuhjnvT2J0GJo2MH4ZFkvIlJW99ODE0QgIV1MJBvtAneyYCtCY2dAf93I4U9icusF6ZubjUPmV/kuT8aORqpsq1VEVAP4NnoHjsFB5g+BuOwTo/Hl6RjV67SXguL2gCT14L7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20599b3-fb76-4d40-9415-08d81d70cdd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 03:42:39.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMBxWkvyOPQdvwl3cvTSHEvJkveWsD2MA2vXMvXHpf9v9WmoxclOQQf4Sv5rno01AjH/wm9Pz2dhjDFqd1ceZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPiBTZW50OiBXZWRuZXNkYXks
IEp1bHkgMSwgMjAyMCAxMTozOSBBTSANCj4gSGkgQW5keSwNCj4gDQo+IE9uIFdlZCwgSnVsIDEs
IDIwMjAgYXQgMTI6MTggQU0gQW5keSBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPiB3cm90ZToN
Cj4gDQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1zYWJyZXNkLmR0c2kNCj4g
PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlc2QuZHRzaQ0KPiA+IEBAIC0y
MDIsNiArMjAyLDggQEANCj4gPiAgJmZlYyB7DQo+ID4gICAgICAgICBwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiA+ICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2VuZXQ+Ow0KPiA+
ICsgICAgICAgYXNzaWduZWQtY2xvY2tzID0gPCZjbGtzIElNWDZRRExfQ0xLX0VORVRfUkVGPjsN
Cj4gPiArICAgICAgIGFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDEyNTAwMDAwMD47DQo+IA0KPiBJ
IGRvbid0IHRoaW5rIHRoaXMgaXMgYW4gYWNjZXB0YWJsZSBzb2x1dGlvbiBhcyBpdCBicmVha3Mg
b2xkIGR0YidzLg0KDQpJdCBkb2Vzbid0IGJyZWFrIG9sZCBkdGJzLCBhbmQgZG9lc24ndCBicmVh
ayBpbXg2cS9kbC9zb2xvLg0K
