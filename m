Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE1820672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Oa7eKBzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGOUM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGOUMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:12:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A8C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:12:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so4234168wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWbieh3LrbWhh/fEhcjffhKT60XI0SjYwP6KF5G9PmE=;
        b=Oa7eKBzyOYAGVxNdVuYtDlukvTUwMMh04pLIob39z3UQrEWijhRwysGyspB7iV6J77
         7hOLTY+xRlc6MzCEyi2uvmJE2Rg/JF7u0PcJyrqvXN2JVY1B3QgOb9SGYJYp/pGVdC03
         b6/KPmh1ou/p8yOqRICVx8hzsbj8UCbPmWBTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWbieh3LrbWhh/fEhcjffhKT60XI0SjYwP6KF5G9PmE=;
        b=WCd4f865us5LXPubJbM9I18XyvGdCpoxk+vxurK+HpTRQ/+frRzPnpn4Z2v7Srt1Ti
         fLNtDPObuBfaeXsKqa1iibN0Q/WLqBjTniNfg8EjFfevJjVYuUGNZnuZZvpD0nj1ZT9c
         aMFk8xNreI84C/KLD1ilrPaGZXqMPJzo5PnVDQDjHPfIdJM8tsRnDxcuPn/xm7Uvz5Kr
         kNcJhIX6viiONz1GOdJkzYqlE6+fsVpV90Dq7BCMxthP+j76z0eoEQMA0S+s9lXVgK1b
         xN8VSKOXmOgijIpAfQus5pqXnMD4UxlB86fJho8N/+/4mitfsS5Ut1p3kLTYSeuYsEgI
         aeeA==
X-Gm-Message-State: AOAM533g0y1pJwVCejdy5pj6LDDplZHpn3jr5qe7h11vitFmxFw/AFGd
        temX+ettsKVn33/wRaxH7r8Xrw==
X-Google-Smtp-Source: ABdhPJw4pmnmQ24kmxuAeL7bKMdM9Ue87LbKsJdY1oWxzBHNkrAt3ddETbn9EeDbuv5P+KbtV8ocuQ==
X-Received: by 2002:adf:bc41:: with SMTP id a1mr1132526wrh.186.1594843939606;
        Wed, 15 Jul 2020 13:12:19 -0700 (PDT)
Received: from dev.cfops.net (88-144-169-51.host.pobb.as13285.net. [88.144.169.51])
        by smtp.gmail.com with ESMTPSA id p4sm4765528wrx.63.2020.07.15.13.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:12:19 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, masahiroy@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v3 2/3] um: some fixes to build UML with musl
Date:   Wed, 15 Jul 2020 21:11:58 +0100
Message-Id: <20200715201159.54166-3-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715201159.54166-1-ignat@cloudflare.com>
References: <20200715201159.54166-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

musl toolchain and headers are a bit more strict. These fixes enable building
UML with musl as well as seem not to break on glibc.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/drivers/daemon_user.c |  1 +
 arch/um/drivers/pcap_user.c   | 12 ++++++------
 arch/um/drivers/slip_user.c   |  2 +-
 arch/um/drivers/vector_user.c |  4 +---
 arch/um/os-Linux/util.c       |  2 +-
 arch/x86/um/user-offsets.c    |  2 +-
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index 3695821d06a2..785baedc3555 100644
--- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -7,6 +7,7 @@
  */
 
 #include <stdint.h>
+#include <string.h>
 #include <unistd.h>
 #include <errno.h>
 #include <sys/types.h>
diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
index bbd20638788a..52ddda3e3b10 100644
--- a/arch/um/drivers/pcap_user.c
+++ b/arch/um/drivers/pcap_user.c
@@ -32,7 +32,7 @@ static int pcap_user_init(void *data, void *dev)
 	return 0;
 }
 
-static int pcap_open(void *data)
+static int pcap_user_open(void *data)
 {
 	struct pcap_data *pri = data;
 	__u32 netmask;
@@ -44,14 +44,14 @@ static int pcap_open(void *data)
 	if (pri->filter != NULL) {
 		err = dev_netmask(pri->dev, &netmask);
 		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
+			printk(UM_KERN_ERR "pcap_user_open : dev_netmask failed\n");
 			return -EIO;
 		}
 
 		pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
 					UM_GFP_KERNEL);
 		if (pri->compiled == NULL) {
-			printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
+			printk(UM_KERN_ERR "pcap_user_open : kmalloc failed\n");
 			return -ENOMEM;
 		}
 
@@ -59,14 +59,14 @@ static int pcap_open(void *data)
 				   (struct bpf_program *) pri->compiled,
 				   pri->filter, pri->optimize, netmask);
 		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
+			printk(UM_KERN_ERR "pcap_user_open : pcap_compile failed - "
 			       "'%s'\n", pcap_geterr(pri->pcap));
 			goto out;
 		}
 
 		err = pcap_setfilter(pri->pcap, pri->compiled);
 		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
+			printk(UM_KERN_ERR "pcap_user_open : pcap_setfilter "
 			       "failed - '%s'\n", pcap_geterr(pri->pcap));
 			goto out;
 		}
@@ -127,7 +127,7 @@ int pcap_user_read(int fd, void *buffer, int len, struct pcap_data *pri)
 
 const struct net_user_info pcap_user_info = {
 	.init		= pcap_user_init,
-	.open		= pcap_open,
+	.open		= pcap_user_open,
 	.close	 	= NULL,
 	.remove	 	= pcap_remove,
 	.add_address	= NULL,
diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index 8016d32b6809..482a19c5105c 100644
--- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -9,7 +9,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <string.h>
-#include <sys/termios.h>
+#include <termios.h>
 #include <sys/wait.h>
 #include <net_user.h>
 #include <os.h>
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c4a0f26b2824..45d4164ad355 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -18,9 +18,7 @@
 #include <fcntl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <net/ethernet.h>
 #include <netinet/ip.h>
-#include <netinet/ether.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <sys/wait.h>
@@ -332,7 +330,7 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
 	}
 	switch (id) {
 	case ID_BESS:
-		if (connect(fd, remote_addr, sizeof(struct sockaddr_un)) < 0) {
+		if (connect(fd, (const struct sockaddr *) remote_addr, sizeof(struct sockaddr_un)) < 0) {
 			printk(UM_KERN_ERR "bess open:cannot connect to %s %i", remote_addr->sun_path, -errno);
 			goto unix_cleanup;
 		}
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index ecf2f390fad2..07327425d06e 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -10,7 +10,7 @@
 #include <signal.h>
 #include <string.h>
 #include <termios.h>
-#include <wait.h>
+#include <sys/wait.h>
 #include <sys/mman.h>
 #include <sys/utsname.h>
 #include <init.h>
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index c51dd8363d25..bae61554abcc 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -2,7 +2,7 @@
 #include <stdio.h>
 #include <stddef.h>
 #include <signal.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/mman.h>
 #include <sys/user.h>
 #define __FRAME_OFFSETS
-- 
2.20.1

