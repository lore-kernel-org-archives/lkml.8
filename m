Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375BFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB042078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T+HNDBE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgHUHLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:11:33 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:50437 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgHUHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:11:29 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200821071125epoutp02571845df1e88e0dd41828fc51868baa0~tNvjk9up60746707467epoutp02i
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:11:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200821071125epoutp02571845df1e88e0dd41828fc51868baa0~tNvjk9up60746707467epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597993885;
        bh=pWhxRBBhpPL/FNckZSjtofTkWnWYHR8ValDZxMZ2xws=;
        h=From:To:Cc:Subject:Date:References:From;
        b=T+HNDBE9prfmOQSbCSY7oyTj/GB/L2AG4xQPCHRMFWMXClkvggw4HfsgMdhNZmzf8
         T5gJrGH2e8gSDYq6Brl3lBeOm8D/fFepE5gaKwYpoEcRryp16FmSStRdH/ZFNInky4
         gvP791B8BgO3frWj5MXAP8q8Pyt2MpwtwcMTRJdo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821071124epcas1p2cb22caadc80637b59cddfbc4bf0c31c1~tNvjBv6L63015030150epcas1p2D;
        Fri, 21 Aug 2020 07:11:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BXt3Z1Nn6zMqYkg; Fri, 21 Aug
        2020 07:11:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.8D.18978.A937F3F5; Fri, 21 Aug 2020 16:11:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821071121epcas1p12225cf2891c2bbe22b90ac65e826dcaa~tNvgI2I6P1342713427epcas1p1R;
        Fri, 21 Aug 2020 07:11:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821071121epsmtrp27ec11fa305d199e8343a20e4abe67d12~tNvgHZR4u2513725137epsmtrp2N;
        Fri, 21 Aug 2020 07:11:21 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-5b-5f3f739a9010
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.20.08303.9937F3F5; Fri, 21 Aug 2020 16:11:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.64]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200821071121epsmtip2cc62b0a65d5e107ca3d3e67eeee637b5~tNvf0yzxj2425024250epsmtip2f;
        Fri, 21 Aug 2020 07:11:21 +0000 (GMT)
From:   Hoegeun Kwon <hoegeun.kwon@samsung.com>
To:     nsaenzjulienne@suse.de, eric@anholt.net, maxime@cerno.tech
Cc:     devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        dave.stevenson@raspberrypi.com, sboyd@kernel.org,
        mturquette@baylibre.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org, hoegeun.kwon@samsung.com
