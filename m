Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DB820708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=incline.eu header.i=@incline.eu header.b="qtKBJ41x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgESNad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:30:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98730C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:30:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so11813786ejd.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=incline.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEMhfbxLJL6rLlCZ47d/1BZ4dX7nhYnz9Rioocq948Y=;
        b=qtKBJ41x1eSyUD28shYUh/C2cDHMO0K27JJTjNr05O/dfQwVqxz6wzn2pCcjJBHSzl
         mfPLtIdTT54CMjGqu6MS8lL4yiYywbLs0q0ijnB6tHzfmMd641p+jJH7KQDUJeZ0IF6y
         LU4J/1SNtPyo08JErha6rVSRVRo26xi9DjO2d1eZLVqeggH3V4U6JA/x92JDhuLaByXu
         3nx0rwzvGYulMkAlYVj8J//hF4X7SK78J2UFsDvBwhmfq6//4LSk/gliHV6c5K26Rypt
         JDFT6qVBlyAX/K6V75+2PpPxPBuRaQvJmCxRWsN3J48EFYWmQYI4Vib3PZ0uNB50w/XQ
         +sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEMhfbxLJL6rLlCZ47d/1BZ4dX7nhYnz9Rioocq948Y=;
        b=iexR7cEMX0JZQ2zPnetAd4LoY0RaukF4FUj9ixp/YRv2vaGR2MTWFNV73zTfDPS3ve
         sYFX7kOjw8hhp0h3q3hZwqNW8T+33MXmx9rkDvxl6eeubsRn5bBHtsfKzQMQo6N/aB9b
         GZcFi4724DCkJRwJrlXGVdP9l25duooySEUvS/9GJwsrppFWkzurHgUsb+qwqBnC39Rf
         IDcvZkMGPEbhQ4M4wrTVXpyVedjbGIl/yOdk0Regcc6t1rGCD40QlAktAlg4SdgFu4ZR
         BE22qneZPxwgB3qiSN3LK9OuMY+pkvZoz+JF3z39MlgnkUX3uVDDggn/+VKo19ToWmfU
         jiXg==
X-Gm-Message-State: AOAM532y/2e7btoQ6nMIiIi8cyySHbWUeKSsLlQ+iaalizUgSq3cUaFt
        lz9vvxFtt34dedrig/DWJBvTfw==
X-Google-Smtp-Source: ABdhPJx6jGz89iiW7ZTUSEdSnNX6Fz8y5eW/9ohfFZB2NUmCuHu6A13Bl5f2Eo4pa70nDKlt93AKJw==
X-Received: by 2002:a17:906:5004:: with SMTP id s4mr19656281ejj.13.1589895031319;
        Tue, 19 May 2020 06:30:31 -0700 (PDT)
Received: from sparrow.lan.incline.eu (ptr-7u1g92dm5ip8miek4t7.18120a2.ip6.access.telenet.be. [2a02:1811:51a:b600:ace:32fb:ad63:b5b])
        by smtp.gmail.com with ESMTPSA id 93sm1449443edj.39.2020.05.19.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 06:30:30 -0700 (PDT)
From:   Timo Beckers <timo@incline.eu>
Cc:     timo@incline.eu, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf core: apply calculated padding to PERF_SAMPLE_RAW output
Date:   Tue, 19 May 2020 15:26:16 +0200
Message-Id: <20200519132616.794171-1-timo@incline.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero the amount of padding bytes determined in perf_prepare_sample().
This prevents garbage being read from the ring buffer after it has wrapped
the page boundary at least once.

Signed-off-by: Timo Beckers <timo@incline.eu>
---
 kernel/events/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80cf996a7f19..d4e0b003ece0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6807,8 +6807,16 @@ void perf_output_sample(struct perf_output_handle *handle,
 					break;
 				frag = frag->next;
 			} while (1);
-			if (frag->pad)
-				__output_skip(handle, NULL, frag->pad);
+			/*
+			 * The padding value is determined in
+			 * perf_prepare_sample() and is not
+			 * expected to exceed u64.
+			 */
+			if (frag->pad) {
+				u64 zero = 0;
+
+				__output_copy(handle, &zero, frag->pad);
+			}
 		} else {
 			struct {
 				u32	size;
-- 
2.26.2

