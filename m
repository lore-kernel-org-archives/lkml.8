Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA435C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3800222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846537;
	bh=nnwxZghy9qMMharnd6Mv2u5XeJJ/Ophsfiznx4exfvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pmlQhq+ZR4zfH/Lrp31ZvAMb5Hf7cfnnV7iSMqXB7W4BcrT3d0BKKpu9sGBID7RO4
	 /hPKr5avzdiHZaspVNSWcIFaqHlzANpfMIvvxKVexcki//Pa114sYLBTwu5Rmjmuab
	 PqFs/VfC0d+dWSkwUzvaD4qyoKRsP9Y92H7ARKgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgCJNWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgCJNBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A232920409;
        Tue, 10 Mar 2020 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845307;
        bh=nnwxZghy9qMMharnd6Mv2u5XeJJ/Ophsfiznx4exfvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSA+9VUgFKwOHZYgMN4ZMsXviynF9Zovz8AyMTfniYW518OPwjt5cb8f9pdhAvSPf
         XEAZDwAhOdovckvjcrxe8LPnfrZ5D0e1i52JOjZeP13357yV18IfPc5QohSWkvHKks
         lZ/UJ1dSVyyoPI974zLKGEdKEia8Fd2+/mE6mo9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Reichl <hias@horus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 136/189] ASoC: pcm512x: Fix unbalanced regulator enable call in probe error path
Date:   Tue, 10 Mar 2020 13:39:33 +0100
Message-Id: <20200310123653.574149045@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Reichl <hias@horus.com>

commit ac0a68997935c4acb92eaae5ad8982e0bb432d56 upstream.

When we get a clock error during probe we have to call
regulator_bulk_disable before bailing out, otherwise we trigger
a warning in regulator_put.

Fix this by using "goto err" like in the error cases above.

Fixes: 5a3af1293194d ("ASoC: pcm512x: Add PCM512x driver")
Signed-off-by: Matthias Reichl <hias@horus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200220202956.29233-1-hias@horus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/pcm512x.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1564,13 +1564,15 @@ int pcm512x_probe(struct device *dev, st
 	}
 
 	pcm512x->sclk = devm_clk_get(dev, NULL);
-	if (PTR_ERR(pcm512x->sclk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (PTR_ERR(pcm512x->sclk) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err;
+	}
 	if (!IS_ERR(pcm512x->sclk)) {
 		ret = clk_prepare_enable(pcm512x->sclk);
 		if (ret != 0) {
 			dev_err(dev, "Failed to enable SCLK: %d\n", ret);
-			return ret;
+			goto err;
 		}
 	}
 


