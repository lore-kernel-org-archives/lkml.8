Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF0BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB54521974
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="MnyCXKlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgGHIf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:35:57 -0400
Received: from mail-vi1eur05on2138.outbound.protection.outlook.com ([40.107.21.138]:3680
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgGHIf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:35:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUGhduIWuEVfdTs+tJvAunnhUaNhmb5x0yEspagnJJkts8gJHkipNj7VvjKUQFK2Zo5ReWmkodBgE6PtESp+8PUbRbDUQIUJP07GJoX/JzQBtx78OJKboyuQlLjlmi/NaeDgKLk5Rm4r3B/NaLAG/lf+J/oiz3fBnp0wBs52LJ2gVKWvNq7i+NYNhKyJNeWLlAWrO7/izeQnNNl8Fy9zgmS3YgtUO14t7FDNJQXgcPOnQ64LUff7lMbUWXZdQFCGNq7M0uUih0CT779ZuBNjY4DTtWnSPTa9ZrKSGBxklDPDKtc7YmgIiiqIf0iiLfotBKDhGeU1EhG8CcU/A1QhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N4GPlh9Pu4gIAVuUqfxp92+r5xtmS6Fy68pq7sdTq8=;
 b=ZAwvacJZgFQNQDl8f/Ij+Uep+lCtAe6gHM6zdt/OxH5SaA3Zomwvnxcz4ZsvlgzyhjLLLJ/QmAjZD56TUQWHX6L437G+vQa8WRFHs4s5Cmku3u25zZyrFozlA5VlGIT08bvB3wX3AtV1M7Q0IGZGY0fbK0rsRZgHp+T2Gyavtxbom42X4XotHNFBdKtRE/Yowbp3R6Jj/pfROHprJdto7C3Tcvow9SpYnvYg2zEEkLKgL6DaM0PS/SSYhvRkhgnT0LQe2GzL5FyHIrDFVBAc27S7YnletA3NBTaN1z/pxrIhVPc9saK7mBqOIYh5pcVjXu+OqiFFCyq6JxOK+00gzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N4GPlh9Pu4gIAVuUqfxp92+r5xtmS6Fy68pq7sdTq8=;
 b=MnyCXKlb1wK484jawo5jRfSS2GxepMV88KzIdcLzKvH8xfYOTmSE1Y46jlP9q1Qt+k3eE2ADWGusQ8/OE6d5Ayv8lHvz9Kdi9z6AT+LVxOiq/zZL2q/CN7xr3cAE5/2Lxc2JJieKfg/PLMEER4WHCw1cn2pOdsv4UOuJ53S17uA=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB7PR02MB4988.eurprd02.prod.outlook.com (2603:10a6:10:76::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 08:35:52 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 08:35:52 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH] habanalabs: set 4s timeout for message to device CPU
Thread-Topic: [PATCH] habanalabs: set 4s timeout for message to device CPU
Thread-Index: AQHWVPvENXvZleMdUECguNw1uuQfyKj9Wtpw
Date:   Wed, 8 Jul 2020 08:35:52 +0000
Message-ID: <DB8PR02MB54681675375F6370D8D3C657D2670@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200708074538.24016-1-oded.gabbay@gmail.com>
In-Reply-To: <20200708074538.24016-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [93.172.81.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37b48335-640d-491c-ce63-08d82319ecb3
x-ms-traffictypediagnostic: DB7PR02MB4988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR02MB49885D4FFB50E56A7E2E4382D2670@DB7PR02MB4988.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zM4psintxWrmoWMhroorbifuR0KK3m2DyxQ86g8u+iJZSOzmPo/Lg+LcetFMqTvFMBEJ409lfALa2URdAraBrcfb9J8etvFulq0vLOvJk7Wj9+v1Z4ezHrXGpa0qpl4toT7nBOW0ZbotWhh5UvCaub4lnJF129FAqXPt3gCgJgbkimVk28S8LWGEa/WXDDMXAGwRFC24+SkLkVtR2Ttiw7LsTH4/LuNVuwomMmby6EQQOtz7BYPBwQje2xULh7L3I+KQEZyPwwziKvyQ5Th2tJDjh+LYgbBpMx+ssTbX+lZhPBkN4B5mkMy1GxjBFMJ3QzuToURJj5v6DDQgnkoOIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(366004)(396003)(376002)(136003)(346002)(64756008)(53546011)(4744005)(52536014)(186003)(66946007)(316002)(8936002)(478600001)(8676002)(6636002)(110136005)(83380400001)(15650500001)(86362001)(55016002)(7696005)(9686003)(6506007)(71200400001)(2906002)(66476007)(66446008)(66556008)(26005)(76116006)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: h7n1QbqhHMfKpNoMF97FecMohL0qIuDQ3K8mJKtqvD3m17SPCC+rQXv5/K8TL65jSABh8JgE+t1HfvdBndCcUFVY7DBVJ0EUAx+MAoQLnKmT+M9hNKt1Z4yxNcjvgFok4KHRX8ruECLU/yqY9QrvLrPzMCpHJiwl8YwBgC5Gq0TMHI8UgWrqjUMjOq5KWMrx1PkZuWF8owFH9LOvVMzltjf5yX1/ylyUA7A+m6CuL/7jlyyzzxm5yZSlP0XOy2l7IqT9ZDGnPvHwHBLqplECm+IO539eF7DceROORu+aipwsOyXsN49nqcaVxmeL+rVYuC4aKgPbaMfMqS1k3ExurM0gBkPNDB4AS2KFJTxHf2GPZek3M6QJfIPTBQ/u7xdb6jwaYnp28VS6cpJM8ZcTv3VtpheWDeWIwdNPbRUVc15oHZq0HpQUBj8V/ohvj0XE0bMjYG+j4/pjWx2eFZILc01+hVmXNZ8OPY+bofudIu0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b48335-640d-491c-ce63-08d82319ecb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 08:35:52.3407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwhH+fkZTFP1ySB7k+1CTalccKrd13znUodAZG6TVxCJQ726VTGKPN3pKfDG92iFoEBXsOqQ3vh/g26UBCXSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4988
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 10:46 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> We see that sometimes the CPU in GOYA and GAUDI is occupied by the
> power/thermal loop and can't answer requests from the driver fast enough.
>=20
> Therefore, to avoid false notifications on timeouts, increase the timeout
> to 4 seconds on each message sent to the device CPU.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
