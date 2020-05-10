Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52ABC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CE1207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiAh446Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgEJQ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729193AbgEJQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A2C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so7960353wrt.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYaO3vIFzjPS+OfApN0NYSAANmGhGDH0gcx3AO0sLnU=;
        b=uiAh446YfKtgnRC1fQcABQkMfbqSQvqvqmPuS8O26UEmq/dcUXoHl3BYwBQ1bqoeDk
         lzpm+0QFhTRLE5YzGMKlaQBoEXO2Xqo/Lm9lWaN7ZoL2k1x97RG65AvnDp7PuK1e1Waj
         jq2osBsVEmu6irLO0dkRnNqkhV/4mHhZr/aEupDm9Wvh6Npc9eluv3hSWCfmukrX66m2
         a8Ji6vS1BCHQmz4h8NqcXjbrCwFFZmLV3TVPifVI54WSgy5j1RJsQ6cUO8RNN88WPS1R
         pqlm8rAmkuLvdL5CLpQaR++IHipHx360nAQqQdwnV9HT8rbSs0JX7kLhsYv3U3Og/S+C
         gjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYaO3vIFzjPS+OfApN0NYSAANmGhGDH0gcx3AO0sLnU=;
        b=ZPMhCPp0qlfolcXL45uUPFRCopfv8fKCcPeRgzQmRfTNn9FA9zyl5ZylmqZLI4Ev/c
         /vA4RclSlakyM065p4jMjsegaxUpZACh63KFX6nrwCYFDiKFQdC8rXmrIYGYWKMmTliM
         cvrmn+FdGRHmbN7ktSdMvZ+3TivSua4dwFnzIkbP2V8VraUNffzzn88w7IR7PNDUqNqE
         PXP5B6q8qQAt0YkQOk3tEgpo76CT3TQsDIH82WMlRqj7aORWP6HHfX3D5BwNWJSBTIlY
         LZiZJb7nwvhDbrxYt3WbdUy7HKJXinkoNIU65vDv6eY/gJqaIgedmkEZ0i6NAqNByQ86
         1QNw==
X-Gm-Message-State: AGi0Pua9dpOti7EM8AlvmB5gC8f9tRAYwc1N65T/623uzbclonhgY1wD
        fbSgNvF+EiHE7lO1DkJzZE4=
X-Google-Smtp-Source: APiQypIW4OiL8jyn7DImLpe0ow+y3YcsSLrPBYX2kzMMClad8smYzUnb3uZIPJ1/AW7spP8aYpKVLQ==
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr2556186wrx.133.1589129749565;
        Sun, 10 May 2020 09:55:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:48 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 07/15] drm/panfrost: use device_property_present to check for OPP
Date:   Sun, 10 May 2020 18:55:30 +0200
Message-Id: <20200510165538.19720-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of expecting an error from dev_pm_opp_of_add_table()
do a simple device_property_present() check.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index d9007f44b772..fce21c682414 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -96,15 +96,19 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
-	ret = dev_pm_opp_of_add_table(dev);
-	if (ret == -ENODEV) /* Optional, continue without devfreq */
+	if (!device_property_present(dev, "operating-points-v2"))
+		/* Optional, continue without devfreq */
 		return 0;
-	else if (ret)
-		return ret;
-	pfdevfreq->opp_of_table_added = true;
 
 	spin_lock_init(&pfdevfreq->lock);
 
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "Couldn't add OPP table\n");
+		goto err_fini;
+	}
+	pfdevfreq->opp_of_table_added = true;
+
 	panfrost_devfreq_reset(pfdevfreq);
 
 	cur_freq = clk_get_rate(pfdev->clock);
-- 
2.20.1

