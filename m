Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87414C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577BD2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSlCNUui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgAXF65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 00:58:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39656 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgAXF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:58:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so572011pfs.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 21:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s14M+XVlZXNPHGbN9I1qTR9x7OXJoM3WgwZC4zMmQX4=;
        b=LSlCNUuiLm0Q1QXEfvl7GFVz6CzZhkqH5X2ehpZwkblHFqE0m9xqfBNhBSEQrUaT9L
         6gpNEOUq87xwcJeBHEIT47QdtYKkryNAJBokPtaq6OtfItz2Lxg9tboDcJ70a8JVru1X
         DtoPF0Ts+pS/QwMS63pswCCu+MSqqXF6dGHak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s14M+XVlZXNPHGbN9I1qTR9x7OXJoM3WgwZC4zMmQX4=;
        b=ICd30o8jxJWVQXgU13GORUl+R+b3MgbrF0G/o2IHn/UvGmTRwDhL1F3vIZ1gjYNtjV
         ZC2leobFKTi7GwL3PTr2ydwMg9bXCUQwBvYbJjErKHLOuQPkUyFvCHGva3/qmbiC4yh4
         gAIgu6/OxqzLUoqXE0XIgocrgLT4ateJsSgqSs0lW6MMbt0g6vKpWtvVwLNTq4YLVgJA
         B/xfT8n79V6JngWSSyN0dH2848X4aPYo9A6PsUlrtEJdUsBaZkEvrSowfH9fjDKIX6GD
         ThB23wlHbxvx3IS7G+g2NeIaUX2puCfVDP38XmFtdAhBFjNElMv9u3+1HGXx+YDaxDmP
         PPYA==
X-Gm-Message-State: APjAAAWVLNMK3kH81S7bUyjZUMgx7SxmgQDoa0+QvLDocpR8Njbqcqav
        MeeYsIW1mnvFp95tS5I4XY3OXw==
X-Google-Smtp-Source: APXvYqyQcigu26x8ehnXLJh/qHsisgaIEC5ibAxhcxMxShBiRVEShktY0k2vnAxWppEQMMsCovXNBQ==
X-Received: by 2002:a65:5242:: with SMTP id q2mr2247064pgp.74.1579845534111;
        Thu, 23 Jan 2020 21:58:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c184sm4701457pfa.39.2020.01.23.21.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 21:58:53 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 4/4] alarmtimer: Update alarmtimer_get_rtcdev() docs to reflect reality
Date:   Thu, 23 Jan 2020 21:58:49 -0800
Message-Id: <20200124055849.154411-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124055849.154411-1-swboyd@chromium.org>
References: <20200124055849.154411-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function doesn't do anything like this comment says when an RTC
device hasn't been chosen. It looks like we used to do something like
that before commit 8bc0dafb5cf3 ("alarmtimers: Rework RTC device
selection using class interface") but that's long gone now. Remove this
sentence to avoid confusing the reader.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 36124aea8d6f..2ffb466af77e 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -67,8 +67,6 @@ static DEFINE_SPINLOCK(rtcdev_lock);
  * alarmtimer_get_rtcdev - Return selected rtcdevice
  *
  * This function returns the rtc device to use for wakealarms.
- * If one has not already been chosen, it checks to see if a
- * functional rtc device is available.
  */
 struct rtc_device *alarmtimer_get_rtcdev(void)
 {
-- 
Sent by a computer, using git, on the internet

