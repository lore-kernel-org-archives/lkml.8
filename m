Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6610C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01AD2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g8gfqBz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgEFNGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:06:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:44998 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgEFNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:06:05 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200506130601epoutp02627c40e15d64b89c46d43dd17071a718~McjnmjF4B1460214602epoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:06:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200506130601epoutp02627c40e15d64b89c46d43dd17071a718~McjnmjF4B1460214602epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588770361;
        bh=REp5cMAB/X+MaeXe6tEHjuJoP5GbS74ogwgiAXj7E9U=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=g8gfqBz/nbCf58wVIk1LxSh58cg1gOSFDAvvHs4zeTods8Sq4DrHxBfioQNRG3YjD
         vJBbmSg1433ZNSiiGA0RDCnjyDOcaLVCkoAPL/AYzNqg0tR4fhj/pTSZ9EwMmdzWUn
         wsKFD+zAfgMwcBojtarPHyixgerou3Jt+5KVhslI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200506130601epcas2p40ca1fb93bfb5ae459906e6d8478720f9~McjnLXtU_0139801398epcas2p43;
        Wed,  6 May 2020 13:06:01 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.187]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49HH062kFHzMqYkZ; Wed,  6 May
        2020 13:05:58 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.10.04647.636B2BE5; Wed,  6 May 2020 22:05:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200506130557epcas2p2816ed596f34dd10405e748e1fcd12ebe~McjjgQBdh2082720827epcas2p2b;
        Wed,  6 May 2020 13:05:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200506130557epsmtrp2f90465e95893ece2bdff5919744dea36~McjjcR9B41737917379epsmtrp2H;
        Wed,  6 May 2020 13:05:57 +0000 (GMT)
