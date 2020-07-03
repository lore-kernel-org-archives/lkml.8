Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0112088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tcpAFjwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgGCOt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:49:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36872 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGCOt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:49:28 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200703144924epoutp0385e2de1a9a35960ae4f7b2396351e230~eRYcSm86y1072310723epoutp03B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 14:49:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200703144924epoutp0385e2de1a9a35960ae4f7b2396351e230~eRYcSm86y1072310723epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593787764;
        bh=bsE6QLvTDojRwXialKZVHCrDPPKOpbZsYkXHSf/L++M=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=tcpAFjwEuU8UUZY+NN5rAS9/FcxDddOvA0ETQkXisUW87JY4CdBLMeNNLAvb0h9un
         kbq2mhEwQLgOPqLwjB+64vLz19uvNSkJKZ7ecPEjKwLiCzMpufv297abZcQorAKCgO
         UjW4Rgpztrkicjptdr4PR45nadPmrGnrl+dQxA2M=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200703144923epcas5p3e3660f508f10bcb6e2c11cbc776205bb~eRYbospYP1094310943epcas5p3g;
        Fri,  3 Jul 2020 14:49:23 +0000 (GMT)
X-AuditID: b6c32a49-a29ff700000024fb-8f-5eff4573fac8
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.F0.09467.3754FFE5; Fri,  3 Jul 2020 23:49:23 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] fs: fat: add check for dir size in fat_calc_dir_size
Reply-To: anupam.al@samsung.com
From:   Anupam Aggarwal <anupam.al@samsung.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200630170748epcms5p87fa9b4348c1448d2d5a5f6cdddbc021e@epcms5p8>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200703142939epcms5p1440ec65f7e8a3e4741ade2496135d747@epcms5p1>
Date:   Fri, 03 Jul 2020 19:59:39 +0530
X-CMS-MailID: 20200703142939epcms5p1440ec65f7e8a3e4741ade2496135d747
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7bCmlm6x6/84g/8LjCwu7k61mD53A4vF
        5V1z2ByYPe6/TfTo27KK0ePzJrkA5igum5TUnMyy1CJ9uwSujBmnlzIVXFGrmLb4PXsD43eV
        LkZODgkBE4nfj8+ydTFycQgJ7GaUONL5B8jh4OAVEJT4u0MYpEZYwFPi36l9LCC2kIC8xPcF
        n5gh4voSC073sIHYbAK6EnNfzGYFaRURiJL4/husnFnAUeL23rdMEKt4JWa0P2WBsKUlti/f
        yghicwr4SRyYNB+qRlTi5uq37DD2+2PzGSFsEYnWe2eZIWxBiQc/d0PFZSROrFvDCHK+hEA/
        o8Szj61MEM4MRomrax5DbTOX2L1hHpjNK+ArMe/EZLBuFgFViZXbpoMdLSHgItGzrxbiaG2J
        ZQtfM4OEmQU0Jdbv0oeYIisx9dQ6JogSPone30/g/toxD8ZWlph67TUrhC0p8bizFepmD4nJ
        m6eyQ4L5PpPE9elPWScwKsxChPQsJJtnIWxewMi8ilEytaA4Nz212LTAMC+1XK84Mbe4NC9d
        Lzk/dxMjOE1oee5gvPvgg94hRiYOxkOMEhzMSiK8Car/4oR4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzKv04EyckkJ5YkpqdmlqQWgSTZeLglGpgUur60NI8ZS7LHSeVh5cOb/mfW69jVaIom9lo
        3Gx9O/Poy8ktauIVsxlX3a1ebF2cwKZzUjHC5dQxtgP/3v31Ug2Zsb6ra7Vy5odtTDGMtx1L
        tQSOvt7JHbtiyvm/6xc6bpyuerH7Nev9JBdm7ydv4x26XpXJXAx33J25Sm63/tWU7KtXaiwf
        bLAS6Xdfu3OnV4w/wzP++IrHQm4/7PTWqrzdE9JZExHYrOeSYfcgTXfrX+5tJw6ET9O+fHjR
        0SSPyIX57++vnvhf7Fe3WtCjY4rags6n+HRUYlf7er59ah0aWpqx4df7iCUO7OvnXva9x3Bc
        /uym/YZi82w826VLVXIXr32se3v5/KJbf45sVGIpzkg01GIuKk4EAEqZ95aCAwAA
