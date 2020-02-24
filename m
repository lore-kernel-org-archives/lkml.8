Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54360C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287EA20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Mb1nR0GJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKfTp/VE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgBXJLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:11:00 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:45901 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728347AbgBXJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:50 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 62E4B64A;
        Mon, 24 Feb 2020 04:10:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=h4W+HJeoNQVE7
        dwloRlWrUOnWKSD6AD1egWsD16amdc=; b=Mb1nR0GJJx5XBcPcOrJH1ZXkR1ivz
        2Qcshr0uSzuO/b8vxmw5IvmGUXWXDY42U+7aaeGxXMlxCICL3pR/HyZ6h2l5kQjd
        MKSg/FcfiOFg1/0EUcNWQM9AX07yrkSUefGSLukGKr4TDrgqR3qZX23sUKC3wtIw
        zRZsgYer7cIUEF7ZLlgpRGPVCwUnSE5pj1aEK3R7s9TcjHRfXu+zVqzA8RMaGSXp
        f8yZNsn5xhbbYHiQ21/BQSvBd5rOASZ5MrSxIKDOKj5/8Pg7+1lfCxGcw97Y6Ry/
        o2/nhfEpw+dW7xK2CX7sCKT/ieofkkeIz7IYrygkW2vdGPIG7S6P3SNzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=h4W+HJeoNQVE7dwloRlWrUOnWKSD6AD1egWsD16amdc=; b=iKfTp/VE
        z40H5LZDs1hPjFpZupQJFeOEsbWvQHhneYdMM7wQOi+YU/YXNvplQee8eHtNqcTY
        xhq6nPqxLWA3Dvh5V+ASXdL05wP3WCpSEKxpSRBqIiW9AKzAzXkvGXpIq0ddzjlY
        suk1GhxaY7W0I6LUWDm1iivrLqcL295xPCpX/jtWm/0QUC6YdmHGZTowPu6LdZ8v
        pOUXEcWC2JBl6frgRqW3+JDkZWBrP+almtmOujftjA6G81VEZHgSI7vbSSQ9my0K
        XW1oDhRaw3z67QUDnJfWvvM45nWDDrCg70HOKY4xHPHGJ1LNCOTGK7HRL4XAGIbC
        XrueAGU7omGqkw==
X-ME-Sender: <xms:GJNTXtCVhjBMpdMJJiYF46HVhUHHlC11od4tQzvl8419eXq7zUfGiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudeknecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GJNTXlfv3bBGP4BKUwYTe2QZZBF8A9WhJzzB8FHREHolsnjS-r4GSQ>
    <xmx:GJNTXqcbmuFH3eZg_HuZruyHT_32XjNIkb3fPipx6LIgJ1bb73RLlQ>
    <xmx:GJNTXjNPcamyWht0tI27Pjn_h7sgWB8WrfzMnonQ3-PmLPkZ-XGxVg>
    <xmx:GZNTXhLC2U30YLZokQlyFnblN7Wm5MqzQw-LlBDMpgrqLpk4cocIG2QLy0s>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A69153060F09;
        Mon, 24 Feb 2020 04:10:48 -0500 (EST)
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
Subject: [PATCH 83/89] drm/vc4: hdmi: Add CEC support flag
Date:   Mon, 24 Feb 2020 10:07:25 +0100
Message-Id: <6d70995c9effa5253964724350a007525fca975f.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to the audio support, CEC support is not there yet for the
BCM2711, so let's skip entirely the CEC initialization through a variant
flag.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++++
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f7fd1914aec7..1762484bd97a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1168,6 +1168,9 @@ static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
 {
 	int ret;
 
+	if (!vc4_hdmi->variant->cec_available)
+		return 0;
+
 	vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
 					      vc4, "vc4",
 					      CEC_CAP_DEFAULTS |
@@ -1459,6 +1462,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 
 struct vc4_hdmi_variant bcm2835_variant = {
 	.audio_available	= true,
+	.cec_available		= true,
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index f41116507156..cbb1d3ab85d7 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -35,6 +35,9 @@ struct vc4_hdmi_variant {
 	/* Set to true when the audio support is available */
 	bool audio_available;
 
+	/* Set to true when the CEC support is available */
+	bool cec_available;
+
 	/* List of the registers available on that variant */
 	const struct vc4_hdmi_register *registers;
 
-- 
git-series 0.9.1
