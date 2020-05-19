Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4FCC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF0720758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M0Tx1Q0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgESB4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:56:34 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:9601
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgESB4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:56:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQjygqi646macA6QN7LHavcSiwd+q3gI8PdSRSe40ApcoQCMlldO8x/MsKaVDiCK0VoEBkeQMyQ/VMX1wwtj5TCwe1ZMsbRplHOcNEjiG5lQ3E43wB5qItukly7Fsl9gCWeYdVJKtjutJtdalmKio1qtpGzlxei0uPI4kB1zgrpPGa8/u4MgQeRckODlgKbOBCe1JzgPA2hA0ec32hUSxDKI8mVbzaccdTKd1nFbGtfmWKmFOsf1GiaaegCv2MKbzjClB5qLcNWPORnMyrxKPrEbF84RrNEDdXSJffmQUcmhQqfK6UVdaCBF131ZoEaUwQdHO3Ow3T9h9/iwnw8Qpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5f+KfOXHZonH78iHOC9Km9uKksO0EsgLQXUgHtS61c=;
 b=iZNTAX++OhT/tRZuzFi7+/ojLp6JSka/mJc0GdwLgIHlxepJlJ0IbrZHseSCNDE74nrcmZBrovrCoCCfLQNiYm9WYg/ph4NEReIeAC7JQm/s89tCD4k/jNNAXo4PmmqACtk9P9YbY3nLF4wRFv0vecDbUJY6yYCADLE0elvPCXahJlUJEgCOxRVhmIFiAWUJvbVQw3Wf2vWhmKG8498VyrlkurbZdTkRaF/rJuKLqCAfBqNznEahsBwnLtbWtlvCODquWWvgrqva/bLp+wmhgGhi6X/p5udqhyIra8nf1j+uQqNyyPzuR8BgcBRS6UgAIky9w/pPyJRyi4yGm+79Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5f+KfOXHZonH78iHOC9Km9uKksO0EsgLQXUgHtS61c=;
 b=M0Tx1Q0dhTqFEd9REKwFcQ1U/lI4+zON4gIBoCTE8rZwYKDIote59WUHxCZZi0aG2GgveM0MMt/WobpaCk38CLTbQJO0pp9G6RlDYqvxSfqcHQNfMN8G3QL3TxhG13cVp1zKahCo7jg89FTx34+9pG0Vk0bwYLUUufa2RTnvZwU=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6486.eurprd04.prod.outlook.com (2603:10a6:20b:f9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 01:56:27 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 01:56:27 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] ARM: dts: imx5: make src node name generic
Thread-Topic: [PATCH 2/2] ARM: dts: imx5: make src node name generic
Thread-Index: AQHWLRTOIcjwouRyDUK2ly/z+q4dVaiupxPg
Date:   Tue, 19 May 2020 01:56:26 +0000
Message-ID: <AM6PR04MB4966237A7DDB05FE29EE6B0F80B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589806460-19592-1-git-send-email-Anson.Huang@nxp.com>
 <1589806460-19592-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589806460-19592-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b00decd5-c75c-4075-f2de-08d7fb97d77c
x-ms-traffictypediagnostic: AM6PR04MB6486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6486A599C76C142D901A72C580B90@AM6PR04MB6486.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c0imm73hcAjbuefoOPswY2sgew3hXIoqMmGxgMcs4Ppe+++wCySDdtP0yviLFM/1+WwXJB8EmAO4eBRf/ww5PSCt4uBvC/JqNKn64MLYjlS+6DCplFm24HJRw5AwjGxTVHjWPe3GVcUxFHMWP3Sj9Vku/VMUzXUL8eDmGmCM8RI+jQu4TGnDN+NFYTYi8nj7cwIEcQzRwknqZOf+vy/0jwv5M+BZ59HFx6jAieetHUZxRaBBjM+pcKKQ1f6VkdJtkCmqYrh9ScttbcZBqwwbKWj5FZiyc2O5DfNTeLZGKT7x5f5eCfh5fF9ZqX9kvCBE3ZaT72ZjPs0TvP2Y7yCry4Ro5ZoUirQYtk5KgF5WEwXSbY9UuwYCzHT/6j/BTuo95yXY0fXVjvObRcXbgX0dlCmSEQe7A1Fa7aKKXSmed88gEsYIOpZ4E7xOTr+Y5E/ZPf/8a5+jcFCH5i9lQ5xC7JU+msXv8pW/sU1xIUI0V9U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(2906002)(478600001)(71200400001)(110136005)(4744005)(7696005)(86362001)(9686003)(5660300002)(186003)(8676002)(52536014)(76116006)(8936002)(66446008)(66476007)(66556008)(64756008)(44832011)(66946007)(26005)(55016002)(33656002)(316002)(4326008)(6506007)(53546011)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NCWJdPJgyS/S4mfw2iozgW+E/RjDMqMO5aaa7NVtucE2tZ9Cgs/jS0+UJWrofVer31ngcH3kMa2QinnRlp6if95bkQV84IHjGOI/BcYlri7YP2SWv0a6QcQlMUA8rkp0vNf0Qy03pRB6JPoPvQBm0IX1YDWTvswtLcXC3Ff8IyDuCAQPn0NaiQarUVE/91JjQ1/ckASDNOnHS6383KjT5GvkwqdEAaX3wxVOHXm9+mcukf5yHHXeqhR5iS2Hwx1xQN3NJc+0izXIgmxykA9XD99mz+pUwya9XEjrrIrVZU0Hh0+r5l7KMV6ODTIXsPtqdxbBhc3faxGrbA86Cr+p85RO4wlWsU7AagbIa1qB6MaAJkapbX9H9JtFVmaRm4/Tj2JWTdbTM3a/bxk4O0PPmZ6GAz+7fksnD/6Jag3AV7/LM+tvLC7o6njSb+Cf/fAWkJf2j3hSK2RULL3CJ9Eq7nQ6o9hySN70UbTKoloJdUik2qB+WWY90hUxiSDQ8+EU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00decd5-c75c-4075-f2de-08d7fb97d77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 01:56:26.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pfe2xbgT0KuShH09kQwPFatuNWIfmAX2CUVJivk+bLdtBjs4zQYidI4CR0+c4JYwvsVgR8JZfjR5K1l2HWWwBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgODo1NCBQTQ0KPiBUbzogcm9iaCtkdEBrZXJuZWwub3JnOyBzaGF3bmd1
b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIDIvMl0gQVJNOiBkdHM6IGlteDU6IG1ha2Ugc3JjIG5vZGUgbmFtZSBnZW5l
cmljDQo+IA0KPiBOb2RlIG5hbWUgc2hvdWxkIGJlIGdlbmVyaWMsIHVzZSAicmVzZXQtY29udHJv
bGxlciIgaW5zdGVhZCBvZiAic3JjIiBmb3INCj4gaS5NWDUgU29DcyBzcmMgbm9kZXMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMN
CkFpc2hlbmcNCg==
