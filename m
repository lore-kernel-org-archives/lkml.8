Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA794C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8292C205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LFHogvnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD0Teu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:34:50 -0400
Received: from mail-vi1eur05on2072.outbound.protection.outlook.com ([40.107.21.72]:6142
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgD0Teu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:34:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU1nEK67KZ5tZQdXxRMotayBYZnq8vknaAi/uuc7IYt0UFYxL3jQnPtWGvRZAb7yVD7DZDjvKq2W834YsBM2IIZfOAdm3SUz4zIGIqkdFr6IJocWgNVBSYQu7Kw/dlKtn6mmvpsj/l3mLt5cw+1sp/CmiTkt4PM3qywuXDsZK8m7L2I2O6LHQPrX1bjZRzGMqiykZFxeEDZXCymYCGi1OltRDfKBnq7O+TSYIH+c1GslniZ6w6iwf7nmoq8AaIIjiE9wCjn9EtNL7QLrWzxZXpHk8NluS+9uSDppg1ZHSNHqzgDx/ibiK75anxFs6RoOhtw9NgnQ9lEklNvy034PPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsN9jWbg9loNUXAl0n7rm1Zbyfjlc/gT6Qt+xSzi2c4=;
 b=VXIY/49uBNLo1EqA4OmW+7ikcONuIHt/VjF8LcNK8+MEq5UB3dchXlC/ejCmorJKt9+cdEjNjDTVT7VTQwCTUYunffiPIu85CnHmdpiyG4+xupoXh5NBM3+GjKk+VYmN6b4l8sZZyG2mneyFmKrsEaxAASeT2uhCQlwk09laP7h7xjOBF1BJy3AXg9Uj+kx1O1Aex6UVI8ewr9hi4APiesC+BoSDqN8LXlmfs5IuJC+uXIfIYKaUmAbjsyyIyLh9PKvK0O0BWCDC/rmc94AJ1pFjsJjkzbMtqtoypULxxseSNqBytYskKlvB38xNCYrpLklyGXQtkJ+dH96uaccLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsN9jWbg9loNUXAl0n7rm1Zbyfjlc/gT6Qt+xSzi2c4=;
 b=LFHogvnJJcy3oc+HDGlRtB21iEyxuGwdC08h/3wp/J5Lqo4vaGD55uRKd8Yrz3oCohVcKPf2QgP6XqlTzkgiWo4OVEDrTgBphoC9bex1p2GCl3heCAEP/xQuLn7wCqVQkkn/2FIAFk8DfsMG2BjSLyVysRdzrdje3EJXvQqf0lI=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 by VI1PR04MB4238.eurprd04.prod.outlook.com (2603:10a6:803:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 19:34:41 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::8de5:8c61:6e4d:9fe9]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::8de5:8c61:6e4d:9fe9%9]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 19:34:41 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Topic: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Index: AQHV+FjQMBLZK1sUBkmPtGWbyCJKZA==
