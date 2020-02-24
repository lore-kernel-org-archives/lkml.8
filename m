Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACBAC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AEB2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="TW+wXJz5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TmazJPbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBXJNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:13:06 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:36885 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728003AbgBXJJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:57 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 1D289628;
        Mon, 24 Feb 2020 04:09:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=HrcO6q4Cs/fdy
        zr6HzRlMJbR7u8he4OI01tO0VTXeAY=; b=TW+wXJz5Fmko4RC7evt3+ZqbzvdhW
        kgTnQGDcqdPm8XLNrLhRno0/NoTygahw6RNbcAgPqK7m/PZDwyxSJqnzP7r2SVFS
        V4EheerRnwkNrL9sCZOB2/98J8lqu9qcIaiHuGYmrUlHUsR2eUuJ3GZOBBbU6cOE
        c/5kwIfa4uKU14CL6a3ZQNc7zgnnVvfRctkcpkIyYsdJj/7eA8ENLI3WNk2y8uhG
        G1STe9Uxf8qk5xzgwpzfhR/6tgoSbiVyFyVm3mYYZz5upAIgaNK5ZPzI1ftxVUwt
        VC9L7UPayPKh6/q8xHM3BB8XRiEV9C05HIZZNnoctheCMqNzdjYBObvRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=HrcO6q4Cs/fdyzr6HzRlMJbR7u8he4OI01tO0VTXeAY=; b=TmazJPbN
        0Z6lmlo/FWAM6/7iLe0xjohhcdo1SW17P0gThxzbCt1SPuE+c2WYNIy7bGwp2Mfx
        f4+qzhn9WVyDne3Xd2KIJEsULRSmHs9NkDznrfQNqS9DwYADFJ5bSe/OkqYq55NK
        M5inXuQzJZnjW00v83HIx4lrzaqDy95Qe5WcbyEs0AK59VwhIuL44bL+KT25eRsc
        DSBMJ2LleRqmMgtL128T9UX9TkU8RoLfaY2bfN+4wB2MkEH+Ubf5IsX8SUfz3VNd
        xKy1966RNoI7vdsyMAOHXCBWEAi7Mdyg+PBlquH9RurdS0jTXO9IYSMMEQrTCs2+
        z7o+qDncElxREw==
X-ME-Sender: <xms:45JTXqfhlq7Hr7khdUbHL95OND7PElQ4UOfZ8XRtP8-U9gxrkqmfjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepfeelnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:45JTXudW31iRM17FBtGQaKKwclFiN09MVDb6N26ckd8glxanwhHNLA>
    <xmx:45JTXqc2ZOuACeItKn5binEtBt79XEUcO2i5Gg4r0vVWdRqMlkCyLQ>
    <xmx:45JTXvlt-JS5mXfwzpwl-zeYysYx8y1egN-jzr8Ys5GM4ozuXnqzQA>
    <xmx:45JTXpYCY6gSzKNCoRqUe-5GOaDiu1bkD1ITjsNZ7u196uJSqdEhFvRMnfs>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5ED99328005D;
        Mon, 24 Feb 2020 04:09:55 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 46/89] drm/vc4: crtc: Use a shared interrupt
Date:   Mon, 24 Feb 2020 10:06:48 +0100
Message-Id: <386f44abd9b0f5ee6ee1d76b23025a27450a093d.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pixelvalves in vc5 use the same interrupt line so let's register our
interrupt handler as a shared one.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 236a14190ebd..4a2ea897eb48 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1176,7 +1176,9 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	CRTC_WRITE(PV_INTEN, 0);
 	CRTC_WRITE(PV_INTSTAT, PV_INT_VFP_START);
 	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
-			       vc4_crtc_irq_handler, 0, "vc4 crtc", vc4_crtc);
+			       vc4_crtc_irq_handler,
+			       IRQF_SHARED,
+			       "vc4 crtc", vc4_crtc);
 	if (ret)
 		goto err_destroy_planes;
 
-- 
git-series 0.9.1
