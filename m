Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD5C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C622070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBgXe5AY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgBQNoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:44:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45916 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgBQNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:44:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id g3so19770546wrs.12;
        Mon, 17 Feb 2020 05:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7wpsMP2q+fA/OVi+XTu9od/CnB0uA/QKGcPyEUOs0lw=;
        b=OBgXe5AY40cDqIwpqyKbELr93rcrUuyJsT6Ac+zwMMlmMJTAedWWvppefLIexCGZnl
         OXv4jTGD3Dy+0kLxDs27eR6R2xIr9wxMWyyMQhvvqknFiMsqqnYXboHbPL/i0m7p25f+
         19Rst1nz6buVrf8t3B47JCZUMgprDTK8QbZ5X/e0vJ/x5NFsL5NRrg8l+VmaHdpZc+7n
         f+lCxRR6AdX/nCiTKW322OfsXcsUDWNJQ2kic1ExE7U04n8YP43YLsLRgVVaalB19aVP
         BY3i5cTrnIzK6gjrz9OwYe0cKXlFTpO4THJHg7FBXAcE3ZwyNiJgTvWAS4OzrHTXmyD7
         KBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7wpsMP2q+fA/OVi+XTu9od/CnB0uA/QKGcPyEUOs0lw=;
        b=KPidjmSgb9OjICVCsxjsAAMP/bWLsoOxUmP7plc45Xhcr0tBdMdJzlokAm262CJg76
         VLwozKqlbXR5OrNMt6zNvC7WKd+PmKR9G1sjD/H2q4PO4AUzev4d20mISNF1VQOJv2Qm
         6fTJpCH+jueuNYARn0qGx6AV4iVK+UCtbrOG1YsuBKr2FadK9ZQN73kXeGA5kKNOFdhp
         /x115FSoPKoXyCRyWOdQHnnYjbLXHH8Gs4EevzBx/4+M1UIWM+RrLhOneC+9CzkD5fAy
         6tsguxI3p276Kgm2e52nqYi2iAIb3IpdIzgDDPclLvj1f9Ghe17pP/7KIv60Le8M2v9I
         4phQ==
X-Gm-Message-State: APjAAAWLeJ3AKGngZxQqs7aHYl4c+g49PwnT32sCLa/j/MvqMkSzYbgF
        XdWt0HrnP4uqwEu65p62UMY=
X-Google-Smtp-Source: APXvYqxfE8mmuZt0XZWD0swbae6L0C6YWFdQFoG7uNSJi9XOyxZSBtL4TB2SVjIace7jfVuD9rGGMg==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr22064626wrp.112.1581947056250;
        Mon, 17 Feb 2020 05:44:16 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:3888:da00:b474:2167:8661:27cf])
        by smtp.gmail.com with ESMTPSA id z6sm1069084wrw.36.2020.02.17.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:44:14 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Pat Gefre <pfg@sgi.com>, Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Anatoly Pugachev <matorola@gmail.com>
Cc:     linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] tty/serial: cleanup after ioc*_serial driver removal
Date:   Mon, 17 Feb 2020 14:44:05 +0100
Message-Id: <20200217134405.19154-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9c860e4cf708 ("tty/serial: remove the ioc3_serial driver") and
commit a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver") removed
the ioc{3,4}_serial driver, but missed some files.

Fortunately, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/tty/serial/ioc?_serial.c

The driver is gone, so remove the header and maintainer
entry as well.

The serial.rst Documentation might be useful, so we keep it and update
the maintainer entry to the document's actual maintainers.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Christoph, please ack. Tony, please pick this patch.
applies cleanly on 5.6-rc2 and next-20200217
only sanity-grep for filenames, no compile testing

 MAINTAINERS          |  9 +----
 include/linux/ioc3.h | 93 --------------------------------------------
 2 files changed, 1 insertion(+), 101 deletions(-)
 delete mode 100644 include/linux/ioc3.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..ffd51bb3ba7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7945,6 +7945,7 @@ L:	linux-ia64@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
 S:	Maintained
 F:	arch/ia64/
+F:	Documentation/ia64/
 
 IBM Power 842 compression accelerator
 M:	Haren Myneni <haren@us.ibm.com>
@@ -15043,14 +15044,6 @@ M:	Dimitri Sivanich <sivanich@sgi.com>
 S:	Maintained
 F:	drivers/misc/sgi-gru/
 
