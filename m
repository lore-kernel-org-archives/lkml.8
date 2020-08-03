Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057F1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B64F22B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UTAFAQAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgHCSDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:03:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:46191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCSDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596477768;
        bh=BBa3NSjXaC3TQAHSDrvm2A0DeRZLmH0CWpxHTLdlYjs=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=UTAFAQAzApPZZ0flsN9S1yEnccWgfdgX7V9WZUnOsUBFIqOuXwq3VHF97JnHS2iUf
         kG+viCGPchkFkwExep2S5/u0UME9TcEfaeyT1JeSfrM1uBULYdrccAGh9PS7OOO5RT
         543q1lHNvfC35ZsMYpalHjQ4lz9/DkIeEjLRi02I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.148.26]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlXK-1kUsso2yBS-00juVp; Mon, 03
 Aug 2020 20:02:48 +0200
Date:   Mon, 03 Aug 2020 20:02:38 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAOTY_-H3L=uJNJRF1VedbwXNwY2N-q4F6A-NsdNwbQswG0D-Q@mail.gmail.com>
References: <20200728111800.77641-1-frank-w@public-files.de> <20200728111800.77641-2-frank-w@public-files.de> <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com> <trinity-2bdb3521-256a-4d4d-928a-be9b8c179d4c-1596355539029@3c-app-gmx-bs58> <CAAOTY__TsqrfRX-z+DE0+X_UzxBqChJ+VdyQG6z9N6Qr4bn2Kg@mail.gmail.com> <trinity-b0ca2ee2-259a-4a1e-86ee-63b093202060-1596451368067@3c-app-gmx-bap36> <CAAOTY_-H3L=uJNJRF1VedbwXNwY2N-q4F6A-NsdNwbQswG0D-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Re: Re: [PATCH v2 1/5] drm/mediatek: config component output by device node port
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>, ryder.lee@mediatek.com
CC:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <D0A969BC-1BB3-4EBB-8D03-DAA610E62EBE@public-files.de>
X-Provags-ID: V03:K1:WAQfzGVjSkS/16yz9r7IpNOuSlMl2BMKsoaMRRAoP3sVBH84qNq
 wD261Oq8/ov+9nxyiq1n/yjiI8bous5siv81EUe0lDdC9apZwvIfi//d2RQVhmg/5lFA683
 eKifWM6puhV8WX6izdjWHwl8PERQlm8PXD7uwIsSjbGuzFloLAdV9Z2Zd1l8AbB9pcv2dZN
 6qiuH0R+YQg36uqjHpCsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bv0vMe1HGgs=:Ot2Dri9B6JRi7gkA5+I8B+
 PkMBVJDfumgzFBC3CAldXejaKPq/gpCzWuT3RtgtVVFXdmR5m3flZOp6k5exj3VBkPa8JxIA9
 DrQrWK6khzrvwaWTrGJOEmFAfUhnickZo96K9r8xubioKh6F1+NQw+raMXePuDtkFHP0uy/au
 0PdQ5f+q2IUCXAOVfUwTeyCDuMSmIDSBIoezxbnZFHc1SiuJ3yuty8m8eA0OKGiO69fyfDlPW
 SBTzkzznB1IVSMoOizir+Nn7RFwKtIvGyGOXLD1v871lz9baNXqH3pLUY8cY/eOFPZslwoVCL
 QgIZ8CjC04iP2GPLpWDGmyzPbyGuqnwgdFJIh2TM1cxX10TlBYssqjlLMIUhn4bVOEfIRRAU3
 gd7TuYa4x4EyLnrWkl3Las+b1DjIlbwkYrH1mIn68uAQjblxXziZpAaR6YHryS8jo1FCGzRg2
 gyVkyclaURvX1y7AM0ZBDSLsetp7N3gfgfHm2nekEQuFDbi+PN6gK5m2604vYrPi7w0XivnDd
 3kYUfi17Zn7Xgq74Et16bhWi3o626NdEC2FfQNPc6v2ltiVsZXNpcuxeZCgpjqVlj0rvYiyDi
 n8c/VlUmFSipPoNIQMZA2rLkAjY9dXkS5UzW6KRHt5JZSSE0ahio5T+YkR+MJowQ0std6ESSR
 w6CowPHmidjF6E1/Ch0jooaRnn1424QJZ1MBy1/X6/k/yhteMzr8Uu/GBzUjnctHY7SLFTR+x
 mLzcvIg7Lidvw0UaPqz5yRWKeSlxA4ATOwigXDVgqx/ucoWQPriOTfHYML2qgENx+pVH+sRDr
 c06+FvRlOEZfC0Br91IBXyZ77BsJgBkA3nWlfAAQJlSkjRF0KEAJNdd1MP/KHVnjEapH8ppdp
 MXR0CjgycbAui4PWvs6m27hG/8KU31mHdOaqhMLS8xT6E24GL6iuRREeU+58q2OlMKGxrjDBs
 pLi8jD6lsNgP5/TQjeFeYtBE8Y5D4U2SL0YGPK6L9U3KAjwr7nSKlGAFXvmS/Kn3y4j/YJ+7p
 EDCpkFfnMeFSDksEWqRJIX6H1l0K647GOBnEwBf++o2RMRnTW2i8HfAqm/37Y0amCkm9xxIOO
 TyLihjFr4r4WBP/33uFJmuhTSn5Vsar624OOJYh4D3mCXEhx8+C07YScahCH8kQ4Dva9Omt7T
 31rYgmi+/nYkeJ5y2uOa8kVGdGV0Dg0T+tH1v/coBnzCk1tbua9LopdHd64z8Schp2vR8IrYa
 oZ9Y6BN43P46iOgYzXsiLhiIHGEF/sddtg029cw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 3=2E August 2020 18:27:02 MESZ schrieb Chun-Kuang Hu <chunkuang=2Ehu@ke=
