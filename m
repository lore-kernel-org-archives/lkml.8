Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D09FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CCA208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVZkiafE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCFN2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:28:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37098 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgCFN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:28:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id 6so2375378wre.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ATcltqBAZ3vv6t5DCoZL9cPihQSXfcTDNZgQ8YyGQjM=;
        b=JVZkiafELVxPRF/LtVsLcPTtVn/TzBrli4Bdkqp3fL88X9wXB9ixRaBhcT1HWOmwpK
         nVDu7VbhSFYHXNLTQXPqkKXTQ5jGDxhCeBcv/+YRJESQaCcrHQcES6xIOK9AuYntANPz
         p/S671OFGg8decPT5mi6wMubUWBdM6AvdZxwZ3ECAZKHoRyeqZBK2Ik17sQU1VkCiE7R
         hsf3Gpt3UIB+HPlKpyFyIIQl4E/cFjNEi2ksf9cSCj4uxEzvxO0E1tg0Md6XGeQiyMuB
         1BvUgy8dLvMW6quhYUK6k48JylBh1JIYpNW5mJt3YCYsagUIvNBHlnoR/AIs3nHqkJUy
         Pjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ATcltqBAZ3vv6t5DCoZL9cPihQSXfcTDNZgQ8YyGQjM=;
        b=k59bh5FkBIsnIaOTTkLnU3vtuF3fyuOp7f6aLCSTst1UOLLgw32KBV524c8ngjrA6V
         +VS2zKXgMHqIu65td57YS4w0d2DymlTpNcfv99JlE2AKIj0754EjjfDchB+3SaTW1aWi
         o/eNc/K4NBkmNQg7mLPpTaXNuWu8Uo7RmfGsIenDuPYEZUgCSY96DnhzDdN5qH9LFP0S
         QcJod2rdUW1ljWHkhtlJrYd9KmbWrtJ6L6LyK3c7PzbbpIOYdA9RcWCQ8Yjc/twkTpxg
         1EPBjof4E/zPnZBLFJ/jhXt87oZBgQm1FEzL/z4IptUWqcCKn6/qhR4xNy7wvSn4nT3U
         dOLA==
X-Gm-Message-State: ANhLgQ16u0uH13rCVnoaz0lzAtqYbi8j/GP7u1+BWjM0P7CjQWxb40nk
        1TwRYyNcuvWYsgqh3/u9l36reg==
X-Google-Smtp-Source: ADFU+vtdpTEb+R9fc08Xg3nFUFodU7hiSp7Kau/HAd/4WuD15ZkHU0XD1dXctPsLd1AW9FG3ZIIgdA==
X-Received: by 2002:adf:c449:: with SMTP id a9mr4023051wrg.366.1583501291148;
        Fri, 06 Mar 2020 05:28:11 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t1sm53349237wrs.41.2020.03.06.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:28:10 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: wcd934x: minor fixes
Date:   Fri,  6 Mar 2020 13:28:04 +0000
Message-Id: <20200306132806.19684-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset has 1 fix and a header cleanup found during
recent testing.

Srinivas Kandagatla (2):
  ASoC: wcd934x: fix High Accuracy Buck enable
  ASoC: wcd934x: remove unused headers

 sound/soc/codecs/wcd934x.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.21.0

