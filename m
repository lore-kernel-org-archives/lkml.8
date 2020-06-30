Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F584C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498802073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UCgB/mj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbgF3Mmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:42:39 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30245 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgF3Mmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:42:38 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200630124233epoutp0478630ff780ddf4aa75c9e2643e61c161~dUt1XP8MV2633526335epoutp04M
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:42:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200630124233epoutp0478630ff780ddf4aa75c9e2643e61c161~dUt1XP8MV2633526335epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593520953;
        bh=BqWjbF3KvaKtFeVajCvVEJ2Nw4HimN3xx9iBAsRhjIc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=UCgB/mj/LSfb4nRusMXw3W3/fGk/86IDW3a9EY4Uk48XT/aA6w0Yk9qMVhBGvOL+A
         rjuoEl1l1JZ/0C+jrDN5apR6PXVBfQ874ZNwXEV3HaIjhvXwV50g7JNBx+pUsvXwiF
         0HM7QzmhQVuNZoadSdvWZ0sB/OufTDmNARI3VM/U=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200630124233epcas5p3047d7ea2a6f8da6210af4e5d8d3ae3e5~dUt09Jkqt2213822138epcas5p3b;
        Tue, 30 Jun 2020 12:42:33 +0000 (GMT)
X-AuditID: b6c32a4a-4b5ff700000025e7-9a-5efb3339266e
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.21.09703.9333BFE5; Tue, 30 Jun 2020 21:42:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] fs: fat: add check for dir size in fat_calc_dir_size
Reply-To: a.sahrawat@samsung.com
From:   AMIT SAHRAWAT <a.sahrawat@samsung.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Anupam Aggarwal <anupam.al@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <87ftacolpf.fsf@mail.parknet.co.jp>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678@epcms5p6>
Date:   Tue, 30 Jun 2020 18:03:55 +0530
X-CMS-MailID: 20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCmlq6l8e84g3ez+C3eN1xht5g+dwOL
        xeVdc9gcmD3uv0306NuyitHj8ya5AOYoLpuU1JzMstQifbsErozz/XNZCg4bVnzbeJexgbFd
        r4uRk0NCwESi4+R6ZhBbSGA3o8TWd2pdjBwcvAKCEn93CIOEhQV8JB7feMcIUaIgsXvuDXaI
        uJ7Er3lbWUFsNgEdibbehWwgtohAtMTLdxvA4swCjhK3975lgljFKzGj/SkLhC0tsX35VrCZ
        nAIGEj0/Ohgh4qISN1e/ZYex3x+bDxUXkWi9d5YZwhaUePBzNyPImSBznhwHCnMBmc2MErOu
        dzNCODMYJfq+TIFabC6xe8M8Foi/fCVmtmqBhFkEVCVOf/3PBjHHRWL2AW6Ik7Ulli18zQwS
        ZhbQlFi/Sx9iiKzE1FPrmCBK+CR6fz+B+2rHPBAbZIqKxPvJOhBhKYn2zilQB3tITN48lR3k
        MCGBzYwSd+7+Z53AqDALEc6zkCyehbB4ASPzKkbJ1ILi3PTUYtMCo7zUcr3ixNzi0rx0veT8
        3E2M4BSh5bWD8eGDD3qHGJk4GA8xSnAwK4nwnjb4FSfEm5JYWZValB9fVJqTWnyIUZqDRUmc
        V+nHmTghgfTEktTs1NSC1CKYLBMHp1QD067D+9eUdqt+2h3jVMHQ8fWv7pe/82rjw4McNu89
        PnfO46DjE7uPXHnbNUVZNfSkWVNx0u3z4cb5nPV5Uz/6S7+2YZrxrfbDYd+WFqP7+z9+nLo4
        PE6bpfH55wVHLj1XKiz9py8dmXw1oMHY5V9+rfCJPX+/7TWO9HWouZr+siBK+OfDWb6VH6IK
        1luqhBWYTvmiozZn1n/Rtxufn0hibtXv1/518v5mHoOzjHEaiUqTvbrE+49zhOsU2WpW5+16
        y6gYzXAzRVNz6tfTIbVxP+riuN4Ulc3azjUhcAvfoaz9LEuClvJvaT5/z5Z/VhKj0a6t0/OU
        XyeWH3upHPgwMZ4th2/Zf83lTmn6tsxJSizFGYmGWsxFxYkArAO4XYADAAA=
