Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A62C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916CC2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J2N4Pq3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgERN2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:28:17 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:7813
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgERN2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:28:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpczSoBrXRYQCd/fxBoO4540+b3/0Hpzzb98bKH50zkKIjO8GCmi6ksSDv+v+epsb14uxHF82JqnUdBYAfMLir+4MACYC0XbW9LWnNYGLXsP68ejNGXbCVY5avJhyNFHNuuiDsw72MdtbhrbuZ+drHZ3FIVSOItDjBU9xvsl4t/HsYBOrPYWLcHNVfRoHc8Rtw6nDuR6niszrTcRkHcRzb1sLvJ1u7bpuTs9cF1gpKxERtud+2qFi61tESiOYyQuWwzmKqiAyUvfRVhv/hQGkAHlz5RXcG49K2cx2dWQAZgwwz0EhJeK2QaIJ9pj8MVxEgKpbiMx4RUmGyyYmhiEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NTkV1tH3rglpJhKpixuV+BUkYIn++YTeD1ejcZEzeE=;
 b=Bq0J8TmBA2tr4bN107eNSqnY8nMj53WTAeOYxq4Wgx2EcubMif/z2c1hbemCsSO07+vuUyFaMS6JPqFa2w6Jcqv0DVDdMuDymCd/Fup9SlZBj3LZRQJjugmpIxzLa/RS9wzoE7E80JI2XfWwmAsIvTFs9Xw886LpuBvqkzRVvoh57jCmN1i5hDY3HU8rdrANqamxS503FQyKcMZ7lKDGWDqpo/bXednZ+sDwA2JsK4QGVFD8ahN/6DGXsisg2EA7471VWG/KWmEAda+fWLm5/tD6hcQ5gbhG/YZ8HQfh/Q+8CTkOImUfvfoojy96lwsMOC7P3J5HIMLwsR7e3iHQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NTkV1tH3rglpJhKpixuV+BUkYIn++YTeD1ejcZEzeE=;
 b=J2N4Pq3MBxJb8c7mBUPkiuJILqYlbg9ODnF/xo/S4NlPlO86Eljupz5rGR5sKd6PcEw6krmcKb8a9yjcOu8XvoGTeBUjF+NnV7YFKB7p82b6Z6Q2rjBZB3Wx04PhS7fREecOiibPzPdDJzHTiQF/JgCcPogZeqWXd9JpqeR6qRc=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2919.eurprd04.prod.outlook.com (2603:10a6:4:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 13:28:11 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 13:28:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 00/14] remoteproc: Add support for synchronisaton with
 rproc
Thread-Topic: [PATCH v3 00/14] remoteproc: Add support for synchronisaton with
 rproc
