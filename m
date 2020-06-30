Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D390AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A610620759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="oSxJLsSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgF3GvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:51:04 -0400
Received: from mail-eopbgr1410074.outbound.protection.outlook.com ([40.107.141.74]:9760
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730423AbgF3GvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:51:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4aBrAXiEg2RqM4HfVIYuuH63Zai0JD03KA/88pWvPawgu9RtxURKPYnKU6FlN3atlLNRT/TVVxXdIsFNomA/9HJ0OiM8bKkDMabWX8dBfZriQdWBVyUq1lgSANMS27mFMmgYCqyhj50AB5fgL4on/lZfIxb2MmsxYZ95Vzj4Cp3bYuLurW35PQivNsqXHL6KAqFRw6nV/w9gNZedqgpaSdRgkb50k/sPdoerdiGqNOkXJ0v2DWJPfnaVxxWB8oh9T6T9avKJq2wZA8uJHO5t2E8mVPo2G9kQEql6CA10wuWd37tSk0PCTEzfP+CkwPhSvu1xwS67q1JHceu33Go9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkNF+6lW8LswPiOYV9A+FBWQz1WnHNPrLuMMYj0k9pY=;
 b=C+mg+pM+Q2LXygx9mtyMEbtuv23PWFINNTKoRitaB9KZ68fWTtP5HbbvegOPtLa8ej7av/8tFmjEh8/JWc9KzbSAUBeVL3FBDRtFKWUtuXlfOJBdxnEFHrzeubrLHCTWL5NfbIKZBprUqhkMmzq4MBGQqKaanq3t/FvgCFgY2H+LT/mgsO7c8isOnAV9t9AQe7TQcIZQPjcPNpEeaHPanl9ikgQKQ0OXHLwAPPB9bfRXqrUsqrlvy+tVD9APPEeeoXq+QbANWY/fCzwgKK9ONwbyFhYP4q1xCIFYX5sSJFlUmPB70niI3igkHtUGD8Iv4X+03WzIWfGX7Tyt8f514Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkNF+6lW8LswPiOYV9A+FBWQz1WnHNPrLuMMYj0k9pY=;
 b=oSxJLsSXyAfce4k8spM2jd0FHrRc8Mf0iUHIYIqNzZAU5O4eTFeOLdm4JpL8BetLlfx+q31iYNaEEiwvhFYMGOSpvhzf5tYdHLLD+Sx2qogrH6EhHI7T5MDv7NEJaG5ONi6cUBldc57TBLRse1EcTBXErrNqP7y38xaD0HZizNo=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB4527.jpnprd01.prod.outlook.com (2603:1096:404:123::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 06:50:59 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3131.026; Tue, 30 Jun 2020
 06:50:59 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
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
Thread-Index: AQHWTgAvsqGEJZfvC066yVQdqpY4jajwuZyA
Date:   Tue, 30 Jun 2020 06:50:59 +0000
Message-ID: <20200630065057.GA9777@hori.linux.bs1.fc.nec.co.jp>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
 <1593426565.3504.6.camel@suse.de>
In-Reply-To: <1593426565.3504.6.camel@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39d633fb-0fd2-46a5-82f1-08d81cc1f282
x-ms-traffictypediagnostic: TYAPR01MB4527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB45278626331A7A6CE312E83AE76F0@TYAPR01MB4527.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZyB/yvCKZza0zH1DM7ovwW0mutVFR5W09u262jpFzriMj/3qeynIYMbxaFsc7ZzzNKJWT4IZGGXxlAfTJJfk7/opvOydMEu9zFXjtd0X/uadgG9dKWtGJiNzg9BStnqFm4nr35fViJyRzYmZOZNdX2OZEFKmRjdNHS85THalCWCjluxq0OvnlRVynhsX632Qf62MkvzrvwvzvyVOWYTd/HzFUdgfR7JFa5YYTIcY301/AnTQScANBwtKnCBIKYi4M2iAspJFZAP5mhwh+qEVWcM47UtS97Kl1kV11TWUHShAnNdNBPhVMibmyoRN9x4REY3NbfyHeNuNATxxbb+Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(6506007)(4326008)(53546011)(85182001)(7416002)(6512007)(9686003)(478600001)(8936002)(26005)(55236004)(71200400001)(6916009)(316002)(66476007)(33656002)(76116006)(66446008)(64756008)(66556008)(66946007)(1076003)(2906002)(54906003)(6486002)(8676002)(83380400001)(86362001)(5660300002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Pe3xbAwGoGf5y+A61CdH/OPUWz2Z+oEehp+N16TICjYg1n6519favHgTN3GFJIIviGdcHwIXoNIBPQPss+/k9rmHW+w7JBpyHcagIO/DMpqOo4yffUA9/NxYbVN7iZsoQw2FLzsA2xLMDToBZ5U6agTBJ8/HgwIDolA9MIkdUTH2kAGea0QWf4SN0dCKlrSZXVjcxMGZTzywC4K8wk2Zg1THwLzzJiyNP96ivOj335ufeEJVSsVk343UprmExfuEnjVjaTj57WtA6qM+I6P3TCKaUujVr6R9juu4UVyraJ53tjAJZUyEDhKDK9fJ6oqO9K7vg618KRvxY+ousA6RqdtKSXZqUIw9MQdUgCMITwZO/kjAvMCMT5OCyaZH8+vy+4wOg7pByX10Rgcm4w2kUFrZCDX67Lvaer0FrFYEqMWexWuO8Nvf/yuKnggGdSvZG/ZKh9aWtdRxaiu/u4GcqgpPqcuGsHXAp+vnkb8YEF8jQvIc/ra5S1On5lJIF+Tn
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <08A920DBBC3918448A928D5EA5DEA39B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d633fb-0fd2-46a5-82f1-08d81cc1f282
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 06:50:59.5100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82B0krE8VtYd6fer1vDkp6Vtn8yMuEAMOtpXJeGqIsIocki+2Qi1qZzfGTA4PKuuxZDdwEVnCWGQ5DAtTyrVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:29:25PM +0200, Oscar Salvador wrote:
> On Wed, 2020-06-24 at 15:01 +0000, nao.horiguchi@gmail.com wrote:
> > I rebased soft-offline rework patchset [1][2] onto the latest
> > mmotm.  The
> > rebasing required some non-trivial changes to adjust, but mainly that
> > was
> > straightforward.  I confirmed that the reported problem doesn't
> > reproduce on
> > compaction after soft offline.  For more precise description of the
> > problem
> > and the motivation of this patchset, please see [2].
>=20
> Hi Naoya,
>=20
> Thanks for dusting this off.
> To be honest, I got stuck with the hard offline mode so this delayed
> the resubmission, along other problems.
>=20
> > I think that the following two patches in v2 are better to be done
> > with
> > separate work of hard-offline rework, so it's not included in this
> > series.
> >=20
> >   - mm,hwpoison: Take pages off the buddy when hard-offlining
> >   - mm/hwpoison-inject: Rip off duplicated checks
> >=20
> > These two are not directly related to the reported problem, so they
> > seems
> > not urgent.  And the first one breaks num_poisoned_pages counting in
> > some
> > testcases, and The second patch needs more consideration about
> > commented point.
>=20
> I fully agree.
>=20
> > Any comment/suggestion/help would be appreciated.
>=20
> My "new" version included a patch to make sure we give a chance to
> pages that possibly are in a pcplist.
> Current behavior is that if someone tries to soft-offline such a page,
> we return an error because page count is 0 but page is not in the buddy
> system.
>=20
> Since this patchset already landed in the mm tree, I could send it as a
> standalone patch on top if you agree with it.
>=20
> My patch looked something like:
>=20
> From: Oscar Salvador <osalvador@suse.de>
> Date: Mon, 29 Jun 2020 12:25:11 +0200
> Subject: [PATCH] mm,hwpoison: Drain pcplists before bailing out for
> non-buddy
>  zero-refcount page
>=20
> A page with 0-refcount and !PageBuddy could perfectly be a pcppage.
> Currently, we bail out with an error if we encounter such a page,
> meaning that we do not give a chance to handle pcppages.
>=20
> Fix this by draining pcplists whenever we find this kind of page
> and retry the check again.
> It might be that pcplists have been spilled into the buddy allocator
> and so we can handle it.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

I'm fine with this patch, so this will be with the next version with
some minor change like moving function comment block together.

Actually I feel we could refactor get_hwpoison_page() with get_any_page()
to handle this kind of pcplist related issues in one place. But this could
be more important in hard-offline reworking, and we don't have to do it
in this series.

Thanks,
Naoya Horiguchi=
