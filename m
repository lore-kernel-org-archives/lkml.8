Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9DEC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEF721556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="D2ge/CUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgBZPya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:54:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39255 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgBZPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:54:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so3734979wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wo0vVnrj7LlByM+obGlDBGQf7mdPxoHFFT3j3qcwsLQ=;
        b=D2ge/CUQB7iGAkEt8HFgxp9DNF+UeoHLmFY/rCVFwsAshQNIff37GWOwSPUw4j1P8B
         hwr1PUmCUAvOzdcVSCmpOBhHuHFiYwrwtEnoOb8baGokvQdGZ/ksIBJIq61zSoET3RHc
         Abvkss2EMEyMSbCNmZJbKrckbYSyZnZwwoxgvBnAHvr9gcREEGZFiS9zVOlxtQCIBOKN
         3J1SISCF9952GWPd0DDuLplZQ+H3QxjGMXiAbE7dbk1MPNx9lWbL4xJ5J0q1iN+lK/UP
         dUoGaPvx9hayfHDVaedDlyYL0vUcGb7Dgef4C4cEqzjyeG5vnTdGGjNjy52exdTIR29e
         Z63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wo0vVnrj7LlByM+obGlDBGQf7mdPxoHFFT3j3qcwsLQ=;
        b=SOMf3W85etZr0W38k8637goleXeT5FQ4bMG6znyJ02AYkc+KY/3ep0WabBCXokeK7t
         yRq+xrEyh9nLwjGmGhz4p6jgwFDvZI+Hoid7RvyNI8nZ7zuEvBkc6EwBhugpPOO+ByaK
         rn/ZtM+zilrgHeFssUdjCQMQKTT51SmpVSiXt3QN0VUoSs9bNlLJ0v8QdFsFBNI2vMmE
         tE4J6xpu5tZON5V3GenTWjn1cp81vw2+hRdcxkv45VIQGdkDLDMCcK5wVID6E+pqWbff
         idlDwzdKB549knsH5YjFo3sqeHEhzycsxBOy5Ye62IzH/oiQ+t14vgksZmJkAk51SRdl
         /qyg==
X-Gm-Message-State: APjAAAUh1s/i1YZgePBZN19oGhs4fYPzBxZhZmgQ+i+72z/zguMDHMBP
        BODjxhxHzzEq/yEzPU+vzGRWJqhdEu8=
X-Google-Smtp-Source: APXvYqzqSPTE4HjVOU1QP0igqWnIMR7V1dfoLRxmTUsRdAA0o4XAaRn6Zaj/OkBlmBAV8XLFboN1XA==
X-Received: by 2002:a05:600c:22c8:: with SMTP id 8mr6243279wmg.178.1582732464696;
        Wed, 26 Feb 2020 07:54:24 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id j12sm3792291wrt.35.2020.02.26.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:54:24 -0800 (PST)
Date:   Wed, 26 Feb 2020 16:54:23 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>
Subject: Re: [RFC net-next 1/3] net: marvell: prestera: Add Switchdev driver
 for Prestera family ASIC device 98DX325x (AC3x)
Message-ID: <20200226155423.GC26061@nanopsycho>
References: <20200225163025.9430-1-vadym.kochan@plvision.eu>
 <20200225163025.9430-2-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225163025.9430-2-vadym.kochan@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Feb 25, 2020 at 05:30:54PM CET, vadym.kochan@plvision.eu wrote:
