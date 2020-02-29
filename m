Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBABC3F2D2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 02:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60E8246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 02:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="izMEbqLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgB2CHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 21:07:39 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:41029
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbgB2CHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 21:07:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECCT5ZqcK96yWui2qybTloHH9Ngyzm77k3yKOYEooP2ZfVKq4KCnmy6z+GvCcd3PbslMmpD//Wp0B53wEicGxN19WwJpXdU/SKS5PNiJcmygJGBYv7ywSBn9G17yiQo95U6W4Sr1R//8qJ0/Kw9c/sdPitjNagH8+l84SlWEZtau0Rh31LkLIwTiCT+nn2PLqLu/Lv2Cdj8mLemYdeAI1dAbUeModXroQ2sZCNt5ZTFTPhe+6mUicPjluQsGMgOn4NVY2Kzmv+ooK1a7nFbSY14zfrR+uVxaCeeEsRcbgcmnF/wjWoIjKxolvXSxM5pGhl0KlsNwxTfLk2VperJ2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHUEF6DlaDyZLujTZEmLjLnII30tgcc/7ijd3oVMX6g=;
 b=kOP1vXpaDr/xIXqc0SoronDir1ik03vxBpu4jf91gkitmAdsFZSQzMlJNO4nJLw2tX/yS9PYTamRLFvJa/dUMQD9WxAG8268gmTH/48nG16up+V2zNVmNgtv/uADiUoxsPqrSPaOSp1ZYcApScCHBvwygmV+lIMm00ktHPh5QBGPMEtns1UFLBiSSRDE5xCIRS+Lqf8EFSPOaDTkkAZpDcRxbcaB8jaF0v7c8xf2STLLvZSijoIQ1cLMkyCSv4CCkSNIA8J8P6k5nqJeawK86g5rpOzNb5EEjmhYriRTeHt6ZWyAapeNCClUmCzD+HfcBv+1P2SdeflPp9ceOE8QkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHUEF6DlaDyZLujTZEmLjLnII30tgcc/7ijd3oVMX6g=;
 b=izMEbqLKCavqOQwMjVZ6EvO8rs8jeLCU39X/OHib9xzGOSKGCZaw4nU4FAwQD25AcaNgr9Rc9WA4rLlvkEEdzt18argl9EoMGBYg9veqaY+XfzhgF0qLoN4fAL6PVZTQhTuqtMhUbFQxpX0nK+gp7Xy5UToQxisFu8DhUDAuzsE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5793.eurprd04.prod.outlook.com (20.178.118.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Sat, 29 Feb 2020 02:07:33 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.012; Sat, 29 Feb 2020
 02:07:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
Subject: RE: [PATCH V3 2/2] firmware: arm_scmi: add smc/hvc transport
Thread-Topic: [PATCH V3 2/2] firmware: arm_scmi: add smc/hvc transport
Thread-Index: AQHV7HUEw4K6S9kW+0Sj3fQlJbhvlqgwzHcAgACkEkA=
Date:   Sat, 29 Feb 2020 02:07:30 +0000
Message-ID: <AM0PR04MB4481C79FD4EB32E6F111A22588E90@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582701171-26842-1-git-send-email-peng.fan@nxp.com>
 <1582701171-26842-3-git-send-email-peng.fan@nxp.com>
 <20200228161820.GA17229@bogus>
In-Reply-To: <20200228161820.GA17229@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e30f7a3-0330-43c9-9b92-08d7bcbc22d0
x-ms-traffictypediagnostic: AM0PR04MB5793:|AM0PR04MB5793:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5793F9E67422695A58C64A9F88E90@AM0PR04MB5793.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(33656002)(4326008)(7416002)(26005)(9686003)(64756008)(66556008)(478600001)(66446008)(66946007)(66476007)(76116006)(6916009)(186003)(44832011)(86362001)(55016002)(81166006)(8936002)(316002)(8676002)(5660300002)(2906002)(81156014)(71200400001)(6506007)(54906003)(7696005)(4744005)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5793;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOTWPSpmPwBPBMBGhU4oWLScvAHXB0hzVTRRAST9949+acb1Gy8g2FG1uhFjP9/rSDBgSEuIhZgOqlxiU12V7ba8SGgEveJKVIWeHREmQXrXf6I0m7JWX0IPQCQzryNGSb3UNidizVmb31xxqFOpiWgZ03mWyzRpDt0b6kOIPCTKA41IExo4bsiN0xHS2omYY3O4p6ftrRWCh923E5f7be7WDKDTZaKzaD4Z3itn8osUqkjoUfGBVo+FMlZPiBy7ujxAEIQQzr12juIX/2Xq0rxMf3HSsyuRZho4hWQM0jDqwEm/iQzsl9DiYN05TOoRVXeikYNcLM6e2+M5/XlLXafipqhDK0+/K48WS2e7PX0gK/iVbQ0YuyQ7iG1OFgWhJNU4zHSShaDOoGxsRzwybdToNMZz0LWgr7WpaABu6jdL4C+e/wD9Y7XMhtGLyI9+
x-ms-exchange-antispam-messagedata: P5saxQxq4DX1T6TiMumqP7Y3PMqlTijYDo4Zv6gUv+Gfd0PhlXJwbIQO+3cNL04GU0MyogKzwXUjcgrKcEUkhMELdPYncCJsA6nXYVw9AGIDrfYlQZIoJimy/MITbc+IwsYil3rDWaNBFQoUKiVoYw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e30f7a3-0330-43c9-9b92-08d7bcbc22d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 02:07:30.3274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ux73LShVH912iE+eT2DtgvNrxiRB5LvIZMQqmxnJzjx03UIxjqJudpB0mgvipkwhh3/+e9C5lCktTQgcX0KSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5793
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> Subject: Re: [PATCH V3 2/2] firmware: arm_scmi: add smc/hvc transport
>=20
> On Wed, Feb 26, 2020 at 03:12:51PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Take arm,smc-id as the 1st arg, and protocol id as the 2nd arg when
> > issuing SMC/HVC. Since we need protocol id, so add this parameter
>=20
> And why do we need protocol id here ? I couldn't find it out myself.
> I would like to know why/what/how is it used in the firmware(smc/hvc
> handler). I hope you are not mixing the need for multiple channel with
> protocol id ? One can find out id from the command itself, no need to pas=
s it
> and hence asking here for more details.

When each protocol needs its own shmem area, we need let firmware
know which shmem area to parse the message from. Without protocol
id, firmware not know which shmem area should use. Hope this is clear.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
