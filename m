Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85482C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA0620720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGnAz+Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgEKKL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:11:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729305AbgEKKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589191916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ZN7xwg5CWZvOzQGTmaByrLX25ajcsG3GF52exfugwgc=;
        b=bGnAz+EvMKihQjuT4lj344jlprwrC+m0nsEX6URRFQ/Gby19OHhj8jcz8gn/XwVxIHVUN4
        dQ1rrVtP+YdHV1Y+87dPMTJPSMyKtIYFryv95DjFIz9/+HijpLOrifjf+N0YZU9Gh3soGp
        dfBGhnb+/2Pjl1KJjYVeTPIxyYiAqNU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-GRFP5Sg8PXyF7zCf3qotCA-1; Mon, 11 May 2020 06:11:55 -0400
X-MC-Unique: GRFP5Sg8PXyF7zCf3qotCA-1
Received: by mail-pg1-f200.google.com with SMTP id g11so7386130pgd.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZN7xwg5CWZvOzQGTmaByrLX25ajcsG3GF52exfugwgc=;
        b=EDMEKKyaDXnnu4e0aIOvHtpb2HCFe2QAGtRiINBoekw9Za7mxfxuox+4GxTcnPLZYM
         05wmGjQ/ta8nGjfn6Buxhdg2cbgh+lnSXHB6MYrqn8/qtMUW+gxLwQGitq/0R6LDjzev
         Pq8WRdX0/8Ba0k6V0EckI7uIn1lCa7m2ODVkfdcmaeHyC3vOLapVdvAPhCC4nbQ2jyyN
         vTY/2ytMcl1yQhcRMwrTNrIlCXzdXQ0aEzmDEifLQAnDCOHgLN8CnErRDLf0Zj27TaLF
         NKspKIfBIgLxoSO5Obw6KT7jV65QE7geDSgV3K8u6nQPmeStID+WDxgzwLP5gTWEOvtF
         K9tg==
X-Gm-Message-State: AGi0PuaqJUrxTuowKl3CtD6QeKppfgVejXBXWA7qaG7wDdjiiN5ZdnwB
        A4uUDDChVUuW4+TLCTqLr/BrVRsWu0HfiD+/Hw0zYNEjYWuzFquplp8uUl8wsi7K6KGzx97s+lM
        Qry0brrTk2G2ZiZMZu/QQXkb8
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr14128019pld.73.1589191913262;
        Mon, 11 May 2020 03:11:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJWyWXGdAoto/0EXXwdx9Dr2HzYt8dFPCj8KebFaRpzS/r4xZule3kpAQxzMDRxJPy9o+z/rg==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr14127998pld.73.1589191912970;
        Mon, 11 May 2020 03:11:52 -0700 (PDT)
Received: from localhost ([223.235.87.110])
        by smtp.gmail.com with ESMTPSA id s136sm9033998pfc.29.2020.05.11.03.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 03:11:52 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        manishc@marvell.com, davem@davemloft.net, irusskikh@marvell.com
Subject: [PATCH v2 2/2] net: qed: Disable SRIOV functionality inside kdump kernel
Date:   Mon, 11 May 2020 15:41:42 +0530
Message-Id: <1589191902-958-3-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589191902-958-1-git-send-email-bhsharma@redhat.com>
References: <1589191902-958-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have kdump kernel(s) running under severe memory constraint
it makes sense to disable the qed SRIOV functionality when running the
kdump kernel as kdump configurations on several distributions don't
support SRIOV targets for saving the vmcore (see [1] for example).

Currently the qed SRIOV functionality ends up consuming memory in
the kdump kernel, when we don't really use the same.

An example log seen in the kdump kernel with the SRIOV functionality
enabled can be seen below (obtained via memstrack tool, see [2]):
 dracut-pre-pivot[676]: ======== Report format module_summary: ========
 dracut-pre-pivot[676]: Module qed using 149.6MB (2394 pages), peak allocation 149.6MB (2394 pages)

This patch disables the SRIOV functionality inside kdump kernel and with
the same applied the memory consumption goes down:
 dracut-pre-pivot[671]: ======== Report format module_summary: ========
 dracut-pre-pivot[671]: Module qed using 124.6MB (1993 pages), peak allocation 124.7MB (1995 pages)

[1]. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/installing-and-configuring-kdump_managing-monitoring-and-updating-the-kernel#supported-kdump-targets_supported-kdump-configurations-and-targets
[2]. Memstrack tool: https://github.com/ryncsn/memstrack

Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Ariel Elior <aelior@marvell.com>
Cc: GR-everest-linux-l2@marvell.com
Cc: Manish Chopra <manishc@marvell.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 drivers/net/ethernet/qlogic/qed/qed_sriov.h  | 10 +++++++---
 drivers/net/ethernet/qlogic/qede/qede_main.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.h b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
index 368e88565783..aabeaf03135e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
@@ -32,6 +32,7 @@
 
 #ifndef _QED_SRIOV_H
 #define _QED_SRIOV_H
+#include <linux/crash_dump.h>
 #include <linux/types.h>
 #include "qed_vf.h"
 
@@ -40,9 +41,12 @@
 #define QED_VF_ARRAY_LENGTH (3)
 
 #ifdef CONFIG_QED_SRIOV
-#define IS_VF(cdev)             ((cdev)->b_is_vf)
-#define IS_PF(cdev)             (!((cdev)->b_is_vf))
-#define IS_PF_SRIOV(p_hwfn)     (!!((p_hwfn)->cdev->p_iov_info))
+#define IS_VF(cdev)             (is_kdump_kernel() ? \
+				 (0) : ((cdev)->b_is_vf))
+#define IS_PF(cdev)             (is_kdump_kernel() ? \
+				 (1) : !((cdev)->b_is_vf))
+#define IS_PF_SRIOV(p_hwfn)     (is_kdump_kernel() ? \
+				 (0) : !!((p_hwfn)->cdev->p_iov_info))
 #else
 #define IS_VF(cdev)             (0)
 #define IS_PF(cdev)             (1)
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 1a83d1fd8ccd..28afa0c49fe8 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1194,7 +1194,7 @@ static int qede_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	case QEDE_PRIVATE_VF:
 		if (debug & QED_LOG_VERBOSE_MASK)
 			dev_err(&pdev->dev, "Probing a VF\n");
-		is_vf = true;
+		is_vf = is_kdump_kernel() ? false : true;
 		break;
 	default:
 		if (debug & QED_LOG_VERBOSE_MASK)
-- 
2.7.4

