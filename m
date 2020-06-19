Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7971C20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592542504;
	bh=bFexccscXk2UlaIa+BaEhorrfA99CZlAzpnuwyv3vSg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qzcq6Lx0zLcB/nq1GprBMO47ZY8cQzVQJHlvlkGeYFeXai3mNEJIZtUPbJ7XXCHKZ
	 Lu3BzqGOFAF+KcQZ+CrRHZP69qmatMhSruge+8qUYOrYKWGvIiwj9H5EMdGPcYlteJ
	 3XZd4GfF3fnup4fJ5tfvoZ/O7HcoApJM3WFolLeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFSEzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgFSEzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:55:02 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FF220890;
        Fri, 19 Jun 2020 04:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592542502;
        bh=bFexccscXk2UlaIa+BaEhorrfA99CZlAzpnuwyv3vSg=;
        h=From:To:Cc:Subject:Date:From;
        b=LnGKm3Z2NDS1Q4yfFCee0znsKJe5Whm49EzlQ8HMzD5RrWZGsRVFNp2o3ULielKJD
         u9jM6X0PdR2qWV1GMfwV6Gava33WXp6GOgV6yBXS/fJ9v+SmdZBL09VhI5BODQiHbC
         Rj92N5hz4OKVc+QsVudgvfjkZj5e3LjOaS/MuONw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ALSA: compress: Document stream states and fix gaplless SM
Date:   Fri, 19 Jun 2020 10:24:45 +0530
Message-Id: <20200619045449.3966868-1-vkoul@kernel.org>
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

