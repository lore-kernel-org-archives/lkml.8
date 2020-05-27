Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D599C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3608C20EDD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="dEs6sji+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqP6XMUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390437AbgE0Pw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:52:29 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36045 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730661AbgE0Pvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9139D581518;
        Wed, 27 May 2020 11:51:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Hsd8JQOKXqqad
        N9HnqexX4egl8EjW+cY6nFdDegziVM=; b=dEs6sji+it2ZXHG8WYplk+ElCqypR
        7f6YbJHc52sSBDtdllmRFe4t1AftH69jcdN9BduIlV5SYH1Bn5nGk9VcOTItgENr
        psGkZ3nbXqK5MuwL+GMpDXtF/5uD7WENtwYVHxAms9LfpoRK16H/4ZwxXI2hYFEV
        TULzEC5aiLXNdNrFaxb7C4XVNhWO/olCEui1kf5++xYO4q+j1clJgbvCmjPxzRHG
        UKc+BzlfcszWm7D+UKCuvx6CEwEoh42jA+I+YZZu95SCV0qc5Cm5Dbnt0wlkXfqi
        fRdi8NbsGn3/OIrTThEnUtwRqc1vXIcV+pAwh0hm3CpHRefS7KDkyzSOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Hsd8JQOKXqqadN9HnqexX4egl8EjW+cY6nFdDegziVM=; b=fqP6XMUW
        y3gBzLXMEY5ZRdGOje4ECtWXxvIsqmqy+oZPl8bbK9U1svzXamIzZ+kvz4MVUX6t
        2Ml5WXFG5To9tfdn/SCBVc6W7MdibibSljuybpstJbtpxDHPXybW1Y1RWb19+ZQe
        /ZkP2eNOHPQkJKxWzi4pFvQGk5Dh+I985yD2DdC9mW2AnuKSElpuF10vw47vDmvJ
        abCCFkvc4Dwou6BN8qE8sxYDPkVJyUy7F11psaxiyVkH7s4WV5KZ29EPD03VS4mw
        b+ENhJ8XL1S3hGPyuDYpOsf2rs4OLZuApDLaEJJviuaVutztVtkEUSPnorse7UYt
        CFV/6mU+JBtoUg==
X-ME-Sender: <xms:iYzOXpyiBsTFpIJjAMF5o8VXHDcwv9Njoc00UmEaMgg3s0kA55l8eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:iYzOXpSAseRgG1ESpsNfuZGXxM9ygo2n9Npp-hxkKTSKYZQUvk3E6g>
    <xmx:iYzOXjUP6bBrfqf8doch-6KDGVZlsMmJTBpAbdpXZAxzGA8j7d0XKw>
    <xmx:iYzOXriDpPa8MKsCeAAP4ZFTuZPFaZHGx4y0CdTkoZW_KYo95bqXlg>
    <xmx:iYzOXtBXjCnzGm-rvyl4c6t0CYyB9VZa4w6KYmTZEhZI_EuOT40q-g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 352773061CCB;
        Wed, 27 May 2020 11:51:37 -0400 (EDT)
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
Subject: [PATCH v3 089/105] drm/vc4: hdmi: Remove unused CEC_CLOCK_DIV define
Date:   Wed, 27 May 2020 17:48:59 +0200
Message-Id: <45917004243e1d8a060a9932bd5348143718fb5b.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CEC_CLOCK_DIV define is not used anywhere in the driver, let's remove
it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 27cfcf38edb4..f62b488c5bdb 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -55,7 +55,6 @@
 
 #define HSM_CLOCK_FREQ 163682864
 #define CEC_CLOCK_FREQ 40000
-#define CEC_CLOCK_DIV  (HSM_CLOCK_FREQ / CEC_CLOCK_FREQ)
 
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
-- 
git-series 0.9.1
