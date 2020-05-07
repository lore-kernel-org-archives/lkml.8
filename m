Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A2EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69055207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G7IXVnXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEGGsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:48:42 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:27349
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgEGGsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSEtBXQKppDedMkDbV54jP04LQYvdAQAyY5PQObtqNANS4oswO87iAo0M8XlMiAcct2EmHYqNux0kDsGo1pIX9OU+MC3IYzahUqvgdiA1371jeQ0lecSg2TWLXSU/lh3wIqXSLCNgdL6faNxCyjYJINCYb0FwRHJm67Ty/iufs77wvqrci1F4zQlDMUDZ2HXqeUALgTbhxyg9rcmbrgDb/TAuFxTHlD4tpS2KL/S9ykB7ODnJE6Ag4t1nZJUMFFs8IsWMKdS3ZuO9IyMD4/x3x7BET7XIdN9bSBKc1d7ufZMcV1Sbt8t4LmSPbL7JWvN6X+uDQhhHGWKkdtPxE8eWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG0eLUzvsKC2Kr+Q4nNoO+Y9skX1waMRGm/61YDzc/A=;
 b=nz3S/vOA4SC7HxonwGWUi+zyHHMLkxSul3S5o86XPN0iRWwJhE9AdhvknMClMXB4WpAcypB5/ud86E+Rmqf0raQYGbiuR8ldyKJoymXzx1oVFKPEOliZmVgehZ3UHi9n96p5OPe25C5v/E5/HU/G5JCwGkWLX0n/J/EZKs3t6ykJfVkRLTW3f19kL/si64D59zir/SJJY5N+d8wWCp9h0q0ZgISdm0/Ehi6ndT2tcEvF/lTlzzsNHxYxCKDNFBUwiajOVTwQg1Mc2LSpIlWqsUyS/FxYnY6Hw/jYFNo0EwYp236erG0P3OP0sbojvmg/u8UXudV9n3kCSCDeeDv7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG0eLUzvsKC2Kr+Q4nNoO+Y9skX1waMRGm/61YDzc/A=;
 b=G7IXVnXsC2Lrgpg4O7kXcsbSCJTvKAQoUlIm4CEEY9YzWxewrzqcOWmh5wwmqTLQ89Z4kHMpzobcw7f4n0kQJ4uSA1jjzeMbnbEWS7GecBoZABt5XxeL58eLj/WR+bDYFsSyPwMJ0Rdm22emxkMviwVP7T0eUjK+CMxowkjXnV8=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6951.eurprd04.prod.outlook.com (2603:10a6:20b:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 06:48:37 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792%9]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:48:37 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: RE: [PATCH 1/1] usb: chipidea: msm: Ensure proper controller reset
 using role switch API
Thread-Topic: [PATCH 1/1] usb: chipidea: msm: Ensure proper controller reset
 using role switch API
Thread-Index: AQHWJAli3z7u8fIbYkCGKuKib9RUKqicLlyAgAAAZmA=
Date:   Thu, 7 May 2020 06:48:37 +0000
Message-ID: <AM7PR04MB715700DD8841E9DC4F9866FB8BA50@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200507004918.25975-1-peter.chen@kernel.org>
 <20200507004918.25975-2-peter.chen@kernel.org>
 <20200507064621.GA789457@kroah.com>
