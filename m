Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D184C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167D4206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bANlL0et"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgHDJx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:53:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:48889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgHDJx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596534808;
        bh=UjeGRcpAgU30m1QdVj6HpRLtLtjKyy+eXr8UxSxBC2I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bANlL0etjAqnUNI1l+6XL/Jf2amjm1rgrZLhEmzyYpLeIasM57KaslVRDwiRRTWGb
         vxdeeuJbLr6WRBY44v6xeISeAF+491Mk5C470KfdAvffKLCcIhxiDJSHe62I9XYHyE
         UAeq3zd1mKnAtSDCnDBfyx157Pb1sAcLTMHHanTA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.119] ([217.61.144.119]) by web-mail.gmx.net
 (3c-app-gmx-bs08.server.lan [172.19.170.59]) (via HTTP); Tue, 4 Aug 2020
 11:53:28 +0200
MIME-Version: 1.0
Message-ID: <trinity-a7ac2cda-c860-47ac-8451-fd6d7338882f-1596534808733@3c-app-gmx-bs08>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Aw: Re: Re: Re: [PATCH v2 1/5] drm/mediatek: config component
 output by device node port
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 4 Aug 2020 11:53:28 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAAOTY_-H3L=uJNJRF1VedbwXNwY2N-q4F6A-NsdNwbQswG0D-Q@mail.gmail.com>
References: <20200728111800.77641-1-frank-w@public-files.de>
 <20200728111800.77641-2-frank-w@public-files.de>
 <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com>
 <trinity-2bdb3521-256a-4d4d-928a-be9b8c179d4c-1596355539029@3c-app-gmx-bs58>
 <CAAOTY__TsqrfRX-z+DE0+X_UzxBqChJ+VdyQG6z9N6Qr4bn2Kg@mail.gmail.com>
 <trinity-b0ca2ee2-259a-4a1e-86ee-63b093202060-1596451368067@3c-app-gmx-bap36>
 <CAAOTY_-H3L=uJNJRF1VedbwXNwY2N-q4F6A-NsdNwbQswG0D-Q@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:QwdKZO4FiZV3+KlU6ywm3BaZAsIcXy9QykjG6eYTalqdFz5Z5rxuwafBGe4o0IIGaE/T3
 IM18u3freut5DoyOqZTzGUJNsmyDgRhxC3X8mikKs4z7ufPjdoazrFfJp12P3/XW4D6QtZt9Fw4S
 n9IE8ebt6D9QQN0ZDGeEs9dm16iwIlNJiu5t2KeTT7U+OPz9gEAfunzYykwy0pZvI0MFblVNRdau
 hnU1lNQGcu5o+FktIAric9ivM1nW1PzRBuSe3xi+LxVzugqmzLTtvoj6x3o4FuEW4JasicgSKdTC
 Cg=
X-UI-Out-Filterresults: notjunk:1;V03:K0:rWygIIyHI8U=:AxITTtEsoYSHYzxi+pjfU8
 i903jHk42Kj+2UNdssMksfvOS3GesgVS1TuGMea7nI5zBr+fJVFp0u673bOZ5thB6HKpN94V7
 8y/vF6dX5eLvySVgxrLjWXgDpkOH3WeSJftGOl2t7Lp38ES02oeewYo/917zshnRicaLCbr17
 lPdnmIKlGSsScCwOO+uHBDVX/4mZTdsPzXsXV9Vqqb8cmswuv5UxXn/4Q05ppVoSe7igzI4zv
 N318JXLZ64n1hTltJK+GOz14vsaT03+8N6yZVB+fBTMsThJ0E+KXm0c5Tz6hOvGwfOgj61XiB
 imO8E/VaTguDMcxD8B+vr56m4mGgcbi+7ZOAAzNOCk95kObJl9yFEX7X7xV/4ncv59Nn6ng6G
 JbqSh6YVmAN6R2XQfC0AKasKKTaQENzM0qkuA75VgD4mCI3LkhZpBzGLnFtUXdTyzl1MkiPGi
 GIptdxz8z5AMw/rSjnxqKR+Om3WqY7kh319+BlmxzJ5waolYLGGU1sdEy895hdOM3+McAdBuj
 I0wYUH4jXRVfGBt7bcfdLoC3lFszW6K3BmgRSZXj5U+pcJNFzTwdsn9x/Ce9WvrSzoUHQBC5v
 cCwXFbulGuGucUrlxqjCdHwnjs1f1h0xXzXnHqHsnwXlkJ2NXv29ROHuburR2NLDZWHP+sCqC
 yxu95kGFG61zY17YD4OTQ5YO/R/VtDsIn2WeyoMj76yW3Rqk4icM0feTjUpQNUXAZO5Y=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've printed the mtk_comp_id after the modification-loops...

[    5.480848] main:
[    5.480851] DDP_COMPONENT_OVL0
[    5.482776] DDP_COMPONENT_RDMA0
[    5.485827] DDP_COMPONENT_COLOR0
[    5.488978] DDP_COMPONENT_BLS
[    5.492206] DDP_COMPONENT_DPI0
[    5.495170] ext:
[    5.498233] DDP_COMPONENT_RDMA1
[    5.500068] DDP_COMPONENT_DPI0

so only the main-path was replaced with DPI at the end. so currently the D=
SI is not connected (or i move it to ext). have now added new structs for =
mt7623 with swapped DPI0/DSI0 and commented out the code from Patch 1...co=
mpatible was already mt7623 with 2701 as fallback, so no dts-change needed=
...

now i need to look which changes in dts can be dropped...at least the bls=
=3D>dpi, right?

regards Frank

> Gesendet: Montag, 03. August 2020 um 18:27 Uhr
> Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>

> Yes, this is what I mean, but I think it need not output to pmw.
> But now I have a solution that you need not to modify binding document.
> Because now mt7623 has a different routing than mt2701, and this
> patch's approach is to use different port setting in each device tree.
> My solution is that these two SoC has different compatible string:
> "mediatek,mt7623-mmsys" and "mediatek,mt2701-mmsys". For now,
> "mediatek,mt2701-mmsys" has its data as
>
> static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =3D {
> .main_path =3D mt2701_mtk_ddp_main,
> .main_len =3D ARRAY_SIZE(mt2701_mtk_ddp_main),
> .ext_path =3D mt2701_mtk_ddp_ext,
> .ext_len =3D ARRAY_SIZE(mt2701_mtk_ddp_ext),
> .shadow_register =3D true,
> };
>
> I think you could create a data for "mediatek,mt7623-mmsys" which has
> a different routing.

