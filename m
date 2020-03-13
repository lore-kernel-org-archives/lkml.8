Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DE7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 06:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACC02072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 06:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="cwKDEo4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMGDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 02:03:40 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:33652
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbgCMGDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 02:03:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPiMu5RREhHdvBFtwJBY4OKp51ImdsWYdp6VRwgZubnevjN4ug2bUujZYYEYep0xaeHI7Zmo1h2bwzwUTQ6xBLGRbWUE7hR1JwPT/ua3njqEt57dUax82Uikk5+RDUfjN0xz0/BV//TOLMRc7NgI1absOeGIof+GXqCPaUQDNzMQq+IuDMNVyc1H6YFCBLpTNqxwVN3V4QMLJsE/2jTVQmDU5oR/2yAufNZrtBJybImd3H5CwjNIYfqKMyAaBzMcvAOUKKtPMDot9jjQm9DMRkfn/0ISlKCXjX/Knx2b2tbOV/lJ0X+/iZv+9sr2bW5s2iWv7l+z9sGjV1IHodyKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3walBZMtsMuImfJYoHGRfANXf1L7lmgZvKNGQhx5CFo=;
 b=Tfh0GoT0HKSIZKlLNhxlkDDIngbx4QBokHCrrXFk8l7RwOaBOd4nRIG79tOBfZdNLTPEpfqdRZm25HO5cgCH57+tFDu0ByJDjlci1louJrl7cs8j/JI6HUC8DW7K98hrQ8LFZAaQWTPbQWASZ2RJTMwIV+33irCwLVYxyDiQJnSi3m834OpKeZBnf90aDQyqUB2IkgWqLgunauVi80m0rt7ch386IbcHAKMFQGU2eBls1l+Dw78YTv3boAHkSnltPK1UBirMaMdUMSOoAR3AOzEI4InA0TCFkPevuNN9lrlfg7oecXUh4Rq/Q6lgEsvBlKHvamk7cJmUbLCg++Vqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3walBZMtsMuImfJYoHGRfANXf1L7lmgZvKNGQhx5CFo=;
 b=cwKDEo4l4PnMKx3Lqd/3vt51HKjBL7nX9kA01f9IuJs0pTv/ING0y62N5KXT6oN8NwK5MXSJNYj9x7MQbHaED0GkAmYvoIKNaZxaR5HRODZC1nDlLrh6eyhMazBl71azYaVMK0cNzIMXAB6kiTbWxTvkZLu42WC8AD8jMNc5mvQ=
