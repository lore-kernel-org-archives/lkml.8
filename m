Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65A8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE9B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456082;
	bh=5lj2CjP+mqKw3lIwcakr7w5MtVUT9JglI5l66SdwoVw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SshnP3W+tksrRalSCNbeG0nQ5Vau0I2aFrBw0GfZeYZqBXhUCyL/lxUzq25Xx4gb1
	 ZV/qItRqiJEQTt0X2U3Dml+Hs3APJr5JOGLTgRmKd3pT9CcIYFVXkfipILEkvsjyxp
	 ebeaoKACCfD0U8GqE6dBJGlI7Xb8ABe30dohsFJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgF2SlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbgF2SlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:11 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895DF23132;
        Mon, 29 Jun 2020 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593417014;
        bh=5lj2CjP+mqKw3lIwcakr7w5MtVUT9JglI5l66SdwoVw=;
        h=From:To:Cc:Subject:Date:From;
        b=urFpXw2Nprp+sZH5KbJeu7SytbNd781ejuIm530e85EZPeNa1/DAn2ZmjBtdxvltY
         q6GbEWWnIUFDZaxpLIToAyhOOCx0TnZFBbNWAccfBjU+2vRsvXjB2WXm7XJ3054N8y
         VnBd0GaNdrVrB++fp2ZBVpDsqwufP9eXFgdLngG0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] ALSA: compress: Document stream states and fix gapless SM
Date:   Mon, 29 Jun 2020 13:19:59 +0530
Message-Id: <20200629075002.11436-1-vkoul@kernel.org>
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

Changes in v4:
 - Add review tag by Charles
 - fix the lock deadlock pointed by Charles

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
 include/sound/compress_driver.h               | 10 ++-
 sound/core/compress_offload.c                 |  4 +
 3 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.26.2

