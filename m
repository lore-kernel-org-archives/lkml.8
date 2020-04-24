Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D9EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0DA20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgDXIxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:53:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42814 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDXIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:53:50 -0400
Received: from 1.general.ppisati.uk.vpn ([10.172.193.134] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1jRu5j-0007TW-Fp; Fri, 24 Apr 2020 08:53:47 +0000
From:   Paolo Pisati <paolo.pisati@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sysrq: export sysrq_mask symbol
Date:   Fri, 24 Apr 2020 10:53:46 +0200
Message-Id: <20200424085347.40185-1-paolo.pisati@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit "68af431 serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE" breaks
the build if CONFIG_SERIAL_CORE=m:

...
ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
make: *** [Makefile:1331: modules] Error 2

Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
---
 drivers/tty/sysrq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 5e0d0813da55..cf49010335fd 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -74,6 +74,7 @@ int sysrq_mask(void)
 		return 1;
 	return sysrq_enabled;
 }
+EXPORT_SYMBOL(sysrq_mask);
 
 /*
  * A value of 1 means 'all', other nonzero values are an op mask:
-- 
2.25.1

