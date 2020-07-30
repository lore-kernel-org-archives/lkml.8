Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA5EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BBF20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViS1JlQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgG3Uv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgG3Uv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:51:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66235C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a5so18878821ybh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G95KKuekTz1iA7Zr8ZdyT9EdDFTvRs8dYtvTVOv4Dfc=;
        b=ViS1JlQVeIZx1+sasiczEhUQiJqT9BJ3+cGlNfVvdmsU9R2mLheJZdbOTUgKPav/+p
         5pdrAapxvRSoKlz+chL0Gy18OCbJssl+aqaycS4dtpZekMdniwmfHSE28+u/htN+H2l+
         lzAV54E++V9VAVcItllAAJIR59b/yWJz3F+UzYTyFBu/N5BqHonoSRohu96fk/lK3LEL
         0FlD+6rYx6p5mrUR2jhCMNL3Mk/QYxpV5o//SYtwl8PLWXae6OWyWZcWxICKQUEdXgj8
         g1z85D6nN1NBUXBVWo8pSEl6use+HV+VDaOcghe11TQpqrFnYk0mdJa+xoPyhRvpSBPa
         46FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G95KKuekTz1iA7Zr8ZdyT9EdDFTvRs8dYtvTVOv4Dfc=;
        b=OaPxF2dvhPLnJBjM/TNZ9JOZdJKmIZ7rVqTOthT7ZhVQ89f0OvdDG9ofcTt1Qgj6Fu
         rVsbnrGfgUmE8lzX6jkNtuwjoBL6WN4CKIMgB5Mun0/rbWAkzqydf7TWcsB9PQiGZvpN
         BZQVbvhtcLPXqZl1MgC3X6N8r7/t5yR+vg7Gf9tLdIzdL4J2yIkoxqYYgRLxU0EawC4r
         bB0O3nMeTUg0ZVJ1H8SGxunC/pbp30nmujxAeLwK4Uai/0ktdosqhTpSnt5Zb4D7keyf
         bx+DvbEkCWyKTntieMqe62CLQeVtYUegt/0lC5sd7gEU/HqZreS953eO4u6wVeIrF4QQ
         fXzA==
X-Gm-Message-State: AOAM530+JGmsB0n8KR6lT2S6LUseAcwF+cfEbNRVPko/LXMMc/QCXxts
        CvtSh0g4OKrtfoLjo60S1t/v+h5ZEeMTdE31CXU=
X-Google-Smtp-Source: ABdhPJx9IM+NZ+Dy+UO1H89OWuA1mQwu+ABN06cb8h6aN7Xpr4/KTHo0SHpRsO8t4uShHvxZa2ijHx26yaXliUNcOww=
X-Received: by 2002:a25:40cb:: with SMTP id n194mr1171359yba.380.1596142286622;
 Thu, 30 Jul 2020 13:51:26 -0700 (PDT)
Date:   Thu, 30 Jul 2020 13:51:09 -0700
In-Reply-To: <20200730205112.2099429-1-ndesaulniers@google.com>
Message-Id: <20200730205112.2099429-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200730205112.2099429-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 1/4] ARM: backtrace-clang: check for NULL lr
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Nathan Huckleberry <nhuck15@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        clang-built-linux@googlegroups.com,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Lvqiang Huang <lvqiang.huang@unisoc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miles Chen <miles.chen@mediatek.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the link register was zeroed out, do not attempt to use it for
address calculations for which there are currently no fixup handlers,
which can lead to a panic during unwind. Since panicking triggers
another unwind, this can lead to an infinite loop.  If this occurs
during start_kernel(), this can prevent a kernel from booting.

commit 59b6359dd92d ("ARM: 8702/1: head-common.S: Clear lr before jumping to start_kernel()")
intentionally zeros out the link register in __mmap_switched which tail
calls into start kernel. Test for this condition so that we can stop
unwinding when initiated within start_kernel() correctly.

Cc: stable@vger.kernel.org
Fixes: commit 6dc5fd93b2f1 ("ARM: 8900/1: UNWINDER_FRAME_POINTER implementation for Clang")
Reported-by: Miles Chen <miles.chen@mediatek.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/lib/backtrace-clang.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
index 6174c45f53a5..5388ac664c12 100644
--- a/arch/arm/lib/backtrace-clang.S
+++ b/arch/arm/lib/backtrace-clang.S
@@ -144,6 +144,8 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
  */
 1003:		ldr	sv_lr, [sv_fp, #4]	@ get saved lr from next frame
 
+		tst	sv_lr, #0		@ If there's no previous lr,
+		beq	finished_setup		@ we're done.
 		ldr	r0, [sv_lr, #-4]	@ get call instruction
 		ldr	r3, .Lopcode+4
 		and	r2, r3, r0		@ is this a bl call
-- 
2.28.0.163.g6104cc2f0b6-goog

