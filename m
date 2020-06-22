Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7E62543B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592809108;
	bh=M+IMJCWsfaGwRdIZxma3LL04/JdsXZ7jXdbDu2zWSs8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=W2Av4Eu128eJyFMGxklpiTOS/BXB05F4dC5UQykUm1g/N24W+iUp1M5IJgpl4u1j5
	 z/9ZxLj5Bwt9R1z6qX48B6YlG+2dL63iT2ogjYo9MRtQDQ9iGmXQO5fidtRQC/CsIx
	 ysY6FcHkvfZSxgQa7umw/XKGS51bScw7AfwBFjIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgFVG61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgFVG61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:58:27 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5C7625360;
        Mon, 22 Jun 2020 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592809106;
        bh=M+IMJCWsfaGwRdIZxma3LL04/JdsXZ7jXdbDu2zWSs8=;
        h=From:To:Cc:Subject:Date:From;
        b=l04caq2+VwFrt5m0dYJc5LRs8iiTn1o+HMA8ghi+N8f3XqMi+7KwU1sNFKobHP9MM
         iUyz9jgrPTtoEqEAIRHtG9NQSac3bCTS3tyoTFytA1zfZAW3hiWG8WUKB/UB0iysDd
         XH8dFCbQ0y629dk9gI/qSqH0DEj36sUjeJjsC4YM=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ALSA: compress: Document stream states and fix gapless SM
Date:   Mon, 22 Jun 2020 12:28:08 +0530
Message-Id: <20200622065811.221485-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srini found issue with gapless implementation which prompted to look deeper
into SM for compressed stream.

So documenting SM was first step, so first two patches add that. Last patch
fixes the issue by keeping track on partial_drain and then moving state to
'running' in snd_compr_drain_notify() for partial_drain case on success.
While at it, noticed snd_compr_drain_notify() is lockless state change, so
fixed that as well.

I have tested this on Dragon board RB3, compressed audio works out of the
box on that platform and Srini will send driver and fcplay patches for
gapless soon.

Changes in v2:
 - Added tested tag by Srini
 - Update compress SM with Free state and compr_stop() transitions

Vinod Koul (3):
  ALSA: compress: document the compress audio state machine
  ALSA: compress: document the compress gapless audio state machine
  ALSA: compress: fix partial_drain completion state

 .../sound/designs/compress-offload.rst        | 84 +++++++++++++++++++
 include/sound/compress_driver.h               | 12 ++-
 sound/core/compress_offload.c                 |  4 +
 3 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.26.2

