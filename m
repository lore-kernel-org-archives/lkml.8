Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1748D20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxvIDIbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgFKTip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:38:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51164 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726332AbgFKTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591904319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=+T/pLFOFWhPqP/4Y2+KijPsKT8TaUEKgCEsaihLS+Sg=;
        b=SxvIDIbfBaq0FkKa594pM9rr7H0SJKCt9AhqemUoKb30wG68wQDO2zQQVF/z/sDsJZ2v7D
        EBIXi6lJWGknxXDoCcP6mMHj8SduaNyDrPgy+KKQ0v0NHCBwz3njp/fNDoBR6dtm0LKaGj
        8ef5L0FGK7MCcErB33KvUzcx0pN0VYI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-h7NMfT9pP8a47r2O0khY1g-1; Thu, 11 Jun 2020 15:38:38 -0400
X-MC-Unique: h7NMfT9pP8a47r2O0khY1g-1
Received: by mail-qv1-f69.google.com with SMTP id h4so5123718qvr.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+T/pLFOFWhPqP/4Y2+KijPsKT8TaUEKgCEsaihLS+Sg=;
        b=fOG/01rR9Acjw2FdZrE5a64mbb848kQh6FJk9sHMpLdan5MPS16n28Vsf6zR76kHu5
         ctYIDQt0Hh6jgEn/6oGARr9mrMzpaPoRqmkRVEx5cVjkpfCbxJZYmccoqmXp6z7LwMZn
         dkMly2McEpmsJP0vn/oWlr4vg6ljhMoYem0WXUMAWpF/p8JJGgzrJGnUSDJAAXu/JOEN
         hiEusAPJyFhvEmDOSnGBo6J8sNRJljmio/JblReXbXpCQSAfu5isfFGS1ZnApLd/uPBG
         JVsEQCvrRhNgTWJI4kirSgjMiz/ti9t0EwfDALxQqMnIlzDIsDCEc6aT1G8EjMrdwbT0
         DsxQ==
X-Gm-Message-State: AOAM532vHoZadZYXrH5I+GWA0REFPL9R5zJ9aoRSafDHtueeVRkFAG/N
        OPBIMy/c/w8jWJ+kpTrVtgwveIII1zkZFu8wC63xw5yTDoudnCqlaxF2/Q0HF+2t09XQluDXRaR
        m+Al9dd7wG7fWFPWglwFLPN9X
X-Received: by 2002:a05:620a:1245:: with SMTP id a5mr10654832qkl.161.1591904317563;
        Thu, 11 Jun 2020 12:38:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4dpfStmnjpuWuvm5A7olHToa/nIp2crCfHajW7c6kq15mk+mW7+DCk7P8myHlXdCLoeAhPQ==
X-Received: by 2002:a05:620a:1245:: with SMTP id a5mr10654816qkl.161.1591904317344;
        Thu, 11 Jun 2020 12:38:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j22sm3020783qke.117.2020.06.11.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:38:36 -0700 (PDT)
From:   trix@redhat.com
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/1] selftests: fpga: dfl: A test for afu interrupt support
Date:   Thu, 11 Jun 2020 12:38:27 -0700
Message-Id: <20200611193827.8302-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200611193827.8302-1-trix@redhat.com>
References: <20200611193827.8302-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
an expected result.

Tested on vf device 0xbcc1

Sample run with
 # make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
 ...
 # selftests: drivers/fpga: afu_intr
 # # Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
 ok 1 selftests: drivers/fpga: afu_intr

Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 33 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..4c6eda659125 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += clone3
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
+TARGETS += drivers/fpga
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
new file mode 100644
index 000000000000..0a472e8c67c5
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -I../../../../../usr/include/
+CFLAGS += -I../../../../../include/uapi/
+
+TEST_GEN_PROGS := afu_intr
+
+top_srcdir ?=../../../../..
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/fpga/afu_intr.c b/tools/testing/selftests/drivers/fpga/afu_intr.c
new file mode 100644
index 000000000000..e4ef3fac764d
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/afu_intr.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <linux/fcntl.h>
+#include <linux/fpga-dfl.h>
+
+#include "../../kselftest.h"
+
+int main(int argc, char *argv[])
+{
+	int devfd, status;
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0)
+		ksft_exit_skip("no fpga afu device 0\n");
+
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	irq_num = -1;
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	if (status != 0 || irq_num > 255)
+		ksft_exit_fail_msg("Could not get the number of afu error irqs\n");
+
+	close(devfd);
+	ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
new file mode 100644
index 000000000000..e2111b81d8d7
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/config
@@ -0,0 +1 @@
+CONFIG_FPGA_DFL_AFU=m
-- 
2.18.1

