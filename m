Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B19C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96DD206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UBzHBSnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505358AbgDNT7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731053AbgDNT7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:59:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE099C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6xL0GrY/tFoNahqe+hs1n/qqY28teNHmaKNZ+aIWV2qRott0LHC0zeUz2Ksrn2Kbp5uk6Au+/DJ3VEzjfC/sysTQuk0qM9qakwLJnBdNqXrSRo4YqZSXsOFTUCVM5B8OsdKqL7xI0MTwTfB8OOjLejHkfoq35UU9R5MYAJv9+3fkl8onNveBhUMHK6aMajcnjeYzPkUi8QBMb1K/lYxGpsgAfO1Na35I9Xc6SS1y8cQOHnzbmh4sRPKUqygah1NhZU5o4rcQ3E7W+wAzcVQO1UwwSR7tyTfS5YqeIgEroepxgIPrOwl/RQWi4V56LgkEI18LcKPAOQ1IvFGo+SiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAbA7TrEcUnypmMqfcDxi3hA4qK/qCuWGuM1yqv9xNM=;
 b=BeQP0W25zWF7WpctH6E9kvuqSIK/NhKNAdv5+UVvU2iDeKc5jtb4jLrgGi5TrTtydvyMvQhRVZ1fX3n9oKf4VNxZ79UsTamzEWLDU2UWh2ixu8LLUN76oSKoDokE7M1mFZVuXhuvmkg2tyE8eYNAf3WkjltazqAkV3sDuoLFsUQJOzS4DHPk6NQZ4sw1pSbuB90KWMQHKE7uvvpNYxtHIkmrdVKKnBGmXkyau8sC1A9lLpaG9rjdpc9bb03uEO+iYaYCRZd2Vyerr0Rh2J7dNEfA5j4T9lhZwNnd69iJ3As0JvDzAelRJJluF3ZPQ52WMdAOIyH0rHYRM0ZEaUtiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAbA7TrEcUnypmMqfcDxi3hA4qK/qCuWGuM1yqv9xNM=;
 b=UBzHBSnQcVFu0Flrm6GKq83vIVxCxLhEdtx+XXEOIJbkHY2nov7ctPIr/9Pe7RBGZm9kzX5e1xPgO3i6tXo4QHbZnDGxvCZvoCfJhP6PBUFNhUdn+zOtxSuo3qonGkAHfGmwbNnA5j4vcB8bJJqme/CUTSBPbRxMl7d/0ZtpN6c=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 by VI1PR04MB4573.eurprd04.prod.outlook.com (2603:10a6:803:73::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Tue, 14 Apr
 2020 19:54:29 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 19:54:29 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mailbox: imx-mailbox: fix scu msg header size check
Thread-Topic: [PATCH V2] mailbox: imx-mailbox: fix scu msg header size check
Thread-Index: AQHWEmDd5kEp+mUChUCEq05fLBSjFw==
Date:   Tue, 14 Apr 2020 19:54:29 +0000
Message-ID: <VI1PR04MB69417717438360A9858DD0D6EEDA0@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <1586870475-32532-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1d2ecd9-3fd5-46a5-8aeb-08d7e0ada4e0
x-ms-traffictypediagnostic: VI1PR04MB4573:|VI1PR04MB4573:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB45730CF46F0347609CA553DAEEDA0@VI1PR04MB4573.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(9686003)(316002)(6506007)(110136005)(54906003)(5660300002)(7696005)(53546011)(52536014)(558084003)(71200400001)(55016002)(33656002)(66556008)(8676002)(91956017)(4326008)(26005)(66476007)(76116006)(44832011)(8936002)(2906002)(186003)(64756008)(478600001)(66446008)(66946007)(81156014)(86362001)(15650500001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1AhqmjX3lbRSqlbWv3YRxRV/UdZK+SIS2iKRNQUGlPtYILaeFvF4eQ9puGLEnhflt2bLTrSDZECLcCHS51ANc0ITevqXfF6yFFqtDHzR8/QTXFDdPASfkmkx5LnT1rkjeyBcIKBh/WKEAEbtJyUxy7s+Tmz3dSwqsCCpgnPi/Bbv/eh7nlSjP813AR6RB3Rjy390s95xYigjATZtJPf0dl33jSHX2h3eyQljSzmirUuKNW/dL/UKYgwpa6Hn9+yefJAyIkwMwPKEKs1RZ4wFfCA7Xz0Cp+Qa6GGdzwOLXLDlUTUk2wjqERuhz7Ff6cPNuY7ejyqzybKYELWfXoPKO94nb4uhWbLiklPRyaKkjfAg8Mbm0O1XuUMBiZecES/rOYAS7q+QyInJq3wilA97SUWArYgoqP5puJV/zxp2PHj4Bw/itL2xc0FLgRr03sZ
x-ms-exchange-antispam-messagedata: JKP8+Y+26ZNQZnpHKZQZ4/huXFB+BM+XXOOZb1qc1+t38a5ZcgnjtCwlWaHHnMtTem/NulMTkgMkuwkKOTJqtBHp7nYlRAsy1Q1Emkc//Z2GOUdl59YNrctcXXtzw0kSGB1mY42WzhENdi2SWAtw7A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d2ecd9-3fd5-46a5-8aeb-08d7e0ada4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 19:54:29.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kWnKJANn7VXq5W/KhF0gyXWaPLpBumki6omih3Dwj9c9cmcD9Vkx9mcEG1eq+1HxJQYeLdRodV7LOzBSTWkOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-14 4:30 PM, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> The i.MX8 SCU message header size is the number of "u32" elements,=0A=
> not "u8", so fix the check.=0A=
> =0A=
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>=0A=
> Addresses-Coverity-ID: 1461658 ("Memory - corruptions")=0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
