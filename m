Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA1620772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UZ7f1qkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390215AbgF3RSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:18:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:29917 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbgF3RSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:18:04 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200630171802epoutp04f389bee4277a2f270ec0ccc8a25a868a~dYeW7Le_U2857828578epoutp04F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:18:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200630171802epoutp04f389bee4277a2f270ec0ccc8a25a868a~dYeW7Le_U2857828578epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593537482;
        bh=OFIZvdJMTjnrR5aLpvP6crNuAA9jAjOdnPgXyf5Kgw8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=UZ7f1qkh4Ov5VTJffYzQD6xW/GJUh1NU1mvj5ucQcUaWLiIAjjxpjIcGMpQYSw24I
         hKGPJeX0vLvm42Dv7dk141p1GCIBJzhOnb+4J6xuWfdqDzwu0rLc1lyEAtfkIhRDYo
         nRztSNBEStrK+arPJNR/7K4UeAkuuzaJ+KV1YbNw=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200630171802epcas5p4d4829c628a0621f1e6a13d9210ad65b4~dYeWmJ-vN1379113791epcas5p4R;
        Tue, 30 Jun 2020 17:18:02 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-e4-5efb73caa5e2
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.17.09475.AC37BFE5; Wed,  1 Jul 2020 02:18:02 +0900 (KST)
Mime-Version: 1.0
Subject: RE: (2) [PATCH] fs: fat: add check for dir size in
 fat_calc_dir_size
Reply-To: a.sahrawat@samsung.com
From:   AMIT SAHRAWAT <a.sahrawat@samsung.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC:     Anupam Aggarwal <anupam.al@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <875zb8o6zh.fsf@mail.parknet.co.jp>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200630170748epcms5p87fa9b4348c1448d2d5a5f6cdddbc021e@epcms5p8>
Date:   Tue, 30 Jun 2020 22:37:48 +0530
X-CMS-MailID: 20200630170748epcms5p87fa9b4348c1448d2d5a5f6cdddbc021e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCmpu6p4t9xBg+WsFi8b7jCbjF97gYW
        i8u75rA5MHvcf5vo0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBmH191nLtirWNF516aB8axC
        FyMnh4SAicSiC/tZuhi5OIQEdjNKvJ/7n7WLkYODV0BQ4u8OYZAaYQF/iSO/TrCD2EICChK7
        595gh4jrSfyat5UVxGYT0JFo613IBmKLCBhIPFx+BMxmFsiRmHyyiwViF6/EjPanULa0xPbl
        WxlBbE6g+rvLtzBBxEUlbq5+yw5jvz82nxHCFpFovXeWGcIWlHjwczcjyJkgc54cZwY5X0Kg
        mVFi1vVuRghnBqNE35cpUEPNJXZvmMcC8ZevxPaXdSBhFgFViQPHjrFDzHGRODKZFeJkbYll
        C18zg4SZBTQl1u/ShxgiKzH11DomiBI+id7fT5hgvtoxD8QGmaIi8X6yDkRYSqK9cwrUwR4S
        kzdPZYcE8lwmid/XLrBNYFSYhQjnWUgWz0JYvICReRWjZGpBcW56arFpgXFearlecWJucWle
        ul5yfu4mRnCK0PLewfjowQe9Q4xMHIyHGCU4mJVEeE8b/IoT4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzqv040yckEB6YklqdmpqQWoRTJaJg1OqgalqosDnSr3GTxmfb6od3SSqeWTpD8Ocdpa/
        7txVeWX1E2x7oxk4O4/M++D9MWm/bMySVU6Rurmvwj+fK89b+bvtmtFT13W1WwIvS1zjNQ6/
        3PNg6mrhk+zLUk+wSAsXNip0nVExztnbryqRsXThebb0RUv6L1vd7ZtnpR1xOa/M6dKOyh8Z
        f7e8vuWXWJT9p4E7/nymyvT48E33TrZKX3989YqOeGNUZ85meS5bRcYYyXC+/24vnPh1NFMu
        Me0vM1n3J+W8T98zpXVRf7k5mgqurVew+yryajOf+Y/kT5X6n2pS3keE73vvbWVqytQmx8tc
        Xiw58RbLyQC3jckPX6cnt+YERBULMXreEBFRYinOSDTUYi4qTgQANkWVVoADAAA=
