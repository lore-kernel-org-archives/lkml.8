Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB9DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 04:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADDA2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 04:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kEyT/uZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgHBEoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 00:44:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:44887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgHBEoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 00:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596343373;
        bh=d6pa9qyO4ebYl6Gjzcm6qUkA1sR4+0nvmuHulLIEwSk=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:To:CC:From;
        b=kEyT/uZsdtMz5bYuwiwsWt5jUL5Vu3BvuPsfxAdi7v8bkZx4wFM2hvekOuGs+24ud
         qikDTuSBQXqHPeu3u5+DubpHQzhlCgzQIIOnB/Qo37h+Gv7k2Vv/wgwwgJ1PJB6q+o
         EjE6BT84iETJB5UE2va01b4uQqmm6QsHR4P7TmuQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.158.217]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1kDtne0Bst-00WqYd; Sun, 02
 Aug 2020 06:42:53 +0200
Date:   Sun, 02 Aug 2020 06:42:42 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAOTY__7wCeTm0OY0P1VKZp-r7+d7yj=LLb79Nzr1pVVkOjy2g@mail.gmail.com>
References: <20200728111800.77641-1-frank-w@public-files.de> <20200728111800.77641-3-frank-w@public-files.de> <CAAOTY__7wCeTm0OY0P1VKZp-r7+d7yj=LLb79Nzr1pVVkOjy2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/5] drm/mediatek: fix boot up for 720 and 480 but 1080
To:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <6F0FD8AA-A582-45FC-BE1A-06B3812B3DEF@public-files.de>
X-Provags-ID: V03:K1:KhyXaG0jr6aA9V5C1Ggsw1obPQoBRxRiw27abReqz2kmvby8piV
 XZKCGh/or/j/Foag7XjwnyyRKO19ZF9b107LB+efhVUVgTYdeJ1DxNySte2gVFUCZr7Amrq
 YGGUW1znGZm1ePEPxg5IckIDLjW5cTEyUw8lHSr7L23rkjrs1w/rU3971Pbve/bcMnqtDsl
 nSuvNyI6mQuC8pmvm51/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YquysWn8bzM=:PZuL/LvxoKH/OE2y2Cb/64
 lvdf5Al3BTDnRcIm+xQ9YewMh6svw5u9B5km6GNwpNhkaBq/JVgkLv+NDo+ZGBbPpP9GmQ3xu
 cHQ/kP/Ms2Bg276HKrZ9XBvmt5RpXkbOR3+lu8nIi6a2rUDykCBJZiV3jETrVXXvgYl9PgXKp
 j2yAvCHFO3aVZWkXYI/aWFptPU4nxdUXWnXK5TrG37hMPbJXRml7l6jvRB+VbbsPMmSEWtDLr
 T6giqtPaHxfDpnlqe52YqKvbR0wGdJYmaBQ3DRrmLzeUTJEHY3bKUtkw0Ar/5jsvq210laOlx
 S5QDUaAlB5DTUPtIsvcNJCJBbKnMEMImzikWlEnJoUPCzICIN722NKTAbHvngSflGJ1GUJJDb
 asIjYa4oTk+vAP4vHKpeRpeb0v5MEe22dyj1aiwC3CcSFOo9bMYFj3soSq7lGIWMoBgsl5FYD
 OuNsHe+24d9vKtbhbIEM+MRiFawbRpx9+86fPAmt3pV/bku+HAOuitlMVm+0hZc9+hrl9Gs6v
 1MWy8OIob/ZeUqzeGJM53vE5JeTP4BneUCd7h4peaCuLQGruOFQxo0fv2ViUpUOUX3jpBhI7R
 hutO2fP+dkxKywCenVTXsIZgguphGPyHFbEwcXU8Wre1i5wN8uSTldma+QcxPjGlmCwaKMxml
 e6chRU0doUeSYxFrKMQOa5OxAmr3Qw6ZNjDcjGTYv51OEL19Kupn0Fkb3ZSOtfsYxH1D8/qFG
 GB1DnHSx4J2kL/o3SnAEKlRvFbUNVlXTycn0GLGB/9LDH7+rrWWNfbGyJYe6OLOOaCvC8C8Y2
 G+GelO8f/LfrLISPDaOGGPXBlIzVK4GCrJFO6G4nVuq+eDOKTrouTLHxvOTiCb6joqu4p1pVu
 cRKAQQz4sNKnjtMEM5dshpnzm3mvdEAeUh3IKqTeXGIouNQjZkfZcXrY2JJCKdD6t1nyT1xUh
 fRhPE36BgwN0bRHCr9ye9nvQNJDxursjh+x6lF9x7kKCZMKMtEA2FLChgTgQX+Nok60tCe6sg
 LcT0iSeMI1Wqfrh6Pcmd8/3gOLt5SijkBWzFWcC0o7mYobpxsw8lPqMzYyAwV7bJn6DVhYyw9
 /r1+kIwkNQYEZVzM64/f6zX0laq+Puf42/LFIUfti+XnUQuhImebf3XFssrbMOfREbchDBXON
 yXxOLtRzdduYleH9i44Pbp2o6ivEli1Gv9VcYACYhVdr3aym4veOnpkVAcgW4sQ9PrezO6nHI
 XpVysDCujSm7+9694QodyY6BAvc/K73Z9Gxb2iQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2=2E August 2020 02:08:44 MESZ schrieb Chun-Kuang Hu <chunkuang=2Ehu@ke=
rnel=2Eorg>:
>Hi, Frank:
>> - disable tmds on phy on mt2701
>> - support other resolutions like 1280x1024
>
>If this patch does two things, it should be broken into two patches=2E
As far as i see,it only disable tmds and so fix specific resolutions like =
the the one below=2Esome other (like 1080p) does not have this Problem=2E

> I think every pll is default off, so you should turn on pll rather
> than disable tmds

Is disabling tmds wrong here? Which pll is needed here? What does tmds? I =
got only the Patches for testing=2E=2E=2E=2E

>> without this Patch i see flickering on my TFT (1280x1024),
>> so i guess clock is wrong=2E

regards Frank