>Marvell Prestera 98DX326x integrates up to 24 ports of 1GbE with 8
>ports of 10GbE uplinks or 2 ports of 40Gbps stacking for a largely
>wireless SMB deployment.
>
>This driver implementation includes only L1 & basic L2 support.
>
>The core Prestera switching logic is implemented in prestera.c, there is
>an intermediate hw layer between core logic and firmware. It is
>implemented in prestera_hw.c, the purpose of it is to encapsulate hw
>related logic, in future there is a plan to support more devices with
>different HW related configurations.
>
>The following Switchdev features are supported:
>
>    - VLAN-aware bridge offloading
>    - VLAN-unaware bridge offloading
>    - FDB offloading (learning, ageing)
>    - Switchport configuration
>
>Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>Signed-off-by: Andrii Savka <andrii.savka@plvision.eu>
>Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
>Signed-off-by: Serhiy Boiko <serhiy.boiko@plvision.eu>
>Signed-off-by: Serhiy Pshyk <serhiy.pshyk@plvision.eu>
>Signed-off-by: Taras Chornyi <taras.chornyi@plvision.eu>
>Signed-off-by: Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
>---
> drivers/net/ethernet/marvell/Kconfig          |    1 +
> drivers/net/ethernet/marvell/Makefile         |    1 +
> drivers/net/ethernet/marvell/prestera/Kconfig |   13 +
> .../net/ethernet/marvell/prestera/Makefile    |    3 +
> .../net/ethernet/marvell/prestera/prestera.c  | 1502 +++++++++++++++++
> .../net/ethernet/marvell/prestera/prestera.h  |  244 +++
> .../marvell/prestera/prestera_drv_ver.h       |   23 +
> .../ethernet/marvell/prestera/prestera_hw.c   | 1094 ++++++++++++
> .../ethernet/marvell/prestera/prestera_hw.h   |  159 ++
> .../marvell/prestera/prestera_switchdev.c     | 1217 +++++++++++++
> 10 files changed, 4257 insertions(+)
> create mode 100644 drivers/net/ethernet/marvell/prestera/Kconfig
> create mode 100644 drivers/net/ethernet/marvell/prestera/Makefile
> create mode 100644 drivers/net/ethernet/marvell/prestera/prestera.c
> create mode 100644 drivers/net/ethernet/marvell/prestera/prestera.h
> create mode 100644 drivers/net/ethernet/marvell/prestera/prestera_drv_ver.h
> create mode 100644 drivers/net/ethernet/marvell/prestera/prestera_hw.c
> create mode 100644 drivers/net/ethernet/marvell/prestera/prestera_hw.h
> create mode 100644 drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
>
>diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
>index 3d5caea096fb..74313d9e1fc0 100644
>--- a/drivers/net/ethernet/marvell/Kconfig
>+++ b/drivers/net/ethernet/marvell/Kconfig
>@@ -171,5 +171,6 @@ config SKY2_DEBUG
> 
> 
> source "drivers/net/ethernet/marvell/octeontx2/Kconfig"
>+source "drivers/net/ethernet/marvell/prestera/Kconfig"
> 
> endif # NET_VENDOR_MARVELL
>diff --git a/drivers/net/ethernet/marvell/Makefile b/drivers/net/ethernet/marvell/Makefile
>index 89dea7284d5b..9f88fe822555 100644
>--- a/drivers/net/ethernet/marvell/Makefile
>+++ b/drivers/net/ethernet/marvell/Makefile
>@@ -12,3 +12,4 @@ obj-$(CONFIG_PXA168_ETH) += pxa168_eth.o
> obj-$(CONFIG_SKGE) += skge.o
> obj-$(CONFIG_SKY2) += sky2.o
> obj-y		+= octeontx2/
>+obj-y		+= prestera/
>diff --git a/drivers/net/ethernet/marvell/prestera/Kconfig b/drivers/net/ethernet/marvell/prestera/Kconfig
>new file mode 100644
>index 000000000000..d0b416dcb677
>--- /dev/null
>+++ b/drivers/net/ethernet/marvell/prestera/Kconfig
>@@ -0,0 +1,13 @@
>+# SPDX-License-Identifier: GPL-2.0-only
>+#
>+# Marvell Prestera drivers configuration
>+#
>+
>+config PRESTERA
>+	tristate "Marvell Prestera Switch ASICs support"
>+	depends on NET_SWITCHDEV && VLAN_8021Q
>+	---help---
>+	  This driver supports Marvell Prestera Switch ASICs family.
>+
>+	  To compile this driver as a module, choose M here: the
>+	  module will be called prestera_sw.
>diff --git a/drivers/net/ethernet/marvell/prestera/Makefile b/drivers/net/ethernet/marvell/prestera/Makefile
>new file mode 100644
>index 000000000000..9446298fb7f4
>--- /dev/null
>+++ b/drivers/net/ethernet/marvell/prestera/Makefile
>@@ -0,0 +1,3 @@
>+# SPDX-License-Identifier: GPL-2.0
>+obj-$(CONFIG_PRESTERA)	+= prestera_sw.o
>+prestera_sw-objs	:= prestera.o prestera_hw.o prestera_switchdev.o
>diff --git a/drivers/net/ethernet/marvell/prestera/prestera.c b/drivers/net/ethernet/marvell/prestera/prestera.c
>new file mode 100644
>index 000000000000..12d0eb590bbb
>--- /dev/null
>+++ b/drivers/net/ethernet/marvell/prestera/prestera.c
>@@ -0,0 +1,1502 @@
>+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
>+ *
>+ * Copyright (c) 2019-2020 Marvell International Ltd. All rights reserved.
>+ *
>+ */
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/list.h>
>+#include <linux/netdevice.h>
>+#include <linux/netdev_features.h>
>+#include <linux/etherdevice.h>
>+#include <linux/ethtool.h>
>+#include <linux/jiffies.h>
>+#include <net/switchdev.h>
>+
>+#include "prestera.h"
>+#include "prestera_hw.h"
>+#include "prestera_drv_ver.h"
>+
>+#define MVSW_PR_MTU_DEFAULT 1536
>+
>+#define PORT_STATS_CACHE_TIMEOUT_MS	(msecs_to_jiffies(1000))
>+#define PORT_STATS_CNT	(sizeof(struct mvsw_pr_port_stats) / sizeof(u64))

