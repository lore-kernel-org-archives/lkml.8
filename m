Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0435C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890BF20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fo3RllS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgGFPx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:53:58 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:42271 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgGFPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:53:58 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200706155354epoutp049318707bfc7925eea9313bd99e3a0fd3~fNMmzl_9K1028410284epoutp04Z
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 15:53:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200706155354epoutp049318707bfc7925eea9313bd99e3a0fd3~fNMmzl_9K1028410284epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594050834;
        bh=GWXYfDKAYwwxxk6FrcmqUEL3Q0Iav7F34gH3uoT2p0Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fo3RllS3uwwnyW1IvFhzX+ihdFM5y/WdIx0R4Ev6vHTGShWGBYs+xEC/sGP1laLiG
         CHuzK859p1nIwrbLXDMemay/mywI0LLsCeymkq9HUy+9jbDpZXzPgdl8EHCgy7nnVb
         qqBnbGKQka+0Sdra1ShbT/luh6ZAxAXlbnMDxhoc=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200706155353epcas5p3a881bb765ba16c67a3fe7957c3368aae~fNMmOoIO62799627996epcas5p3Q;
        Mon,  6 Jul 2020 15:53:53 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.C6.09467.119430F5; Tue,  7 Jul 2020 00:53:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200706155352epcas5p1dda4df18c037960b6a326e077d7cec8f~fNMlscvsB2582125821epcas5p1d;
        Mon,  6 Jul 2020 15:53:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200706155352epsmtrp184f8be7fa0a1763a02af5e6af535cdbc~fNMlruSTj1979919799epsmtrp1-;
        Mon,  6 Jul 2020 15:53:52 +0000 (GMT)
X-AuditID: b6c32a49-a3fff700000024fb-5b-5f0349113747
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.1B.08382.019430F5; Tue,  7 Jul 2020 00:53:52 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200706155350epsmtip1097297e896e175d74dd7052060e220cf~fNMj-mzah0236102361epsmtip1E;
        Mon,  6 Jul 2020 15:53:50 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
In-Reply-To: <20200705182306.GA13827@kozik-lap>
Subject: RE: [PATCH v1 2/2] arm64: dts: exynos: keep LDO12 always-on
Date:   Mon, 6 Jul 2020 21:23:49 +0530
Message-ID: <02e601d653ad$a5734190$f059c4b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJLYggk8ojyKiThj86cHLqsfdRQHAG6bdnCAyh2CO0B1MYKXqfa1vMg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZdlhTQ1fQkzneYOJZIYv5R86xWpw/v4Hd
        YtPja6wWl3fNYbOYcX4fk0Xr3iPsDmwem1Z1snlsXlLv8XmTXABzFJdNSmpOZllqkb5dAlfG
        mePL2Qo+8Ffs2LmXtYHxF08XIyeHhICJxP+2WUxdjFwcQgK7GSXWf7/GCOF8YpTYfOUpC4Tz
        jVHiUt9L9i5GDrCWnS2OEPG9jBLvbjUzQzhvGCUu/zjHDDKXTUBXYsfiNjYQWwTI3nxjOTtI
        EbPAckaJW79vsIBM4hTQl3jYHwFSIyzgIrG8Zx8jiM0ioCKx+8B+VhCbV8BS4v2zlSwQtqDE
        yZlPwGxmAW2JZQtfM0P8oCDx8+kyVohdbhK3dq9hhqgRlzj6swfsOAmBv+wS3TN2QzW4SMze
        3McEYQtLvDq+hR3ClpJ42d8G9WW2RM8uY4hwjcTSecdYIGx7iQNX5oCdzyygKbF+lz7EKj6J
        3t9PmCA6eSU62oQgqlUlmt9dheqUlpjY3c0KUeIhcaQtdQKj4iwkf81C8tcsJPfPQti1gJFl
        FaNkakFxbnpqsWmBYV5quV5xYm5xaV66XnJ+7iZGcIrR8tzBePfBB71DjEwcjIcYJTiYlUR4
        e7UZ44V4UxIrq1KL8uOLSnNSiw8xSnOwKInzKv04EyckkJ5YkpqdmlqQWgSTZeLglGpgck4/
        WVKqzFLVqym8bdG+I4JWy/Vf/z5noXCpxVHtxcyV/P1MvA8nB6offP7s2jHDKecynQ5npV11
        vSA0dd/BnizDdmu9wrtOnncSD9qummwaqMic9GtTJfv5rIDnSdH+yjdc98l0cV/IX2rHdPLC
        vKSP8y33Luk6p/PBYMu6OaxbP7eyzUld5G551qNoxZHInguTQ2t25EpvjHht8fha7cLbLq0P
        A5l0eEOaU0S3ndvV3f41/PXFmRfWcRjVbvPZzsYgHrjDp6Tpbf2Hp5F7V61dI8bKOr21eev8
        lY9nbWhmvrzaecvZAs8UY/5wp6PuXrUschtWn+d1nVxb6x0fuOTjJL6YwtASC9OHs0PblFiK
        MxINtZiLihMBitxqhKADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnK6AJ3O8wf0Huhbzj5xjtTh/fgO7
        xabH11gtLu+aw2Yx4/w+JovWvUfYHdg8Nq3qZPPYvKTe4/MmuQDmKC6blNSczLLUIn27BK6M
        JSeesBdc5K/Y8PMecwPjTZ4uRg4OCQETiZ0tjl2MXBxCArsZJT7f/MTcxcgJFJeWuL5xAjuE
        LSyx8t9zdoiiV4wSu75/BytiE9CV2LG4jQ3EFgGyN99YDlbELLCaUeLvvT3MEB2PGCW2Xj/N
        CrKOU0Bf4mF/BEiDsICLxPKefYwgNouAisTuA/tZQWxeAUuJ989WskDYghInZz4Bs5kFtCWe
        3nwKZy9b+BrqUgWJn0+XsUIc4SZxa/caZogacYmjP3uYJzAKz0IyahaSUbOQjJqFpGUBI8sq
        RsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgeNHS3MG4fdUHvUOMTByMhxglOJiVRHh7
        tRnjhXhTEiurUovy44tKc1KLDzFKc7AoifPeKFwYJySQnliSmp2aWpBaBJNl4uCUamCSSm9o
        DVUu8lS5t9x8Y7XhPHtOk8ztDFN3JFS8eTX34+63UjvdZl3kfs5/oFL1o0TvsZMOorLHHbwS
        TvxOvFizk/M4g8uKrHd6fIb/Vl28qtR/Zeatbh65HfU7H8fq7KzbHlEmqcbxz++QEZ+L9cPk
        w7/vHJ+7S0xcXrY1c/rEKHGrg69PMorGLqiTOyL+6Gp84bpPyReL7P5/Pye5pJ/vMcvbOSnL
        nq6s+iBVe3hauumpJpHa/6WJ3YE7U6Tnf3c8zntORSn28zfN/RMS69pWRJx4mv1wQmV4Nw/H
        NfkGyQsnp95h8VGwtWwX/FBQXHYz2Cqs+NmMdZM86nVZVP3+1HpePTHPYNMGU6YzTNVKLMUZ
        iYZazEXFiQDy7wpQBgMAAA==
