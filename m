Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71003C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C803206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="D8wok7Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgG1LTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:19:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:47797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgG1LTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595935103;
        bh=+AN/A7LaJ8QE7aEa8re6PrqGoq/kSyCmQ9u1D7Iy5LI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D8wok7VxB0mIvkh48xKtrEvGEbuIEDbNRu2dKCl4Hgek+N85Rue7sHVaXCxm4mVTl
         MN8dP5oBINRQZLdZpNVChq0a48UnOuDhey02LN/mVAaHVKG61QLc3PfaylK5xsekef
         DhZJeAxZaq/GxOXTGfB/jWknlu+A4ro/v2EOUftw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([80.208.215.239]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MgNh1-1kiFof40mV-00hsD8; Tue, 28 Jul 2020 13:18:23 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chunhui dai <chunhui.dai@mediatek.com>
Subject: [PATCH v2 2/5] drm/mediatek: fix boot up for 720 and 480 but 1080
Date:   Tue, 28 Jul 2020 13:17:57 +0200
Message-Id: <20200728111800.77641-3-frank-w@public-files.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728111800.77641-1-frank-w@public-files.de>
References: <20200728111800.77641-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ak6ylIwTkGEi+mVAT3DUFYeBflxF5UYrm21Ep/FvtMOgSVvosry
 re5T5r+z1mGqxMwD61JmDn8kXvfaEsk8E5o6GNX/A4yzkKQh5AmNhTlp8O1kK8euvhrXFWp
 NhVShiqVk49RchrRqkTBVvSn/O/dsTnEra+yI4Ykv0nQELNnk7mjirt/GkINhIpGwhrgcNx
 8Jnt6M95h7lBxQSpTgtWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dqUcR0KBXak=:aRyR9GOnlN77WX8Zjvk0JI
 YepXy56eg10gErublaOanE/Bmqqf2Baw8del2gqrNPIwfPQ7n+DOiqTR6n6G8yVLuk9IQU5j8
 i76C1QN0Cukxg3eowP4JKteczmd/mfBaqFkGzbegQSZ1AvW/p7+wSx4iQSANEFBwoxEL+6HQU
 kSAhV52L9qNFPJQnreTu0t+PQo14ZzBgt/zzb3hBY4juiWVycCBp2233Zt5rhxcGIaJQ5mehn
 9GSgv0KeuDWcnZsBWA4x2g4ZOHJVwoppHI11t+qJ0eKkig4wszqDwysr2NaWdljTx339t8LdP
 o2Bbn3eVIJjs4+YVhrTA75XN2ROOPkFRA29cqtSuGBDI4H+QLZHs409UT8nxiDQZaCvI7SyVb
 lt2d/t+XI/fiS4y9loLGGStZU5AnDC+AaEpEESRgIvw6XguLeaOIBgN1qimpZnD8K4+MXnIFV
 tMduf1Q+1ex3VJP05EqAPy0LMY7YX7gRQVGc1wliRDmLLDIPimvlC99teletDY16eJLaFUwG7
 vPmLu7A7mge5kIYBRg3JJb8BFUsKn6dR4Ntf3ytoSYTgJxeg208A6M0bhaVejvTxnk47KMaRh
 HXCf9cRzmw5dFFxk9FYqecrtVWtPHQUUGp/4GH+x4pFdLdkP7QL7R9QoBXLOKnmvvbqeWjhOz
 NM0ZOeLO31h9KE7kwvfs9Oh0PqgehAKps8M7VX3kvRXMxrspyjfqO1pqAksFUiJ6jWk/SShb3
 zw5UPivbUVJ+7V8nXKzRIqJvST8+3Yu4fbaH6I4MGxxoab+SaBY+JzpSxEtMufZA6082YqWN0
 h+lV0rkLojAfHXiCwyEjKxbtvaFuyssixVB+KlIATdhyKSzTiZRMx2hTftW8KYuDU5tQLGFLm
 B/c6wBVT9jP8HUp28skc/8dwf5PoR3y2gFrBh2uSWMna9zNNtpsvMuefi5ZFLFWz2KSCQnjWW
 VGYldNp72+0lLzPx9NJvPMXtSnnx8X8/Kf1jUNOloNw2l1qmD5pnWXLrjkzpZysztBwtyzXsl
 jgAviTDjbGIqbmoC9BfvDQ2igXRdqNbSHAHHAkpx/yH9xZZvgY5RCnNIglWSHVMJaR0Kqbg+i
 SFVn7WIjCSSvW9A7RAW4FZkwEUHEZ/SQJdxZWDGeFaL6dESAL0ggoqMSPbVuSiJFgZqGNT0R7
 kr2Wm9ISh4cnpbqlC8vTyR8x/PV6ZU6OW7OCvie6VtD+kapKXwQbxAgmYcK5mZAuaNUDYpStT
 IiWzYNz6Ir8g5gfRfsq+oEVovZmuInfiANpQfiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

- disable tmds on phy on mt2701
- support other resolutions like 1280x1024

without this Patch i see flickering on my TFT (1280x1024),
so i guess clock is wrong.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 3 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        | 1 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi_phy.c
index 5223498502c4..edadb7a700f1 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -184,6 +184,9 @@ static int mtk_hdmi_phy_probe(struct platform_device *=
pdev)
 		return PTR_ERR(phy_provider);
 	}

+	if (hdmi_phy->conf->pll_default_off)
+		hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
+
 	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
 				   hdmi_phy->pll);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/med=
iatek/mtk_hdmi_phy.h
index 2d8b3182470d..f472fdeb63dc 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -22,6 +22,7 @@ struct mtk_hdmi_phy;
 struct mtk_hdmi_phy_conf {
 	bool tz_disabled;
 	unsigned long flags;
+	bool pll_default_off;
 	const struct clk_ops *hdmi_phy_clk_ops;
 	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
 	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/=
drm/mediatek/mtk_mt2701_hdmi_phy.c
index d3cc4022e988..6fbedacfc1e8 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -239,6 +239,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_=
phy *hdmi_phy)
 struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf =3D {
 	.tz_disabled =3D true,
 	.flags =3D CLK_SET_RATE_GATE,
+	.pll_default_off =3D true,
 	.hdmi_phy_clk_ops =3D &mtk_hdmi_phy_pll_ops,
 	.hdmi_phy_enable_tmds =3D mtk_hdmi_phy_enable_tmds,
 	.hdmi_phy_disable_tmds =3D mtk_hdmi_phy_disable_tmds,
=2D-
2.25.1

