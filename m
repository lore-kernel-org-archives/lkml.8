Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAF6C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B691020716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="PMb22boP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgA2NlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:41:19 -0500
Received: from mail-wr1-f100.google.com ([209.85.221.100]:33076 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2NlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:41:18 -0500
Received: by mail-wr1-f100.google.com with SMTP id b6so20258515wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LKAhm5fgnCM0f4ool+EzZtuKWekhU6ZjNjBMoV+cWXA=;
        b=PMb22boP3CV1EyVw1dzQscsMHDiMAsnTPfS80IVQS+kzcT55qoid2iPIWveJzgs1t4
         TbtnBge7nIGnp4Yk2L58XyNcE5vaEbZl1icPp8g9mvE81iNUQZBIHdx03Jzb/O19uYjR
         lm5tgSgLRJIZdcb3ZXqucs9cpbiJJRec7cNEBeh0jLIxESZPSN8rxqivDbcu6lNgT6m8
         EKHj9I3QJSf453pGCmysJSM7LOkU3+B4onEA/w/xWvFxxVK/Ae5fYCEq182LGRJECnU3
         0h/9iSOseqfUelq0iw0GKK3tuawCrHhslneda3rv+roe31BI9cd5MLZAPyj17bhP1n0R
         gIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LKAhm5fgnCM0f4ool+EzZtuKWekhU6ZjNjBMoV+cWXA=;
        b=W5Xgcbd7e4HEKHJnP8fJLergpLk2sXo+mVQUdjlKvea4a9FeMQJiLYzPGv2VMUnRey
         cm7TCsJ+3rSRze/NYVnYLNn9lf7YZpBXjF62EDhZM1tv5gN+tBNg5JVsI1Yor6ZrKr2D
         hbWOPhRgvAlBtsQ55/3spe2MmsKRfV/axzGnVxgXeRjyFHzE8aRLGQGOHHC4KfAP60Kf
         36mluxWZMGuB++z7LB7e9dpm4xOnSBpfRQ15Q/5E0mqNhrc43blOkJwUaLr/dMWjq68X
         soON5ObaLZijljEhphy6oZpYOSLlElHG7+yhSECTc2+IFK1+dyYSRn4HSTKluaQe2Zyw
         MsDw==
X-Gm-Message-State: APjAAAU4UCeSsN/DjSuZyFVvbqzKcwZ8UJVF7jUJn/CV83rpDbh9r+6W
        9wjSmJLSDywUGI8BUjs0N5lV9Kpi7kElnjFPMIv/n/LnzPii
X-Google-Smtp-Source: APXvYqyFQ98FYktk+97oLQYaNelIlb9g5MjMxMu3Mz01RbmXwDkqAxJuAuvFxeN+z7MX3XHkYpJc92dWUgQm
X-Received: by 2002:adf:97d6:: with SMTP id t22mr35073052wrb.407.1580305275875;
        Wed, 29 Jan 2020 05:41:15 -0800 (PST)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id r3sm33567wro.56.2020.01.29.05.41.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Jan 2020 05:41:15 -0800 (PST)
X-Relaying-Domain: flowbird.group
Received: from [10.32.51.186] (port=60422 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1iwnak-0003Z2-Rk; Wed, 29 Jan 2020 14:41:14 +0100
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     dmaengine@vger.kernel.org
Cc:     stable@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: fix context cache
Date:   Wed, 29 Jan 2020 14:40:06 +0100
Message-Id: <1580305274-27274-1-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a DMA problem with the serial ports on i.MX6.

When the following sequence is performed:

1) Open a port
2) Write some data
3) Close the port
4) Open a *different* port
5) Write some data
6) Close the port

The second write sends nothing and the second close hangs.
If the first close() is omitted it works.

Adding logs to the the UART driver shows that the DMA is being setup but
the callback is never invoked for the second write.

This used to work in 4.19.

Git bisect leads to:
	ad0d92d: "dmaengine: imx-sdma: refine to load context only once"

This commit adds a "context_loaded" flag used to avoid unnecessary context
setups.
However the flag is only reset in sdma_channel_terminate_work(),
which is only invoked in a worker triggered by sdma_terminate_all() IF
there is an active descriptor.

So, if no active descriptor remains when the channel is terminated, the
flag is not reset and, when the channel is later reused the old context
is used.

Fix the problem by always resetting the flag in sdma_free_chan_resources().

Fixes: ad0d92d: "dmaengine: imx-sdma: refine to load context only once"
Cc: stable@vger.kernel.org
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>

---

The following python script may be used to reproduce the problem:

import re, serial, sys

ports=(0, 4) # Can be any ports not used (no need to connect anything) NOT console...

def get_tx_counts():
        pattern = re.compile("(\d+):.*tx:(\d+).*")
        tx_counts = {}
        with open("/proc/tty/driver/IMX-uart", "r") as f:
                for line in f:
                        match = pattern.match(line)
                        if match:
                                tx_counts[int(match.group(1))] = int(match.group(2))
        return tx_counts

before = get_tx_counts()

a = serial.Serial("/dev/ttymxc%d" % ports[0])
a.write("polop")
a.close()
b = serial.Serial("/dev/ttymxc%d" % ports[1])
b.write("test")

after = get_tx_counts()

if (after[ports[0]] - before[ports[0]]  > 0) and (after[ports[1]] - before[ports[1]] > 0):
        print "PASS"
        sys.exit(0)
else:
        print "FAIL"
        print "Before: %s" % before
        print "After: %s" % after
        sys.exit(1)
---
 drivers/dma/imx-sdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 066b21a..332ca50 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1338,6 +1338,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
+	sdmac->context_loaded = false;
 
 	sdma_set_channel_priority(sdmac, 0);
 
-- 
1.9.1

