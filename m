Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EC5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 08:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAA02075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 08:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iWvAhM/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgHBISD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 04:18:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:35023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgHBISC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 04:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596356258;
        bh=PQ2sPG5p324ifQb0YMxfDxK1lEkh9ilGDsno+DsEzaY=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=iWvAhM/zZhMDtha0+OWH4G9YwBGXZNFpalSuBKsql4yYhuXSQcCy603sVFYLlPMaA
         VHkHsP15O5gPFp1XjU553i6A+J1Ku9dslLTDLpineq4uvRxOzhzzohllIV5xBWR6R8
         NMhdM4JyWVFopK3j0MnxhmQWbjIbKfgIc3849sjI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.148.8]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1k1Jq83J3N-001NND; Sun, 02
 Aug 2020 10:17:37 +0200
Date:   Sun, 02 Aug 2020 10:17:31 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAOTY_99VEs2aNAoWBJhcCMsem5ewmV18B=GMLc_n-Wico_+Hg@mail.gmail.com>
References: <20200728111800.77641-1-frank-w@public-files.de> <20200728111800.77641-5-frank-w@public-files.de> <CAAOTY_99VEs2aNAoWBJhcCMsem5ewmV18B=GMLc_n-Wico_+Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] drm/mediatek: dpi/dsi: change the getting possible_crtc way
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <3A3F5CA5-85C9-4CD8-9CF1-8A4411901C1F@public-files.de>
X-Provags-ID: V03:K1:8AbS/l2zu48Uj4jsqyhgwGVm2qyPBsdakcvG9Thdq1zFkKpd6dk
 Q+UyV2CGpURx6lo8b+g3oSAzIaRq035kzd53WFtueIzKa7TTeq2/F8fjxLQxthNongRZk7G
 lCUB+5sBqkTxYIswin6WMeOHvOhwzjqh2b4X67xBQt8Yy5oab6O/ULVnWl+a3ZdclD7Zq/G
 FY9RGUvvIIVzr45Av0ZJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G51yrzLeBO0=:d2FSDmTPqkppOl/VBTwRzr
 8fPrlJrtoYDBs7THCu0R6PGEuVR2kzk3JU7ji3eQl8FU8pjn5FZys+lYjHyMpHsf+1So/I9q+
 sI0ewbX7D+sDDUUDHDONN/hcVpVGCs4TznsZvF9XzmCvA4bxJCfdqRaaxgXCdT3HyGx36U8Uk
 7mSk+SfsaZ40zFayIe+s8oCrCsyqEh41N7M1NmNLbWWQ8PW7l4o9wf6g4T1y/XfdsXpSx56gP
 zxbffcx+31l6Q/owUwLkInMg1oq4vNv9+0c48ALsIz3Q6zjlU185ZVDTKI3x7fNxl1eb2vrnm
 y7r2B5e5Se1SUlDbj7J0iFa5KTKMjc1HHHElatwoaBiV4zwCDuQuB00buBAHawH4J8Ct8EYC6
 bxL26C29u+u0lm6JJ30Lofnsii99UUySVlAvjsOkID4QUY/a7rqv68mazwtKoHySmDi6AQnfA
 9x4JV9oSykmfuTs9qXDHcyhgc5NBKYBJ0qAPd/MDNgb787oH16E+FTpXR/z6XdC9RgQoX2uKB
 UNwwmbr/kWkLSgnVLCiyOBbm4gh9F+wYyT/hpEMffjjC/WjiO8NJ6i32EAW83tCGV8oN9ODQF
 59LMNdHSloEaqUMsrmr9Ml8FUvmHAcNSV4yxZsDsTrBwU7/WQ6YJZgE98D5Jic1l5Rz1lK4fQ
 CX/6PJhpgLk+Acgyeu1Xcm6sRpLCJWZ0bGWbi96AYEQL7HQLuxtgsQ8Zs1W5KTIyN0UPyViZJ
 zJSj/XsffRnccSp/IFzbc9sHOVYi81RH9CI0B3dpJ0dIFCKyd3iip7PZt8EwcjwOQT6Ks8sp2
 LDO7bhVYue1wQJsSvPTIXj4TPksq0akfVjwxlp3p6whEyXgx61NGLbTcAnCMKNKtoN/WGKYZ2
 jn8fI9BwH2cEFO0juwiNdCM9lTQJacRp4gJ+Jn3Fod81rsfskLoMan7rOjRhSPEYtSwQDasUB
 TSOY91kTmHF7kbajHGwKdO8d9ZdOwuv/bqKKnc4khW7pUVQa/68P3tB7oxWVntAuQAnNxSY1q
 d0hdajM9WWujWv+JKS5zAqiOU682g2GvDVLGwYpsj1sWwfNfShX/cQgc+amrCWBSHpx5Q4T5E
 arKVpawwvOP99/xs+2NW1kPDBTtSBmmmtzBu4vMG/qhucOH8CUYeY2ZHHCAqK9i5GTo4jBosi
 InoCaKt60ujslaqzeXuSP3KOb3Ga+PpldDo28mck+04RGWPYtFLxVkUD6vGJtpdEfd0FzcN/i
 ugsqyFkVZNof0+ilojGLF9MTNbiT6nYUwKPevxg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 2=2E August 2020 05:07:41 MESZ schrieb Chun-Kuang Hu <chunkuang=2Ehu@ke=
rnel=2Eorg>:

>I would like more information of why do this patch=2E For example:
>
>For current mediatek dsi encoder, its possible crtc is fixed in crtc
>0, and mediatek dpi encoder's possible crtc is fixed in crtc 1=2E In
>some SoC the possible crtc is not fixed in this case, so call
>mtk_drm_find_possible_crtc_by_comp() to find out the correct possible
>crtc=2E
sounds good (and you have much more knowledge about drm subsystem than i)=
=2E I will take this for next version
regards Frank
