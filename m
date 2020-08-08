Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D924C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D97B2053B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ac8Ay/g4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHHM1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:27:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:40657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgHHM1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596889651;
        bh=YRbpvjuQuUd9oUTYdd74s47n04KsNZ+0RJ4NNZHvrW4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ac8Ay/g4NhVcWKf1ivzizjaXPHEYlLspSJrl3IX9eX3w0NEmgiLY7P9w0FkMFQ1kV
         z8pv1RdMycE7ypOg2SN5mZEdMLcJR7HohsAG3jeFyoFYc18DFn0eQ6sZC8JfIxCvbN
         nV9nnEChY6Ew/C9O/iasVKgJwmP8mdg4jKvCQ5LQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.39] ([217.61.152.39]) by web-mail.gmx.net
 (3c-app-gmx-bap69.server.lan [172.19.172.69]) (via HTTP); Sat, 8 Aug 2020
 14:27:31 +0200
MIME-Version: 1.0
Message-ID: <trinity-f5a5deb1-c123-44d7-b7ca-1f7a8dbe1c1c-1596889651064@3c-app-gmx-bap69>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        chunkuang Hu <chunkuang.hu@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Aw: [PATCH 1/2] arm: dts: mt7623: move more display-related nodes
 to mt7623n.dtsi
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 8 Aug 2020 14:27:31 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20200807082754.6790-2-linux@fw-web.de>
References: <20200807082754.6790-1-linux@fw-web.de>
 <20200807082754.6790-2-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ti0yCfi31/teh3YG5W8qHJKm0SNcwMUtl+Gh3qRvfzdI39vY36mhVNFwgmQlANRwWuXRO
 Z6odYE+tNXJDzG2hhPWYLSJ+LehW097tyrdY4ZWCvmtw8QM1KOlsE3tWRUy+HszSnAJqLjymHU02
 70wAG2aV5CCLsxL8NCvVtNO0I6sHMK1kargEMcNlAOiz4XKtns3T+ioAUTclxBHnpHw/E/TUB+0k
 uQb3Y1YlrpjhAwgYqCwuhQBImUKCyIjjZ+jglLM8Y2BjVAcb76w78MOuy9YNpMkqLSrP8J8NXR4L
 wA=
X-UI-Out-Filterresults: notjunk:1;V03:K0:96prrdCvRSw=:4cFUpjcBGoMlIJ4q5azFOV
 ZPu1Xu6AyqM0dVANroC5UivKoN6sCAV/hXO+hDGjcQuxftR4HvWuBvFXXQBbyJFUFc+g2VCtA
 gYvg79gJ1dQ8BTVUFmEBLp1DzhuOL/0/Q7lbFxcWPxe1XaQf+c5bnEn3xdEyF2nYuoTtY9mra
 RqnFsop3Xp6gjJAEA/jSigphoWVJdDtEFudZ9zT+rVYVlrLG8k1SIvgxv4soTKB4/X839pRrp
 QaNKOAG+ikWmavzmSUUSft9gQyzBwFd5B90FZlqqMrysbLoa2luT7YMykhm7NZs8GAC5vNJbG
 KQ+LsGq4zUqlrGOY/qzRPzCZrktH3Ecm7Yr0nr76md40e2Oyjxe0tEGc363p5CaGovKmvLyka
 hBcAFFV3Mys1CN5HaNCuSlzEPFDWujiJZhJqlHBhZeiJisWr4xrMCAqgIwo4GW3phsuNQy2qm
 AWQE2l+L0D90boCesDOnvmElbFEYqrzIXk5pEB95eJr/Pv6wJJRHnf+iwcWT5vDGfsjeTz4Hj
 7LNcRJvy6qZlnuJRmUbyPEIv8lhfNHfhIetqUYb+iWUouyUzjhJwWmvETV/aEkUEQmsyt/MVO
 Zy2jK+Qr85BSwS9TyETEH+PP6LhgSlgdKpVDDJ4e20WyhgExqgLUOTLj2bpRZ6nOBZFL0rRQV
 8sse9Bnt5HaDJ8M9C8wFqpIKSONiJk/RcW7V154wSFM3SjjL0rvETAn7TmQcPJ/SBies=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as i made a mistake in cover-letter, it is not assigned to the series.

to show its content, i send it here as comment (instead of resending the whole series):

based on series from David Woodhouse [1]
i moved more display-nodes out of mt7623.dtsi to new mt7623n.dtsi
and changed last part from my series [2] to add these nodes to this new dtsi

the depency of dtsi-dtsi-dts is already done for mt7623a, so i guess it's a good
way to use it for mt7623n too.

this first set is an RFC if all nodes are in right order and if it is wanted to move
them out as i have no technical document about mt7623a/n which describes which parts
are available on both or only on one of them

added MTK DRM Maintainer CK Hu, Ryder Lee and Sean Wang, maybe they can give me some advice
how to proceed further here

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=329209
[2] https://patchwork.kernel.org/patch/11700699/
