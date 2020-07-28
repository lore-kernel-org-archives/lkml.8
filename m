Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92886C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B812070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Y4T5TGaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgG1LSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:18:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:38251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgG1LSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595935105;
        bh=nn4BkbW0oeEmcmd3H6QHuJO7LEA/snDXKRVANzx14BY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y4T5TGaBuRt3b8kV1LyAkiduwg0Pe2qyX/uDh1A70EFNHcoeRo3AbL84Ed0E5L4Ci
         9fy+P7/8/XbZytNcRLfs+Qbbe4Ek/IWc2C/s8d2pS0lPw2nRyjbKLn4LWt/DJmpdnH
         AxxaiKJ+plcgGAPLFxsWaaQRXl+ctR610QqCPuXE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([80.208.215.239]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBDj4-1jvSko3s5u-00CiFj; Tue, 28 Jul 2020 13:18:25 +0200
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
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 4/5] drm/mediatek: dpi/dsi: change the getting possible_crtc way
Date:   Tue, 28 Jul 2020 13:17:59 +0200
Message-Id: <20200728111800.77641-5-frank-w@public-files.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728111800.77641-1-frank-w@public-files.de>
References: <20200728111800.77641-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rTF2GSs7JL/heYwGA7znoUaELcob0GxZ4gZI2tIFt+A0aSnsby8
 0XUoXibUcKWysOwTn/CZlW9rpuGJK1GojEZyc2C44706GSiy8/tpQFVhRWP45HlMen+R/4e
 1n7CdNSfTDuS/oJ9dYALJKe0JKchcLjuEAMsxGJNZA1wxc1ce6AFpbtSXwwPzaHP1HtCNqi
 1X/DLBRAf1lZTLoCXaovQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RV7oFfUX3MU=:M/4aNAEJjpZZJa0cjUuRDy
 L+eM2xGQG0RnqgxzoVd6drELeZaZId4oJe/xJyShs0HwkT2wheosTwwuILnf2RQBc0brb0ZAN
 3kgK0FgC2+33+gDvC7Sn1sdVkvxbaTnc2WsBgkTgbmpxUHcRcwk7pdZZkxImMFVL6PnNmfoHl
 S3r9AuBOJ+GDA1ZOXLXiAq7+BnBnUPM3YY6kjC/yqaZMlh6sDb9CFbMfCPB/1QP4Mus62JlAp
 nKHOFpKDIBtP+s5Zq+ZGgU3oXXli7enF7H84NmYnY48rO3qsGMx8eMfAH3L3rz3T5iRo9mVug
 lb8/+GNqLADqus314zDsvpnrWth/ekQCZnIMvIrnGGPwgwrDim3fAV+5heOQZSGUaAhR5sU5/
 JhqIKmwtXo7gfcwUOtfZ7p/DrnyhnNnqZNe5QihNZ4eiQ+2yEuMEDwEHiU60iPxGgsexMbZzb
 vxwQdKql69+vWsXTOviDAH4/doIRjTEW85lnK1r7RcOZn2pef9whEKUZeJKb1jZFCfxtCCx26
 CDEts7whrkI/HtKYEtOjJlJzR5/1IoBFeadIfLTHgT/cKNXTojUTFvyupHB9YkJmopSy8KPm5
 mh2e+6jtsM4QvtPJ+bmcZ+AbEv8dwoRSyrT+55cloJ2v/FJO9Q6M3Ct4x+wyKck5Ti/ucMs2t
 bPUx5ta0y1FrgNwyQwmVKdpBQ7GBlTQx2hgZw+f5+9TXJ8FYZf0Jbg0CiipPtro44NoO/x3E/
 AaTCTHXe9dtBtGy2lFrrzzdPmh9WXV0rvuE7etvFmC6u/8yC4ttnlbugQurapc1LRmEX+a9VC
 PxI/44Td8EioDsFiTAoiBti7oIjDjCqxD5qZWB4SitqNWqol4DAIcV3EHP5n51NGW+5DBu1fM
 J+CxAO64WqNWXgdIxPlYcC4M8G30BF5gT//HcCT60n2cxjBdkdRavGkTlM+FONv+JtcmTbbLJ
 n2eHWFSImvm8Y16waIlN5SKMtNy5qxFvHXmgyqPHcxdeOtBp5gio36/sEyj7DBcNESumMTJxV
 SCLCqDCpLP9svdXOuP7l/ZiKhmVDPQJ42wns7bMUOrLTMFvwGDSCqsynNn9EtFuPzlpCO2G8f
 zOkTKcy1my8y5mGqZ6Nu2aiu9tcWYwnM7i9puNmR4xD1sY0wJK6FnhSrcfPOr/3Hxae7A5UDj
 h0xsgMZfaQU2xntgM2jl8C16RynN94gnVY7H4+zufLpj2xmMMaZrYngQ8HBqDoMUiS3ISCaIJ
 M/N+H2nqLFdhZSlVZL1y1Hr//wNT03awmNwDpKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

[Detail]
dpi/dsi get the possible_crtc by
mtk_drm_find_possible_crtc_by_comp(*drm_dev, ddp_comp)

Test: build pass and boot to logo

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
=2D--
 drivers/gpu/drm/mediatek/mtk_dpi.c | 3 ++-
 drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek=
/mtk_dpi.c
index d4f0fb7ad312..e43977015843 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -608,7 +608,8 @@ static int mtk_dpi_bind(struct device *dev, struct dev=
ice *master, void *data)
 	drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_funcs);

 	/* Currently DPI0 is fixed to be driven by OVL1 */
-	dpi->encoder.possible_crtcs =3D BIT(1);
+	dpi->encoder.possible_crtcs =3D
+		mtk_drm_find_possible_crtc_by_comp(drm_dev, dpi->ddp_comp);

 	ret =3D drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL, 0);
 	if (ret) {
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek=
/mtk_dsi.c
index 270bf22c98fe..c31d9c12d4a9 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -892,7 +892,8 @@ static int mtk_dsi_create_conn_enc(struct drm_device *=
drm, struct mtk_dsi *dsi)
 	 * Currently display data paths are statically assigned to a crtc each.
 	 * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
 	 */
-	dsi->encoder.possible_crtcs =3D 1;
+	dsi->encoder.possible_crtcs =3D
+		mtk_drm_find_possible_crtc_by_comp(drm, dsi->ddp_comp);

 	/* If there's a bridge, attach to it and let it create the connector */
 	if (dsi->bridge) {
=2D-
2.25.1

