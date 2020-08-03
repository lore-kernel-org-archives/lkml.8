Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B611C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7BD204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="t0pMPQre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgHCMiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:38:01 -0400
Received: from mail-am6eur05on2118.outbound.protection.outlook.com ([40.107.22.118]:45056
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727850AbgHCMhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:37:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkJV+SD+TmWv8t5FtEch6chh6KbkeELojEV638fW9lVophjMjNZgw3CeT3P1Yn5IajoxCbyD7c4GAMXr1AObpl0h1HFjNrrL8CUyAa30EkDE3l5Kw+xzyiwRACcwc/yaIxVHKUgUHnqP/lVj9BmTiQpkxvj5JQagoNq2ewpnU7dcm82EcyflEsNt6uFDKRapCfNhF7gLWW+/nme1hJUCglkwoi9jHHyzSgzWPD9t413qcbYqNXnBTHx1gPx377lKhoDxKm4bmnBqjFio+7+aNJ9CYj066r6rfjJ9Q+jhtfJ+wJdOeS6ALamykFYqZJyMRVyhPfdlcqAZC4izZuKkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asfEP+lSwg/LLxLmClZ6FlL/bbOSS78L0Ja8CsV9dtE=;
 b=J4eOnr3TMQmZ97o56cPgpLDSCqBsBTy9IRgelr4V5b5cg9ZOEmnrZWYr+ui3mKvsnBp6UQpwqw74u/wqBauTuzSp3mYiMnkEUyhsX1KrR0nsZbABZezW8ZD2CN96AlvophwQsnmD8lI2FA/D2KVmgd+Zc6SqekPslUZch4syENLdvJhPAjrxQSHFBb6/hw46oDu7yf3ZNGckM9d8GqL2muCxdrbP3GrkTN74gHRaZEAKTvsyHk3D3FJdFETtW9P2lh5p6dR3UT+JWVWH89Lxhfu4tIztKB2TxaGQSYxJkbBSs83w7RzwT81Arv5HpxxeZwY8DS4vuZScGdsRcxu2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asfEP+lSwg/LLxLmClZ6FlL/bbOSS78L0Ja8CsV9dtE=;
 b=t0pMPQreMpb+KxRC1lmdTSGxR0g98MAy0/GpVwx/lWpyQTCX2+T1D22lc600VwdgWUHKQcq3V/sBpYV1gZup9zSuzRzxtIshuMkgf7RB4HnsWC75Oqx7w8ReMCQmKVEjRaisY16uRHlQIEn+EEMzo250FGLMYdK38R/WVxFaAFA=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DBAPR02MB6008.eurprd02.prod.outlook.com (2603:10a6:10:179::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 12:37:41 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 12:37:41 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH] habanalabs: increase length of ASIC name
Thread-Topic: [PATCH] habanalabs: increase length of ASIC name
Thread-Index: AQHWaYxqOuUUqglDB0OnEyp9iVHj0qkmUfng
Date:   Mon, 3 Aug 2020 12:37:41 +0000
Message-ID: <DB8PR02MB5468A881242A13126D8083FED24D0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200803115118.31211-1-oded.gabbay@gmail.com>
In-Reply-To: <20200803115118.31211-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d309b8e0-d6f7-4fa3-1581-08d837aa0371
x-ms-traffictypediagnostic: DBAPR02MB6008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR02MB6008D60355D459004BFF2617D24D0@DBAPR02MB6008.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+hWs5LY8z4GF/8seOMgzQViPOJvpcJFepCsmkUi9jlN89HiozRBweTzwAgAgKssqaLoEaLgKOYRMvFaN2UpFkQB8i24UcaKPnCuKIEarF3ED6ySP0aUibzTa4DecEtAHc9X3z/AN5ye7KLNUJ4S1zq3xZcvzK0eUZaVYmGbEd9pCEsZFaxiA3Z+BizfHrQ9u8MtatCE9ushJ+oOf6FJDEVglqoo7HHJ5T5rRmNIxt+TR/NhMP3SvMTG5pdSOUy/QYaC+70HrnEX7jUqFjDvLqrQ5mYd6d3pd+QJeTCjQo0Y54x3wsM8S7RG9BDEi2wv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(366004)(346002)(376002)(396003)(478600001)(7696005)(558084003)(66946007)(6636002)(66476007)(64756008)(66446008)(66556008)(316002)(110136005)(52536014)(2906002)(55016002)(8936002)(86362001)(5660300002)(8676002)(53546011)(33656002)(76116006)(26005)(186003)(9686003)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /fuBl6LxTJ6f7GLrHV2owq0aHT725m/MKCQQX5qBPsTHvOzk9NxTDopgKj/MpDzrIuup/cf8iJoLRtB5cOSVJWB6Q+ffJXgL4ICNyu4NmN43hRfGTXbSucchSunhqoZAtUF3mSov0CluEwZYw012X5AQx4HUqxUSD6RDeE5994U/A/UhKUa6g0slcYpkbmt435j82IxBlDplUurQbwHSjQBPll98Tz/OH3InFw7JjQHg/Rhp/YrF1wfOM2PCpKpHVqbdTQtE69b6CanY6neCbz9b0gaLIIFFfhXBsryGvY7uIlhuwuFjI07IjJ6oQftngt7Xtue+vHb7SeEsHGeAAQlmufDAJkGyjir68Tb8H6LGlWOwbuucIj4so21vkvIwguK4wsy1bka7d4vpfZQH6cUgIbFTAL3F17u8Yt4nb11cDTwZu2grAJVZ1DE1JhdMkm8GiDvKL6uCsBpZCmyw9+lDiHp01KACjEw+Cy3uAFmSPk74UPKI9KB8DLAzH3TvAkHk0eKlvk6rq8kHvOCKy5kGHJV8Svo5Jun7B6eZu4FOVAw0Xl9IldwPdJjjVeIt3y46vZwObHX7MlEd8qoUhBBI/6tKOSFU2TJX7eGRA10kvOp9TkFQLP6YWu+542XKCfp41K+BGb986mBujvnfgA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d309b8e0-d6f7-4fa3-1581-08d837aa0371
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 12:37:41.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2+UnNsCcZpplYxT/VuLFqmWgjVoB9MnEgtswZK6mmckc17Rfo3we85E/Rus2NGx5tQKtai5vBXsrnuVOcpF1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 14:51 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Future ASIC names are longer than 15 chars so increase the variable lengt=
h
> to 32 chars.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