Subject: [PATCH 0/3] drm/vc4: Support HDMI QHD or higher output
Date:   Fri, 21 Aug 2020 16:10:42 +0900
Message-Id: <20200821071045.24501-1-hoegeun.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxTAvX2vr5Ws5KWycgMM8JFtouGjlNon4yvOsZfgB4mJf7DM+qAv
        LVLapg8WN1DBCVOgQjeWjSq6TUwXFhxfqZSkoaOwKoqNApWBQCYZW1As0CCImVs/WNh/v3Pu
        7+Tcc+/hI0IzFsEv0pQyeg2tJrAQ1OKIT0gwsVny5JUXPLLdMISSiy3XUfLa4H0uObbqwUh7
        1SggPeZajLSOtaNk15ybSy7Xz3DJ0b4rGGmc6uCR366/BuSD4Q9Ii8mMkTcnn2JktW2QR752
        d6Lkk69nQbaQOuf5FaM8E9U8yjQ7glGP77swymqa5lFdbRcxarbOyaG6W89S1UMbKHWppw1Q
        3XfLKW9XdN4b+cXpKoZWMPpYRlOoVRRplBlE7lH5+3Lp3mRxgngfKSNiNXQJk0EcOJiXkFOk
        9k1HxH5Cq8t8qTyaZYmkzHS9tqyUiVVp2dIMgtEp1Lp9ukSWLmHLNMrEQm1Jmjg5OUXqE08U
        qxx3bajuc+yUpTGyEkyhtWA7H+KpcKPfhdSCEL4Q7wXw5sj3aDBYAdA13sALBl4AGxxbJaah
        x5slfQCOWy1blmmmk+O3MDwBrtY/CnAYnglr6n8BfgnBbyHw0Rd1PP/BDjwLPp0eCkgo/jas
        WnNhfhbgGfBe1Teb7WLgTx12JMjtfDhVlxnkA/Dag2ZekHfABWfPJkdA73MbFmQWjjUvBAaC
        eKVvBuPlTUkC+2985WvM990oHv7clxRM74TWVy3AzwgeCp+v1nP9CsQF8EKNMKi8A+cr7dwg
        R8Fhg5kTZApOev8OtBXiH8NG+zyvEbxl2mrwHQBtQMTo2BIlw4p14v//UhcIbOxuaS8wLi4l
        DgAOHwwAyEeIMIHB9p5cKFDQn37G6LVyfZmaYQeA1PdeRiTizUKtb+U1pXKxNEUikZCp4r1S
        sZgIF/w+GSsX4kq6lClmGB2j/6+Ow98eUckp2JPSULFo0WdY8B+MNVXbJlbylfCY40vqfM8/
        h8/OrUrWOyKyRX9yc8ult7Y5x6SnNUve1NDa8D8+ar36bNEuOnr4hWzdcKjbLXo4JzmTHaXK
        q8k/XnDkykzFjRNh8679ztDpnJAi4mL/uSfcrJGoZVd4xSGnMfFDJyPb34RUPHzV+EztFnha
        046479Ry4ueHTwm6w/mnFWvLO086Wi7odpWPnkd3RecMVjtp5R3CeDmmw+BM+62yKWYjTi3J
        H2lq2RPtEtyOycppdi79GFl/+6+C3HFR5PHed6fp3DOynkveOLBQbgYTtrmk2TjqevpJKs4j
        m3jZFLlm7bx37CWBsipavBvRs/S/1GhtTDoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvO7MYvt4g4crVC3W9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20ji8WjqfcZHYQ8mt4fY/N4f6OV3WPW/bNsHnfOnWfz
        2DnrLrvHplWdbB73u48zeWxeUu/RevQXi0ffllWMHptPV3t83iQXwBPFZZOSmpNZllqkb5fA
        lXH49F6Wgma2im0TpBsYb7N0MXJySAiYSMw6eoe5i5GLQ0hgB6PEhv55zBAJGYlV/VtYuxg5
        gGxhicOHiyFqPjJK/GtpZwKpYRPQlfjacx3MFhFwknjwdx/YIGaB48wS0/sPsIIkhAXsJV7f
        PQpWxCKgKtH4/TwbiM0rYCtxpnE61BXyEqs3HGCewMizgJFhFaNkakFxbnpusWGBUV5quV5x
        Ym5xaV66XnJ+7iZGcMhrae1g3LPqg94hRiYOxkOMEhzMSiK8vXut44V4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzfp21ME5IID2xJDU7NbUgtQgmy8TBKdXAdOTg17vvGL6nKoXdYdx8sD7EzfnU
        RPGfF672r3OTSxXkzzrUsGxDi+A+t6p8n3Pt4nv+Rp56Mu34dz2hbM/TyR87WdXl9j2TdNom
        Fdf47dVjkZudoQ9Ujn/aeTo5gTuf+6fpLdnAg73e59WNg3l3VrM0bRe94dSyRpt5XeEyfccu
        yRCn4FBXv0iBlp0K6w8qmn428eU4Kt4dtvTy6lPbRNYe8px2pc+3MKA+MJ4n6t7N5weyE15f
        /i6/nXMvm/HcR39mZi+o0IyeVjBre17tUWl9o27TT7YlF+RuqLm4rmmx/X2zYsX5WtavjXM2
        Kpv0JAvOsvi8f9uSN1GvX/Hum/55DfulrPLSz37ctdXxSizFGYmGWsxFxYkAvX5QCOgCAAA=
X-CMS-MailID: 20200821071121epcas1p12225cf2891c2bbe22b90ac65e826dcaa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200821071121epcas1p12225cf2891c2bbe22b90ac65e826dcaa
References: <CGME20200821071121epcas1p12225cf2891c2bbe22b90ac65e826dcaa@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

There is a problem that the output does not work at a resolution
exceeding FHD. To solve this, we need to adjust the bvb clock at a
resolution exceeding FHD.

Rebased on top of next-20200708 and [1].

[1] : [PATCH v4 00/78] drm/vc4: Support BCM2711 Display Pipeline (Maxime's patchset)

Hoegeun Kwon (3):
  clk: bcm: rpi: Add register to control pixel bvb clk
  ARM: dts: bcm2711: Add bvb clock for hdmi-pixel
  drm/vc4: hdmi: Add pixel bvb clock control

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  6 ++++--
 drivers/clk/bcm/clk-raspberrypi.c     |  1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c        | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi.h        |  1 +
 4 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.17.1

