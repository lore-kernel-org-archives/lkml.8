Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2C7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C467214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592542518;
	bh=xsXYmu5KJaRlZUfPJ9GfJ5BsD+GGZhZMq6RqGkubP44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a36twUgZlK1/ECqZW1Er3agrs09FLyQYl2hP5ffJ6CtSTxIwW2GDvzk9SmIAy2X4Y
	 Jl7FnIy6NcXiGE72em98/H1G46vTtwTrdK9Sp6tyc9bi44T6mDAdvd1fRXKpwrhTg5
	 qo4m0IG9ZUp8Y/n8uvbMHnPrvr1vA8PSP67Leaoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgFSEzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgFSEzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:55:09 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE2420CC7;
        Fri, 19 Jun 2020 04:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592542509;
        bh=xsXYmu5KJaRlZUfPJ9GfJ5BsD+GGZhZMq6RqGkubP44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWaR+4Dl9B4lEGH3LA86yfWN3WtZHxRrvSzeZL19EwYgVM8KWonOpvVr7U4RbDGHg
         x2NjlW9LOLlYlti68KducJiUZSrzJWRlJWO13hzCvjPHz7iSgabN74FHaPkpNrLatS
         O3ESbCIrPQl1Bft1FVqoABlkVpCHY73tERAnoA/w=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ALSA: compress: document the compress gapless audio state machine
Date:   Fri, 19 Jun 2020 10:24:47 +0530
Message-Id: <20200619045449.3966868-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619045449.3966868-1-vkoul@kernel.org>
References: <20200619045449.3966868-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also documented the galpess transitions. Please note that these are not
really stream states, but show how the stream steps in gapless mode

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../sound/designs/compress-offload.rst        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index 7292717c43bf..3e241530e173 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -251,6 +251,38 @@ Sequence flow for gapless would be:
 
 (note: order for partial_drain and write for next track can be reversed as well)
 
+Gapless Playback SM
+===================
+
+For Gapless, we move from running state to partial drain and back, along
+with setting of meta_data and signalling for next track ::
+
+
+                                        +----------+
+                compr_drain_notify()    |          |
+              +------------------------>|  RUNNING |
+              |                         |          |
+              |                         +----------+
+              |                              |
+              |                              |
+              |                              | compr_next_track()
+              |                              |
+              |                              V
+              |                         +----------+
+              |                         |          |
+              |                         |NEXT_TRACK|
+              |                         |          |
+              |                         +----------+
+              |                              |
+              |                              |
+              |                              | compr_partial_drain()
+              |                              |
+              |                              V
+              |                         +----------+
+              |                         |          |
+              +------------------------ | PARTIAL_ |
+                                        |  DRAIN   |
+                                        +----------+
 
 Not supported
 =============
-- 
2.26.2

