Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FB520791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VdK4aqwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgIDMCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:02:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:60721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDMBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599220869;
        bh=FT13C0ebJTxXE8wqcoPUKihv4j2mIvTpRNrXVWEUsZo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VdK4aqwnvEzkJZy0Odb4qneBQFsuRJgMyhgvrHREkpAVAwUuQWU31uIpa9+4Uk02+
         LHGeE4kB5sbNhkd3tr9vB091c7hsMfQGnUEmHTouAk5srp/asL0oQhsFImk9qKjFWU
         DuedyXBNYT2zGNYyi31OKv1IJnNDVAQbG03MKKdQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.147.193] ([217.61.147.193]) by web-mail.gmx.net
 (3c-app-gmx-bs07.server.lan [172.19.170.56]) (via HTTP); Fri, 4 Sep 2020
 14:01:09 +0200
MIME-Version: 1.0
Message-ID: <trinity-0d5c85ee-1f7f-44ee-9e5c-6349d4edb3d3-1599220869440@3c-app-gmx-bs07>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Alex Ryabchenko <d3adme4t@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunkuang.hu@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: [PATCH] arm: dts: mt7623: add lima related regulator
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 4 Sep 2020 14:01:09 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20200831143937.28259-1-linux@fw-web.de>
References: <20200831143937.28259-1-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Zdcm2VtIlFuzIg9+2N4g48+JIQEWJ90Ozh5sFswZjRYm38b1Nq1kEi9atHNr1ObC+tCy0
 TJfkljY75fRhxXVJ1KSRT/xfiSE90L69s8Klm5vrENXG5PNU27+Int6fZUXBQZBM96Pd9za6NHKz
 1WP3CqvfFZ96IGCXt0kcpTNWQbByYDrSWYYQleP05HinLLgChqPMbEMBJ83pElU1HCshWtym8oHK
 0FCuGdva1vxhNuHkYPtcHIBV4D2yX1loE2pnseKbeYKGTOHHUVQxEH7HgQ1laM4QH+EHIStOwPH7
 1A=
X-UI-Out-Filterresults: notjunk:1;V03:K0:q4A+iZp4si4=:Aj6oa9ix1kGaFT+HdJfD3f
 W6/eJcn7F8dSsaiJRG/FeYXvf23b8+5lYbBKzlsS6nDbbGIk0bfkNhSgFTC2kO+GOh9kB1cIf
 qUd/c2nLTyX9VAQ0sSjvbDdO4IfNEF3gD7cK+xVPzn3rN4zzSewX3bj8rKF8L6zyIFa5lemd6
 QwRWZZxzftMrB7duyjC7AX6Vla/UnfyH6yAAEXn8F8G6OgjHK1EivMUYuq48S+p6tCVj0VbAq
 T4Mef4D0KvZAQAFJ2GLNl1JvdIF75Go6ERLjnbSZrJTG3rlx3BhrWs4QBJzok3eMiQHVQ5wH5
 CBH3QAG03cnyZqz4IWS6Mpm+9f1ZU8dISj5dVmGwHOVaAE/cAyy3i9tuoTj/MDuMSQugzT1xJ
 d57cm8zVsKUwQxccE9AP2VhxGLovnGmDuePfY7qnjql9G344j+dQnqQeyl0eFKsf728SPE+Wn
 +0XUsj2knHpNczCN3waISDfEXWTJ+TJ5xDOylJp+BjZwBsW8SDvOqtyV6w6GvRsczRB6GBrGA
 bNioBZf61uUzdKUGOHySqiKosptEKGgTPtD2kr4ZjzL7bIy0EMlRgpzRcunVWnDUPtOraKPxW
 murolT6ixoHgFkUPWAGnut7+Z3NzIkKumNfYXJBSJwyigA7hqK6qlxXwB9aY1chiJlGXtztK2
 R/RDHG5MGwbO+7Oq4jJhGet1cHSD3yk6G4FlXUu2bMQV/qYYJu+w81B4+oKDijDZAJLE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this Patch is now Part of my hdmi-series v6

https://patchwork.kernel.org/project/linux-mediatek/list/?series=343565

so comments please to this series

regards Frank