rnel=2Eorg>:

>But now I have a solution that you need not to modify binding document=2E
>Because now mt7623 has a different routing than mt2701, and this
>patch's approach is to use different port setting in each device tree=2E
>My solution is that these two SoC has different compatible string:
>"mediatek,mt7623-mmsys" and "mediatek,mt2701-mmsys"=2E For now,
>"mediatek,mt2701-mmsys" has its data as
>
>static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =3D {
>=2Emain_path =3D mt2701_mtk_ddp_main,
>=2Emain_len =3D ARRAY_SIZE(mt2701_mtk_ddp_main),
>=2Eext_path =3D mt2701_mtk_ddp_ext,
>=2Eext_len =3D ARRAY_SIZE(mt2701_mtk_ddp_ext),
>=2Eshadow_register =3D true,
>};
>
>I think you could create a data for "mediatek,mt7623-mmsys" which has
>a different routing=2E

The paths are defined as this:

static enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] =3D {	DDP_COMPONENT_OVL0=
,	DDP_COMPONENT_RDMA0,	DDP_COMPONENT_COLOR0,	DDP_COMPONENT_BLS,	DDP_COMPONE=
NT_DSI0,};

static enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] =3D {	DDP_COMPONENT_RDMA1=
,	DDP_COMPONENT_DPI0,};

First thing i notice is that main=3Ddsi and ext=3Ddpi (hdmi)=2E I guess dp=
i should be main,right? And bls is actually routed to dpi=2E=2E=2Ehow about=
 the other components?

The 2 loops are not really clear to me (except 1st overwrites mt2701 main-=
path and second ext_path based on ports/endpoints) but this only applies fr=
om bls-dpi-hdmi-connector,not xdma/color or similar=2E
Or should be main-path (or external) only bls and dpi? It looks like it on=
ly swappes dpi and dsi in my case=2E

@Ryder Lee can you explain it?
regards Frank
