Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF9C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D272145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlMzfBoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgEGSKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728469AbgEGSKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:10:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0DC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:10:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g17so8061086ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N7kuzoZFHLJw/s8kvulTGF06U3TOQxKeXMcbVwjE4XY=;
        b=IlMzfBoiBzByCTT8SvOpeFbpTRaCvxNWjvMZljPGk5OoeTwjsb1wsaeDG4gxHKaVQZ
         lzdyVKLAOhNQTDY9GjBd/yhOypV8xr6JkGrIdiIkOmuHYIEXWQlMLj/DbmLtNbgfFD9Q
         SCG7OJOOpIk03XjGXpiKFMyfX8aoQ3Xrqx3iegD2s+PpWCE+7K6lsm/S9bpA6HqJbgaR
         jMeJZirp1krHSjr5CW2MkZm66dBPji19T3oVp8Np6ywJUg8EpRdIfa2xNK2By97AoJkF
         MC053TSntRx44lPdMaRbtpYv7DwCxcWdZbSZKNuXslPDRHTEvdqxBA1WsqkBobm/WIUG
         gRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N7kuzoZFHLJw/s8kvulTGF06U3TOQxKeXMcbVwjE4XY=;
        b=ntXmeswxFCiDcCuyqEI9fQn9c5Ap89RbpUHNDDoF6QzeCUAKMhjpjjs2ibKicXEzfv
         oscYZheaFjuTKV0UQYAztiSrK702XISNcCnebUYAjRHxBmfQlJ+E6Cv7rsUcpFYQz8X5
         0EcWs1bIYQ82dsE5km7S+SI8Zcq8BGVBsk5xdLGgXFj3PE5dW07c6x9KvGqd35fnty4D
         hMR6H3rZVTP1Q3Mr9W24VuCP0IMo5x1rvj8qXeHTGz63vnVr4herRrgL91TQBMbCChLt
         YQObD3HXsfptTGzEvT4H8mUdLocdGqvJPR19GNddAtsLb8IsA1Ub/IbafcHoHwdz+7+d
         4r6g==
X-Gm-Message-State: AGi0PuZizvPzJoOsaWgyoQMmFYPhhSYCzNkufePgvmJyL452L3yOwqQm
        sLULsD0TVh60B35vcVCvHHoUPHIZZV2WmRTAkBkz/HFIZTUe+3rjvMxnL0L5+4X0XzDkygHnvFl
        h9d3wuTjze0xS7+zIPdoI/MkA4fGHNb5j6AZWpKavsW6XNVDj1biF/Z4FLpzWuqYWBVG73BxA
X-Google-Smtp-Source: APiQypJcn3oiy3Y8e0vbxO3XAex1LsJMYs5+fQTWEg+rN6GSDT89BK+2wbCqxMf6Oy2xk1QtZGIOh5nUJOcy
X-Received: by 2002:a25:d2d8:: with SMTP id j207mr16831345ybg.517.1588875040927;
 Thu, 07 May 2020 11:10:40 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:10 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-13-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 12/14] x86: Export arch_scale_freq_key
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be needed by schedutil once modularized, export it.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/x86/kernel/smpboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8c89e4d9ad28..a8ccd69ba5ff 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1804,6 +1804,7 @@ void native_play_dead(void)
  */
 
 DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
+EXPORT_SYMBOL_GPL(arch_scale_freq_key);
 
 static DEFINE_PER_CPU(u64, arch_prev_aperf);
 static DEFINE_PER_CPU(u64, arch_prev_mperf);
-- 
2.26.2.526.g744177e7f7-goog

