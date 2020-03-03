Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42778C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B12083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5Mi9+vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgCCKyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:54:46 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:47511 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgCCKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:54:44 -0500
Received: by mail-vk1-f201.google.com with SMTP id n9so703859vkc.14
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/fUO4e7b7II/MsvOBnOdt5EEHTfTyNf7SrxUHQx+fwc=;
        b=l5Mi9+vx+ZJO9M1WC5+61AAmmM3bp8Hw0a0CsKTUOo4/BhrrHMMpdnTDGd35WOIoej
         QpsWGl9aw9tJsYgQOw04/Z9bnNHkovUELDhttcfPFhGBvC6iBJalLhqVyJFkeKs45xWa
         3T0T/pVrmZEqKz4kuSpy7pxarGbGaIT3TgD53WaL0tIn070kmeYO2yjtsb/BGtlydCKk
         g6IC5WEYKKSYPk0BKt7qEn+lW4ID+9e35uIm8TelABBEzMveIDgaw+4LQaG41s0uFWQA
         6YOxiMOEVtVjmJIKCq8O8T9Lb4Z+veIEj1KiEeuUno3g8jueaMa63c2hnLOtxTbZSGtu
         548A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/fUO4e7b7II/MsvOBnOdt5EEHTfTyNf7SrxUHQx+fwc=;
        b=jLIYfSsRxSZUteGxddaweP1BkXgkjmsiyTQNA5onJ2u7Yolf0qCL2bZlSMdVkfi8g0
         HTY4vdukVCrQio1CSdZMD1lGMRE+pXXEhgIVc4HE5p7SaCfUS+ZgC+SH9LjPYgzZtaCL
         LU3CO3Es2nUNi1MoyGFuvNXBAHMiGsjBOP9HJePNCGvajowgMyznfmCbFHDqyHQvofHe
         acwK4DOBETtKukffArjlxJzjse9oQ6540nmIr8GwDDovrDpgMB9acMJZbS7TE5jiPgSd
         Ln3UoUV2sbR3KImlgGrw1CAk6u4U0EAwrxs/27G5oZfsVMx9uKO+KZ+bY0xXUaKUowrr
         Hx+g==
X-Gm-Message-State: ANhLgQ2YtzOSV6EcWaMCkjDWo9OMMzwmCzHRhNuCa5PXUpp6G3mvDkpW
        mf0mkADSBCeppyhsKlzHFT+tpUrfMw==
X-Google-Smtp-Source: ADFU+vvIpWaP146aRYIyU9FS4IRKrhW9VgsfBVun9hsWpgp12WBLpb9FBbP5XWgwahVSg+rt0tJYayCPeQ==
X-Received: by 2002:a1f:a286:: with SMTP id l128mr2460260vke.31.1583232882861;
 Tue, 03 Mar 2020 02:54:42 -0800 (PST)
Date:   Tue,  3 Mar 2020 11:54:27 +0100
Message-Id: <20200303105427.260620-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] lib/refcount: Document interaction with PID_MAX_LIMIT
From:   Jann Horn <jannh@google.com>
To:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the circumstances under which refcount_t's saturation mechanism
works deterministically.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v2:
     - write down the math (Kees)

 include/linux/refcount.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0ac50cf62d062..0e3ee25eb156a 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -38,11 +38,24 @@
  * atomic operations, then the count will continue to edge closer to 0. If it
  * reaches a value of 1 before /any/ of the threads reset it to the saturated
  * value, then a concurrent refcount_dec_and_test() may erroneously free the
- * underlying object. Given the precise timing details involved with the
- * round-robin scheduling of each thread manipulating the refcount and the need
- * to hit the race multiple times in succession, there doesn't appear to be a
- * practical avenue of attack even if using refcount_add() operations with
- * larger increments.
+ * underlying object.
+ * Linux limits the maximum number of tasks to PID_MAX_LIMIT, which is currently
+ * 0x400000 (and can't easily be raised in the future beyond FUTEX_TID_MASK).
+ * With the current PID limit, if no batched refcounting operations are used and
+ * the attacker can't repeatedly trigger kernel oopses in the middle of refcount
+ * operations, this makes it impossible for a saturated refcount to leave the
+ * saturation range, even if it is possible for multiple uses of the same
+ * refcount to nest in the context of a single task:
+ *
+ *     (UINT_MAX+1-REFCOUNT_SATURATED) / PID_MAX_LIMIT =
+ *     0x40000000 / 0x400000 = 0x100 = 256
+ *
+ * If hundreds of references are added/removed with a single refcounting
+ * operation, it may potentially be possible to leave the saturation range; but
+ * given the precise timing details involved with the round-robin scheduling of
+ * each thread manipulating the refcount and the need to hit the race multiple
+ * times in succession, there doesn't appear to be a practical avenue of attack
+ * even if using refcount_add() operations with larger increments.
  *
  * Memory ordering
  * ===============

base-commit: 98d54f81e36ba3bf92172791eba5ca5bd813989b
-- 
2.25.0.265.gbab2e86ba0-goog

