Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C357C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78CA2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoSQtxW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgHaViC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgHaViC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:38:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94128C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 14:38:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so600359pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hv3iIpISK+Eauvn2X+pBHs6mFWEi7dy0S6XImcuWXSA=;
        b=OoSQtxW0+3StDvjlRlEx76r1riZgAyXM6VLcswEInCWblGV3xuGwJyaBg0whjjotcM
         wbH5LSI2btvaYWjdAMl8iD8+jfMtNajn/k+jdCapSLxs2PUL9hFiwcbCyWlG2CEiNyuE
         imvA+k5Cp1q54kbpN6IFAXldiwPGnNiDWDg19+L1/3R7QHHB5U7xuReYGKicSFPbD3vu
         T10liVf2z2TtjFiLG9Ie/jgxDwgxN7vRdpL2r99IO5n4U0S6pPseE5xhSbb6AJU/JT3q
         e47+qDo+iusgo3/v0drWT23NdWz5Cb7f8ftbffL7SD4KUSm1r5UVc66381v8afJ6BXnB
         uPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hv3iIpISK+Eauvn2X+pBHs6mFWEi7dy0S6XImcuWXSA=;
        b=D6Pv3vOs/muLSciD9ZSNvUBUc65W8XNTMw0ZGxUAsPJWDtXvEOyCuJSKew5Ygkg9Zf
         SEhGijfJLoFYQ0hXxbHsKo9jSudUS4L2QhPI3eIyLlh8lPJJcT8hZzyL6etU6ZMlNAYz
         aeS994Tq5PPu1ELgqDZlH18riGgBc1o4rorAkAuzKuAVwmFp8kkS13vEb0GbRRcYw7MH
         dqwmvKuoilgRBg1cu2ghuyoGYi6RYBvgtnauwDmdzZKkrtXOwqSsQXupx/MepPFkdBc+
         M7uFynGHwWdzcADaXpNvy35TyGUknWt6aNXeDNhynkzY1EKH7fPatjjiBwj5cdxWCjS1
         J5iA==
X-Gm-Message-State: AOAM532iSl1QFS8bwCUvG7uF1ron0Hz4wmUJyA+ea6n28NFqCTkeMi1N
        cLkdUi6LBmuybY6hmkoSdPFasE/UooPB8w==
X-Google-Smtp-Source: ABdhPJwOasYqywsqH/gXmdcdXJCqpia6QSc5UMEsjUUKJTmBkUyNf87L6K0ndjbpJfKkGCtLXdwLyg==
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr1235872pjb.210.1598909880687;
        Mon, 31 Aug 2020 14:38:00 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m24sm8525514pgn.44.2020.08.31.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 14:37:59 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: stm32: Fix pointer assignement
Date:   Mon, 31 Aug 2020 15:37:58 -0600
Message-Id: <20200831213758.206690-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the assignment of the @state pointer - it is obviously wrong.

Fixes: 376ffdc04456 ("remoteproc: stm32: Properly set co-processor state when attaching")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index f4da42fc0eeb..d2414cc1d90d 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -685,7 +685,7 @@ static int stm32_rproc_get_m4_status(struct stm32_rproc *ddata,
 		 * We couldn't get the coprocessor's state, assume
 		 * it is not running.
 		 */
-		state = M4_STATE_OFF;
+		*state = M4_STATE_OFF;
 		return 0;
 	}
 
-- 
2.25.1