Received: from MN2PR13MB3552.namprd13.prod.outlook.com (2603:10b6:208:16f::22)
 by MN2PR13MB2814.namprd13.prod.outlook.com (2603:10b6:208:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.9; Fri, 13 Mar
 2020 06:03:37 +0000
Received: from MN2PR13MB3552.namprd13.prod.outlook.com
 ([fe80::c8a2:5e5e:9769:6a8a]) by MN2PR13MB3552.namprd13.prod.outlook.com
 ([fe80::c8a2:5e5e:9769:6a8a%7]) with mapi id 15.20.2835.003; Fri, 13 Mar 2020
 06:03:37 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     "palmer@dabbelt.com" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: RE: [PATCH v5 0/2] cacheinfo support to read no. of L2 cache ways
 enabled
Thread-Topic: [PATCH v5 0/2] cacheinfo support to read no. of L2 cache ways
 enabled
Thread-Index: AQHV56zMBsn2T2H8dE+TYqjF1YFIfKhGKqMw
Date:   Fri, 13 Mar 2020 06:03:36 +0000
Message-ID: <MN2PR13MB3552ADB09621545F67A914E28CFA0@MN2PR13MB3552.namprd13.prod.outlook.com>
References: <1582175719-7401-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1582175719-7401-1-git-send-email-yash.shah@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-originating-ip: [120.138.124.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b5d3a46-20f6-4ea3-1efa-08d7c714452e
x-ms-traffictypediagnostic: MN2PR13MB2814:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR13MB28144008C5C122272CE1FF1E8CFA0@MN2PR13MB2814.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39840400004)(396003)(199004)(8676002)(6636002)(19627235002)(7696005)(316002)(966005)(110136005)(186003)(44832011)(26005)(54906003)(52536014)(64756008)(66556008)(478600001)(9686003)(33656002)(55016002)(86362001)(6506007)(71200400001)(4326008)(53546011)(8936002)(81166006)(66946007)(66446008)(81156014)(76116006)(5660300002)(66476007)(107886003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR13MB2814;H:MN2PR13MB3552.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbG4pyzsfDSEU79EQyzB+6obtAuS+MGzbFgMdmWKBTtulkvp5uI+vQwbMSldut+RMHZJO4SKH5t3n6udo8lEELSZ5IX71LIg6y9wvFSLL1tiuJhwHRs6JqqZumBX5Hh5QjJ4u76FGcPG4BCDe5+WC6ww+Pdmw2SzgteqrQX0kCkms4dUjmJhFfWU6/oNSHBCicibfXulh/SqgFSs4CmszY9kH3sxAL9l/lML6aZO+Pwztb/c1DI338Igb+y4RPSrNbgvVji7vSJ1IYfdDwaXNJqOzX+IMxrkedDjtnECzihE05HBUavS3BOuxgGfqCu3ar5ZZNvEgKHSYONcx/t42/E3vI3iQv2XsoJGt0AhvGSuPDVe6gnLBhpXE4sraWlr5PS+vNpxpg2HajTzdGHK8xhAbpqU14eA3WSdfvZxLMzSvNxmCjH8ioYDGahd4ZFL7+/rJx1SVVKA3z3i4+ipmzFYLSYMhtwXmrgpMfDqD9ifyvMFNkQroHZEXQDSdR1EPv8tbE19g4/BmTnp0DSGGw==
x-ms-exchange-antispam-messagedata: Zo2QwQCCR9JS5w4DXVtUpikww45zTV6v7DhBQ1rt0YQqzWK/nFxoIgnoM/+hxk+YEb/C0OBJ5cfgWebuYt1M5UyQYXXMTRwFdAt5hCRPblq3mI5m15xqJXjpfCqS0Q9DU+vLZ7VlhLZWiMKTBvi/uA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5d3a46-20f6-4ea3-1efa-08d7c714452e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 06:03:36.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAN4kTb6qhBGP9uOdfwmUqKmrGenAD1143LR7nEGLUC4lZO8sCr7KjQbEB3/WmSSlzCz2la8D8XPoSeVpFwjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments or updates on this series?

- Yash

> -----Original Message-----
> From: Yash Shah <yash.shah@sifive.com>
> Sent: 20 February 2020 10:45
> To: palmer@dabbelt.com; Paul Walmsley ( Sifive)
> <paul.walmsley@sifive.com>
> Cc: aou@eecs.berkeley.edu; anup@brainfault.org;
> gregkh@linuxfoundation.org; alexios.zavras@intel.com; tglx@linutronix.de;
> bp@suse.de; linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org=
;
> Sachin Ghadi <sachin.ghadi@sifive.com>; Yash Shah
> <yash.shah@sifive.com>
> Subject: [PATCH v5 0/2] cacheinfo support to read no. of L2 cache ways
> enabled
>=20
> The patchset includes 2 patches. Patch 1 implements cache_get_priv_group
> which make use of a generic ops structure to return a private attribute g=
roup
> for custom cacheinfo. Patch 2 implements a private attribute named
> "number_of_ways_enabled" in the cacheinfo framework. Reading this
> attribute returns the number of L2 cache ways enabled at runtime,
>=20
> This patchset is based on Linux v5.6-rc2 and tested on HiFive Unleashed
> board.
>=20
> v5:
> - Since WayEnable is 8bits, mask out and return only the last 8 bit in
>   l2_largest_wayenabled()
> - Rebased on Linux v5.6-rc2
>=20
> v4:
> - Rename "sifive_l2_largest_wayenabled" to "l2_largest_wayenabled" and
>   make it a static function
>=20
> v3:
> - As per Anup Patel's suggestion[0], implement a new approach which uses
>   generic ops structure. Hence addition of patch 1 to this series and
>   corresponding changes to patch 2.
> - Dropped "riscv: dts: Add DT support for SiFive L2 cache controller"
>   patch since it is already merged
> - Rebased on Linux v5.5-rc6
>=20
> Changes in v2:
> - Rebase the series on v5.5-rc3
> - Remove the reserved-memory node from DT
>=20
> [0]: https://lore.kernel.org/linux-
> riscv/CAAhSdy0CXde5s_ya=3D4YvmA4UQ5f5gLU-
> Z_FaOr8LPni+s_615Q@mail.gmail.com/
>=20
> Yash Shah (2):
>   riscv: cacheinfo: Implement cache_get_priv_group with a generic ops
>     structure
>   riscv: Add support to determine no. of L2 cache way enabled
>=20
>  arch/riscv/include/asm/cacheinfo.h   | 15 ++++++++++++++
>  arch/riscv/kernel/cacheinfo.c        | 17 ++++++++++++++++
>  drivers/soc/sifive/sifive_l2_cache.c | 38
> ++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
>  create mode 100644 arch/riscv/include/asm/cacheinfo.h
>=20
> --
> 2.7.4