X-CMS-RootMailID: 20200629110320epcas5p34ccccc7c293f077b34b350935c328215
References: <87ftacolpf.fsf@mail.parknet.co.jp>
        <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
        <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcms5p6>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many implementation that doesn't follow the spec strictly. And
when I tested in past, Windows also allowed to read the directory beyond
that limit. I can't recall though if there is in real case or just test
case though.
>> Thanks Ogawa, yes there are many implementations, preferably going aroun=
d with different variants.
But, using standard linux version on the systems and having such USB connec=
ted on such systems is introducing issues(importantly because these being u=
sed on Windows also by users).
I am not sure, if this is something which is new from Windows part.
But, surely extending the directory beyond limit is causing regression with=
 FAT usage on linux.
It is making FAT filesystem related storage virtually unresponsive for minu=
tes in these cases,
and importantly keep on putting pressure on memory due to increasing buffer=
 heads (already a known one with FAT fs).
=20
So if there is no strong reason to apply the limit, I don't think it is
good to limit it.=20
>> The reason for us to share this is because of the unresponsive behaviour=
 observed with FAT fs on our systems.
This is not a new issue, we have been observing this for quite sometime (ma=
y be around 1year+).
Finally, we got hold of disk which is making this 100% reproducible.
We thought of applying this to the mainline, as our FAT is aligned with mai=
n kernel.

(btw, the current code should detect the corruption of
infinite loop already)
>>
No, there are no such error reported on our side.=20
We had to trace to check the point of stuck in simple 'ls -lR'.

