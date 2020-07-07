Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9099EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66EFE206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JaJM/M0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGGC05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:26:57 -0400
Received: from mail-am6eur05on2041.outbound.protection.outlook.com ([40.107.22.41]:24161
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbgGGC04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaexmFnxhVtTWQoM1TEI1TP/PYwKxXXqYhrOHTOmmEe0z95H9BQ1ErVCctQIc2nIkqVUNzcYEyIfiFsUzJBnYPMofiDJCzRJazz2xZgQFt9WatIuj7smCy60zc5soGfTSjGciADb1Z0uD4YgEoTKTYWXtqlpaF/dbfH2xKIxBn/6rq6NE3qcBWfJmq+5A4j3g8W6a8GOm6z+T3kGk5pAYy52+i7wK8PdyyQS5xWn15JfKzXs5SadGEquZdQXtYTOdswajOaON8PWzv/CrIQ3bnOllbBPEFfV20WK77KpcjxZgWC2DjDuMkt5bVR9onWIGyiRGJ/I+2NXoStUGYSKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTO1l99rjaJbJZkO/GofpCgBKDYmCC2fwA5+cJ+dJyw=;
 b=C+d0IXrCEH6awdi+/bLOStMRlXFwxpRasOqrEEcQJKrrGz9jLhwBCvMQsv0SlNj9zykBCKsZhiBAbFFuVM02aasZqkoCVILXNDXbkK14T+jRfyLyib6u1JrSgKD84CnKdNs1Gndyc3YedVA/koAOkMhNAiOypYC6D0/kKdZI7IpWpuWDFTTdgg7V5B8gUpHJ9Q/RVaZjchWvYVX9pHDbT+mfbDxFAoKZ+Gefz/Ju4ubGFjED1QnOtuGAnusnRfOtRi3+sgYUfL1kD09q1V7zMsXwoDrZhP2K1wTs1+9Yf+O/aJSv+fDDT7CWhbpf7Wf8T4LWM0mTvXCU+1pynP6seA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTO1l99rjaJbJZkO/GofpCgBKDYmCC2fwA5+cJ+dJyw=;
 b=JaJM/M0uycVBHJSy0OJPtpbWV1mBa4Vq6Sx3l0erRcopw6+L0iXCKj/VQu2Pqnye12x+a7CALiaKV4kAgk0xsrYPD2L8cBXxrQQyjTNLwORSN/3C43boE2hUBnHpZhq5k/g5dc7z/BgicQf+EFg2nqL4Q8NfMC76q1qvIA0MIHY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB6860.eurprd04.prod.outlook.com (2603:10a6:10:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 02:26:52 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 02:26:52 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "j.remmet@phytec.de" <j.remmet@phytec.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "georg.waibel@wiedemann-group.de" <georg.waibel@wiedemann-group.de>,
        "Georg.Waibel@wiedemann-group.com" <Georg.Waibel@wiedemann-group.com>,
        Fancy Fang <chen.fang@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 0/6] Support building i.MX ARMv7/ARMv8 platforms clock
 driver as module
Thread-Topic: [PATCH V5 0/6] Support building i.MX ARMv7/ARMv8 platforms clock
 driver as module
Thread-Index: AQHWUIVINw6miKuF10+LFBIwErSPHqj0nIiAgAbNwuA=
Date:   Tue, 7 Jul 2020 02:26:52 +0000
Message-ID: <DB3PR0402MB3916702489B6525639A42053F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593703441-16944-1-git-send-email-Anson.Huang@nxp.com>
 <20200702182957.GO12562@pendragon.ideasonboard.com>
In-Reply-To: <20200702182957.GO12562@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d32569af-3b7a-4538-4ca6-08d8221d35aa
x-ms-traffictypediagnostic: DB8PR04MB6860:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6860F84D5999F76CBFAD2953F5660@DB8PR04MB6860.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bj3/pW6rPwcx8A9/+o+lF0abmKRGCJZeMhlrc9EYzgKDHQTwqsWZ0gNh0/XN6Vcu2GIwFPWefSZeqivx6qhdHdPw5cPUi0LXTNbSyVcSYBJbdj0qW/6leVmjFYihC2lvMd6HBbLkVP0IlYDcQ24jm3qCA64lLIN0JVIbaqzallr28tvClpBkTWbI6G2m9gYAEjefNFUlQ2IkcIDs+aea3Uh4vFQ1/ydBAwu3amPo0hHQ/UWZniYMMF62du3g/9cPTxNmz2WwWa31VEMWRpu4iI/x7zhG8GYOo2zrOoAaOordgbGd0esAuMN+teAEaS28v0gOKCeQYURb8LgKjQFpjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(33656002)(71200400001)(186003)(8936002)(4326008)(7696005)(26005)(6506007)(86362001)(64756008)(478600001)(66446008)(66556008)(5660300002)(52536014)(66476007)(66946007)(76116006)(44832011)(54906003)(316002)(55016002)(9686003)(7416002)(83380400001)(6916009)(8676002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fqhcz09gw0RAlPUw1Ho03TYPTdPKLI0YtRoAtxdIysB0DluuemBVEeeENcUMqkWPBOh/Um2jjBH1BXjGjysUhy+/YmfPZQLhJLGIvtIMbppzQIp2y/ZaHJUbe/d9e1s/aX8RSr73Yqwd+/IDWC9artYqPnJO2MOG2p35c0Y+ERF6WNZaxu8nMafoOZELM4ZpC6l8Yd2Dkes+W7mNDRUuEsYdFDIFF1oWHTeUp7eUpEdWPQ4EOnxJk71TydflAs9IouKx30b20ytLMNWVCPItIg1r0MiQBA0NSwazzgSlo9evYvuog2CJu3ZOoXB2Qb0bU5+nKab8QSW7YwjjWtndedm3gZZ19rBNrik0MJEE6XQf0/5FuwPU/KfVnjl9GPvhI4cAQ0YD95PHculAW94wmnSLgQrrIpCF8JUdxvTOq6umET9eSJVuNbzMdc7+Fsv1FlbPliXW5aczlo+vyx/APooGy722//GUO1FgJXsSZac=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32569af-3b7a-4538-4ca6-08d8221d35aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 02:26:52.1505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k19es/sSQsvNr+QExutzbUbRQRGIzpJcVTJPAJwpxbY/YNVCPE/bEQnKhptNdXF7DklvaRGQoHctehfuQZ4FRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExhdXJlbnQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY1IDAvNl0gU3VwcG9ydCBidWls
ZGluZyBpLk1YIEFSTXY3L0FSTXY4IHBsYXRmb3Jtcw0KPiBjbG9jayBkcml2ZXIgYXMgbW9kdWxl
DQo+IA0KPiBIaSBBbnNvbiwNCj4gDQo+IE9uIFRodSwgSnVsIDAyLCAyMDIwIGF0IDExOjIzOjU1
UE0gKzA4MDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IE5vd2RheXMsIHRoZXJlIGFyZSBtb3Jl
IGFuZCBtb3JlIHJlcXVpcmVtZW50cyBvZiBidWlsZGluZyBTb0Mgc3BlY2lmaWMNCj4gPiBkcml2
ZXJzIGFzIG1vZHVsZXMsIHN1Y2ggYXMgQW5kcm9pZCBHS0kgKGdlbmVyaWMga2VybmVsIGltYWdl
KSwgdGhpcw0KPiA+IHBhdGNoIHNldCBzdXBwb3J0cyBidWlsZGluZyBpLk1YIEFSTXY2L0FSTXY3
IFNvQ3MgY2xvY2sgZHJpdmVycyBhcw0KPiA+IG1vZHVsZXMsDQo+IA0KPiBJJ20gY3VyaW91cywg
aG93IGRvZXMgdGhlIHN5c3RlbSBib290IHRvIHVzZXJzcGFjZSB0byBiZSBhYmxlIHRvIGxvYWQN
Cj4gbW9kdWxlcyB3aXRob3V0IGNsb2NrIHN1cHBvcnQgaW4gdGhlIGtlcm5lbCA/IFdoYXQgaWYg
dGhlIGRyaXZlciBmb3IgdGhlIGRldmljZQ0KPiBzdG9yaW5nIHRoZSByb290ZnMgY29wZSB3aXRo
IGNsb2NrcyBub3QgYmVpbmcgYXZhaWxhYmxlID8gRG9lcyB0aGlzIHJlcXVpcmUgYW4NCj4gaW5p
dHJhbWZzIHdpdGggdGhlIGNsb2NrIG1vZHVsZSA/IEV2ZW4gdGhlbiwgaG93IGRvZXMgdGhlIHNl
cmlhbCBwb3J0IGRyaXZlcg0KPiBjb3BlIHdpdGggbm90IGhhdmluZyBjbG9ja3MgPw0KDQpZZXMs
IHRoaXMgcmVxdWlyZXMgYW4gaW5pdHJhbWZzLCBhbmQgaW4gdGhlIGluaXRyYW1mcywgaXQgd2ls
bCBpbnNtb2QgdGhvc2UgLmtvIHdpdGgNCmNvcnJlY3Qgc2VxdWVuY2UsIGFzIHBlciBteSB0ZXN0
IGFuZCBBbmRyb2lkIEdLSSB0ZXN0IGZyb20gb3VyIEFuZG9pcmQgdGVhbSwNCnRoZSBjbG9jayBh
bmQgcGluY3RybCBuZWVkIHRvIGJlIGluc21vZCBmaXJzdCwgdGhlbiB0aGUgZGVidWcgY29uc29s
ZSwgdGhlbiBvdGhlcg0KbW9kdWxlIGRldmljZXMuLi4uQW5kIHRoaXMgcGF0Y2ggc2VyaWVzIE9O
TFkgcHJvdmlkZXMgdGhlIGNhcGFiaWxpdHkgb2YgbG9hZGFibGUNCmNsb2NrIG1vZHVsZSBmb3Ig
dGhpcyBzY2VuYXJpbywgTGludXggd2lsbCBzdGlsbCB1c2UgYnVpbHQtaW4gYnkgZGVmYXVsdC4g
DQoNClRoYW5rcywNCkFuc29uDQo=