Date:   Mon, 27 Apr 2020 19:34:41 +0000
Message-ID: <VI1PR04MB694162B89953B58266395091EEAF0@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB69418E9348D5765B4AE01D18EED00@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <DB6PR0402MB2760726D128E4BA868F03D9488AF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ad6f389-9b18-4beb-3a3f-08d7eae2082b
x-ms-traffictypediagnostic: VI1PR04MB4238:|VI1PR04MB4238:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4238EC55FF1DB6A9C18E7D1EEEAF0@VI1PR04MB4238.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(66446008)(478600001)(91956017)(66556008)(9686003)(7696005)(7416002)(66476007)(5660300002)(55016002)(44832011)(71200400001)(54906003)(66946007)(76116006)(110136005)(64756008)(86362001)(6636002)(4326008)(8936002)(2906002)(81156014)(33656002)(6506007)(8676002)(186003)(26005)(52536014)(53546011)(316002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRYl+TyJCFLYEz6gHzgIhZCWTZbAbv1ngsrwzpntyq9QgZkl7vQK+2lBksr/0xn+qOkJOC9Wj5pi5kjn+3MrrGZj3rtOvPun4brCSS/UmlZEf4u3Ba+eV4WiL/gt5o/iaOqZoBigTlhJcI6/E4AYGokzkhefb2MQ9jBpACBxYlgZURMgHY6j2KSliJEhvdfOqW+N4vB6enpSbIBnmNq+9TJMIiFlnrrwCUc0DIa8jzLd68NWqZrMIw8ywd3JWgc5H+JTMIluJnW4XzHBMUM3zg1eLqBJUkTgms8r/jVpQNxviLskzX7irHiwoxC39vV9Xvz7ggyp/IxB92KGDRE7hyVGt4D077TsSd7rMJUNYSsziMXZev9rO2O/Bp81St4DW+GGE2JQ+Ybc2VfNbC/mo5RV4pGbkWroMu1P35MGIOAO0oOFLK23YQ0PIcO4J9S7
x-ms-exchange-antispam-messagedata: cEjHh3TRX4Bc/dCqXvNOgTsocunGZld5e3RkNe4BmdE3BT3YFqORRBFr/lBjyNP1OaJbKk6fACMmwqbyR3wOfnWVk5WkUKvtqucmRswZKGct7YGcSeVkp2VmgPWIKH+BpmFxi1OuO9q7wmWHsoLLMWC3qNRuBm7OdTHbw7WCcixRzZlJNgd0rJDnnwzohh2FCOjOINAt1wKYPj8pl8n+Wy85SPdQVRpiwGuKZRD+h9F5ZbOZgwQ+X2qOK7iaMr0cazrkcurT3e81BevtDrkDlIuNdbfM0EVfdbzThdYVDdxfFXdu7mS3ipe17HJaHspAWB89TzkSxOsS7hbcC5U33hc1WKj9Nm2nroDJB8lXQWXBJRrIDrmljRgq4KlBDKNDhUg2KJKxXhyxOZiUlssPq8RNlHyq9nKoFKOeQYMxuVpACB9eJg5y0oGgo2/hwyC2Ji3+ki8+k9YpkpbduJbkrrxBabHQ1SScEaB1GlQDx5yGg5xzD2whWyHDooZUH5dLyum5j2Jcr1Wb5Vz25kV3U1z0UqMFEvdl79rffrTv5IKMpsme1ueNpblnJi9zttu+4ewTFbk4DmvRJpwqr2TZ87lZszOyakw0SsVtfzr2ZOGUdmwlwhF0wnb7SWsZyU1jILYrE4EC7oQ++u5DuMR5k1tQ9BgaVryE+rz5f/MfpIgR09CTjY2IbXeR8QOnz/W9rU/zoT32BnK25NmWkI2LKdFxwD4RAG8VEPBCsPXYTuuRmelNzzqGGxVuIxo1JQGaoEkWc+rNKYOKgEHnwrZ6/9NiDfULvyNv2SQGix9BvjE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad6f389-9b18-4beb-3a3f-08d7eae2082b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 19:34:41.4862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9TX6lmYzP/+JWZwwslIA0IsPjEtnK3LWUVLyrbSHdEbmIWEO4wHMHrgYdy+nOGD6nabxRpenvc8lxJkNMPBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-27 12:15 PM, Peng Fan wrote:=0A=
>> Subject: Re: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite=
=0A=
>> clk=0A=
>>=0A=
>> On 2020-03-12 12:27 PM, Peng Fan wrote:=0A=
>>> From: Peng Fan <peng.fan@nxp.com>=0A=
>>>=0A=
>>> The CORE/BUS root slice has following design, simplied graph:=0A=
>>> The difference is core not have pre_div block.=0A=
>>> A composite core/bus clk has 8 inputs for mux to select, saying clk[0-7=
].=0A=
>>>=0A=
>>>               SEL_A  GA=0A=
>>>               +--+  +-+=0A=
>>>               |  +->+ +------+=0A=
>>> CLK[0-7]--->+  |  +-+      |=0A=
>>>          |    |  |      +----v---+    +----+=0A=
>>>          |    +--+      |pre_diva+---->    |  +---------+=0A=
>>>          |              +--------+    |mux +--+post_div |=0A=
>>>          |    +--+      |pre_divb+--->+    |  +---------+=0A=
>>>          |    |  |      +----^---+    +----+=0A=
>>>          +--->+  |  +-+      |=0A=
>>>               |  +->+ +------+=0A=
>>>               +--+  +-+=0A=
>>>               SEL_B  GB=0A=
>>>=0A=
>>> There will be system hang, when doing the following steps:=0A=
>>> 1. switch mux from clk0 to clk1=0A=
>>> 2. gate off clk0=0A=
>>> 3. swtich from clk1 to clk2, or gate off clk1=0A=
>>>=0A=
>>> Step 3 triggers system hang.=0A=
>>>=0A=
>>> If we skip step2, keep clk0 on, step 3 will not trigger system hang.=0A=
>>> However we have CLK_OPS_PARENT_ENABLE flag, which will unprepare=0A=
>>> disable the clk0 which will not be used.=0A=
>>=0A=
>> As far as I understand when switching from clk1 to clk2 this is done by=
=0A=
>> temporarily switching the rightmost SELECT mux to whatever was in the=0A=
>> spare SEL, which is essentially arbitrary from linux POV.=0A=
> =0A=
> No. The fixes in this patches has been confirmed by IC design owner=0A=
> =0A=
>>=0A=
>> This is quite unexpected but in theory it might be desirable to use a th=
ird=0A=
>> parent as a fallback.=0A=
> =0A=
> No. this will make things complicated. To CCM SEL_A and SEL_B,=0A=
> it is controlled by a hardware counter. Saying you write n times to=0A=
> the target interface.=0A=
> =0A=
> The mux will use n % 2 to choose SEL_A or SEL_B. write twice=0A=
> to make sure SEL_A and SEL_B has the same value.=0A=
=0A=
What if SEL_A and SEL_B have different values on boot? The first time =0A=
linux does set_parent it will switch to the other SEL_X which might be off.=
=0A=
