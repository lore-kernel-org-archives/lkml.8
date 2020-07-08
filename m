Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82130C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612A4206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="H1YszzNH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJ/bE42S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGHRr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:47:56 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51779 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgGHRmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:42:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B874D102B;
        Wed,  8 Jul 2020 13:42:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=BENe0sOigToWR
        deeCSYjBzSkm3mke3+hggwOrL63usQ=; b=H1YszzNHwtU32uPHzw3qOY6+v+2PU
        LEqFN5R5TOmGlsrjk2YhOy4BiW8oeCVLmHg1zVa7bdsTT7b2ckIUku9Bj/juTM+f
        ixo1krHh6sPoQqxjRgnC9xLKRkuS563XVp8hpQVItApKXtjR4YQ75vh04GzvhZtK
        1vwwX+GwHLlvxMoXfXxBXnlTt+Uu/8BOcNbfwWnbZ5/2DYjHS4tVoMANsxwTlNcu
        Agcueja8N87m2YbS9RxIM5N9mQXyArymp8R+1yi88yecNyu8ISn7YxbFjFHuyOsV
        cIpQQiI6vRC67DkuE/3U/taBuQk1OEkylcM+f016/LGhVeMQXqihmQstw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=BENe0sOigToWRdeeCSYjBzSkm3mke3+hggwOrL63usQ=; b=kJ/bE42S
        tROZPNRrpDTFMNL6dQVbTTgGTL5HllU7Q0gf8KH6w1t3rx5h2SrfRRQkZSsXLCJW
        uDKsQ3TBagKmaqBZLcF2PEWDs4ELEgq0w8uvg+Cs2di+pVAA+e2d+iRxSmBo7b4k
        gFT5MLHYyFOyjm8d5YqDJk9SwSfF8v+Lzkji8kHDE6rXPIv/pVmzz/MLOWsKGRNL
        l5d5UdDhqRjFgG9g8YQtJ05/dEMTJ5jESYWp6CQQtg3L8a0pBq7VZpAA3aOAlhmX
        Nl7TEqkRcqSk+lVZpADNtFOI+sOc1+uqIGDnrdhcLnPrk7mK9thZIsz7UtqrxiE0
        EDNCZKm+CkpSDQ==
X-ME-Sender: <xms:lwUGXxP5WzRVgOR-_SU5FCCBXCzXorKrS_J9UwGzDwkkOMIDZALCZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lwUGXz87akxKEj7RjrRpjo269sZAX0MAzGvab1hywXOHT85XlIIwSw>
    <xmx:lwUGXwQs6jFnuxscErsuRw13GVq_NAKEM0T9fq4CNONe_pTutN12GQ>
    <xmx:lwUGX9vB0_TBuJIQGHDknai1wg8BV0dHs-PQsGUQh8QoO3UtYLMIiw>
    <xmx:lwUGXzsTZaYfRkVi_jP_q4myxMMpQ9HqrMOwphpID8mb4FxfFsYT01iTUKY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 017FC30600A9;
        Wed,  8 Jul 2020 13:42:46 -0400 (EDT)
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
Subject: [PATCH v4 11/78] drm/vc4: crtc: Use local chan variable
Date:   Wed,  8 Jul 2020 19:41:19 +0200
Message-Id: <0f6b7375a07b70353336dd7c9420138186d62936.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4_crtc_handle_page_flip already has a local variable holding the
value of vc4_crtc->channel, so let's use it instead.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index d3126fe04d9a..cdeaa0cd981f 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -533,7 +533,7 @@ static void vc4_crtc_handle_page_flip(struct vc4_crtc *vc4_crtc)
 		 * the CRTC and encoder already reconfigured, leading to
 		 * underruns. This can be seen when reconfiguring the CRTC.
 		 */
-		vc4_hvs_unmask_underrun(dev, vc4_crtc->channel);
+		vc4_hvs_unmask_underrun(dev, chan);
 	}
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
-- 
git-series 0.9.1