Thread-Index: AQHWGnMtQQcf4J8dJ0yMAJ0O0OhEl6it+yTg
Date:   Mon, 18 May 2020 13:28:11 +0000
Message-ID: <DB6PR0402MB2760B52EDFD1DB20AE0BDE3588B80@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc4edfd4-b92b-4a74-3a1f-08d7fb2f4fa1
x-ms-traffictypediagnostic: DB6PR0402MB2919:
x-microsoft-antispam-prvs: <DB6PR0402MB2919B8E2CD1CEF8A106391C088B80@DB6PR0402MB2919.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8dHAwoWB7J792iyQPJNYu0ybagGcYI1omcTOLpWQsgzsB6mSvEPW4ZHTGOOhyza+Lc857bBjR9oRMx3DxsXJkNQRfS9cND7viVC9hwGWAChVk/4pvfL59eY2w7aqhonlfxBQ6JUQrT7mheDOSOlaD6Y9Fta0WcQZchZyYDb6tJXB9qxQofKC/tYPLJ751KmoltRA2g9pJp2uBRyQA5pze1A8jl7C7QaBprAoSQ3a5zOqxVxeNYlF4NkvyZbeXjNkRvDhcFH9s3FT4Z241+aUdfzGVKlq2QU+F8JJAJfPEKkpG8yFBDD4BmHyMFV3VE6InAKU66ICuia5HmLuRssJIel4lcIjo/nue1zdjQMCpFDC9Ba8BNPZZ9Kst1Q88ksTdYaezxJwa7cDoddXL3xZPucBQEC6toNEyA6qvXF5+WHwWFEI3g+Oh2nUQnX+u+YX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(26005)(186003)(44832011)(8936002)(2906002)(33656002)(110136005)(7696005)(6506007)(71200400001)(7416002)(5660300002)(478600001)(66946007)(66476007)(66556008)(64756008)(66446008)(4326008)(316002)(54906003)(86362001)(76116006)(55016002)(9686003)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JeVJeF5DTU/CzJgfw9B1eg9OJ/gXG/n5asj0LGvRUlivV5lOIfBpd67jVh+CqJHs2OpwbfQPBDJgLADBh9K1PSJwd0mqFFJapb8+RUSNkm/InPHUQ3v/JnK2SQf7vT2oG7IoYFyAaInjQDS+oTtb5Wpbbv4IdR9ZKF4bAS+af+puq+kC/iAzVXXxEuTYB7qPb5MdA6c6jZGX8myAmgjU4ggk9LCD3JEw+IcMhvLTioSBI00CEtA/E+abhnXMbATn07GwWn8IK1HnRU5IX0Ccz2/M+3ZgtfJS4+9oj45pKbllBWQ0wVNWAxv8wSCaiQiYLjJe96wUDDw7vTd4mv6HiJCRAatGbop3OrCT5bqQiUAwu21xoqOCUn2v0eMkp8iytZYYjuT5t0EXOkMOb011otr+ToA+FHoFHokpPhJw573rjO+YcoMpcH5uEzft0LyWOvAKT+ptrlvUvGtslQKEwaWwlsfYL+SwIX7uXG0EHztlIan6+sjXThcKPwwjujQp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4edfd4-b92b-4a74-3a1f-08d7fb2f4fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 13:28:11.2886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAHhwTawZecH8uw88LXWNC3Kd/OEWyATfQrlewU6wAEm/RVJJ92eQ9DI1lu7FGIZkg+3Rs352O7EMJLc7sa+bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v3 00/14] remoteproc: Add support for synchronisaton with
> rproc

What's the status of this thread? Will this be applied or requires a new v4=
?

Thanks,
Peng.

>=20
> This is the third revision of this series that tries to address the probl=
em of
> synchronising with a remote processor with as much flexibility as possibl=
e.
>=20
> Two things to pay attention to:
>=20
> 1) Function rproc_actuate() has been abandoned to avoid creating another
>    way to start a remote processor from a kernel driver.  Arnaud expresse=
d
>    the opinion that it is semantically questionnable to synchronise with =
a
>    remote processor when calling rproc_boot().  We could rename
>    rproc_boot() to rproc_actuate() but I'll wait to see what other people
>    think before doing so.
>=20
> 2) The allocation of the synchronisation states has been split from the
>    remote processor allocation.  A new function rproc_set_state_machine()
>    does all the work now.  Proceeding this way has made the patchset a
>    lot more simple.
>=20
> Other than the above I have tried to address all the comments made on the
> second revision.  If a comment was not addressed it simply fell through t=
he
> cracks rather than ignored.  In such a case please reiterate your point
> of view and I'll be sure to address it.
>=20
> Applies cleanly on rproc-next (305ac5a766b1).
>=20
> Best regards,
> Mathieu
>=20
> Mathieu Poirier (14):
>   remoteproc: Make core operations optional
>   remoteproc: Introduce function rproc_alloc_internals()
>   remoteproc: Add new operation and flags for synchronistation
>   remoteproc: Refactor function rproc_boot()
>   remoteproc: Refactor function rproc_fw_boot()
>   remoteproc: Refactor function rproc_trigger_auto_boot()
>   remoteproc: Introducting new start and stop functions
>   remoteproc: Call core functions based on synchronisation flag
>   remoteproc: Deal with synchronisation when crashing
>   remoteproc: Deal with synchronisation when shutting down
>   remoteproc: Deal with synchronisation when changing FW image
>   remoteproc: Introducing function rproc_set_state_machine()
>   remoteproc: Document function rproc_set_state_machine()
>   remoteproc: Expose synchronisation flags via debugfs
>=20
>  Documentation/remoteproc.txt             |  17 ++
>  drivers/remoteproc/remoteproc_core.c     | 197
> +++++++++++++++++++----
>  drivers/remoteproc/remoteproc_debugfs.c  |  21 +++
> drivers/remoteproc/remoteproc_internal.h | 123 +++++++++++++-
>  drivers/remoteproc/remoteproc_sysfs.c    |  24 ++-
>  include/linux/remoteproc.h               |  27 ++++
>  6 files changed, 372 insertions(+), 37 deletions(-)
>=20
> --
> 2.20.1

