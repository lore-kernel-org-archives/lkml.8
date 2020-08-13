Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93667C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDA720639
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ7YhnJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMFmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMFmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:42:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62573C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:42:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a14so5405300ybm.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=K4z6h/ZBrq50C0ovmsW4dSKeXLB4WwD8TYiSUyA2qdo=;
        b=UJ7YhnJgMIiaMtKnMB6qOrejUG2dFZeUxZ46/HNjBls+FfU7g16lyFv5vCUl+VFSmu
         zaYXZ9vjWg3ojYt5AiYLtEzUlxhjnfxZRLsmRXEzitMwn7mta+KmSo0L3X36xtXin0Hn
         +sSXlQMxbQNUdHpi6dO4S3/HDpA4VJcLat8ugbW7I5XA1uIp9u3Y86JAmvGzkcdGvKPq
         h5abmk9/bZJ2LgabX14evoEtBpL33Nzp/wl/5Q17yAjVs8PA2kDyAsfqdl0nKsSkhhcN
         DvI0UUR/Z9EoFnddTU8iuuQO3PH5ESGqPdkIBhT4x1/xMcUR3y7mkiZ6BdYvUg/F4039
         WA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=K4z6h/ZBrq50C0ovmsW4dSKeXLB4WwD8TYiSUyA2qdo=;
        b=j28MwGaWUeiVx5Kk4acfJFHBwsxwleC8VBKCGOhhw0CFYGEcvOa1HRvACpmvBWntXr
         uixDc/Hz/wChad5lXwQ1fr/8lJv8lQPk8S8QLvPlw/ElwNHwUTX7yf3enK3+5jNNbFU3
         KleCUGsg7b7aYweKEP6f1TWbYHvSVFXgwS7TkPNRL9/h1zYU+xfdYQzti+vLj4JgLY3I
         nbz4ccrSAJHrX5tyS4OVjlQD+l8KFZP6W82/QO7HzwmoA9Ki1ojdp25GGDCpJttM4P6C
         jdr7nlQmAPOHBfUBoGQCgsQ2EpYBr38XFfUegNVjtvuaqC5IT0+7Uvag1FKIjZkMY5d1
         N/Ug==
X-Gm-Message-State: AOAM531ckXncMFKykqNS9r4u6DooYviwxLkobShPqBseOoE8E2UpEXvN
        RKmf8Ahjss487QiDksJ8HrZSqrnOa4Hvx3AFOKUMuXtnbR+8dBPxPlln0tRhVaLfDrvBknJx0Wl
        wVQCRAIjp9X676leH23LgvqmIPVW0q4hHwsv9bnpBg71Ag+xCdLhZ8VGXAsJ+g82UGpIp9wMm0u
        1aCnF9
X-Google-Smtp-Source: ABdhPJy1Bm6BaLD7J26+u09kMWFFz+8WIXZI8sBIklgp04H76mKEP1vqFKEYHbpGk54JLdD/OwttkLTZSYlXHygv
X-Received: by 2002:a25:3754:: with SMTP id e81mr4501384yba.22.1597297325101;
 Wed, 12 Aug 2020 22:42:05 -0700 (PDT)
Date:   Thu, 13 Aug 2020 15:41:34 +1000
Message-Id: <20200813154020.1.Iaf7638a2f2a87ff68d85fcb8dec615e41340c97f@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH] rtc: cmos: initialize rtc time when reading alarm
From:   Victor Ding <victording@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Victor Ding <victording@google.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmos_read_alarm() may leave certain fields of a struct rtc_time
untouched; therefore, these fields contain garbage if not properly
initialized, leading to inconsistent values when converting into
time64_t.
This patch to set all fields of a struct rtc_time to -1 before calling
cmos_read_alarm().

Signed-off-by: Victor Ding <victording@google.com>
---

 drivers/rtc/rtc-cmos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index bcc96ab7793f..c99af567780d 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1006,6 +1006,7 @@ static int cmos_suspend(struct device *dev)
 			enable_irq_wake(cmos->irq);
 	}
 
+	memset(&cmos->saved_wkalrm.time, -1, sizeof(struct rtc_time));
 	cmos_read_alarm(dev, &cmos->saved_wkalrm);
 
 	dev_dbg(dev, "suspend%s, ctrl %02x\n",
@@ -1054,6 +1055,7 @@ static void cmos_check_wkalrm(struct device *dev)
 		return;
 	}
 
+	memset(&current_alarm.time, -1, sizeof(struct rtc_time));
 	cmos_read_alarm(dev, &current_alarm);
 	t_current_expires = rtc_tm_to_time64(&current_alarm.time);
 	t_saved_expires = rtc_tm_to_time64(&cmos->saved_wkalrm.time);
-- 
2.28.0.236.gb10cc79966-goog