Thanks & Regards,
Amit Sahrawat
=C2=A0=0D=0A=C2=A0=0D=0A---------=20Original=20Message=20---------=0D=0ASen=
der=20:=20OGAWA=20Hirofumi=C2=A0<hirofumi=40mail.parknet.co.jp>=0D=0ADate=
=20:=202020-06-30=2016:38=20(GMT+5:30)=0D=0ATitle=20:=20Re:=20=5BPATCH=5D=
=20fs:=20fat:=20add=20check=20for=20dir=20size=20in=20fat_calc_dir_size=0D=
=0A=C2=A0=0D=0AAnupam=C2=A0Aggarwal=C2=A0<anupam.al=40samsung.com>=C2=A0wri=
tes:=0D=0A=C2=A0=0D=0A>=C2=A0Max=C2=A0directory=C2=A0size=C2=A0of=C2=A0FAT=
=C2=A0filesystem=C2=A0is=C2=A0FAT_MAX_DIR_SIZE(2097152=C2=A0bytes)=0D=0A>=
=C2=A0It=C2=A0is=C2=A0possible=C2=A0that,=C2=A0due=C2=A0to=C2=A0corruption,=
=C2=A0directory=C2=A0size=C2=A0calculated=C2=A0in=0D=0A>=C2=A0fat_calc_dir_=
size()=C2=A0can=C2=A0be=C2=A0greater=C2=A0than=C2=A0FAT_MAX_DIR_SIZE,=C2=A0=
i.e.=0D=0A>=C2=A0can=C2=A0be=C2=A0in=C2=A0GBs,=C2=A0hence=C2=A0directory=C2=
=A0traversal=C2=A0can=C2=A0take=C2=A0long=C2=A0time.=0D=0A>=C2=A0for=C2=A0e=
xample=C2=A0when=C2=A0command=C2=A0=22ls=C2=A0-lR=22=C2=A0is=C2=A0executed=
=C2=A0on=C2=A0corrupted=C2=A0FAT=0D=0A>=C2=A0formatted=C2=A0USB,=C2=A0fat_s=
earch_long()=C2=A0function=C2=A0will=C2=A0lookup=C2=A0for=C2=A0a=C2=A0filen=
ame=C2=A0from=0D=0A>=C2=A0position=C2=A00=C2=A0till=C2=A0end=C2=A0of=C2=A0c=
orrupted=C2=A0directory=C2=A0size,=C2=A0multiple=C2=A0such=C2=A0lookups=0D=
=0A>=C2=A0will=C2=A0lead=C2=A0to=C2=A0long=C2=A0directory=C2=A0traversal=0D=
=0A>=0D=0A>=C2=A0Added=C2=A0sanity=C2=A0check=C2=A0for=C2=A0directory=C2=A0=
size=C2=A0fat_calc_dir_size(),=0D=0A>=C2=A0and=C2=A0return=C2=A0EIO=C2=A0er=
ror,=C2=A0which=C2=A0will=C2=A0prevent=C2=A0lookup=C2=A0in=C2=A0corrupted=
=C2=A0directory=0D=0A>=0D=0A>=C2=A0Signed-off-by:=C2=A0Anupam=C2=A0Aggarwal=
=C2=A0<anupam.al=40samsung.com>=0D=0A>=C2=A0Signed-off-by:=C2=A0Amit=C2=A0S=
ahrawat=C2=A0<a.sahrawat=40samsung.com>=0D=0A=C2=A0=0D=0AThere=C2=A0are=C2=
=A0many=C2=A0implementation=C2=A0that=C2=A0doesn't=C2=A0follow=C2=A0the=C2=
=A0spec=C2=A0strictly.=C2=A0And=0D=0Awhen=C2=A0I=C2=A0tested=C2=A0in=C2=A0p=
ast,=C2=A0Windows=C2=A0also=C2=A0allowed=C2=A0to=C2=A0read=C2=A0the=C2=A0di=
rectory=C2=A0beyond=0D=0Athat=C2=A0limit.=C2=A0I=C2=A0can't=C2=A0recall=C2=
=A0though=C2=A0if=C2=A0there=C2=A0is=C2=A0in=C2=A0real=C2=A0case=C2=A0or=C2=
=A0just=C2=A0test=0D=0Acase=C2=A0though.=0D=0A=C2=A0=0D=0ASo=C2=A0if=C2=A0t=
here=C2=A0is=C2=A0no=C2=A0strong=C2=A0reason=C2=A0to=C2=A0apply=C2=A0the=C2=
=A0limit,=C2=A0I=C2=A0don't=C2=A0think=C2=A0it=C2=A0is=0D=0Agood=C2=A0to=C2=
=A0limit=C2=A0it.=C2=A0(btw,=C2=A0the=C2=A0current=C2=A0code=C2=A0should=C2=
=A0detect=C2=A0the=C2=A0corruption=C2=A0of=0D=0Ainfinite=C2=A0loop=C2=A0alr=
eady)=0D=0A=C2=A0=0D=0AThanks.=0D=0A=C2=A0=0D=0A>=C2=A0---=0D=0A>=C2=A0=C2=
=A0fs/fat/inode.c=C2=A0=7C=C2=A07=C2=A0+++++++=0D=0A>=C2=A0=C2=A01=C2=A0fil=
e=C2=A0changed,=C2=A07=C2=A0insertions(+)=0D=0A>=0D=0A>=C2=A0diff=C2=A0--gi=
t=C2=A0a/fs/fat/inode.c=C2=A0b/fs/fat/inode.c=0D=0A>=C2=A0index=C2=A0a0cf99=
d..9b2e81e=C2=A0100644=0D=0A>=C2=A0---=C2=A0a/fs/fat/inode.c=0D=0A>=C2=A0++=
+=C2=A0b/fs/fat/inode.c=0D=0A>=C2=A0=40=40=C2=A0-490,6=C2=A0+490,13=C2=A0=
=40=40=C2=A0static=C2=A0int=C2=A0fat_calc_dir_size(struct=C2=A0inode=C2=A0*=
inode)=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0ret;=0D=0A>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inode->i_size=C2=
=A0=3D=C2=A0(fclus=C2=A0+=C2=A01)=C2=A0<<=C2=A0sbi->cluster_bits;=0D=0A>=C2=
=A0=C2=A0=0D=0A>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=
=C2=A0(i_size_read(inode)=C2=A0>=C2=A0FAT_MAX_DIR_SIZE)=C2=A0=7B=0D=0A>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0fat_fs_error(inode->i_sb,=0D=0A>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=22%s=C2=A0corrupted=C2=A0directory=C2=A0(invalid=C2=A0size=
=C2=A0%lld)=5Cn=22,=0D=0A>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__func__,=C2=A0i_s=
ize_read(inode));=0D=0A>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0-EIO;=0D=
=0A>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>=C2=A0=
+=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
=C2=A00;=0D=0A>=C2=A0=C2=A0=7D=0D=0A=C2=A0=0D=0A--=C2=A0=0D=0AOGAWA=C2=A0Hi=
rofumi=C2=A0<hirofumi=40mail.parknet.co.jp>=0D=0A=C2=A0