X-CMS-RootMailID: 20200629110320epcas5p34ccccc7c293f077b34b350935c328215
References: <875zb8o6zh.fsf@mail.parknet.co.jp>
        <87ftacolpf.fsf@mail.parknet.co.jp>
        <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
        <20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678@epcms5p6>
        <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcms5p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C2=A0=0D=0A>=C2=A0There=C2=A0are=C2=A0many=C2=A0implementation=C2=A0that=
=C2=A0doesn't=C2=A0follow=C2=A0the=C2=A0spec=C2=A0strictly.=C2=A0And=0D=0A>=
=C2=A0when=C2=A0I=C2=A0tested=C2=A0in=C2=A0past,=C2=A0Windows=C2=A0also=C2=
=A0allowed=C2=A0to=C2=A0read=C2=A0the=C2=A0directory=C2=A0beyond=0D=0A>=C2=
=A0that=C2=A0limit.=C2=A0I=C2=A0can't=C2=A0recall=C2=A0though=C2=A0if=C2=A0=
there=C2=A0is=C2=A0in=C2=A0real=C2=A0case=C2=A0or=C2=A0just=C2=A0test=0D=0A=
>=C2=A0case=C2=A0though.=0D=0A>>>=C2=A0Thanks=C2=A0Ogawa,=C2=A0yes=C2=A0the=
re=C2=A0are=C2=A0many=C2=A0implementations,=C2=A0preferably=C2=A0going=C2=
=A0around=C2=A0with=C2=A0different=C2=A0variants.=0D=0A>=C2=A0But,=C2=A0usi=
ng=C2=A0standard=C2=A0linux=C2=A0version=C2=A0on=C2=A0the=C2=A0systems=C2=
=A0and=C2=A0having=C2=A0such=C2=A0USB=C2=A0connected=C2=A0on=C2=A0such=C2=
=A0systems=C2=A0is=C2=A0introducing=C2=A0issues(importantly=C2=A0because=C2=
=A0these=C2=A0being=C2=A0used=C2=A0on=C2=A0Windows=C2=A0also=C2=A0by=C2=A0u=
sers).=0D=0A>=C2=A0I=C2=A0am=C2=A0not=C2=A0sure,=C2=A0if=C2=A0this=C2=A0is=
=C2=A0something=C2=A0which=C2=A0is=C2=A0new=C2=A0from=C2=A0Windows=C2=A0par=
t.=0D=0A>=C2=A0But,=C2=A0surely=C2=A0extending=C2=A0the=C2=A0directory=C2=
=A0beyond=C2=A0limit=C2=A0is=C2=A0causing=C2=A0regression=C2=A0with=C2=A0FA=
T=C2=A0usage=C2=A0on=C2=A0linux.=0D=0A=C2=A0=0D=0Aregression=C2=A0from=C2=
=A0what?=0D=0A=C2=A0=0D=0A>=C2=A0It=C2=A0is=C2=A0making=C2=A0FAT=C2=A0files=
ystem=C2=A0related=C2=A0storage=C2=A0virtually=C2=A0unresponsive=C2=A0for=
=C2=A0minutes=C2=A0in=C2=A0these=C2=A0cases,=0D=0A>=C2=A0and=C2=A0important=
ly=C2=A0keep=C2=A0on=C2=A0putting=C2=A0pressure=C2=A0on=C2=A0memory=C2=A0du=
e=C2=A0to=C2=A0increasing=C2=A0buffer=C2=A0heads=C2=A0(already=C2=A0a=C2=A0=
known=C2=A0one=C2=A0with=C2=A0FAT=C2=A0fs).=0D=0A=C2=A0=0D=0AI'm=C2=A0confu=
sed.=C2=A0What=C2=A0happen=C2=A0actually?=C2=A0Now=C2=A0looks=C2=A0like=C2=
=A0you=C2=A0are=C2=A0saying=C2=A0the=0D=0Aissue=C2=A0is=C2=A0extending=C2=
=A0size=C2=A0beyond=C2=A0limit.=C2=A0But=C2=A0previously=C2=A0it=C2=A0said=
=C2=A0the=C2=A0corruption.=0D=0A=C2=A0=0D=0AAre=C2=A0you=C2=A0saying=C2=A0=
=22beyond=C2=A0that=C2=A0limit=22=C2=A0is=C2=A0the=C2=A0fs=C2=A0corruption?=
=0D=0A=C2=A0=0D=0AI.e.=C2=A0did=C2=A0you=C2=A0met=C2=A0real=C2=A0directory=
=C2=A0corruption?=C2=A0or=C2=A0you=C2=A0are=C2=A0trying=C2=A0to=C2=A0limit=
=0D=0Abecause=C2=A0slowness=C2=A0on=C2=A0big=C2=A0directory?=0D=0A>>>=20Wil=
l=20try=20to=20arrange=20the=20fsck/chkdsk=20output=20for=20the=20related=
=20to=20disk,=20to=20highlight=20the=20concerns.=0D=0A=0D=0A=C2=A0=0D=0A>=
=C2=A0So=C2=A0if=C2=A0there=C2=A0is=C2=A0no=C2=A0strong=C2=A0reason=C2=A0to=
=C2=A0apply=C2=A0the=C2=A0limit,=C2=A0I=C2=A0don't=C2=A0think=C2=A0it=C2=A0=
is=0D=0A>=C2=A0good=C2=A0to=C2=A0limit=C2=A0it.=C2=A0=0D=0A>>>=C2=A0The=C2=
=A0reason=C2=A0for=C2=A0us=C2=A0to=C2=A0share=C2=A0this=C2=A0is=C2=A0becaus=
e=C2=A0of=C2=A0the=C2=A0unresponsive=C2=A0behaviour=C2=A0observed=C2=A0with=
=C2=A0FAT=C2=A0fs=C2=A0on=C2=A0our=C2=A0systems.=0D=0A>=C2=A0This=C2=A0is=
=C2=A0not=C2=A0a=C2=A0new=C2=A0issue,=C2=A0we=C2=A0have=C2=A0been=C2=A0obse=
rving=C2=A0this=C2=A0for=C2=A0quite=C2=A0sometime=C2=A0(may=C2=A0be=C2=A0ar=
ound=C2=A01year+).=0D=0A>=C2=A0Finally,=C2=A0we=C2=A0got=C2=A0hold=C2=A0of=
=C2=A0disk=C2=A0which=C2=A0is=C2=A0making=C2=A0this=C2=A0100%=C2=A0reproduc=
ible.=0D=0A>=C2=A0We=C2=A0thought=C2=A0of=C2=A0applying=C2=A0this=C2=A0to=
=C2=A0the=C2=A0mainline,=C2=A0as=C2=A0our=C2=A0FAT=C2=A0is=C2=A0aligned=C2=
=A0with=C2=A0main=C2=A0kernel.=0D=0A=C2=A0=0D=0ASo=C2=A0what=C2=A0was=C2=A0=
the=C2=A0root=C2=A0cause=C2=A0of=C2=A0slowness=C2=A0on=C2=A0big=C2=A0direct=
ory?=0D=0A>>>=20Root=20cause=20was=20the=20continous=20FAT=20chain=20walk=
=20through=20for=20that=20directory=20and=20making=20the=20corresponding=20=
applications=20to=20stuck.=0D=0AIt=20keeps=20going=20on,=20so=20eventually=
=20the=20application=20had=20to=20be=20terminated.=0D=0AMay=20be=20arraning=
=20corresponding=20metadata=20dump=20related=20with=20this=20might=20help=
=20in=20clearing=20doubts.=0D=0AI=20Hope=20to=20arrange=20them=20soon.=0D=
=0A=C2=A0=0D=0AThanks.=0D=0A--=C2=A0=0D=0AOGAWA=C2=A0Hirofumi=C2=A0<hirofum=
i=40mail.parknet.co.jp>=0D=0A=C2=A0