X-AuditID: b6c32a48-88dff70000001227-be-5eb2b636b0c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.81.18461.436B2BE5; Wed,  6 May 2020 22:05:56 +0900 (KST)
Received: from KORCO008850 (unknown [12.36.185.49]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200506130556epsmtip22f1bdb82c78c22d15ee7aff33ca275ad~McjjLUrlw3177131771epsmtip2B;
        Wed,  6 May 2020 13:05:56 +0000 (GMT)
From:   =?utf-8?Q?=EC=B5=9C=EB=8F=99=ED=98=81/DONGHYEOK_CHOE?= 
        <d7271.choe@samsung.com>
To:     "'Will Deacon'" <will@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hosung0.kim@samsung.com>,
        <changki.kim@samsung.com>, <hajun.sung@samsung.com>,
        <gregkh@google.com>, <youngmin.nam@samsung.com>
In-Reply-To: <20200506125315.GH8043@willie-the-truck>
Subject: RE: Reqeust export symbol for API in arch/arm64/*
Date:   Wed, 6 May 2020 22:05:56 +0900
Message-ID: <000001d623a7$14bc6590$3e3530b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWb/N1gTRzZGonrGREO3YTptpglQFi3uW7ArVbMHuoeau0sA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+Ty7HK0TX2vVq3/IOBmkYW2rs46WEhU1SGoVGHSZHdxBzd3Y
        2Sqji5SVltkFU5op2sVCxGyJWFGtGSwrM4yuVJZd6YZpWesC7Xgm+d+P932e732f7/tIQlWv
        iCPz7G7eZeestCJG1tqeyCQbWn1mbVPHeLbk+W05+3YwRLA7rnYT7PeHvUrW9+qBnL138ZiC
        LXrKsCf8/cq5pLHW5zH6GkoUxvMntxvLWhqQccAXb5Kvss7J5TkL79Lw9myHJc+ek0YvXpE1
        P4sxaHXJuhR2Fq2xczY+jV6QYUpemGcNL0JrNnBWT7hk4gSBnp4+x+XwuHlNrkNwp9G802J1
        6nTOaQJnEzz2nGnZDluqTqvVM2HlOmtu4bu+KOcjalPNn0+yQlRJ7UXRJOCZsOt7h3IviiFV
        uA3BnpedSGyocD+CS5X5UmMQwcDvQjTsaL3+Ry41LiO4di4Usb9HEPx2ekilwCuh5/UDhchq
        PBmuhJqRKCJwF4Kij51hB0lGYwaaAzpRMw6nQoU/IBdZhhOgseXaEFM4BToHbyglHgsdR1/L
        RCbwVKiv+0hIG2kg9KZeLh6pxvOgIhgrSdRQVbKbEMcCPkrCqV1FkQQL4MzxqxHvOPgQbFFK
        HAcDXy4rJN4I/aEgkszFCJ7fKo2YZ4D37R4kDiNwIpy9OF1EwJPg+pPIamOguP2vUipTULxb
        JRkToKvsBRqe1Fz9Oeogor0jgnlHBPOOSOD9P6sWyRrQBN4p2HJ4Qe+cOfKtfWjojyYZ25D/
        TkYAYRLRoyl/vc+sknMbhAJbAAFJ0Gpq9M9zZhVl4Qo28y5Hlstj5YUAYsL3foiIG5/tCP94
        uztLx+gNBm0KwzIGPUtPpHyjHq9R4RzOzefzvJN3DfuiyOi4QtRQuzWTSiLjm8qrzd3Ly5fW
        VVlS0mdrlllvN25RtGUc0nj7bK0Fh7V0z9ptyh198fub8snSZysWZ2wasKSePdBsypbdWVS5
        moyf/8v7ON2yJPFu+5RYd3JReuL6818dTT9ia+4fOXFBb5i7r3ereVtXzM3MbvKeSc11mipw
        zU5/kJYJuZwuiXAJ3D/9dj9CuQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXtdk26Y4g1VTrC06751htXj27Sez
        RdP+S8wWX68/YrfY9Pgaq8XlXXPYLFrumFosPvCJ3YHDY8GmUo9NqzrZPDYvqffo27KK0ePz
        JrkA1igum5TUnMyy1CJ9uwSujG89J1gKmrgqzv89xNjA2MfRxcjJISFgIrHtyB/WLkYuDiGB
        3YwSffMvMUIkpCTat8xkgrCFJe63HIEqesYocerOJpYuRg4ONoFQie0nBUBqRARUJfb93MAI
        UsMscJ1RYtbPX4wQDVsYJVZfOMYE0sApYCqx4ZAhSIOwgJXEtAOHWEFsFgEViTVbDoLZvAKW
        Eme/nWCHsAUlTs58wgJiMwtoSzy9+RTOXrbwNTPEcQoSP58uYwUZLyLgJDHtuCREiYjE7M42
        5gmMwrOQTJqFZNIsJJNmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOKK0
        NHcwbl/1Qe8QIxMH4yFGCQ5mJRFenh8b44R4UxIrq1KL8uOLSnNSiw8xSnOwKInz3ihcGCck
        kJ5YkpqdmlqQWgSTZeLglGpgYv/uZJy3x1dxY4TlIfuUPRX67N8iJ/nd+Dqrv/2wxRaVw0sP
        VWT6rtOf8oXX6PSeZ9q+wjPnpkgZ9ol6BL9bM295zIJHJ1TcD0xxORsaap0ipdPwVNPukGeX
        97svWsbsu+PWKbYlXmbgvrtirnf20ff7M6cvblm2Wf3zG6+b8dv+1PZUqp0487VySr6lp5a2
        TW34JkH/aQbPPe/xv432dtO6s+lLnub51Bl7bcotX5T+vc1hWBskouJV4O1YsmTb9Q1HJ8/c
        kWZ1er9L3I0kAeEdaexHRR7mJD4JTaj0UXz99aetg9v1h5dnyTmktuXvTktcuUW/noGx80Ol
        8hZfz51PH/w+sShkTm7LIituJZbijERDLeai4kQAxdBsDBcDAAA=
X-CMS-MailID: 20200506130557epcas2p2816ed596f34dd10405e748e1fcd12ebe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506124645epcas2p25a8efbe59fa20194e19d642227dd47ae
References: <CGME20200506124645epcas2p25a8efbe59fa20194e19d642227dd47ae@epcas2p2.samsung.com>
        <00bc01d623a4$669d1e70$33d75b50$@samsung.com>
        <20200506125315.GH8043@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Will Deacon <will=40kernel.org>
> Sent: Wednesday, May 6, 2020 9:53 PM
> To: =EF=BF=BD=D6=B5=EF=BF=BD=EF=BF=BD=EF=BF=BD/DONGHYEOK=20CHOE=20<d7271.=
choe=40samsung.com>=0D=0A>=20Cc:=20linux-arm-kernel=40lists.infradead.org;=
=20linux-kernel=40vger.kernel.org;=0D=0A>=20hosung0.kim=40samsung.com;=20ch=
angki.kim=40samsung.com;=20hajun.sung=40samsung.com;=0D=0A>=20gregkh=40goog=
le.com;=20youngmin.nam=40samsung.com=0D=0A>=20Subject:=20Re:=20Reqeust=20ex=
port=20symbol=20for=20API=20in=20arch/arm64/*=0D=0A>=20=0D=0A>=20On=20Wed,=
=20May=2006,=202020=20at=2009:46:45PM=20+0900,=20=20=D6=B5=20=20=20/DONGHYE=
OK=20CHOE=20wrote:=0D=0A>=20>=20I=20am=20software=20engineer=20in=20charge=
=20of=20BSP=20(Samsung=20SOC=20vendor).=0D=0A>=20>=0D=0A>=20>=20Recently,=
=20Google=20introduced=20GKI=20from=20Android=20R=20version.=0D=0A>=20>=20W=
e=20cannot=20use=20mainline=20API=20without=20'export=20symbol'=20by=20the=
=20GKI=20policy.=0D=0A>=20>=20But=20we=20want=20to=20make=20an=20arm64=20sp=
ecific=20vendor=20driver=20in=20=7Bkernel=20source=0D=0A>=20>=20root=7D/dri=
vers/soc/samsung/*.=0D=0A>=20>=0D=0A>=20>=20Could=20you=20support=20us=20to=
=20use=20the=20below=20APIs?=0D=0A>=20=0D=0A>=20Sorry,=20but=20as=20a=20gen=
eral=20rule=20of=20thumb=20the=20kernel=20doesn't=20EXPORT=20symbols=0D=0A>=
=20that=20are=20not=20used=20by=20in-tree=20modules.=20You'll=20need=20to=
=20submit=20your=20drivers=0D=0A>=20along=20with=20the=20patches=20doing=20=
the=20exports=20if=20they=20are=20to=20be=20considered=20for=0D=0A>=20inclu=
sion.=0D=0A>=20=0D=0A>=20Thanks,=0D=0A>=20=0D=0A>=20Will=0D=0A=0D=0AThank=
=20you=20for=20your=20quick=20response.=0D=0AI'll=20try.=0D=0A=0D=0AThanks=
=0D=0A=0D=0A
