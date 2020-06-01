Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BF4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325BC206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C4f7EYcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgFAHnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:43:41 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:58887
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbgFAHnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:43:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTut3K0klCc/prrnLFhyguAewnpBsKtKdwih6nctXsjdguEBlVE75FMTiqGgX66j3lkR/VseQUWbsUnh7TU6cDy7feFg6PW+7T15MEvznBXw6QxGy0toRygC7AFko6k/9FmPbXIqbHeWUJm3t7ktP5VULpfR+ub4AYQg680q/WITC+FptFOXRerKnCV3NzVcFttk6vMIrE3x3pF6JjW7lceAFvImyCJj3fsXWp6BjWnTBbTt+oV7/QdbgQE6Pauh6Fc1eKYTqJOqqPvtcmmKoc2htV8J8NlSuKnmOi/t1XlEpJRSD3v67SlWWzaaUJqyN7kJ5EAuzBPGAsGHDBRbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoK29iLef5lr99A9FfnGNN8n024RREy+zWVfGJNg2I8=;
 b=Y05nqmZM5pZbQULEOhTlxGp9nxLvseh00+QnUwTQCX7U2G/YFjbiNntZkzvekaVGdbD47sQgvFCEjl9SGlt7gY6m3jbj767V9p4Z4Rv93QC/6MOwZmVgcHlxuoPVlOJTmEcUKknv9Fw2McpL54HQhOJ8t5A3Ao51UQwEvR0XD/rIDHr861pL38d9VdisLHXBDFC+ktAcyA5GYASuAGAo22bF98B8uutj0peFBPvdClycneMpQxhIyLH/wOiDDx4/jYvqg3qWBAxve12SVxuFNT0w+mxB98f/4UbJZxRplOKxxUlWNJnDDFWu+eMjw326iYP8AU9XOb3OF+b6CzJREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoK29iLef5lr99A9FfnGNN8n024RREy+zWVfGJNg2I8=;
 b=C4f7EYczKho95L5gjzJFGXwO0BZxzZefOZo1qraXuE4KBmLdUTxxxlAAc2gbsaVQjbLBV6lfMjs3fECFNQCXM0JcmdfgWxW3MvYzh+psaAboNVI//2ChpEU9L82NNMcX7J7BzHzuoBP5N5wqBixk5C+JonxRALQgCFsL7N4VbBY=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5160.eurprd04.prod.outlook.com (2603:10a6:20b:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Mon, 1 Jun
 2020 07:43:36 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 07:43:36 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
        Anson Huang <anson.huang@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Thread-Topic: [PATCH V2 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Thread-Index: AQHWN8hCZjmk5RkUXEC5rON2mzz/bajDYM4Q
Date:   Mon, 1 Jun 2020 07:43:36 +0000
Message-ID: <AM6PR04MB496668011F3AB2BEEEE6D1E1808A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
 <1590982999-7149-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1590982999-7149-2-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3458bd1f-1301-4715-3956-08d805ff7e3f
x-ms-traffictypediagnostic: AM6PR04MB5160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5160E97D65F65EC753ACC8BA808A0@AM6PR04MB5160.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35lsrjIvMARJuuuTYjvU+6plaWCjFiQykfoFvuhpmR41vCw5ezK9EuG2X4dERIMM7Z5cQ5ktSyZl1js4aAawshFuslJ9zQi5/zGbzjtKEoHWfn82YFa0DprVpXW/5fOHX7ocFEU37gZgRKD01hbptEaG0tg0DfzK9bMfrAdqoewBf/3ADHOMzriHIXLdSeZPFUuWgJXKdZfTGOo0O9AK5+TXHwY6RCPLfzbNVIsuX//ddyi38cZGsU4D9svnOqvWLMJmWqrPO/lcoxy/bU4Diw15GRpzCpzaz7+PA2AHI1v/ybWDqe9pauGR/5oBTolr6FPjTrMMykjIk3Baz+Vyd4782J88iPeyn/Ui7uZkHvLXwZJQ7X3aKLBqbtcx1Oyh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(2906002)(44832011)(7416002)(71200400001)(76116006)(66556008)(64756008)(66946007)(66446008)(54906003)(66476007)(5660300002)(186003)(316002)(110136005)(7696005)(4326008)(478600001)(26005)(8676002)(9686003)(6636002)(8936002)(86362001)(55016002)(52536014)(6506007)(33656002)(558084003)(15585785002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YCZ7DHOi8+e1aG/5go0/txCatjgJR13pvSgZPeopz0RfkzqbEYnCYfouSQfhu42m9ack+DQMOeIpiVxrmYjlAV12r5B0awrJ1kgbu/iSiSMZRGRcuWyIYTx5Hce54nrFvr0SVEveB4OJ31DID+CsyPY6Fgqa28yCDY+EtJNzH4hAZ+Qb5ujVTrQLpGkZOwijL4yzoOwxWwktEow8X/VvPZfBpPuTK5ua3HwGuLzPXXuNDdXexHVCLIqYXhLCs0HetUSzQobf6CEF/rvSo2hbNl5F4cfjoaNti/Y+TbcBXM5Ed4wa0pd9zwcxAHhLY5V/l/lsgSa8o9x9nRgsCiIT/HHgQ3sNv+jGxJOkf3cPJNvrGbw9ymU39Z6IS9zk+J1zWmrGLoQFEocpAZUDC9Np3Lc4N2MqlylQ47qBeROjqTR4TnaVVCL1bxT0FvV83Emr90KkGqvWwF/k8bLostMo4rPPuZYumpgNzLyhlvY7z3U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3458bd1f-1301-4715-3956-08d805ff7e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 07:43:36.4897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zc7nyYFLA2EAEPZIErSd+do/HBTwPobwlmHTrCC7IaNvGurZWRAN3xvhvVOzHBTvZDdIDz/YiRKNTCCQ5P6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5l
IDEsIDIwMjAgMTE6NDMgQU0NCj4gDQo+IEFkZCBpLk1YOE1RL00vTi9QIGNvbXBhdGlibGUgc3Ry
aW5nIHRvIHN1cHBvcnQgaS5NWDhNIFNvQ3MNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5n
LmRvbmdAbnhwLmNvbT4NCg0KQlRXLCBBbnNvbiwgDQp3aWxsIHlvdSBjb250aW51ZSB0byBoZWxw
IGNvbnZlcnQgTVUgYmluZGluZyBpbnRvIGpzb24gc2NoZW1hcz8NCg0KUmVnYXJkcw0KQWlzaGVu
Zw0K
