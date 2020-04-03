Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B32C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59E5207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SarIPIQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404255AbgDCRar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:30:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:35871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403981AbgDCRar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585935032;
        bh=gNFpDKKwiTezkt3owt2u3asT3zDsRHR/nSLRzKGjZlU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SarIPIQSqNqxpAt89OURT8FivW6drYCgEVFTsN9/9n9Xuz69uaFls4c0KT/eDp8KZ
         lU+8G/ik3PkJZb5CgwuOQij3cQpU8pwTaWsduldtc/t5PZW2lGaAHFobaYAyhu06Oi
         n9aczJ6O2xJVrSCRkWVwLuXbHtjhwliREHKwDWZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([82.19.195.159]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MhlKy-1ipk5o1hzc-00dp3s; Fri, 03 Apr 2020 19:30:32 +0200
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     alex.dewar@gmx.co.uk
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [PATCH] Coccinelle: zalloc_simple: Fix patch mode for dma_alloc_coherent()
Date:   Fri,  3 Apr 2020 18:30:10 +0100
Message-Id: <20200403173011.65511-1-alex.dewar@gmx.co.uk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jzuIV293In4jZGU3O+2pdnE+8RxxVxRqA655L/kzkJWgyppp7L3
 /4kLXfJn+ctPh6ZS8Bfwb7/FJEq4aWCM/JIZWI2VTUefC5tTGWTNCetLn2c223EYHsx8Ruv
 j4g8jPlKaLXxDGLoAsET2lDKieDDLvyUlTnLJ0PdtC5OAhBJspekcfQ/Isn/qXCui6hgUyB
 1N0S+6e0wWkzeH1W6fX4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P6FN45gUO5g=:3+cZirxTizNsPm56Jld8M8
 wtcIvejBdbdoPOJ0qcYuRoQA9c+xfailewR63A/FEr8eRT0iU+vE/MYE/XVNSPWjwOTMD7TG1
 ZxvlxxeRuIdfe0ZFpEZgfG5Jmv+n5FB2Zz+C2vXSDzETxttgOIqPQF6h82Vrhx0K4I1t7m5v3
 qv86AyFoeLBKjBKZaTNQtHGSY3XLZFbJuqKHTtEMXkmcDmW/fT+XwTwq+AeuoIGW0z6rgOTop
 MCNSftpZ4AceAhfLasTxlPDJle0Hpau5KaOYXPpvOW0NK6moTEeWvKVh4DJ3G7nt6IghgtYNB
 PYyuomgJE9FDHnBmjGFYRWYER7QVdwhphAq0AcsAWKbtkEc+yGUOa/Mc6MD7Vhc5hMh8C7lSj
 jQQBTvAIxGwGKQEqNAUpy+n3zZGcQrq2wWWLCSb3Up73P7sNFxpmmh1i5//GtIlkzFTYGQPJY
 Udh2C4FBT+MgfVnX2zCNmCv//Jyp9NKqVfbhWmrAg+sVOAwRuc0KNGb1G4L6ZG589q+MrOWQ3
 cPYRnwhnKmxHncMvOg/xz8omOlqFtBEGIcDVnCcausdi8BLCdOMiI+eSfYubHZYroUwqiKMQh
 snAVD7inMvVtP/jGr+y8vOmwXd9EisVAE6O27EN8iJ+wKgJR1UjdXvutVa9sHP4FECAr80DO1
 YjZWHIznBJJnjbUr1ClwDZoI3pz9EpAxe90OZbs9ypvOUSRk/SPUUdP9jUNWyikRRBOYR0I9z
 NVvYsFl0l4Rpn58xTmeoezAozwrKaU6rfl4cf2fHoI4OZKxZtdKuyJsvCQrOmNnQhCKl4oDNm
 BdHZFgdfbFpIovC6Cg8UCPfE6ASPrA9YZY/UPjrPGpEKvJUQPaTTQp7YtR7mfyy1xgEcnmZ8/
 uCaEDapbHeIvjm7hePJ22bgNHiWpKUcfcB1dXzcVhs9RoSIeDkxWE1CWIZYLYspMh3yIjL05x
 dgv6I/LE0Fz6gDOKb32rEa276h76Yt5bP/hXvsSkRpW8cWdfSSe0idQ6Cfo217dMO5Gn4Mgfn
 WXC+EVuGsqBFKt6yocA2CS7bWtD0hGJsR1kwX+7wf0JUzGA1e0tq+8C/xNGcWRrNGOkfhwGyU
 m5uQrKbfXi7iMHfsGpD6xNu3PxMF7OUav2+fzT0ur/DV0W22cdwHCmfpG/5pcYIIBTRiWP90c
 iW++oQPLJFNaI05O79WyUf+yUwn+zmdlwhEMR9DKYmUV2WiuR9+gGDylvd3QhIq8hpfd+EpNf
 aiWAEHD7hrCdh4snE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()"), in
removing dma_zalloc_coherent() treewide, inadvertently removed the patch
rule for dma_alloc_coherent(), leaving Coccinelle unable to auto-generate
patches for this case. Fix this.

Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
CC: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
=2D--
 scripts/coccinelle/api/alloc/zalloc-simple.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/co=
ccinelle/api/alloc/zalloc-simple.cocci
index 26cda3f48f01..c53aab7fe096 100644
=2D-- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -70,6 +70,15 @@ statement S;
 - x =3D (T)vmalloc(E1);
 + x =3D (T)vzalloc(E1);
 |
+- x =3D dma_alloc_coherent(E2,E1,E3,E4);
++ x =3D dma_alloc_coherent(E2,E1,E3,E4);
+|
+- x =3D (T *)dma_alloc_coherent(E2,E1,E3,E4);
++ x =3D dma_alloc_coherent(E2,E1,E3,E4);
+|
+- x =3D (T)dma_alloc_coherent(E2,E1,E3,E4);
++ x =3D (T)dma_alloc_coherent(E2,E1,E3,E4);
+|
 - x =3D kmalloc_node(E1,E2,E3);
 + x =3D kzalloc_node(E1,E2,E3);
 |
=2D-
2.26.0

