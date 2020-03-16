Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFAC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AFE2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JVA3g1yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgCPOl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:41:59 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53009 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbgCPOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:58 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so1480476pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9R5XSTLVZnVSKo/0XfK6tXbSB33SVkOVSFtlvO7+58=;
        b=JVA3g1yvmXAbwUG5G/mZ9MS4EZ2IDxpKCNFP4zMteYa2bM31Fi7foXgy2zn7U/plFb
         hbmVYdMksbxu1IcdHNwv7cN9hxMgw8remZj0VSQAcyznP5ga+nzXy6B6n1LEBfa/iKPk
         WcC44w2DAl7fQz2h6wkL6ap2QvsWQEKDflen7A0odk3dHqr6AhGDoSrijiJwz4YMfcCz
         BWgA4XngKVPOOAj2kwHw4KZY3L4f/u38YbK8oEkjbavNbUwjHy+YBw5Q2cDXkvVJfEsm
         CkSdhNcVXkN9B7psPS6hkBT2lc3AAUEFjZ8D/BARlOfJ2kYqaoxdK9Jye9edr3jUbb4I
         8sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9R5XSTLVZnVSKo/0XfK6tXbSB33SVkOVSFtlvO7+58=;
        b=lcSdeo2PYQQnZckSopnN4HRfg0iw5NG66oI5PetBJIjGwPHcFZPvuJngJgw6QVN2D/
         0wysQ8Yo30JnCQd2fXlpGYiVrpM7YI0SJQBBQ9WAwlh0oi9bQj5mmZW5Fz4Qlqc3/Poa
         aZOm1Ctw+6AwP/BfOb4sTXyzJ3aDJyR6ypjXuQs5trejwqOv4MduhN4XPWPc3JIs4DvS
         YVQp+VXWG+F+nIU+uevh7NsJw86cZGLyOnOVAF9kgg8Ut0jYXZvQJk1LjJ4sJsy2HH8j
         bWjKheDh2f6uD2Ztx+uHmRGWw9rnVpa6CFXY0Csdrg4E1A0TjixU7M0+yNZcKLBVwrKP
         qYSw==
X-Gm-Message-State: ANhLgQ0UMb6tQTIq2ociW3AZL2knE+S/xGbGuNbyDrstWywhLm3akM4b
        7zEbzteteHazyIrmGwlCDdNJO+tWx+nfEA==
X-Google-Smtp-Source: ADFU+vv9VT3Lzq9azzLTj30SKf4UnURL+HmYI2WwnZrLhXI11EpIWnehawyvpiMFoeYIjgAwqWRsow==
X-Received: by 2002:a17:90a:8b08:: with SMTP id y8mr25579391pjn.87.1584369717336;
        Mon, 16 Mar 2020 07:41:57 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:56 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCHv2 30/50] sh: Remove needless printk()
Date:   Mon, 16 Mar 2020 14:38:56 +0000
Message-Id: <20200316143916.195608-31-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently `data' is always an empty line "".
No need for additional printk() call.

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/kernel/dumpstack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 6784b914fba0..2c1a78e5776b 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -118,7 +118,6 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk("%s", (char *)data);
 	printk_address(addr, reliable);
 }
 
-- 
2.25.1

