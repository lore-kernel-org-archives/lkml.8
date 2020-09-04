Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E00FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2317620716
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="OdPlhwg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgIDCEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:04:20 -0400
Received: from mail-eopbgr1410059.outbound.protection.outlook.com ([40.107.141.59]:46656
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728582AbgIDCET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:04:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZL4aIfVRAN3hJDN/ZhfVh9J+qR/M++CtfGEMW570koGHKikoRxt15eJ5DcxsiLrPWCAsg59aLbR+iZ49/0I4/aI+cCyXndNto3bHoXqZztNemmNe+TXwOmnpB/wOQGXsOjUFcwmqlACRCcfGf10bJsfDtm74yizYT/IrCv0dbff1mdCq4si9jhYZnsyIUW6pSyyb6aIOMLo21eCl3T2EINkmbao690I6fLK69U8hVEnajvBI85csvI+5ULI5YuPOPEjyCnLteH6Yr8lpDSXWZxET/RObQbU6P5EO1axAlTuqLwsP2d3XhtuuR4FaqioIP28COh5B0eNmU8NFzH/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV0W+4bZeOrG3uOF7P/RZM4iUF1OFXMg1ZGyF0OfiPs=;
 b=ce0dkDLfO8ZOfpSZz/qheJrtnRHoC7z2DqO2GTQrmbsTLTcTEVPhOReP7Olk54j5TSmyYMcI+KErwZerkZ+QH2fwApPZaxdD2BkDrqxPYHYzk3LVSbk0SPqxG4otZspKIjhHns+TdR1Crqqrbc4PkQq3yO+fe1dpGvGqJtVyVhskmXrvzR8HmmlNV/62V6osICUyLKOPPpMSRpsL8ZQuW1Tnu6CbdYF86X9maPiDN+53YuloVHIpp9VrqJTyvdjUgfnj+Os23L2FNImqtcXv0AMHoNurQHunNn72tbGaa+26/0M5YTtvmyqFBXAWHqzCdCpymsOIaJ/jFWbI8rqV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV0W+4bZeOrG3uOF7P/RZM4iUF1OFXMg1ZGyF0OfiPs=;
 b=OdPlhwg7ePbRnVbQLxBfdWGmQOLMbxDkc394+ygk+ebXGn0Ge7B8bsX3XUlaoOGWCpQjVyM9BdA7maJ1EDODfU0e+OrflDu/ytZIidHVtYepGKjdQE1psZgD2/TtaA/h2z8nAVAXZO+DT8MHOigWbrv73VyWgk0aZFr3ga8pW1I=
Received: from TYAPR01MB3213.jpnprd01.prod.outlook.com (2603:1096:404:8b::18)
 by TYBPR01MB5421.jpnprd01.prod.outlook.com (2603:1096:404:802e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 02:04:16 +0000
Received: from TYAPR01MB3213.jpnprd01.prod.outlook.com
 ([fe80::c1fb:d14a:1d72:a39]) by TYAPR01MB3213.jpnprd01.prod.outlook.com
 ([fe80::c1fb:d14a:1d72:a39%6]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 02:04:16 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oscar Salvador <osalvador@suse.com>
Subject: Re: [PATCH 2/4] mm,hwpoison: Refactor madvise_inject_error
Thread-Topic: [PATCH 2/4] mm,hwpoison: Refactor madvise_inject_error
Thread-Index: AQHWgQ3JdaD53Ibs/0mHj2iAn+ybCqlXvUYA
Date:   Fri, 4 Sep 2020 02:04:16 +0000
Message-ID: <20200904020416.GB32236@hori.linux.bs1.fc.nec.co.jp>
References: <20200902094510.10727-1-osalvador@suse.de>
 <20200902094510.10727-3-osalvador@suse.de>
In-Reply-To: <20200902094510.10727-3-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24caf980-f91c-4094-ae77-08d85076d3fd
x-ms-traffictypediagnostic: TYBPR01MB5421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB54216F2220C6FBA1C03C3446E72D0@TYBPR01MB5421.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqr4ab9EVsA2prXP7KBUSAFHdypWmigcbyc1dIFm6rpqwV5+xABy4G4TyI62kux6PR+NaK8kSffAXPcoQLP0Y7EZuoTcxKxXgezHMHjpn8FkakToEmrCnIMbi0A3MSeEuU1tlk2EhmmWuwaw9uOQactCozQyHUV3MiCkOeEUyDPHILW16198/S+xtVG81FYQiud8IlMC+/CEFCG64LOSnVIZmhsV1FAxyqBpHcmUB9jpqPA0jFjQqVYo/avxyI4ENncnBg2FqTm/0H5G1JvbcjSMfEODJxBqRWmbXFwbC36wrj2Xdjh5jh8zzqB9eugeh2YZ+4UWi9cLJEDXQ1IG2V/VxeqzDPnP4+YPzMF4P1IQByAOKbeUWBbbIMyzoHlP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB3213.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(9686003)(478600001)(6916009)(6512007)(186003)(8676002)(26005)(558084003)(66946007)(5660300002)(54906003)(66446008)(1076003)(6506007)(33656002)(66476007)(2906002)(76116006)(66556008)(64756008)(4326008)(71200400001)(55236004)(8936002)(316002)(86362001)(6486002)(85182001)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: v1WcorW/L5E2wCZgyGyra4aR1i8NzFJxQaH30o+rNC9ubIEhn6AE/baQ0OFg3Km6NggfvKn1utBAH+QTFKI2OCnllV0mL1Bk9chFw4ZiQ9O00x8jyqfB7wBDlJ7ZVUi5OScLNmNolwCeLybafjg1NETbo+yVB/W6z1POrutcCkViqQJPaJOtDkt5tZR6vmgri78ppb89XPgXSSHJ8X/rIJ2K9wF24L3vUe5GA4suzHIuAcwbcdJAZFCT8GSjoBUe81j/4aiONzP/uLF+bmBLWkPdZVu4EBMEbduskFZ4bhZmOvKoHkxBI1Ka5kC73BGBBh7hAfgTbzzhdLR0nOyL9nQasWfc/YdXGAPoZJBo6AYgoRAm+HAMcw/6Bob7Krj9we7ks2lMYmoAGRaZzd8/S5daq5ZyhW1lqjsM7JPBMioUEIoz/feCJ+9Kvn2fHZHwu+aDtK9MoZu8BTFNg4y5+bCSFChf1nyj6f83TKCQd3GLqdN6c7XP99ABYZ7e7RMUdu+G31v9zCZk5OO6yNa8GD0xIXK5YA1FKJY2nKjXhauET/KEGkzmrMNvPoN7wwpWLkR5Kevwurjy9bmDf4q6ar0GXaQjjEV6q34/qmi3gPP0uB5V11kRImbzVSo3lkGagVdes/VS95sCpXn7xvf/JQ==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <EBEAB20D5A88BD4C96749F77596068FE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB3213.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24caf980-f91c-4094-ae77-08d85076d3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 02:04:16.5356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tzd5x8OCNdJK6YNy0Hrp9BsvEyV8PE7s0ZuH4DvqANll3yxWv2eNBUIH0C/aTX80IWGkC9oYFGeMWU3mUY6U8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:45:08AM +0200, Oscar Salvador wrote:
> Make a proper if-else condition for {hard,soft}-offline.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
