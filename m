Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFBDC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4539222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srZcLMtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgCKMLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:11:30 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:33507 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgCKMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:11:30 -0400
Received: by mail-wr1-f74.google.com with SMTP id 31so899854wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Vk9xA5EcmXtoOxvvPNjA5YPkn56q5Oj+pHYxZl8t1uI=;
        b=srZcLMtt9vVF3JbnFL8sj4nAZKdBG16UWw6cBzZfZz4mYApLQnRv5c6TVvP1kMWKfc
         sAsaK1ivjyIubGfgWzc7vGxKb2fTzDfXNcYGhNToScXvhdl7zuRlNWM1F6G+NEzMrSno
         JtTo1Kh1V/RUoS/OYYK74LmiWJeC6f0MZaCTPQfM4cKYykfkxnMT8psI8MG9UIbbbHoY
         PoLF2lT7Ol7wJboStuPbE1l1U4T8fnP9SWrSaDDMa8cmlDHtro6VmSQS1PpYqzWng9EY
         i1TAnG8AAAgcDift/xUjNuCGPGrdkYKaDUYJsSmumOxUaeSs82xgs87eqgg4SPcIy0tw
         Sg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Vk9xA5EcmXtoOxvvPNjA5YPkn56q5Oj+pHYxZl8t1uI=;
        b=XQJD7aqn1Q6h8SgMFXwUqdj1w98bccI0/34EmvxSwy47xCxQ7WzyQoREboeRuCQftu
         LSGqTv4Yfzt9H3k3e7bDQD0BuWpt+XeYfOQndUAhyOYzL+Lqwrz1oXv3uZDfk4sqni7Y
         EI7bN5e1LWhVNWkHZGFp8mX35heps2OqFstMjxMblkUbgOeNV5/Im5O+8w49ADOkJIRm
         7qXIsthsN3dAAQhDIilnyFPrO9P/MxmKuLjj7GsEch+X1Hg/cy/TcZPqcy7nWDhwmyLM
         VI/IoHaztxiLaoRvtVsSAQvx4I0SirxcxTYOupsVEPY1WzcEoNzF6pYYUVmtBTB1sOGx
         9O5w==
X-Gm-Message-State: ANhLgQ2YZrufqL6zqz+Pnu8cRolUAIaT4zZDhow22t+AL53LLNE1Cek5
        KIHXE39bUwYdwFnYe7d2VGhln4m4x80=
X-Google-Smtp-Source: ADFU+vvUEtjz2aIDSC76T/yEApf3PLdhNxRvKwjnfi1Tc8+9kd7HgbzyTPX6pMzpOVxkw7PdiGpJLj37XiI=
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr149301wrx.339.1583928688111;
 Wed, 11 Mar 2020 05:11:28 -0700 (PDT)
Date:   Wed, 11 Mar 2020 13:11:24 +0100
Message-Id: <20200311121124.243352-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH 2/2] ia64: add IRQENTRY_TEXT and SOFTIRQENTRY_TEXT to linker script
From:   glider@google.com
To:     tony.luck@intel.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-ia64@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to fix linker errors caused by lib/stackdepot.c
referencing __{soft,}irqentry_text_{start,end}.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/ia64/kernel/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index 1ec6b703c5b4f..6b5652ee76f96 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -54,6 +54,8 @@ SECTIONS {
 		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
 		*(.gnu.linkonce.t*)
 	}
 
-- 
2.25.1.481.gfbce0eb801-goog