-SGI SN-IA64 (Altix) SERIAL CONSOLE DRIVER
-M:	Pat Gefre <pfg@sgi.com>
-L:	linux-ia64@vger.kernel.org
-S:	Supported
-F:	Documentation/ia64/serial.rst
-F:	drivers/tty/serial/ioc?_serial.c
-F:	include/linux/ioc?.h
-
 SGI XP/XPC/XPNET DRIVER
 M:	Cliff Whickman <cpw@sgi.com>
 M:	Robin Holt <robinmholt@gmail.com>
diff --git a/include/linux/ioc3.h b/include/linux/ioc3.h
deleted file mode 100644
index 38b286e9a46c..000000000000
--- a/include/linux/ioc3.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (c) 2005 Stanislaw Skowronek <skylark@linux-mips.org>
- */
-
-#ifndef _LINUX_IOC3_H
-#define _LINUX_IOC3_H
-
-#include <asm/sn/ioc3.h>
-
-#define IOC3_MAX_SUBMODULES	32
-
-#define IOC3_CLASS_NONE		0
-#define IOC3_CLASS_BASE_IP27	1
-#define IOC3_CLASS_BASE_IP30	2
-#define IOC3_CLASS_MENET_123	3
-#define IOC3_CLASS_MENET_4	4
-#define IOC3_CLASS_CADDUO	5
-#define IOC3_CLASS_SERIAL	6
-
-/* One of these per IOC3 */
-struct ioc3_driver_data {
-	struct list_head list;
-	int id;				/* IOC3 sequence number */
-	/* PCI mapping */
-	unsigned long pma;		/* physical address */
-	struct ioc3 __iomem *vma;	/* pointer to registers */
-	struct pci_dev *pdev;		/* PCI device */
-	/* IRQ stuff */
-	int dual_irq;			/* set if separate IRQs are used */
-	int irq_io, irq_eth;		/* IRQ numbers */
-	/* GPIO magic */
-	spinlock_t gpio_lock;
-	unsigned int gpdr_shadow;
-	/* NIC identifiers */
-	char nic_part[32];
-	char nic_serial[16];
-	char nic_mac[6];
-	/* submodule set */
-	int class;
-	void *data[IOC3_MAX_SUBMODULES];	/* for submodule use */
-	int active[IOC3_MAX_SUBMODULES];	/* set if probe succeeds */
-	/* is_ir_lock must be held while
-	 * modifying sio_ie values, so
-	 * we can be sure that sio_ie is
-	 * not changing when we read it
-	 * along with sio_ir.
-	 */
-	spinlock_t ir_lock;	/* SIO_IE[SC] mod lock */
-};
-
-/* One per submodule */
-struct ioc3_submodule {
-	char *name;		/* descriptive submodule name */
-	struct module *owner;	/* owning kernel module */
-	int ethernet;		/* set for ethernet drivers */
-	int (*probe) (struct ioc3_submodule *, struct ioc3_driver_data *);
-	int (*remove) (struct ioc3_submodule *, struct ioc3_driver_data *);
-	int id;			/* assigned by IOC3, index for the "data" array */
-	/* IRQ stuff */
-	unsigned int irq_mask;	/* IOC3 IRQ mask, leave clear for Ethernet */
-	int reset_mask;		/* non-zero if you want the ioc3.c module to reset interrupts */
-	int (*intr) (struct ioc3_submodule *, struct ioc3_driver_data *, unsigned int);
-	/* private submodule data */
-	void *data;		/* assigned by submodule */
-};
-
-/**********************************
- * Functions needed by submodules *
- **********************************/
-
-#define IOC3_W_IES		0
-#define IOC3_W_IEC		1
-
-/* registers a submodule for all existing and future IOC3 chips */
-extern int ioc3_register_submodule(struct ioc3_submodule *);
-/* unregisters a submodule */
-extern void ioc3_unregister_submodule(struct ioc3_submodule *);
-/* enables IRQs indicated by irq_mask for a specified IOC3 chip */
-extern void ioc3_enable(struct ioc3_submodule *, struct ioc3_driver_data *, unsigned int);
-/* ackowledges specified IRQs */
-extern void ioc3_ack(struct ioc3_submodule *, struct ioc3_driver_data *, unsigned int);
-/* disables IRQs indicated by irq_mask for a specified IOC3 chip */
-extern void ioc3_disable(struct ioc3_submodule *, struct ioc3_driver_data *, unsigned int);
-/* atomically sets GPCR bits */
-extern void ioc3_gpcr_set(struct ioc3_driver_data *, unsigned int);
-/* general ireg writer */
-extern void ioc3_write_ireg(struct ioc3_driver_data *idd, uint32_t value, int reg);
-
-#endif
-- 
2.17.1

