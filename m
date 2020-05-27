Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8330CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE6F20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="GIfvfn5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RzEaKK1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbgE0Pv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:57 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40697 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390252AbgE0PvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3C26E5820ED;
        Wed, 27 May 2020 11:51:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FIyIRAaplSQhJ
        016/FVe2qNN8hRycHhnwTRG5XljB0w=; b=GIfvfn5yFyZoKG/TVp3KnxfsJdlac
        AyZdFzfU+fqK97E+KF8dXIeEnCraat6X0XxopbDjyVTcDDRlTzGGO1sHo6qsE8+J
        13lSclo8atXb+0lmcq2CkLsUaWrPC626bqQAvpRH+dmF4x4PeaSet0CSyLSBmpSv
        4KG6SLoP8+pv4PKXlDZJgzFEs8jCvq5FE3oVYtNND+qoItUo7tNy1/3ycOKhcHTX
        Q2AKXqvvNs83/MEruKAXCRMNor80OpT1+FJ0FT1TTOeUC/U8aAjwu/NEhncSSofA
        KmQOKQOFWaYG6wOaaIcZJLug/B5TwBUAVtbF2jf0lvUAD0TsFAhtQWCZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FIyIRAaplSQhJ016/FVe2qNN8hRycHhnwTRG5XljB0w=; b=RzEaKK1K
        159lPOmqsNA7fLvjVWtIZ/PwhwSqV6eEcGHBUXq0PGB6dWkR312r4bUqVcL6MEBf
        sl2Licn/s1naqB6G7R4r96bRegaSv7TH014B+CMEIDtXIJdH/3AlXI72yujq+SDQ
        NkQSE9JnkfAMtaBF0bSzLCrHMOE89aOvP4xSi/TupMJROpAkcbVFN7rUG73wSftj
        YGb927dUe7XzTP2iz2qYKGYFxcAy5KFqdI39tk0qY8q26OPIiHHKzwc+dSm59YGc
        0x7a0qWkE7osGrs9U5ONajaOaRcJjT8Ecw+fIHgyXflZdS/csechmnvDexU5iwrL
        AnKorWKYCSRb7w==
X-ME-Sender: <xms:aYzOXr9VSW-0iQsEhLXFgGuLdMgiloqdH9do1jicSK-YeV6D4H76Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgeekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:aYzOXns4TTvveCirOeRZPU8etjVQs2Zsik67dSY4Z9L2RkBm_8-bDQ>
    <xmx:aYzOXpDmY1PO6p5YJ8IuSopi2f74IWMDur_uE6mYlevH3RT0-LccDg>
    <xmx:aYzOXnf3UfREY5ah9IQMic8fBsArkAr-4ekyW-Nw463xi4QYYdzj8A>
    <xmx:aYzOXnfXMVNcR-p0H_ViKsv68xt7jF5quQpfOvBE_zRWPw3W28m7cw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CDEE53280068;
        Wed, 27 May 2020 11:51:04 -0400 (EDT)
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
Subject: [PATCH v3 068/105] drm/vc4: hdmi: Use debugfs private field
Date:   Wed, 27 May 2020 17:48:38 +0200
Message-Id: <f094f388fc2df848227e2ae648df2c97872df42b.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 19a0780a14bd..38fe942a327b 100644
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