X-CMS-MailID: 20200706155352epcas5p1dda4df18c037960b6a326e077d7cec8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200705072938epcas5p479f0d040ca34fd44b2ba893a199efb79
References: <20200705070918.63531-1-alim.akhtar@samsung.com>
        <CGME20200705072938epcas5p479f0d040ca34fd44b2ba893a199efb79@epcas5p4.samsung.com>
        <20200705070918.63531-2-alim.akhtar@samsung.com>
        <20200705182306.GA13827@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 05 July 2020 23:53
> To: Alim Akhtar <alim.akhtar=40samsung.com>
> Cc: devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org;=
 linux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> robh+dt=40kernel.org
> Subject: Re: =5BPATCH v1 2/2=5D arm64: dts: exynos: keep LDO12 always-on
>=20
> On Sun, Jul 05, 2020 at 12:39:18PM +0530, Alim Akhtar wrote:
> > LDO12 on exynos7 supply power to VDDQ_UFS20_RESET, in case this
> > regulator is OFF, UFS host controller can not send command to UFS
> > device. To keep this supply ON, set regulator-always-on property for
> > this ldo.
>=20
> Why UFS does not take any supplies? This looks like a workaround for the =
case
> of not implementing any consumer.
>=20
This particular supply is not part of UFS HCI spec and binding documentatio=
n, as per binding only one supply for host controller and three others for =
UFS device are needed. My best guess is, VDDQ_UFS20_RESET supply to reset l=
ogic block inside HCI, which might be specific to this controller version (=
I did not find any such supply in the latest host controller though).

> Best regards,
> Krzysztof
>=20
>=20
> >
> > Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
> > ---
> >  arch/arm64/boot/dts/exynos/exynos7-espresso.dts =7C 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> > b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> > index bb86950032d3..92fecc539c6c 100644
> > --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> > +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> > =40=40 -194,6 +194,7 =40=40
> >  				regulator-min-microvolt =3D <1000000>;
> >  				regulator-max-microvolt =3D <1300000>;
> >  				regulator-enable-ramp-delay =3D <125>;
> > +				regulator-always-on;
> >  			=7D;
> >
> >  			ldo13_reg: LDO13 =7B
> > --
> > 2.17.1
> >

