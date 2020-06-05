Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8C6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D6D2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aWCctjjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgFETqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgFETqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:46:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F5C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 12:46:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so10985303qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sV9RkPGuoOWTc48qekF0zZBZDrJUTh4v9fJ0jb/FVgM=;
        b=aWCctjjWnZUSMcT6Ms5TdcGkcFOgab7dXxSb6fkSyYq6HoBdb9Tvqx/v7JVtmCHCeF
         MA6WH5c97FrtUPsQzAeLJBrfPvcx6u4osY0pjoGT567icSJb6ngJWeDN7LzRNO/1k2v5
         lVZA3DRiOXdRRXzpiDkF9e5jdo2c6L2V6bYNbWDqzA7lSv1EM2pdWSsyIvrSk9txVkpI
         Dnj4hRMeKyJVF1EKUNckBjoZxlCyU0dOgDzdyuw8jviCmfSRh4nwwLiHWiznWHA/kj1W
         hSI47S5fsCnJyQsaVJzumAZ8BvZMNwtsZYlNmjcFBUSrv5xdDdLlOHPRdj4yYKO0YqOL
         R09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sV9RkPGuoOWTc48qekF0zZBZDrJUTh4v9fJ0jb/FVgM=;
        b=KeM8fs8RoirNxKu0fCwc8WO7fTFb3qyB48bZxFbgrbNfmqE2tfx5gXVXxYT/RDZE0Q
         3c++f3I3JnMebPVqGZPNwmIEtm1l4H2p2wy4M6ye3VzUBMWGMbVkYROITuedZUtLEqrh
         +rPvljPygcZRUD6YXeBMBF+hyaLKX6FfucK5GumnxIdNZXW3YmCdfRzAFnQ8xce1NIKp
         RBGYYFf/CEa70pTEQLxEYfX04zDEbG3a1xRb8OlmjfHjTDcEHMtu3C/G63p+n/P7gupF
         RArC42nNEZjgieEqwrcTwOBMClKFUHVN7o5Ul26kYJUZb+ATKwX9CWMVg3bYKrBPx97U
         YdGw==
X-Gm-Message-State: AOAM5335qNbUtG/QcsJ/cFMs12pnq8UZHTCXp1bf9yDyext245QmKJh+
        c31M2vtnf1aaq8JJHI4+TaZ2SA==
X-Google-Smtp-Source: ABdhPJx5xQ9+E/4OYaerdSWSqvwAq/MS3nCOPS274OfID5oocZYxDY8TZg4tLHhGPLbg46ow1XkNcw==
X-Received: by 2002:a05:620a:15e8:: with SMTP id p8mr11797085qkm.333.1591386404392;
        Fri, 05 Jun 2020 12:46:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p11sm716242qtb.4.2020.06.05.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 12:46:43 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        pmladek@suse.com, ebiederm@xmission.com, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: dump kmessage before machine_kexec
Date:   Fri,  5 Jun 2020 15:46:42 -0400
Message-Id: <20200605194642.62278-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
machine_restart(), machine_halt(), machine_power_off(), the only one that
is missing is  machine_kexec().

The dmesg output that it contains can be used to study the shutdown
performance of both kernel and systemd during kexec reboot.

Here is example of dmesg data collected after kexec:

root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
...
<6>[   70.914592] psci: CPU3 killed (polled 0 ms)
<5>[   70.915705] CPU4: shutdown
<6>[   70.916643] psci: CPU4 killed (polled 4 ms)
<5>[   70.917715] CPU5: shutdown
<6>[   70.918725] psci: CPU5 killed (polled 0 ms)
<5>[   70.919704] CPU6: shutdown
<6>[   70.920726] psci: CPU6 killed (polled 4 ms)
<5>[   70.921642] CPU7: shutdown
<6>[   70.922650] psci: CPU7 killed (polled 0 ms)

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..50027f759a97 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -37,6 +37,7 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/frame.h>
+#include <linux/kmsg_dump.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1181,6 +1182,7 @@ int kernel_kexec(void)
 		machine_shutdown();
 	}
 
+	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_kexec(kexec_image);
 
 #ifdef CONFIG_KEXEC_JUMP
-- 
2.25.1