X-CMS-RootMailID: 20200629110320epcas5p34ccccc7c293f077b34b350935c328215
References: <20200630170748epcms5p87fa9b4348c1448d2d5a5f6cdddbc021e@epcms5p8>
        <875zb8o6zh.fsf@mail.parknet.co.jp> <87ftacolpf.fsf@mail.parknet.co.jp>
        <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
        <20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678@epcms5p6>
        <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcms5p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ogawa,

>So what was the root cause of slowness on big directory?

Problem happened on FAT32 formatted 32GB USB 3.0 pendrive, which has 20GB o=
f data, cluster size is 16KB
It has one corrupted directory whose size calculated by fat_calc_dir_size()=
 is 1146896384 bytes i.e. 1.06 GB.

When directory traversal of corrupted directory starts, directory entries l=
ooks to be corrupted
and lookup fails for these directory entries.
Some directory entries name are having format abc/xyz,
following are the few observed directory entry names:

eqk/hb*
*=C3=B9=C3=AF/=C3=B2=C2=A27=C3=B4.=C3=BAB=C3=A6=0D=0Aty7=40o/<=60=0D=0A-=C3=
=B2%/=C3=A73=7B.9q=0D=0A'=C3=BBu/=C3=B6y<=C3=B6.=5Em=C3=B6=0D=0APh=E2=95=A4=
Cf=E2=94=8C6g.=C3=9F/k=0D=0A=0D=0ANow=20when=20path=20lookup=20happens=20fo=
r=20above=20directory=20entries,=20it=20will=20search=20for=20name=20before=
=20=E2=80=98/=E2=80=99=20in=20corrupted=20directory=20e.g.=0D=0A=0D=0Aeqk=
=0D=0A*=C3=B9=C3=AF=0D=0Aty7=40o=0D=0A-=C3=B2%=0D=0A'=C3=BBu=0D=0APh=E2=95=
=A4Cf=E2=94=8C6g.=C3=9F=0D=0A=0D=0AThere=20are=20also=20directory=20entries=
=20with=20garbage=20name=20for=20which=20lookup=20fails,=20e.g.=0D=0A=C3=A1=
)Y=C2=BA&q=C2=BC(.=C3=AE=C2=BB.=0D=0A=C3=86=E2=88=9E=E2=94=B4=C3=87=E2=96=
=80=E2=95=9Cr=E2=95=9F.=E2=95=A3g=C2=BD=0D=0A4=E2=96=92h1=E2=96=93x0=E2=94=
=A4.p3=E2=95=A3=0D=0A=0D=0ADuring=20search=20for=20single=20name=20in=20fat=
_search_long()=20function,=20whole=20corrupted=20directory=20of=20size=201.=
06GB=20is=20traversed,=0D=0Awhich=20takes=20around=20230=20to=20240=20secs,=
=20which=20finally=20ends=20up=20with=20returning=20ENOENT.=0D=0A=0D=0ANow=
=20multiple=20lookups=20in=20corrupted=20directory=20makes=20=E2=80=9Cls=20=
-lR=E2=80=9D=20never-ending=20e.g.=20in=20overnite=20test=20of=20running=20=
=E2=80=9Cls=20=E2=80=93lR=E2=80=9D=0D=0Aon=20USB=20having=20corrupted=20dir=
ectory,=20around=20200=20such=20lookups=20in=20corrupted=20directory=20took=
=2014hrs=20and=20still=20=E2=80=9Dls=20=E2=80=93lR=E2=80=9D=20is=20running.=
=0D=0A=0D=0ATotal=20number=20of=20directory=20entries=20in=20corrupted=20di=
rectory=20of=20size=201146896384=20bytes=20=3D=201146896384/32=20=3D=203584=
0512,=0D=0Aso=20lookup=20for=2035840512=20looks=20very=20exhaustive,=20ther=
efore=20we=20have=20put=20size=20check=20of=20directory=20in=20fat_calc_dir=
_size()=0D=0Aand=20prevented=20the=20directory=20traversal=20by=20returning=
=20-EIO.=0D=0A=0D=0AWhile=20browsing=20corrupted=20directory(=5CCorruptedDI=
R)=20on=20Windows=2010=20PC,=0D=0A2623=20directory=20entries=20were=20liste=
d=20and=20timestamps=20were=20wrong=0D=0A=0D=0AFollowing=20is=20the=20reado=
nly=20chkdsk=20output=20of=20USB.=0D=0A=0D=0A------------------------------=
--------------------------------------------------------=0D=0Achkdsk=20I:=
=0D=0AThe=20type=20of=20the=20file=20system=20is=20FAT32.=0D=0AVolume=20AAA=
=20created=2012/28/2018=203:15=20PM=0D=0AVolume=20Serial=20Number=20is=2016=
06-72DC=0D=0AWindows=20is=20verifying=20files=20and=20folders...=0D=0AWindo=
ws=20found=20errors=20on=20the=20disk,=20but=20will=20not=20fix=20them=0D=
=0Abecause=20disk=20checking=20was=20run=20without=20the=20/F=20(fix)=20par=
ameter.=0D=0AThe=20=5C=24TXRAJNL.DAT=20entry=20contains=20a=20nonvalid=20li=
nk.=0D=0AThe=20size=20of=20the=20=5C=24TXRAJNL.DAT=20entry=20is=20not=20val=
id.=0D=0AUnrecoverable=20error=20in=20folder=20=5CCorruptedDIR.=0D=0AConver=
t=20folder=20to=20file=20(Y/N)?=20n=0D=0AThe=20=5CBBB=5Cfile1.txt=20entry=
=20contains=20a=20nonvalid=20link.=0D=0AThe=20size=20of=20the=20=5CBBB=5Cfi=
le1.txt=20entry=20is=20not=20valid.=0D=0AThe=20=5CCCC=5Cfile1.txt=20entry=
=20contains=20a=20nonvalid=20link.=0D=0AThe=20size=20of=20the=20=5CCCC=5Cfi=
le1.txt=20entry=20is=20not=20valid.=0D=0AFile=20and=20folder=20verification=
=20is=20complete.=0D=0AConvert=20lost=20chains=20to=20files=20(Y/N)?=20n=0D=
=0A3531520=20KB=20of=20free=20disk=20space=20would=20be=20added.=0D=0A=0D=
=0AWindows=20has=20checked=20the=20file=20system=20and=20found=20problems.=
=0D=0ARun=20CHKDSK=20with=20the=20/F=20(fix)=20option=20to=20correct=20thes=
e.=0D=0A=20=20=2030,015,472=20KB=20total=20disk=20space.=0D=0A=20=20=20=20=
=20=20=20=20=20=20400=20KB=20in=202=20hidden=20files.=0D=0A=20=20=20=20=20=
=20=20=202,800=20KB=20in=2048=20folders.=0D=0A=20=20=2016,479,312=20KB=20in=
=207,583=20files.=0D=0A=20=20=20=209,999,392=20KB=20are=20available.=0D=0A=
=0D=0A=20=20=20=20=20=20=2016,384=20bytes=20in=20each=20allocation=20unit.=
=0D=0A=20=20=20=201,875,967=20total=20allocation=20units=20on=20disk.=0D=0A=
=20=20=20=20=20=20624,962=20allocation=20units=20available=20on=20disk.=0D=
=0A------------------------------------------------------------------------=
--------------=0D=0A=0D=0APlease=20let=20us=20know=20for=20any=20queries,=
=0D=0Aand=20please=20suggest=20if=20something=20better=20can=20be=20done.=
=0D=0A=0D=0ARegards,=0D=0AAnupam=0D=0A
