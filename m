Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF05C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5372020772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSRd6oqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHRTYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHRTYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:24:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E04C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:24:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d19so10198244pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=foGR0fGiwdN0rd86kHUK+hl2e5fXz3N4Jwx2Xbkyb0k=;
        b=vSRd6oqd2yNuGDNiXj92z2f1njZntPTkt8HP+/mp1t+kK6R4HgssuFX2lfgOb+qaT9
         11VbEC8URgbDXYPreKg0vFh4DyyzH0ZT0sjILFM9Tbq8uCnvYXiNR2SHweMrIpaZVYUZ
         YSkF26FDsRj1Rae4PkAxKAM1UGefGKxbfVuk4Rw/sp5hyPs4GCb2QnOWbRtYQrGgpYjA
         5J3kbQaqWKeW8GoZ/G176kPXThXKroznk6hsm8a/tRzgdlWUgS9huCCVuA+3skwdSTVX
         RVDnJ5HqmGmB640kh54mHHpgVCZA+SfJ09uVyOgzTJ+ap5ft1xL1GzaVZ/qiNEYNoPoW
         YT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=foGR0fGiwdN0rd86kHUK+hl2e5fXz3N4Jwx2Xbkyb0k=;
        b=nAwkous7Q8bz5ZVK19eDGatcX1vNluMob0HChBzpxgIjHcKN9h9iT3+7XqI86Kd9Ws
         CldpKITdE5fC1p4d/+0Ud+FffeWYO1DXfHRheJLmHUMNYRENFNWicKcmEvndxlZ3dno+
         F3XEZ0/wEruH+Hg+xBY47grON09hec6+iAnB/EAwXXJ2g2NKjSqPd5CA/A2wnmtSmJ5U
         c/xTrAKu1AJGp0/yM5K+XfW5UmqDuk3FIGNpWfC8rUVyY63nw8Nlt6CpB142L0x4SJbf
         0WLZO+BqGmKEp8wU7aVCMfTAuPCmvK4FO9BGfWLymtMt77USKQ2PEFgYHhIUcWqauV+p
         7Z2w==
X-Gm-Message-State: AOAM533nqxkki2tLagz+n5MhwSQyWm8DeTsDnYelyfd8zo+c0nnhaB+Z
        B1kb58mfy+MkuOs/4I16N64=
X-Google-Smtp-Source: ABdhPJzxBman+0zeaLFIwCX2uHveNUfs4U8JPfSIEnbeh/W/dw7TTGhDfVuPP1ZzYEzHzljQO6BT5w==
X-Received: by 2002:a63:955d:: with SMTP id t29mr14041544pgn.135.1597778693516;
        Tue, 18 Aug 2020 12:24:53 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.59])
        by smtp.gmail.com with ESMTPSA id h63sm647493pjb.29.2020.08.18.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:24:52 -0700 (PDT)
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: [PATCH V3] scripts: coccicheck: Change default value for parallelism
Date:   Wed, 19 Aug 2020 00:54:45 +0530
Message-Id: <20200818192445.24885-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, coccicheck utilizes all available threads to implement
parallelisation. However, when all available threads are used,
a decrease in performance is noted. The elapsed time is  minimum
when at most one thread per core is used.

For example, on benchmarking the semantic patch kfree.cocci for
usb/serial using hyperfine, the outputs obtained for J=5 and J=2
are 1.32 and 1.90 times faster than those for J=10 and J=9
respectively for two separate runs. For the larger drivers/staging
directory, minimium elapsed time is obtained for J=3 which is 1.86
times faster than that for J=12. The optimal J value does not
exceed 6 in any of the test runs. The benchmarks are run on a machine
with 6 cores, with 2 threads per core, i.e, 12 hyperthreads in all.

To improve performance, modify coccicheck to use at most only
one thread per core by default.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in V2:
	- Change commit message as suggested by Julia Lawall
Changes in V3:
	- Use J/2 as optimal value for machines with more
than 8 hyperthreads as well.
---
 scripts/coccicheck | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..a72aa6c037ff 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,13 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+		NPROC=$((NPROC/2))
+	fi
     else
         NPROC="$J"
     fi
-- 
2.17.1

