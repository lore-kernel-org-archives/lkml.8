Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E22C4BA01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6098E2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgBYWYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:24:06 -0500
Received: from belmont94srvr.owm.bell.net ([184.150.200.94]:52028 "EHLO
        mtlfep05.bell.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBYWYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:24:05 -0500
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 17:24:05 EST
Received: from bell.net mtlfep02 184.150.200.30 by mtlfep02.bell.net
          with ESMTP
          id <20200225221521.NQRV115221.mtlfep02.bell.net@mtlspm02.bell.net>
          for <linux-kernel@vger.kernel.org>;
          Tue, 25 Feb 2020 17:15:21 -0500
Received: from banach.localdomain ([50.101.131.103]) by mtlspm02.bell.net
          with ESMTP
          id <20200225221521.PVOA16482.mtlspm02.bell.net@banach.localdomain>;
          Tue, 25 Feb 2020 17:15:21 -0500
Received: by banach.localdomain (Postfix, from userid 1000)
        id CA8113C00322; Tue, 25 Feb 2020 17:15:20 -0500 (EST)
From:   chrisgorman@bell.net
To:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Gorman <chrisjohgorman@gmail.com>
Subject: [PATCH] Sound: rt5645: fix comments to show correct options.
Date:   Tue, 25 Feb 2020 17:14:56 -0500
Message-Id: <20200225221456.16539-1-chrisjohgorman@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-Analysis: v=2.3 cv=I5Mbu+og c=1 sm=1 tr=0 a=pTuFESz5lVmf7oCFLcCpYQ==:117 a=pTuFESz5lVmf7oCFLcCpYQ==:17 a=l697ptgUJYAA:10 a=pGLkceISAAAA:8 a=T4KsNwo-XeB6FIUPdDUA:9
X-CM-Envelope: MS4wfGC7JzXarx4hx70n/2SS/1NDj24YKemzZqwaugukGjvPl06qDD+rbEm5x3WbQhGmcRG0GRnukhWSLfK6oAtvNfX9Evhcp3UevawHupIEz4PZjKqmjo99 gp3OIJY0RrWmPtoB4sXmmsviNaz5H8GPoSdpmbOgBYETW7/pNkXz4OOtjtxnxrxNd1QbuGgK6maJ1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/rt5645.h and
Documentation/devicetree/bindings/sound/rt5645.txt both show different
options for dmic1_data_pin and dmic2_data_pin than include/sound/rt5645.h.
Updating include/sound/rt5645.h comments to show the correct options for the
variables, per the other files.

Signed-off-by: Chris Gorman <chrisjohgorman@gmail.com>
---
 include/sound/rt5645.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index 39a77c7cea36..d6c5d3a0b7bf 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -13,9 +13,9 @@ struct rt5645_platform_data {
 	bool in2_diff;
 
 	unsigned int dmic1_data_pin;
-	/* 0 = IN2N; 1 = GPIO5; 2 = GPIO11 */
+	/* 0 = DMIC1_DISABLE; 1 = IN2P; 2 = GPIO6; 3 = GPIO10; 4 = GPIO12 */
 	unsigned int dmic2_data_pin;
-	/* 0 = IN2P; 1 = GPIO6; 2 = GPIO10; 3 = GPIO12 */
+	/* 0 = DMIC2_DISABLE; 1 = IN2N; 2 = GPIO5; 3 = GPIO11 */
 
 	unsigned int jd_mode;
 	/* Use level triggered irq */
-- 
2.24.1

