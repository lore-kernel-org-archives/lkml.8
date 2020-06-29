Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A523C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7379D206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466721;
	bh=YWU8myn0GJoBKGikqE+Sbyv4Efs66UUXqbsd0yzD1N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KGTVKbFyUCNkSQkqFH64f5Zce4mJ8dpDwiPl6tYUwWCXRIl7Fs5s7+2dl53YUZsKs
	 HZyB6QmACZG1F8NWhMjEcqepfbIprbxov6fIWqCNXjCyszV6ZVT58/6fZQ2IB3NNYj
	 W9q3nBOIySuBKxwP3ahZHPBqRRruRd+a7hoMeC7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgF2Vij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgF2Skc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:32 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DDAC2312C;
        Mon, 29 Jun 2020 07:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593417018;
        bh=YWU8myn0GJoBKGikqE+Sbyv4Efs66UUXqbsd0yzD1N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHvUjhAE3RytYaNpiEGhwD7kLeRzQaKQmVs82P7GS5+DKCGgDQVFEdxl1Ku1/Slpf
         /4AgKPqkomhOEUkV+yiZ0DXXRLYttx5ogTIhhpNJXrCqWGXd4GYcw/pcAviny97Vbb
         fHgiI8+RO4GxgAPPXeiOTnfeRxTWr5vcwVN68GT0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] ALSA: compress: document the compress audio state machine
Date:   Mon, 29 Jun 2020 13:20:00 +0530
Message-Id: <20200629075002.11436-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629075002.11436-1-vkoul@kernel.org>
References: <20200629075002.11436-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we had some discussions of the stream states, so I thought it is a
good idea to document the state transitions, so add it documentation

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../sound/designs/compress-offload.rst        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index ad4bfbdacc83..b6e9025ae105 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -151,6 +151,57 @@ Modifications include:
 - Addition of encoding options when required (derived from OpenMAX IL)
 - Addition of rateControlSupported (missing in OpenMAX AL)
 
+State Machine
+=============
+
+The compressed audio stream state machine is described below ::
+
+                                        +----------+
+                                        |          |
+                                        |   OPEN   |
+                                        |          |
+                                        +----------+
+                                             |
+                                             |
+                                             | compr_set_params()
+                                             |
+                                             v
+         compr_free()                   +----------+
+  +------------------------------------|          |
+  |                                    |   SETUP  |
+  |          +------------------------>|          |<-------------------------+
+  |          | compr_drain_notify()    +----------+                          |
+  |          |         or                   |                                |
+  |          |      compr_stop()            |                                |
+  |          |                              | compr_write()                  |
+  |          |                              |                                |
+  |          |                              v                                |
+  |          |                         +----------+                          |
+  |          |                         |          |   compr_free()           |
+  |          |                         |  PREPARE |---------------> A        |
+  |          |                         |          |                          |
+  |          |                         +----------+                          |
+  |          |                              |                                |
+  |          |                              |                                |
+  |          |                              | compr_start()                  |
+  |          |                              |                                |
+  |          |                              v                                |
+  |    +----------+                    +----------+                          |
+  |    |          |    compr_drain()   |          |        compr_stop()      |
+  |    |  DRAIN   |<-------------------|  RUNNING |--------------------------+
+  |    |          |                    |          |                          |
+  |    +----------+                    +----------+                          |
+  |                                       |    ^                             |
+  |          A                            |    |                             |
+  |          |              compr_pause() |    | compr_resume()              |
+  |          |                            |    |                             |
+  |          v                            v    |                             |
+  |    +----------+                   +----------+                           |
+  |    |          |                   |          |         compr_stop()      |
+  +--->|   FREE   |                   |  PAUSE   |---------------------------+
+       |          |                   |          |
+       +----------+                   +----------+
+
 
 Gapless Playback
 ================
-- 
2.26.2

