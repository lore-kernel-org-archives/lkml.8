Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD279C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89981206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gB91F0tW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKWLd+xO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgICIJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:09:29 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:46149 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbgICICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A67DFC88;
        Thu,  3 Sep 2020 04:02:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=VQCRUyPO71jHm
        4tPu/mGDPw0qADlrf66ZnceVVw2jzU=; b=gB91F0tWOMc4ilSm2BtQ5+PW7L0Z3
        xsJWFo6dYxOJj0FVSnHaUbnAmcjRNlWaJXIo1H5ya78bxx07lQ16//yj7dpk59R1
        wwvz9642H7wNf4fb0tTQ8z8stzd6Qn5VHQ73bjMhVlK05IQzlAxgkYXT5uE0ifOp
        wFAzTJ/ENczjN7+vx1eWs9cwJu9KEiUSki8zy+CyH1NW7SSeodkj6ejov/LlZV5e
        Mj5LXio1DT7DQzoSvfeox9J90h6joTDgGePcWGc7mwcTKLihPQlt+/990af+BEAG
        Ke5uXLbUXw3YbP0qsryN1zjQXyI6JdXqOyAlaglrZKFy8AnbwZRo+4/LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VQCRUyPO71jHm4tPu/mGDPw0qADlrf66ZnceVVw2jzU=; b=HKWLd+xO
        a78a9ujQVzVbEiyZObIBS+AhbJwk70hMmQfqnR0/ts613Cs30sXqq9hEMTTiGtkJ
        w/gusOpyeQm4cCha+W3d3yizYkOz0zAkpNfOiGVbbruWcwOkK/sLtbRtapvpPftp
        sqNEN/2GTejbeQcT+jrTiFIBJOm/IVZeMRhbbRoePDVuCd1/DBXtlh//knzA04FD
        UYNke/G0Rn5B+UwDBUkJX45gCq34IOC+cr3hnncg3V5Xu9U1LuiCvDpNMEA9qcKV
        Uvk4ycD/9AG4vxaF1UKsD/oIHZEb4igMpO7hg8frFn1zLHoMJgmwXbWgX9MQP81h
        B9Lfzl9GMFwHTQ==
X-ME-Sender: <xms:JqNQX_kdgDZyKvhTYPSx3BQKDXiwZh_R8El1KSxpf5U8UUrKr6sQ1A>
    <xme:JqNQXy2V_CbE5LhI_s_LM268mZTzTf_Yz-s1HSCUudZ2U95zTPLSR-06aKmOB3SG2
    m2zkwweQkC8Rhhaefs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefie
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JqNQX1pKbgoaQvTJLdUHJlFtqNvLOWVggZv3kZ0gDx_OS6asDBn5lw>
    <xmx:JqNQX3nwnWMNjzDpCAtB0d5XJSDbRZ6ZCVsQQhEv-8TR36VgOBO7XQ>
    <xmx:JqNQX93dGypZ7YDu16yRyqlVVG_5Vp-CG5tMvEvJum0rIuqjKHFIAg>
    <xmx:J6NQX-vkUUfpadEhWsB6b7PeoyZIg19B390aso_m9Th_lGEKwa5Gv15iTCY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 964C4328005E;
        Thu,  3 Sep 2020 04:02:46 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 38/80] drm/vc4: hdmi: Use debugfs private field
Date:   Thu,  3 Sep 2020 10:01:10 +0200
Message-Id: <24028dc06c379dbc71f98e027cce2839fdd446ce.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're calling vc4_debugfs_add_file with our struct vc4_hdmi pointer set
in the private field, but we don't use that field and go through the
main struct vc4_dev to get it.

Let's use the private field directly, that will save us some trouble
later on.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index ec34c08b16df..ae8c4d53e239 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -183,9 +183,7 @@ static const struct debugfs_reg32 hd_regs[] = {
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_hdmi *hdmi = vc4->hdmi;
+	struct vc4_hdmi *hdmi = node->info_ent->data;
 	struct drm_printer p = drm_seq_file_printer(m);
 
 	drm_print_regset32(&p, &hdmi->hdmi_regset);
-- 
git-series 0.9.1
