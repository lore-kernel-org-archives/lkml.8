Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E205C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448A520731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQsMGlpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgELVsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731171AbgELVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:48:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC32C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:48:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so12514196qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgpxXurEcy9zZtLcodFISaUMHDUu4yvx13d5eZk7VhE=;
        b=qQsMGlpxbjrua6TZPluaYWlJ0vC0Gut7ZDPZk+tR7FRTEV1pu6b36VlouDfqdyGdo5
         pgyqfrupoXbujMOF5KCyMqw2EyNFdaol7rULyQS50DzMxXn8JTJRe8bgVPoIa/jyh0lI
         5wiOjf3TmDVXGeW34jsFHWYXeccZ2NjASZYNTfNP49fGe/XEdhdSekdIexOQ9RXYV+XW
         6KzSGY9InBMx/onm3lpFUTEUIjeT14ACLw0gsg7tc76IMOh+rJnu+KJuBDExFO8LR0wG
         of2M6PRFbpcLx4rMufuHw5+L+HBoBUcrJk5HmCu6h6dYZAKxn5GEvmYnzeYFDhzYaGUC
         SOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgpxXurEcy9zZtLcodFISaUMHDUu4yvx13d5eZk7VhE=;
        b=HmKVq6qigW9iwnMasoo7uoettgNVLUaSl8UT2VduqQKvw7WpwHRIDvkvJ4U53RQYzM
         WjvsDuYg5vs/EIcTkAB6D0U1KPTh6p+YBLXk1B1Nl8kkkY//YHsF4czEGseJwk/XbzcW
         C3YeVrggc7OlBqvTc74WKXL/O+E1G9tig0stES+IT/fY8EWr+n5icYOfsqRYKVR+1t+6
         2Co1ljgN8Y6DcH7/mVzX68bzWXNsNbTYlKY6RgpJTs8zEp/O5fW5MYn3AXX0Rb0mRjHZ
         oWHeRDYyzUf2hbV2g83zzhiSHKtCpvKHUxgyS18vztrsL1YDh8TfxmSh4u2GOqyVWnIC
         3dOw==
X-Gm-Message-State: AOAM532XDeTdskW2BMbNXgtbnLF7irEJ+xTJ1UBR3NJ/8qeYAcxdIFNI
        TwLWBaTjp7jp4hcQHGxLj5w=
X-Google-Smtp-Source: ABdhPJz+pO2glId38WZUN+1XOagFJOgZwVOZnE0/nwZz7kCir7nYtmKwi1rdCbWjp93JNGygefHeQg==
X-Received: by 2002:ac8:7947:: with SMTP id r7mr1467325qtt.180.1589320084128;
        Tue, 12 May 2020 14:48:04 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id d57sm700550qta.51.2020.05.12.14.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:48:03 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] powerpc/crash: Use NMI context for printk when starting to crash
Date:   Tue, 12 May 2020 18:45:35 -0300
Message-Id: <20200512214533.93878-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if printk lock (logbuf_lock) is held by other thread during
crash, there is a chance of deadlocking the crash on next printk, and
blocking a possibly desired kdump.

At the start of default_machine_crash_shutdown, make printk enter
NMI context, as it will use per-cpu buffers to store the message,
and avoid locking logbuf_lock.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Leonardo Bras <leobras.c@gmail.com>

---
Changes since v1:
- Added in-code comment explaining the need of context change
- Function moved to the start of default_machine_crash_shutdown,
  to avoid locking any printk on crashing routine.
- Title was 'Use NMI context for printk after crashing other CPUs'

---
 arch/powerpc/kexec/crash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index d488311efab1..c9a889880214 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -311,6 +311,9 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	unsigned int i;
 	int (*old_handler)(struct pt_regs *regs);
 
+	/* Avoid hardlocking with irresponsive CPU holding logbuf_lock */
+	printk_nmi_enter();
+
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
-- 
2.25.4

