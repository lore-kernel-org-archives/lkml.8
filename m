Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54141C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB8320CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bk5lQ9TU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgDTRXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:23:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C170EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:23:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so5244241pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XXVLktK/UeGFcT3gwQksKKEaPZIHVAf5aFv7rQFH3AM=;
        b=bk5lQ9TUQkIs47azp59FxV0N8vgP4mfxRkkBfTfj3kPRVAw2aZZPHb4NE9/LsKGcc9
         3ozygmq5UGea+fq/TZtYPomYsnfcs0dDbC3ENnt57hNmb7oIltLa0oQdqLBMGnrUGApv
         y4TnO/Ffb3Cgv8eh2QaGgusI2H9P6P3pQHcDykT+7iZx3cWvs6LIOfEFiRRTj52hcBh7
         mh+WFQuJE6IWGD2BFvK3aJKUwpu8gbyapiy5TS0iCyOjCr+5HuyVnMnio4W0i/6QPd45
         x6eo0MR9thj0z7KVRMLQbC29y4LIo6TMRsJQ+XTmTtE5aeJNKmsSLHgoNXKgDAl6VYOe
         3nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XXVLktK/UeGFcT3gwQksKKEaPZIHVAf5aFv7rQFH3AM=;
        b=XlF1OGw0bq6cRaO/d3ChtJmQs4BouESARyYgL8Mr7irU22j7ESztYOl8e2RvKIiRGH
         t7r/GL7Wz+xC5wh64PDwuWxNalNV2gVE5GyJCtx8wu76YSOemiwLO/wIPUF0NvKISvnK
         547uRVMXCD4TqAFeUBA8/mE2GcESrbDJxbGKpm3J6ApsGso5AcUm0pXePo/LX/QMzT8B
         zDH9tIRM1UfW/Lx9L/MQrLIqC+bOcpCnGrTUPscSl/r3WRwOzA64A/2rQ2L4D0n+nhSs
         D2zFFoC+hgfkrWQmqub45pgqcONdV/RN2s70J6vNeh4hcAeq0PxoI0MqhEs4a0vxZyMY
         4iEA==
X-Gm-Message-State: AGi0Pub6Gr2AwruJRHpF2NI0NxxoIbBkx1Y/W+1K+huu2hHx0vuXqmxA
        Gb64A/cIc2oJ0AndnAR33TUxKaso8qUDrw==
X-Google-Smtp-Source: APiQypJKE71xdtI4S20YUZ/KAEkB0Wn/iGi0LNM2fcpNfG+TOdEsD1jDdP0UqPEJOQJbevBrsn8ftQ==
X-Received: by 2002:a62:1c97:: with SMTP id c145mr10917987pfc.68.1587403401857;
        Mon, 20 Apr 2020 10:23:21 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r23sm68280pfr.64.2020.04.20.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:23:21 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] tty/sysrq: Export sysrq_mask(), sysrq_toggle_support()
Date:   Mon, 20 Apr 2020 18:23:17 +0100
Message-Id: <20200420172317.599611-1-dima@arista.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build fix for serial_core being module:
  ERROR: modpost: "sysrq_toggle_support" [drivers/tty/serial/serial_core.ko] undefined!
  ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!

Fixes: eaee41727e6d ("sysctl/sysrq: Remove __sysrq_enabled copy")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
v2: Also export sysrq_toggle_support()

 drivers/tty/sysrq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 5e0d0813da55..0dc3878794fd 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -74,6 +74,7 @@ int sysrq_mask(void)
 		return 1;
 	return sysrq_enabled;
 }
+EXPORT_SYMBOL_GPL(sysrq_mask);
 
 /*
  * A value of 1 means 'all', other nonzero values are an op mask:
@@ -1058,6 +1059,7 @@ int sysrq_toggle_support(int enable_mask)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sysrq_toggle_support);
 
 static int __sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_op_p,
                                 struct sysrq_key_op *remove_op_p)
-- 
2.26.0