In-Reply-To: <20200507064621.GA789457@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [180.171.74.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 297eded9-7b5f-45be-ef72-08d7f252ab72
x-ms-traffictypediagnostic: AM7PR04MB6951:
x-microsoft-antispam-prvs: <AM7PR04MB69515065FECB4AEBC4E4D11D8BA50@AM7PR04MB6951.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mCCa7i8e/D34CiajvHKcT3mPIpqJ+XRv731p8VzaLYtF9PBJqa4OheebPrAnScpKQkSRc/U7R2gaK1zuL0uzPjkvfut4wDfEmNWd5vJn8xDOKiQJECnwViWN38/uFEBzQNm1Q0ZEqL5wuQEz6BoR5wyabiUeJqO91ANA0iHxOwvnQucTLEAELESL7cKwun9aDaSZQIzlubrys5wo9znb4ieHgszRFwXGro+9igC+BhcHMehIb/kS8TioRofoc0ETi4vDEVwywARg6rYx0mcS7tsjM3jhP2ro1VyLOrOeS5NlJ5eYmsgmoDLi4zpxib++YiXaU5YP+Ru655N8Q0BlIPtLEhb6taJqKX+3+Cupy+uy5JryzFGlqID/o/0gnCMDfwEPnfGEz8AUlRIw9E+V6ijK41zaONFWX40Rn7Js9COB37ZVyY7+YBdbLuf3J3BCsnOhOJQGfKG3o73TS9+7IQQQOn8BEVE1c7AGtVBY2KN4wGsm3bwRO7w9asCydnIHUy8D/MQ0wwzw3QQUbn2bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(33430700001)(5660300002)(2906002)(8936002)(8676002)(316002)(33656002)(4744005)(110136005)(4326008)(6506007)(26005)(55016002)(54906003)(7696005)(9686003)(186003)(478600001)(33440700001)(44832011)(66476007)(71200400001)(86362001)(66556008)(76116006)(52536014)(64756008)(66946007)(83280400001)(83320400001)(66446008)(83300400001)(83290400001)(83310400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: o0TQVZd9O15b4b4F5JczPIju9Eg6qKHG0NpjQ74MkSGtFLFNliRJPzetYSeLfO1J9DroFW35ysT4mOkiTDtA1ZoeLmeTuhOZeDqi4xJnSUrKYB/fofodhOlx/8uzazx3FyEqG7tI+is1DivuVh39eGqZgQHr8x0gvd+S2zZfHhTL7WWd488K8CP7zwzma8uAI5G07QDx3JBf7OvLLn7uFMuPU4eOZNP4315CoCoVUgXdptyyjNrAcUN7O5Kv8S58JFwZzSbMlx7cYpMHiJCC2m3yXA0QBuLnaeDexqQBOLEFbBiNd17D22fq5ngK8oohlEiZ3PsOwpNT9YgKk3N9bBQH1keBT5QXa3Qq+c6ZjRuPYxTdw1dCHUmhzzM2e+mklUovvLFMKO10xTSDg7d6Tx6K5wGxFKCJzIRzEr/iHZt/BxslX5Jx2oOcaPL02p65zSWhDtv/72vl85+KGUv5M+plSxgC8Xb4vFGagl0uABLa2185+vRnhf2SiLYPDlb6QHBAVFuEPvFrutUJJFnZSHSEIJ2JJRRT1biSYcdhclKyroxTI1XdcM1pAbFlXvDA1GTwHzP1jucxZ/dFIjHm2y6gppSMusGAIVFRvk8fh0MmBGHEiGfeRYtW+OX5uwCPDkChI1tTi26pqEQMrHxwtp0Tcn+uy1YskC1mVKjWZrGezEJRB16ZzdaENR1W3SKu3GiYToQ0TqX3RNt6lnXBAsc2FFdgbPQ7V1VmwDR6GNI2BEslBY/lc8KVWv53NltSghrgFp0JiIuXVRaOaQoS8dA3+nC6FdRePe+ybw9fqUg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297eded9-7b5f-45be-ef72-08d7f252ab72
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 06:48:37.2337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LB2NzihFC4NK7Kh5s1OqblU9AaOYa3oJ9gpM+6Zlh2F5rZ7cBboePK4FYi/CmkPtOEAHtM+QSDAeYLen4/IbGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> On Thu, May 07, 2020 at 08:49:18AM +0800, Peter Chen wrote:
> > From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >
> > Currently we check to make sure there is no error state on the extcon
> > handle for VBUS when writing to the HS_PHY_GENCONFIG_2 register. When
> > using the USB role-switch API we still need to write to this register
> > absent an extcon handle.
> >
> > This patch makes the appropriate update to ensure the write happens if
> > role-switching is true.
> >
> > Fixes: 05559f10ed79 ("usb: chipidea: add role switch class support")
>=20
> This should also go do stable kernels, I'll mark that...

Thanks, Greg.

Peter
