Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F98C2073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceObNRJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgGGQgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:36:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD56C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:36:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so43974922wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUDtaZGuLvv+SLoR7KU3Z891RyQPf3cxC2Vk4Ft9m9A=;
        b=ceObNRJb7swhmuIvVvg3ZWrMgV+06yjHovtpaDEvq4C3mCvWuWv+/xTa0cFjalWvb0
         DkiDYsAW+KY+MufpoNp8ltf2iXAvP2ivhQ/eTvxOtu2Dwa7ZQSoER3vk+bBwrXO9siZ6
         BfPqBqVmp4nDCnIA0gJQNrIXMjoAq8CZBPfpawF2hCp6x69YekTK/MSWoLa1a+Hg9+9k
         neMSXdGgCUmyDrUxBvrtTnfYdHo+0w0wbZN+jG07dxZ9x+oaRwJc0MCZndbsta3LNw+7
         yIbnD/2BxgAALz314G6NQD/xkZaONSuA1VH+KgTN5eR+2bFZek3ybcNA433micyY7kDx
         z7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUDtaZGuLvv+SLoR7KU3Z891RyQPf3cxC2Vk4Ft9m9A=;
        b=IWQ0GaxMe9TXS/fbMffnrR1mxB4QyyTTQ8qfBqdjlvLBR3dre9Gi/myPnB+0PPCwSG
         c9/x0o7Ah+sYzVyTj60w+WYitrYfLkgaODI0DXbtKQO0/mLrT0VEC8m8H/lip2iT/K+g
         Wfb2gmt3pjAdT4Rbwp3+6EkvZ9EG9YdCbfiqGFNDE4L/bN7ISEs7c1d1R1A88kzCC+/k
         G1bbZ8IJV49sArNsiIxx3KEtoxEZ1pwk3a6AI5V+hfQsPlciaMC6F78ZR+f6wxn9Rg6v
         vmvkKJ9/fL++AeqEF7F9R4Zp7xjew8CVzZC8Ed34zm/QXNVUbMv5Grg+VVGNIMtEUP96
         oF/g==
X-Gm-Message-State: AOAM530YyfLfgt88RYqLCHINbTObZy1wlqvJhKmcqns5bCfjYcsGSmpU
        S1AK1IruW8LgWkn/JSKjb7qA0Q==
X-Google-Smtp-Source: ABdhPJz0MNARkMW88PzV5/chhJFzWYfOvc0ROqTGi8ma2hnlG9QS9GYEPrqvZOnoNhLS0UuMXlyHeg==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr4863263wmi.109.1594139809531;
        Tue, 07 Jul 2020 09:36:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:36:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/11] ASoC: qdsp6: add gapless compressed audio support
Date:   Tue,  7 Jul 2020 17:36:30 +0100
Message-Id: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds gapless compressed audio support on q6asm.
Gapless on q6asm is implemented using 2 streams in a single asm session.

First few patches are enhacements done to q6asm interface to allow
stream id per each command, gapless flags and silence meta data.
Along with this there are few trivial changes which I thought are necessary!
Last patch implements copy callback to allow finer control over buffer offsets,
specially in partial drain cases.

This patchset is tested on RB3 aka DB845c platform.

Thanks,
srini


Srinivas Kandagatla (11):
  ASoC: q6asm: add command opcode to timeout error report
  ASoC: q6asm: rename misleading session id variable
  ASoC: q6asm: make commands specific to streams
  ASoC: q6asm: use flags directly from asm-dai
  ASoC: q6asm: add length to write command token
  ASoC: q6asm: add support to remove intial and trailing silence
  ASoC: q6asm: add support to gapless flag in asm open
  ASoC: q6asm-dai: add next track metadata support
  ASoC: qdsp6: use dev_err instead of pr_err
  ASoC: qdsp6-dai: add gapless support
  ASoC: q6asm-dai: add support to copy callback

 sound/soc/qcom/qdsp6/q6asm-dai.c | 397 +++++++++++++++++++++++--------
 sound/soc/qcom/qdsp6/q6asm.c     | 173 +++++++++-----
 sound/soc/qcom/qdsp6/q6asm.h     |  48 ++--
 3 files changed, 458 insertions(+), 160 deletions(-)

-- 
2.21.0

