Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C50C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD8520714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="VOpH3xGV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oQ9vuA9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgFOInA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:43:00 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52447 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729151AbgFOIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7E7F158014E;
        Mon, 15 Jun 2020 04:41:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=kZTi+Ua3AZclE
        VFFt8dvZ6VcmnI6J89SBajyMLNn8es=; b=VOpH3xGVoZk3cZvK1vGk+nGWAPwId
        6uKbvHVMKawbh0hQuLMuVUCe7RClJfzhZ9OCPAgXgdQHkhB6+v7r4+rYZM35Bbl9
        HehUKfGUjcngWYd5CiwHEVqYlahgME3IeEUDXrTbEiOycRvIuMRUdPE3TbbY5P61
        vQd4RJzvYa+cbMOzpjc8kNgpOdmK9Y2p0rRfcPDewQ6o3ArNhC++TiOMzyjMoBLP
        20nZtjsa7NTKFNY17BjU+MLJNjw3wZGRARrZPA28NA5eSNrMXKjm4qEbnz3HctzS
        YtL/eFf/gTXJ4VcmmR5HN2JqEeuNFhkQo1ggUGCJgtxsgzk943z7IU7YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=kZTi+Ua3AZclEVFFt8dvZ6VcmnI6J89SBajyMLNn8es=; b=oQ9vuA9d
        Q8fwGOO36h2EzhCNNjN3ppRHP2XNv7WnJep8dAWqI8NoTNVhCKz+qIrHiOlf9FYf
        SxlsKs4ccXK0ZQvGTRYHp+MeZWppvo+K8pFmnz9ra+gnRd5GhRCwEiZZOKDLBBbX
        HXaiHshNklpLd3bb/NS2szoRK3mdawRPtD4pX/zZKC148E4fGmxpMELydv+AwScm
        R2t7I0hBC7HkAdzU04QWubgSJUrHCH0QpzXCSNBrptYsHHw2gDXxvZQvTen5eoom
        +bA5BpkE7avgUqEXqQr+F8xcg6ZOLFHbXZ++A7ksVlYMQr3rNw65ja4zJ/Qry5az
        BnLbeLzfiNKiAQ==
X-ME-Sender: <xms:ODTnXpcOFi138EXK2UV1t-4nuMpAAVbuYeWYNgoTvq0yyCfuXt5Cpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ODTnXnP8qbDQMf3H3d_HmTBnv4If7h_gzng_WsXKZ6bedCGGZjEk1w>
    <xmx:ODTnXignlFyNTHGS9kWPMMvSn22B97Ge2vWLS6mrlvPHe9uy54eYpA>
    <xmx:ODTnXi8IBpQuxbpecdLbkaytYEV79OcTixPzLnz41cuhFoY601CQuQ>
    <xmx:ODTnXrKS-ROc1o2DkIlVKfEz_n1u_rmx1i0o7DqTPlYFC7KAFw8ONg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1944230614FA;
        Mon, 15 Jun 2020 04:41:28 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 05/27] clk: bcm: rpi: Statically init clk_init_data
Date:   Mon, 15 Jun 2020 10:40:45 +0200
Message-Id: <0342572daa561dc1bb4c9fd10641b2016493e32b.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of declaring the clk_init_data and then calling memset on it, just
initialise properly.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 8610355bda47..ddc72207212e 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -175,11 +175,10 @@ static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
 
 static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 {
+	struct clk_init_data init = {};
 	u32 min_rate = 0, max_rate = 0;
-	struct clk_init_data init;
 	int ret;
 
-	memset(&init, 0, sizeof(init));
 
 	/* All of the PLLs derive from the external oscillator. */
 	init.parent_names = (const char *[]){ "osc" };
-- 
git-series 0.9.1
