Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9317C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD8C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860033;
	bh=+ugu/tNF/pHt3udlHuscPoyBo9goacPReY2N/k7oBBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWuYUqIrohH7DoHMReupXkrj0XwApUHZO9jWyo6dJi8vE0GiE9KV24955Vu9p8xtQ
	 Z/6z3TSQN9kICO/kg2jyV5nFJo6Ps0VEBAFKdIwQoh9YFOgKv6Hoy9FhO+kulDKWUy
	 +Rd9SHrJq8K7N5hvbBHMhHyL1VsCO7g1ZI7/sM2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgG0O1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgG0O0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:26:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9030220663;
        Mon, 27 Jul 2020 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859973;
        bh=+ugu/tNF/pHt3udlHuscPoyBo9goacPReY2N/k7oBBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOv4vbJ11pKZJurAZErnHuFeSAARQOPkld4piEe+QJpqrqY8cPEJWb/yO5eGNwshU
         sS2BEbCjnV9BIV2iPz9JT78cW43tt1KkzJVIdhChwU4MIZlrSVtLKl5HHOAMgXhhUd
         5BviJcEnwN56dyJTgCkhbDF76+iEbYxpyV48zFhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Curtis Malainey <curtis@malainey.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.7 176/179] ASoC: Intel: bdw-rt5677: fix non BE conversion
Date:   Mon, 27 Jul 2020 16:05:51 +0200
Message-Id: <20200727134941.229904990@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

commit fffebe8a8339c7e56db4126653a3bc0c0c5592cf upstream.

When SOF is used, the normal links are converted into DPCM ones. This
generates an error

[ 58.276668] bdw-rt5677 bdw-rt5677: CPU DAI spi-RT5677AA:00 for rtd
Wake on Voice does not support playback
[ 58.276676] bdw-rt5677 bdw-rt5677: ASoC: can't create pcm Wake on
Voice :-22

Fix by forcing the capture direction.

Fixes: b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Curtis Malainey <curtis@malainey.com>
Link: https://lore.kernel.org/r/20200707210439.115300-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/boards/bdw-rt5677.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -328,6 +328,7 @@ static struct snd_soc_dai_link bdw_rt567
 	{
 		.name = "Codec DSP",
 		.stream_name = "Wake on Voice",
+		.capture_only = 1,
 		.ops = &bdw_rt5677_dsp_ops,
 		SND_SOC_DAILINK_REG(dsp),
 	},


