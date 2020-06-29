Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43AAC206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ecqjWqWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgF2Ct6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:49:58 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:36832
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgF2Ct6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:49:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvuZ19YvzyhB9IN0gniaeZQQ9cn6b/fBaWzmo8HZ4vrXs3brJO/x5znfA6yUAMFD33Q18pKC1JxBbQec7xR5ZAXw/nJmDIjd/sPHQCg70T8M2t1pkQkDWAfFWrAhS9xWq4XCd6KsyQjJHjAR+h9Mekgjc1WP+Qj23gfrIoNZunF7ho5S77SiSZXJA19a0Pzc2t7tHemASXE9uUI+pr69xBb/r2lcIhAWj+Jp76tztD4cB8MmPXa4CI2ClHMRE5//cW4wYN/i2cYkLIKZpYUKbcbHzSNjZgsiYzJUgBJtZGh82zfoAV2zFe7hQIJbOWPZ6oYiTXVUvuyozF1pvCHLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUQJFXuvrpMMv7Dbv7s7fJEjczUoax0aDoCXwaKvMJQ=;
 b=DEVGH0CtEAKxAbzqZuS7mM4u4UKAABDqAnWwpw+oSuap2s2T+nwPsGDD1NpYd5oli4sPKjViRKhp7/oLrxheP4YRcTY9cnvcKfnbWWFDY5ngaTdTA80LlCcZk34mKpIaumRYJtApyuF1JSfzC6iSEK0Ta/X4FC4aYR7yFhqR6RTO9r+S2WW5HnsPWF4kn3+pAPMs4X/qoexJyZQ8prfIDFUVsdrZ1wRP9Mvjcjzz0RM4wE4RrNdxJh8qD+1qo/qrH/ZNv/mYe8DJqdn6owzeBXxg6XX5KVUwxQx8L9KkcQsr5sKMPPfHcMCqLTh7z9K3Q7JkrDmcsJL7xA/MIUU2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUQJFXuvrpMMv7Dbv7s7fJEjczUoax0aDoCXwaKvMJQ=;
 b=ecqjWqWS3hUP1pGw5fGxogK8oYiOdoo4uxAhDbGAcmSf43hJgR29eUvd/5s9/XBMZHFXT7Hvj/GFBFXnv5x/MqLUbiRhVOJ5+K/oQxiI1n8xitA1m1MnWdqglv+o+1nqAmSXINXs605T8AEezbSTlnXhaLH1lhtPij0xoBRqXqA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6776.eurprd04.prod.outlook.com (2603:10a6:20b:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 02:49:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 02:49:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "olof@lixom.net" <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3] firmware: imx: Move i.MX SCU soc driver into imx
 firmware folder
Thread-Topic: [PATCH V3] firmware: imx: Move i.MX SCU soc driver into imx
 firmware folder
Thread-Index: AQHWSzcxfOv9KY7jDUqcVeHWDkigp6ju5nlQ
Date:   Mon, 29 Jun 2020 02:49:53 +0000
Message-ID: <AM6PR04MB4966C9BBBDCFD92E20218A23806E0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1593119647-30951-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593119647-30951-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 241e7137-ae6a-4fb4-0ba9-08d81bd71a09
x-ms-traffictypediagnostic: AM7PR04MB6776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB6776F448CDF3547C4C5889A8806E0@AM7PR04MB6776.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkHLAuMOH6z4iyqeyO2JKlnzMiHvHuMe7BvtkWylKuxecS3mYcNUeyLKy4dOH5roqDRh5o20NhyrfvIigolvj3K2i+ifopEDTxx1UOH36p3lN1qgphhkmv7aAGt7me2EgNbEYWGVfbTzOXtpkVZMQZy+Q5nJvtH7ZS1Aeyt8DlKcutiLE4eP4MLBGTpO7JaRGc3Y/M8raeGiLVznymgzNCdS4ZtLn617oIWIA/TfYa1wsnssvMLyThjzDCxGtNAy/WiP0Y+EVM+vSwIckW2p9tQPqaDbUR6VJeCU0r2HwgF4hjseeBj9obHJQolwhATuEwa6Iw/GVq5JG12f9nERuKVVRcX9bgihAIxy63Fz+3fa7HJqHELHFbLxkoqtj2A4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(7696005)(86362001)(66476007)(2906002)(76116006)(66946007)(64756008)(6506007)(66556008)(7416002)(186003)(26005)(44832011)(5660300002)(9686003)(4744005)(55016002)(8936002)(52536014)(4326008)(71200400001)(8676002)(110136005)(66446008)(33656002)(478600001)(316002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CcG0cYbh5PcYvk+Sw7WScgt2hg+joKXDY9U2wRUJjZmMQ4xRH7QBl9vPmtWL0UnQpwl8DMsCQwnztp+cMKaECkxuhdlhEHugGMy6DPwPkhr4T5riMsDPs/12kIZnVGcETkPNGFftH/Kh3sAeg9RPdrv/XSZqx4wNiwszBxEdDq/R65fv4CNsi6SZKBecViOfdWd03f+oNQfQ6sImdPDS2HJElB38dm3rXgdqdkaqcA4rnrclNBeoXKEFPcFjdI/jiZXLQJK8S4yq3ZGoUUajulfqpRwcfDyI+A6YY5HdtK58EyfhbRInuVC5MVcyKPgPzUAhJwEi8/wLxsCDndi2TW2rGO+qkc2XnUvuIfUSCUscM4Is67mGjDTM0k17nkWyYaWEUBrwP42A7ELj9Jc4rSkkf+BkrPWrKRnQuKrN7SxqNpDWmy+0pY/spB985yMwInmzGeb64iQJ5oboyqqy/MCw8an7J99rqNYn8x+lejk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241e7137-ae6a-4fb4-0ba9-08d81bd71a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 02:49:54.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Q7lmjbp4eoR1+orFnn26OEo4VMDfgLXeQ9kcFp7KyFelbueof5o8sfQqIBWW7YurDL3ql4KBBAx1U93Enyr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBKdW5lIDI2LCAyMDIwIDU6MTQgQU0NCj4gDQo+IFRoZSBpLk1YIFNDVSBzb2MgZHJpdmVyIGRl
cGVuZHMgb24gU0NVIGZpcm13YXJlIGRyaXZlciwgc28gaXQgaGFzIHRvIHVzZQ0KPiBwbGF0Zm9y
bSBkcml2ZXIgbW9kZWwgZm9yIHByb3BlciBkZWZlciBwcm9iZSBvcGVyYXRpb24sIHNpbmNlIGl0
IGhhcyBubyBkZXZpY2UNCj4gYmluZGluZyBpbiBEVCBmaWxlLCBhIHNpbXBsZSBwbGF0Zm9ybSBk
ZXZpY2UgaXMgY3JlYXRlZCB0b2dldGhlciBpbnNpZGUgdGhlDQo+IHBsYXRmb3JtIGRyaXZlci4g
VG8gbWFrZSBpdCBtb3JlIGNsZWFuLCB3ZSBjYW4ganVzdCBtb3ZlIHRoZSBlbnRpcmUgU0NVIHNv
Yw0KPiBkcml2ZXIgaW50byBpbXggZmlybXdhcmUgZm9sZGVyIGFuZCBpbml0aWFsaXplZCBieSBp
Lk1YIFNDVSBmaXJtd2FyZSBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlz
aGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
