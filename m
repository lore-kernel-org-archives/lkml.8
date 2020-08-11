Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E23C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635DB206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="Z+5rlNGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHKD4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:56:17 -0400
Received: from mail-eopbgr1410072.outbound.protection.outlook.com ([40.107.141.72]:59488
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbgHKD4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:56:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0u1YXffGvX9DWe8zsjXXJyHor5NQwEGnDad2DyM+Xi2RlavGXoqrV3wKt/1WH9yn3cSY2JwQuN2aGrRbMqYEXb89ME03RphPCyn1igt8hMGBcJU1IC3ypn8KHfge2QC0lXpL0caScMaZNFqm75r30lO6BynTO39YFcELq2DgXJPNVgZe0P9mh/xY3ysFSkn1984ysyM7u2FOSy3ATn2YyZMHIEfbZ099xXMVrpsz7LXest8LWUGbAu+FcbxhgOjU3BuO0EueRBBXmsGeDBrr/1iTbpp/184/f+PReqHR2Xv0Fbr8++miIzcwHfRL/vtSL5nyzxbBY/3PGqgH4z+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EMlokuH/N452a5N5G/mWsJsEiaY2gfS0lQkXuy3U50=;
 b=I13HO8y+pcnwJQjCgzFUdswzRijEdV37TnKasxH75uiCdaCJ5Z90fo/ppRy7SjLMUxx/OfY0vuGEkt+vQhZt72UooHUAPKGEKslUYvaPdP5HCbBxkkMkVenADXmWeE1iSuRKynRS47gPx2D6G6kDFQB7Jp9a+oVl8FKeTJdLBLTWvYE6LlyD9pYME3RqOtoj+8BQJ0/vatZDNc9QjeP1hnUZ0I83BzU2X7LrH8q8sAr2xN53Kxi28Y77BzckF/dsBCojN07zD/kCJOkzc+6IEFJdkgIxKAuKXBsJu2Q+EehCur1hLye6TmiBHBbGB+JP68kTv2CXIIW2aTMnTEqLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EMlokuH/N452a5N5G/mWsJsEiaY2gfS0lQkXuy3U50=;
 b=Z+5rlNGSKQTugQH9RFqD0rZdxMsvgNOIQgY0Z0ikLQ/a61UvDc7NkQ19GQyqpxgx0Mi3jjcKpGaUIUFpmie0e8HflNGn8N2UFfqGQIuRUYNncgql457HYw7709d+UkALfGtxmiRbGWwCo0ZPZj1ldVpmRGO0gUFNAdRw+8PikSg=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB3791.jpnprd01.prod.outlook.com (2603:1096:404:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 03:56:13 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 03:56:13 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Qian Cai <cai@lca.pw>
CC:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 00/12] HWPOISON: soft offline rework
Thread-Topic: [PATCH v6 00/12] HWPOISON: soft offline rework
Thread-Index: AQHWbyom92sGRlXQfk+BXW7m7bWNQ6kyO+2AgAAJfQCAAAL3gA==
Date:   Tue, 11 Aug 2020 03:56:13 +0000
Message-ID: <20200811035612.GA6143@hori.linux.bs1.fc.nec.co.jp>
References: <20200811031139.GA7145@hori.linux.bs1.fc.nec.co.jp>
 <6214D3DD-7EB1-4598-8DA2-344430EC7858@lca.pw>
In-Reply-To: <6214D3DD-7EB1-4598-8DA2-344430EC7858@lca.pw>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b63267a-06e0-4b65-1ed2-08d83daa7db4
x-ms-traffictypediagnostic: TYAPR01MB3791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3791BC19CF91FEF3B159961BE7450@TYAPR01MB3791.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSKHERaPs0F1C+4WKfJMfFWvx1gAN340BNzYWBb620RkPJk6cmkG0JXmbbI6P4gEsVtq1MWD28wNvgHtKOuxBYG0S6jM8UUmm3d/DmL/2YkXpoQnOfmZ4Y8uNb3ymY73E0VT2LQem7h1h8AY3bBk8fJ9iN0OAJNBLxYwrRiutGdNk/ueZog28S+v7kFGgeZdeoOsBf8oPkBxed/Q3uQQzo2JZsECebR9V27GUZw7wlMXeBblqIyBYevieTUf6R8gdCddOTcmNjyHvfbQelsMoTuhPsQ2ITxka6bLBRtvteexJZGES9r/wVF9b8PmQtHLcMQdoWH++uddy3why/dZlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(6486002)(55236004)(54906003)(7416002)(83380400001)(4326008)(1076003)(26005)(6512007)(9686003)(33656002)(53546011)(86362001)(8676002)(6506007)(66446008)(316002)(64756008)(71200400001)(6916009)(186003)(8936002)(66556008)(66476007)(76116006)(478600001)(66946007)(2906002)(5660300002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DNF5CENluYoOh6Ra0g5myIpHopgnP1tjEQok1llmtfeV32Z6g2HEl2MbOJLKbubKa0mLXnEY/1PdIx+4vib4TULUKqHbt4D84zQpVwIuhTDoBV9o5588o5z6Ww6NGKxNzp5STuAbLI+6PEVJ7Zl29Osj32pRxsIig9YsP1//blo9K0g/unmf8Ge6wQ0ANvwNBorajadp0QeVmmzPlr7qNVt2aPf5x6UdvoYXBse4zNJByPXEL94uwVjyXin80SnEFX1Hii0ePuCE3G2EkFyOe/VyM4dX4zJiS3/KAUFd9nmJdDJ6+36yrT9ryGKybaGWjH2hDuUsrdgtsxOKZNIu4WPU7d3no4bCwKMDPNgrO+vwpZRuDmpwG6Bc92eezBwXvSspGGAdF+nrbiyvNPDaf6/muYcsUtSPH5mk2Fx5BXRH4Z1MvWDjkFSQOqdPtmt67vIh17YCKiELoW+uXTAU4dWInLxYARXxmWxORTi4T3uLNGp0Ho1fnqbGmCV6Dxxpb09em+rFUzXb6wS80wxeUyp3noXRSUpXML3tdznLnFzwB2l88vPMFlDJtQAEXHQ5cvrW/RWNSrdPgiiQOB78UzEoqHKcOOvhvyYMX9GR8b4bG1W5oYF/kpSauZfJ7jiDGAVJjTnym3iUOMkg2OOpxg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D9F0649DD0AC534BB4DD3615A63D93B3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b63267a-06e0-4b65-1ed2-08d83daa7db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 03:56:13.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ldbvt3n9ihfLT51bnP/D7b6WOmYBv8N6eSfIff1bsrD/5i9Flx0Rau5kOMKVaJOdsp6CPGasgccHrL5s9bNeSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:45:36PM -0400, Qian Cai wrote:
>=20
>=20
> > On Aug 10, 2020, at 11:11 PM, HORIGUCHI NAOYA(=1B$BKY8}!!D>Li=1B(B) <na=
oya.horiguchi@nec.com> wrote:
> >=20
> > I'm still not sure why the test succeeded by reverting these because
> > current mainline kernel provides similar mechanism to prevent reuse of
> > soft offlined page. So this success seems to me something suspicious.
>=20
> Even if we call munmap() on the range, it still can=1B$B!G=1B(Bt be be re=
used? If so, how to recover those memory then?

No, it can't, because soft offline isolates the physical page.
so even after calling munmap(), the side effect remains on the page.
In your random.c, memory online/offline resets the status of hwpoison.
So you can reallocate hugepages in another run of the program.

>=20
> >=20
> > To investigate more, I want to have additional info about the page stat=
es
> > of the relevant pages after soft offlining.  Could you collect it by th=
e
> > following steps?
>=20
> Do you want to collect those from the failed or succeed kernel?

I'd like to check on the succeeded kernel.
Sorry for the lack of information.

Thanks,
Naoya Horiguchi=
