Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB412074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="tq7RHdk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgGAJHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:07:21 -0400
Received: from mail-eopbgr1410080.outbound.protection.outlook.com ([40.107.141.80]:52578
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729135AbgGAJHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOEVFv4jpPvadTXQo02Gg6dNUke18Ao2UUB/iYIFfepFHNEpJhqw2NIO2Wwfd5FtQmmCI5ESL+Eeg3KmJDZIz9Bi/fa8FGdXESB7669cAlZPAjq3+YqtwCn8sDYe2ub+1WbJVCYQtWtYidGx2akMbdK2mGos9fcOYn6rJMHpOlz1KWdUeOIZ42LrkJy1Aa0W8KloVzNJzrOga251hjTevf2nQOfBegN6KlBXnwQiw/G621aKSXP+TgpOxHFFge59LMC7gqjIKBwQZsuOfEHsJjqcDTFziD9NmvKWlNqgpRzZDxBWAMO6b2q9h7Qy50gbLTvQDmk3M8RqCQ6uqamyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qzlVdU50cU988s4dTuwRa2jX9D9+Sz0r1Yp26W9N3A=;
 b=MbQSX75lg3e347mkPTXktyq8LGLjt+vXmg7WWsCFGdwCFGfQAFQy8vXIY8WCh/fNJA54RMY+l1O0rc14qna3NVWR24BOoGIOhtl0u/mFvmF1ZojfZV1OWUlEx6gycm/d7+F/ediMJsroxSfq9E+LSFnlxHeZ4jSHcd2SYyszgE4ILeQXruXG76jDKqqR01AGq2TRuxOb5/kR/Bft/kEyFz0bh8VetCH3OVMKRITGOA15sWPmUdQ5OA8bCgHi5m0BGkT7UX0S0dTuZXTq603ll30tl5SvldFX7xoFsY+EMlZp8awQ4SJkFr8Wo2H74n84jf4AF+LHovfqb/8ZHI1tSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qzlVdU50cU988s4dTuwRa2jX9D9+Sz0r1Yp26W9N3A=;
 b=tq7RHdk6oa3JlYHWzT9gXSd9yeg0dzUqEmMB9CEQtrYlYdErvUgJd4VpUnWw7eTMXPtLOGUp/kStTbm7qENUPLScvWNg0K16nrSH5TQ5CBqMuv7p8szbxEm8fjxa++t0AUW2V6o6rk4jp4mKqyI1Ff6/Ky3G+vJri5hIDIPjreE=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB4239.jpnprd01.prod.outlook.com (2603:1096:404:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 09:07:15 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3131.026; Wed, 1 Jul 2020
 09:07:15 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Qian Cai <cai@lca.pw>,
        "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
Thread-Topic: [PATCH v3 00/15] HWPOISON: soft offline rework
Thread-Index: AQHWTpx4zbVjN5u0REi9+svCvkNClajws/sAgAGwNoCAAAybAA==
Date:   Wed, 1 Jul 2020 09:07:15 +0000
Message-ID: <20200701090714.GA16045@hori.linux.bs1.fc.nec.co.jp>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
 <20200630050803.GA2747@lca.pw> <1593498910.3046.2.camel@suse.de>
 <1593591727.3586.2.camel@suse.de>
In-Reply-To: <1593591727.3586.2.camel@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93cd0000-a857-4a89-9e9e-08d81d9e2601
x-ms-traffictypediagnostic: TYAPR01MB4239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB4239E3FF06D5E6EEC5EF323DE76C0@TYAPR01MB4239.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VlyBpwJA/OK5XnqVsfC2N5QgffKgXV2hMssnr9ybKg6/3xaep8G0t38uZAXuRKaSpCHMs1ogtZdb2pspkreKEI9dr960IGU0THWSR9i6g/dAc3JDXo0z568jWBz/YkhWpkDkPS+uH6Cymmh12b7N8BP1vSlRbEBnRKv1a80mzYzMizoMy+naBOUr0UwAy9BmLXjTM+oxStulgocrHemYwCmnDYxJPthMl4EVSbS6WnoRKWNUTBFDMl0sbwn4OrUgdCaAgaI69Dbj4k0520ElnY80RVH2Fnh3xLvSCdGz53h4dbjDZX2yen3aa08VX0AYL+D642r7jvJazAAU/HIx5ErL6yx+/RXnbvf3rk9oBptzUx1itq62x8ZlVv+konPq3kDdlfCwQXtKAtpC9Gj9gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(66446008)(55236004)(66556008)(33656002)(66476007)(76116006)(5660300002)(85182001)(8676002)(66946007)(71200400001)(478600001)(2906002)(186003)(966005)(8936002)(4326008)(6916009)(26005)(6512007)(316002)(64756008)(9686003)(7416002)(1076003)(86362001)(54906003)(6486002)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4Kah06zRKzj9ZhgWlTUnuUIgiZxbXe6gQVJI+0hqHjlQM3tRaC+YIWt7ZeahsYfihbAGD9UVII0Tf0DrRxCQ4plSwufcUqpTxJi6nRNnGpspTJisisH/lkZjA6FyBfuzpIqfa8Q3Bhglv8LMB8uoCaMQoDailxNX+J7y/I6p2YVNUSI5wn2/78aULc+MQIxOHTk0k/nt3VNV73mKoxWfqFtU9hFRhg0fbTfcwN16mQupeL48Jsb5giMvU2RNzvjQRm/E+a9IFbeRXCUq/95TEuvqnoFwWgkijkIa/hh0fFP/467bf4mm5deS6uxmrkj+XC0hSXdNS8n8z09Fy6WV+uJsdD79z7sVW6L8hXMQyEp5ViezcubBWUESKn47b+sRo/yG4zhQsz/X/Rj1h9QZossETdRpd+fMg0xkq8Vi3ER5pQb2Gyjk4XAPTzGMp85tH7HbKZt4jNdSLPFUZN7nGTGsprE4lWH94yzSI3sij3MX7OYR6El3hLXLgX1degvm
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <9D7E9CC20CEAFC49AAFE36939CF69E59@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cd0000-a857-4a89-9e9e-08d81d9e2601
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 09:07:15.2044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcyZ3cm/BIXPquVEehWf3HI+L+2rvK/xPfPbBBt5cXu+0BKJhVbMZFzZg4CITFrsurnfGnrFxp1vh0ZWTGBzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:22:07AM +0200, Oscar Salvador wrote:
> On Tue, 2020-06-30 at 08:35 +0200, Oscar Salvador wrote:
> > > Even after applied the compling fix,
> > >=20
> > > https://lore.kernel.org/linux-mm/20200628065409.GA546944@u2004/
> > >=20
> > > madvise(MADV_SOFT_OFFLINE) will fail with EIO with hugetlb where it
> > > would succeed without this series. Steps:
> > >=20
> > > # git clone https://github.com/cailca/linux-mm
> > > # cd linux-mm; make
> > > # ./random 1 (Need at least two NUMA memory nodes)
> > >  start: migrate_huge_offline
> > > - use NUMA nodes 0,4.
> > > - mmap and free 8388608 bytes hugepages on node 0
> > > - mmap and free 8388608 bytes hugepages on node 4
> > > madvise: Input/output error
> >=20
> > I think I know why.
> > It's been a while since I took a look, but I compared the posted
> > patchset with my newest patchset I had ready and I saw I made some
> > changes with regard of hugetlb pages.
> >=20
> > I will be taking a look, although it might be better to re-post the
> > patchset instead of adding a fix on top since the changes are a bit
> > substantial.
>=20
> Yap, I just confirmed this.

I've reproduced the EIO, but still not sure how this happens ...

> Posted version had some flaws wrt. hugetlb pages, that is why I was
> working on a v3.
> I am rebasing my v3 on top of the mm with the posted patchset reverted.

OK, thank you for offering to work for v4, so I'll wait for it for testing.

Thanks,
Naoya Horiguchi=
