Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E16C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AF3208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmEOGUp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392102AbgFSRWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFSRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:22:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB6DC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:22:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b201so4720849pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykiyUBcX7lv0L02KjGOJYnNL284qndFCqddofaXQGhM=;
        b=DmEOGUp1l+mc7oLgPAXP4ow/v0iL4q0vdktF7FaO72WHHr9IDU5NxrUPIZd1+bBjQf
         dTDBpj+Cj4cBSkhUk7QUcY8PiwNUGbwAiyzcrvmCx1xZyGh+cFhjM+SdP8MVlcLF8J7a
         9sgawsqVdZbX0Hk/k7LGLjbVW+EBsgPNFBotTxqTlrec/SPIDY8+Ifaf8yWhtYCf1D1P
         0qDb4hKEMpas+WUtQAPqJ5XJ4DfMKCdkhlqoMdHWfuPZzmp8m3rosi5qX5P+y679FWpx
         6nbpayxmPnUOyqwTgSzoFgqJmyiSyKEhVkedqgBtMwQRpyYFYuNXwFytIyaFl5jZGziY
         wYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykiyUBcX7lv0L02KjGOJYnNL284qndFCqddofaXQGhM=;
        b=BqQaa4fTEiNuYr8XYdjmbYt36xO0+XeVwp8E5sVeRdvfD/7g0WaCY9zmxB+OwP7pFt
         w2GFFDCclR8DrhpjcmqhmBU4eJ9U+5T/6jLR0eRIChT1N66riAs0BNLCcY+prOwB34fn
         nKAg2iWnaK23PGIu6oriyPi9x5W62meZdcJdHN/mqJU52FX80++734XFZaBAd/O3ar9s
         q937gZU+qLsXmIM9FQ4nLBSRCbUnWATJICML0CTNP74lWnDwb9CSCzGfolEXXPvDkAx6
         plLskYVTIwJ55fK15ER/TaM8UBewLHM+LzFbZaI9zzdYXYLhsqYoHBZMyVfrdFlICXlP
         wLBQ==
X-Gm-Message-State: AOAM531UNwqCKSfOLLTRhcwFiMZaP+uX/O/rIAED5d4zTTIXp8kbXzkL
        qeVey0ErxdGyZfT9HlGTogg=
X-Google-Smtp-Source: ABdhPJzICZfJ745drSzqyE/YfQ9U/bajMnz4wLScZa8TtChqLw3rST0e2UrE+D0qFU8EPbXoOgTKbQ==
X-Received: by 2002:a62:5e83:: with SMTP id s125mr8468465pfb.315.1592587367772;
        Fri, 19 Jun 2020 10:22:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id t201sm6426048pfc.104.2020.06.19.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 10:22:47 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] hvc: unify console setup naming
Date:   Sat, 20 Jun 2020 02:22:40 +0900
Message-Id: <20200619172240.754910-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 'common' foo_console_setup() naming scheme. There are 71
foo_console_setup() callbacks and only one foo_setup_console().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
---
 drivers/tty/hvc/hvc_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 5ef08905fe05..2a0e51a20e34 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -603,7 +603,7 @@ static void xen_hvm_early_write(uint32_t vtermno, const char *str, int len) { }
 #endif
 
 #ifdef CONFIG_EARLY_PRINTK
-static int __init xenboot_setup_console(struct console *console, char *string)
+static int __init xenboot_console_setup(struct console *console, char *string)
 {
 	static struct xencons_info xenboot;
 
@@ -647,7 +647,7 @@ static void xenboot_write_console(struct console *console, const char *string,
 struct console xenboot_console = {
 	.name		= "xenboot",
 	.write		= xenboot_write_console,
-	.setup		= xenboot_setup_console,
+	.setup		= xenboot_console_setup,
 	.flags		= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
 	.index		= -1,
 };
-- 
2.27.0

