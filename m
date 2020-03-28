Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33405C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D60206F1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx6haa/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgC1Asi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:48:38 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37701 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgC1Ash (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:48:37 -0400
Received: by mail-pg1-f201.google.com with SMTP id q15so9370408pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 17:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V3RVGKTnvULr71PCJzOr4oAgJDqzxAQ7cIFBHDK9MJM=;
        b=Mx6haa/hAO4e0oi0GGgxjpzV/GRHVOwGpOMYS1XF8EuajtvI0NN1+dIk9104v6xkjh
         HPueHCTMl8QbVElLapdVxtS6VpqLy/TKpJdZT/s6T1EtOUn1ARdsGxKTWbHxslm/UKWu
         +JUzujVKNeMRd/eJk1asK2FW2jz3/XQsT19FZ9ACXJwyH9zjuuhyIno4OgzG+nrYmz3R
         vjvmRfoViTj/CDWRdHpQtHbqoBhDz2IG41j8ZJi+nJ+2rIr+svPu9IID0XlZyewrgR/y
         TiNQsew9FLtQfeploC1KNulgyQm/Vfzt6eA5oZwzA+99L5kzk7AF0dezebLq2+joruyn
         ByNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V3RVGKTnvULr71PCJzOr4oAgJDqzxAQ7cIFBHDK9MJM=;
        b=pp7rFV9CkdJaPv+eaHQdGNW/2FO2C+N3TQ/R6C0qwg6tKgJbsiKFXfPZos3qwGgiDF
         dWCLIlC+1D8AlhMJWgUN3SqOqRjPHS12p9X1+4uXpfUBFTdQhZxp1KIFNfWiVMsjulHI
         Y7A+CFgVYEaf7FwB+PVx7xYgw7a8t6pVTtFPeEhUdSQDib6MzbLkVmFWBOdv7voEzUR0
         92y/vNF/TDh6eNaDKT3DCkKTVN5jJxtIKuEYJYfhzLnhOX3/SOTxwXmBnvi6EpN6GZDW
         GOQSJ4tn8RtnhABXsZc0975ckRcViqNMxi/BGlp56SxnrCkLE1X4acw7zzjP6vqMr4Vm
         YquQ==
X-Gm-Message-State: ANhLgQ33VlGG+4igkTJS+0H31XLzvPBhgLBODYAlhKwe+UPqOzuvZsgV
        /lCyXbFf1jLPp36xVIsb5mgPALl5Oq3Y
X-Google-Smtp-Source: ADFU+vurKcOW8+PhGxANI+fEe0oKAeuHWov8ylyFM57xjXLJZDBKI3luDy6eTR3HW5QK4gitzcBP2hIMyl1p
X-Received: by 2002:a17:90a:4d43:: with SMTP id l3mr2074720pjh.165.1585356516664;
 Fri, 27 Mar 2020 17:48:36 -0700 (PDT)
Date:   Fri, 27 Mar 2020 17:48:32 -0700
Message-Id: <20200328004832.107247-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH] Input: input-event-codes.h: Update the deprecated license
From:   Rajat Jain <rajatja@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From https://spdx.org/licenses/

"Release 3.0 replaced previous Identifiers for GNU licenses with more
explicit Identifiers to reflect the "this version only" or "any later
version" option specific to those licenses. As such, the previously used
Identifiers for those licenses are deprecated as of v3.0."

Replace the
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
with
/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 include/uapi/linux/input-event-codes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 6923dc7e02982..b6a835d378263 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * Input event codes
  *
-- 
2.26.0.rc2.310.g2932bb562d-goog

