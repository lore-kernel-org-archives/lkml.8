Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C969C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11ABD2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="Uu4IsC2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHRIq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:46:29 -0400
Received: from mail-eopbgr1400075.outbound.protection.outlook.com ([40.107.140.75]:2272
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbgHRIq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWFT6Op+r4L8el/5sVj1GASuqvnDrS3wn67qgIJGo3RTTep5oPfoSs5PZ796DCA1nmmaHIWbR+8+6uJCE8nE5bRMo7QCEaGA/tPB1dbLLKutzlt0a7xraNSRLYtkecV2as5JJ7uL3npcLLVt6Lt+GDeSJEBYU9nxQADXK/sCjjdNcM6KWHQAxmw00ThfjeGxBJlQ32eH9KQpWVIr4WvtlAuHZQnFoOkHDpcBFoFewscQkxVvDyGNB9ZLl8mHGHkvGZbBfSffpS/nMW/2ZqbynHuNLVOIELUmAcYYP8LiBc2bCCak6jI40FU1pGZIjKieZr8/E0QJwex+UL+wcui4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kJpPpb2tM1i8t/9DA6GQ8XakZOuNv6Yw9EJoONomGY=;
 b=STfg2koqpF3yUVlnYRcXKT711fwZpEODYxK+UzNljH0YvUnmjr/96Zd0MWzNQjbGjdqmX5jR313OrNvPX7jvHh6AAU8Z64xZPoQH0WLPoxz9f9XybMzZPFQuwkLqX1NTZTx7jwE5+sBfad2tmmgzPAKIHodGkTMzPSeevy0veFXhvsYmT3KFgB+i/cqlYSbXhm+WpGI5aYEMUwWvQla6UXpKalckiK+qIwU1VHOK4EckyUIDAQJT9D4KrBqZqLP5AmRC6jtot3QxEWPVUAF9LkpeMUvFQJQbNVETN5tqtsIG3vvtJACtmtHfN7n6e5KgjrkXxX/GXlgsS2khiLRKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kJpPpb2tM1i8t/9DA6GQ8XakZOuNv6Yw9EJoONomGY=;
 b=Uu4IsC2+4porSLh3dq7O3sQ1GLLCJGF/LY58M8XqmNLKZekOYU9EZodiraAmVk4DSuWHFhwCWAdBVOF1Ubo3YsGwT97+UyRyTv3da9N03I6JKUZJao9yWAKii3JeZXm2pjnmcJaXDHBMRplDNWsIRt26R/6Tcw60BUrRz/sYoq0=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB3584.jpnprd01.prod.outlook.com (2603:1096:404:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 08:46:23 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042%7]) with mapi id 15.20.3283.023; Tue, 18 Aug 2020
 08:46:23 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Xianting Tian <tian.xianting@h3c.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory-failure: do pgoff calculation before
 for_each_process()
Thread-Topic: [PATCH] mm/memory-failure: do pgoff calculation before
 for_each_process()
Thread-Index: AQHWdTpfy+qolaFA5Ee6XfcA6pvtAak9jaWA
Date:   Tue, 18 Aug 2020 08:46:23 +0000
Message-ID: <20200818084623.GA30688@hori.linux.bs1.fc.nec.co.jp>
References: <20200818082647.34322-1-tian.xianting@h3c.com>
In-Reply-To: <20200818082647.34322-1-tian.xianting@h3c.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: h3c.com; dkim=none (message not signed)
 header.d=none;h3c.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46053f29-ef1c-4347-605c-08d843532ff6
x-ms-traffictypediagnostic: TYAPR01MB3584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3584B4A9B561F6DBAEAB873FE75C0@TYAPR01MB3584.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0ppkKxcv6QncxoCUoK5m9kp1Pu+IdKSAggkjhrTFj5SFzO1Gb6dc9rhGohFHsDf/CoQ+Zi2v062IDGfYc4/jKrKLQe5zTB1X030rlxN5R+ZXrKqVX4XwWDUNSoO3EppI7NMintfMvjouZNM/13QQhqfnv/b7SE2P4OvrvnMPuT9bk70HxRdfW7aVaXPzO2WrJJTBLaZYIsmLrxOKSxoUtdAJKFwSFCJQD4kl6HvM5TXwMhK+6hbF6t2eJLC6wHFtS76OAxXJVqagwdWT508Id1/iqk8GqEgjrks2ajqcyp/ki7Im/y+6kjb9Y/lPHHOtcgVjTWuPQDoWu3omtQoOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(71200400001)(33656002)(6486002)(6916009)(66476007)(1076003)(5660300002)(186003)(66946007)(64756008)(478600001)(54906003)(76116006)(66446008)(2906002)(66556008)(85182001)(316002)(26005)(9686003)(4326008)(6512007)(8676002)(6506007)(4744005)(8936002)(55236004)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QJi2jZ/1kTErR+PSIim98l3/Uh8ayxCFx2JCWXaZ3ny5kdAGdsFCL1Wqb3HtYNWRnDGHoUIEdNwSN/Z949Jqs1LQYyDbKvTIYr1DEYvnbdzPd74H4Q3Gdck4rQK1RmRFW49sBKr3WYkj/NRd2iSDPAnh+Xuc0G0wM4pbrOM+blb7DTawuzDe8BytFLcoIewEMUrKxTHvuOitlgG+/Y6lxdq2YqJUJG9oRC2P/7y1EicCV49F56bDeL55BI/XgGXCCwtb7mrwHHtkpaONB5S+7TJb+eDY5upSU+T0z7RfcpnmUKNfSCZAPm81LBE6dVXWjMxbT3kLeWdD23qQImY+0rHVI7tshRJi6AnbHjygugHU8alN6IuBxKA1CkARGlFz5nLyk//e0iTZXr/NHRkEiktL3h+iJApdfu9w0Yon2SXyWT33v1dqmde2dU5sjgSTHZbvrVZABWvpWyLKXQzVQNJy70adKNWVqEdAt73c5t6dWfqQQar9DnvWIBKjkbcVI6pUQrmL9HEHdpOhi5yEiiT4NUXwFiNbQWtAhd/QPTbTzd+O7onFia3xFWVdvEXJ25uEk/fuuOpMZOa1EL6z5ic68H3jnG6WwjDIEwC+AHVHqdDbMP3IQwsfEXVxJo7tkHO/EcQgd2SSCj1yV6Ibdg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <FBD6ED68B8D270439437618D4728E0E6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46053f29-ef1c-4347-605c-08d843532ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 08:46:23.7888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIKIvPCGeBQTr6gmTzxVu5ZQpWZYTcqn+Uo+CLS5GW2YG2GnF/CEuDjMYRie7/6rfsrNEZxK2cSc8Y/TWuJdKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:26:47PM +0800, Xianting Tian wrote:
> There is no need to calcaulate pgoff in each loop of for_each_process(),
> so move it to the place before for_each_process(), which can save some
> CPU cycles.
>=20
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>

Looks good to me. Thank you.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
