Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE802C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703BA20706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593100027;
	bh=p2m3B49vDTXiteO5iNtcCF9X6XFjZuQykWs5KqLaLPo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lXTknXw1APHXjjCZsXr1BbGkhf4HQZ54DEB8TxM0tdFUp0nbNlERHhyhz3FR6jEwn
	 fkfep8Q8wKAoGxhVpkX1swVJWX1KG8ma03CU5F6/+3H0qBZJ9p0bI95aoPy6ryuchB
	 z5oEqVFnDFRLuhz9adGf5KLUywP15Suzr7EQRjAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbgFYPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389551AbgFYPrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:47:05 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C87E207E8;
        Thu, 25 Jun 2020 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593100025;
        bh=p2m3B49vDTXiteO5iNtcCF9X6XFjZuQykWs5KqLaLPo=;
        h=From:To:Cc:Subject:Date:From;
        b=1fc9KQbR086I5+qM5iVP52kq+GJLcfydg0p/EXgxGuhPK7g5D/toyXtHGlRAe6VNM
         cKqmLEMpWoLHwCK6Q1Fw5Lz6N11XPX+hFTXyr3zAsHb4MO5t8Z/eOoef6RxtDb1a9L
         SPWl3IRUcCEs1/kJilPUNn8ysOJSpP8SfE8bjcf0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] ALSA: compress: Document stream states and fix gapless SM
Date:   Thu, 25 Jun 2020 21:16:48 +0530
Message-Id: <20200625154651.99758-1-vkoul@kernel.org>
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

Changes in v3:
 - Add pause->stop->free transition
 - Add setup->free transition
 - remove running->free as that goes thru stop

Changes in v2:
 - Added tested tag by Srini
 - Update compress SM with Free state and compr_stop() transitions

Vinod Koul (3):
  ALSA: compress: document the compress audio state machine
  ALSA: compress: document the compress gapless audio state machine
  ALSA: compress: fix partial_drain completion state

 .../sound/designs/compress-offload.rst        | 83 +++++++++++++++++++
 include/sound/compress_driver.h               | 12 ++-
 sound/core/compress_offload.c                 |  4 +
 3 files changed, 98 insertions(+), 1 deletion(-)

-- 
2.26.2

