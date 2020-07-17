Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27E9C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE5220704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZaHFTWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGQS55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgGQS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A019C0619D2;
        Fri, 17 Jul 2020 11:57:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so8432600qtg.4;
        Fri, 17 Jul 2020 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6fuGIKhuqHXLGaeDFzGZEA59rs5APu4eLSvG3ckX1I=;
        b=qZaHFTWlvx//0vt1MQgdGAjFKJvtWf8tLqNtECwjNMgTGxiRyc6V+MMT+t9TMQp3ah
         WzJC67QML9b9lLb0BVwDlB8/fSJYdxxlcJuNKHl1JupwqLLwoK1LATwdAVjpYYoJo+DM
         Be9Djd+E4vxuZhia/BvUW+wMusRWMLgB5I9NbpJWVyMyqr8IyAQhyUa7lzpInB1kEKc9
         zhe4Sw3uFd5K+fIxMSDKDHyeLluJsguIn3KMCYamQjuE+W+6YxdJgUP5NWJh+79Pt6zX
         /B62hj4fQf+vNLfMnrFuub/eXS83IAUNYCHsvUhrHSEm+nES13GahnReHocNYag0v9Bj
         Jn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6fuGIKhuqHXLGaeDFzGZEA59rs5APu4eLSvG3ckX1I=;
        b=QFgDplXCSuP/Vpmub8TD7sCrbJwkLL+JvvaD/GQqoYCJLLnfhHT9siWILgYrZM5Fia
         FCL8cf195FjQnF6Uv9E+lALDqC59Uq+83At0Q88tWTvB4ZaKZ4LjSFbhNic1M15vmwmU
         tmit+mfVSCo28nl3uRwcWGpUYhTHFReMYTtV4XUiqi/oBNcCwyib4Q7AhEbUnzj3hRbv
         fUqwVkZtnYyzWG1u8KxHhWAd0YBo/dmRacdX3yDrVPVBAzubRWMqACJwMf7Cxc27utbh
         EmOpYUHfErtLZEfqP3p8A1mciv3OB1q1SsZqN8jol/qUecgr4zhy0viRbiJvlXRdWFc5
         yT3w==
X-Gm-Message-State: AOAM5333E4E95THWCkYpI4VR1hOfdQyiKWTVPGFCN0zVB5TLEMibrU7e
        3XVmgpvpuNrH4BfBnUv0ChM=
X-Google-Smtp-Source: ABdhPJw2ycV/H3gw9KlaZUhsFu0KRBkqGCWEnI9A1HOlzt+fLnX6SwuO39vJhiG3OkDRuXoGtAGfpw==
X-Received: by 2002:ac8:4419:: with SMTP id j25mr12574207qtn.0.1595012275507;
        Fri, 17 Jul 2020 11:57:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:54 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] Documentation/bpf/ringbuf.rst: fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:17 -0300
Message-Id: <20200717185624.2009393-18-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warnings:

ringbuf.rst:197: WARNING: Unknown target name: "bench_ringbuf.c"

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/bpf/ringbuf.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rst
index 75f943f0009df..8e7c15a927740 100644
--- a/Documentation/bpf/ringbuf.rst
+++ b/Documentation/bpf/ringbuf.rst
@@ -200,10 +200,13 @@ a self-pacing notifications of new data being availability.
 being available after commit only if consumer has already caught up right up to
 the record being committed. If not, consumer still has to catch up and thus
 will see new data anyways without needing an extra poll notification.
-Benchmarks (see tools/testing/selftests/bpf/benchs/bench_ringbuf.c_) show that
+Benchmarks (see `tools/testing/selftests/bpf/benchs/bench_ringbufs.c`_) show that
 this allows to achieve a very high throughput without having to resort to
 tricks like "notify only every Nth sample", which are necessary with perf
 buffer. For extreme cases, when BPF program wants more manual control of
 notifications, commit/discard/output helpers accept ``BPF_RB_NO_WAKEUP`` and
 ``BPF_RB_FORCE_WAKEUP`` flags, which give full control over notifications of
 data availability, but require extra caution and diligence in using this API.
+
+.. Links
+.. _tools/testing/selftests/bpf/benchs/bench_ringbufs.c: benchs/bench_ringbufs.c
\ No newline at end of file
-- 
2.27.0

