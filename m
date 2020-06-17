Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3484206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592382882;
	bh=EIauXrg49ZmAm0JHai4GmqFhLMfCh3dg+g4p8dynS7M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OS9mQTEowOkBUzuLKyavaTqL66xNfNhJy1fLrlpzyb54DY2a9KydLaBSLhCsYpfcY
	 /AMe8J71m1yba+zdHwbBX/BYaQMftBM2Pv4PyiDH2TdfybCayEfIspghTvdoJzZWag
	 ONrXb90Tc2IG9yyWW9+GNt9PeLndZTe6jCiOKOA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQIel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:34:41 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:49336 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgFQIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:34:41 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05H8XKSE019402;
        Wed, 17 Jun 2020 17:33:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05H8XKSE019402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592382803;
        bh=jxFO2dBK4jUmn4oHU8teM5VIUfsl2fZ2h2BFztlUs+g=;
        h=From:To:Cc:Subject:Date:From;
        b=lSfD59NFqJWikQNmKtodYStw8vK91H6BSc70wS+wnUlB1l3QlBziO46MlAxL98fSs
         8SgLwgbUO04lkUiCi19Pfuw+VtnMGMfbw6FsVydud3S9jE4sWR6sV+99tvHUpJcfXk
         fBhPeidyCFCp6s5y0osBofVmJJV3rRBjUw8jRIJd6uIck9d2MFT4iyTa/o04bh++pf
         69bS6ISGI49RpmcIIo8DDogXEn8XWNmMcDHBxSSwvv8UGacHeVwc1D/zfUyNpjoRAi
         KB6CWwG+PP7oYbAtR4Mt0f6CLZr+5j57yo12xCQg6tGd3V0uzDwtgMrp8E/BjQqbC+
         EMmY+byyVnKLg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Rich Felker <dalias@libc.org>, Sam Ravnborg <sam@ravnborg.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] char: raw: do not leak CONFIG_MAX_RAW_DEVS to userspace
Date:   Wed, 17 Jun 2020 17:33:13 +0900
Message-Id: <20200617083313.183184-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/uapi/linux/raw.h leaks CONFIG_MAX_RAW_DEVS to userspace.

Userspace programs cannot use MAX_RAW_MINORS since CONFIG_MAX_RAW_DEVS
is not available anyway.

Remove the MAX_RAW_MINORS definition from the exported header, and use
CONFIG_MAX_RAW_DEVS in drivers/char/raw.c

While I was here, I converted printk(KERN_WARNING ...) to pr_warn(...)
and stretched the warning message.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/char/raw.c         | 8 ++++----
 include/uapi/linux/raw.h   | 2 --
 scripts/headers_install.sh | 1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/char/raw.c b/drivers/char/raw.c
index 3484e9145aea..380bf518338e 100644
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -37,7 +37,7 @@ static struct raw_device_data *raw_devices;
 static DEFINE_MUTEX(raw_mutex);
 static const struct file_operations raw_ctl_fops; /* forward declaration */
 
-static int max_raw_minors = MAX_RAW_MINORS;
+static int max_raw_minors = CONFIG_MAX_RAW_DEVS;
 
 module_param(max_raw_minors, int, 0);
 MODULE_PARM_DESC(max_raw_minors, "Maximum number of raw devices (1-65536)");
@@ -317,9 +317,9 @@ static int __init raw_init(void)
 	int ret;
 
 	if (max_raw_minors < 1 || max_raw_minors > 65536) {
-		printk(KERN_WARNING "raw: invalid max_raw_minors (must be"
-			" between 1 and 65536), using %d\n", MAX_RAW_MINORS);
-		max_raw_minors = MAX_RAW_MINORS;
+		pr_warn("raw: invalid max_raw_minors (must be between 1 and 65536), using %d\n",
+			CONFIG_MAX_RAW_DEVS);
+		max_raw_minors = CONFIG_MAX_RAW_DEVS;
 	}
 
 	raw_devices = vzalloc(array_size(max_raw_minors,
diff --git a/include/uapi/linux/raw.h b/include/uapi/linux/raw.h
index dc96dda479d6..47874919d0b9 100644
--- a/include/uapi/linux/raw.h
+++ b/include/uapi/linux/raw.h
@@ -14,6 +14,4 @@ struct raw_config_request
 	__u64	block_minor;
 };
 
-#define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
-
 #endif /* __LINUX_RAW_H */
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 955cf3aedf21..84f89ff6efdd 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -90,7 +90,6 @@ include/uapi/linux/elfcore.h:CONFIG_BINFMT_ELF_FDPIC
 include/uapi/linux/eventpoll.h:CONFIG_PM_SLEEP
 include/uapi/linux/hw_breakpoint.h:CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
 include/uapi/linux/pktcdvd.h:CONFIG_CDROM_PKTCDVD_WCACHE
-include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
 "
 
 for c in $configs
-- 
2.25.1