Keep the prefix for all defines withing the file. "PORT_STATS_CNT"
looks way to generic on the first look.


>+#define PORT_STATS_IDX(name) \
>+	(offsetof(struct mvsw_pr_port_stats, name) / sizeof(u64))
>+#define PORT_STATS_FIELD(name)	\
>+	[PORT_STATS_IDX(name)] = __stringify(name)
>+
>+static struct list_head switches_registered;
>+
>+static const char mvsw_driver_kind[] = "prestera_sw";

Please be consistent. Make your prefixes, name, filenames the same.
For example:
prestera_driver_kind[] = "prestera";

Applied to the whole code.


>+static const char mvsw_driver_name[] = "mvsw_switchdev";

Why is this different from kind?

Also, don't mention "switchdev" anywhere.


>+static const char mvsw_driver_version[] = PRESTERA_DRV_VER;

[...]


>+static void mvsw_pr_port_remote_cap_get(struct ethtool_link_ksettings *ecmd,
>+					struct mvsw_pr_port *port)
>+{
>+	u64 bitmap;
>+
>+	if (!mvsw_pr_hw_port_remote_cap_get(port, &bitmap)) {
>+		mvsw_modes_to_eth(ecmd->link_modes.lp_advertising,
>+				  bitmap, 0, MVSW_PORT_TYPE_NONE);
>+	}

Don't use {} for single statement. checkpatch.pl should warn you about
this.



>+}
>+
>+static void mvsw_pr_port_duplex_get(struct ethtool_link_ksettings *ecmd,
>+				    struct mvsw_pr_port *port)
>+{
>+	u8 duplex;
>+
>+	if (!mvsw_pr_hw_port_duplex_get(port, &duplex)) {
>+		ecmd->base.duplex = duplex == MVSW_PORT_DUPLEX_FULL ?
>+				    DUPLEX_FULL : DUPLEX_HALF;
>+	} else {
>+		ecmd->base.duplex = DUPLEX_UNKNOWN;
>+	}

Same here.


>+}

[...]


>+static void __exit mvsw_pr_module_exit(void)
>+{
>+	destroy_workqueue(mvsw_pr_wq);
>+
>+	pr_info("Unloading Marvell Prestera Switch Driver\n");

No prints like this please.

	
	
>+}
>+
>+module_init(mvsw_pr_module_init);
>+module_exit(mvsw_pr_module_exit);
>+
>+MODULE_AUTHOR("Marvell Semi.");

Does not look so :)


>+MODULE_LICENSE("GPL");
>+MODULE_DESCRIPTION("Marvell Prestera switch driver");
>+MODULE_VERSION(PRESTERA_DRV_VER);

[...]
