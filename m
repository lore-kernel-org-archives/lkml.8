Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D258C3B186
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B282173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tid00NV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgBMACs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:02:48 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49381 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgBMACs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:02:48 -0500
Received: by mail-pg1-f202.google.com with SMTP id u14so2473219pgq.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 16:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5sejEhwZ2l45t4qqweTv/TeKAPA6gGJt5bGMAHC09l0=;
        b=Tid00NV9UbKop+yR0Rx7qVMTr/h4L39t83pZjaUJu84RLnBTKMch+9VcMZ6m0qeKjF
         60D1PptlQPn0s8Hs6GND6AZ2U2Jr5MC3DTC/Bl7zBXIxtYa9R7fnZ+1hKo3vYqXmrUyB
         vt12pClRebXdaxCxy+7vmi1rPm4/UcgLGz6ig3WduGtFy9ianJLhRPezoE+2TUOup1Pr
         A+/mQINrJjpFm6FD0ovnhwTk11FkmYGP4oY6F3RwC7hL3A7IVsgP3n/hIYcX/zEu44zL
         sgKqtIJYMoozh9UgZOLjky1IfE+mtB0+fdBXmIjA6qR8kO1IU804rVSNIAYiDuhCQqes
         zGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5sejEhwZ2l45t4qqweTv/TeKAPA6gGJt5bGMAHC09l0=;
        b=UzIZ7nASU1Ei4s9cQIOKQZg/jeDlJiE2BkDHRwXA0MJ/2LBPjZXWrpL2zHhjgzX9Xs
         l6HRMveShCit1Ok4qJO0bpkZ011eqhZ+McCr0Lp5JEeR4N7hxi3qzLn9BpVuSqkGMPvo
         ueupPAP5fLAE07vB3jhqpSWZyuoalGjev/sXdjKA1B3VCK7c+/+eyFmfCy2l+6cz7FRM
         yDXxmDCtHYSROt9SJiNmAQ6jkYhQSCNz7qBLjGDiGFhThRtRvtBoz/SJETuckYHZFN1o
         0Ul4zrtZEixWICDrmC78c5LZggQWTi9fl3E3P126u2q95s+HrdE3NAn7f4nutkv3+sPc
         0xeA==
X-Gm-Message-State: APjAAAWU18Y3BIcOa5+M43VsMTmXr8bqto7xGNkQ1YR4nu0903DVFTfW
        4a6CEe8Ntgt6VKRZEKSnPWrptBYWanaWf8sQ
X-Google-Smtp-Source: APXvYqyQdAUlX785CT1PjEzV5Ehbjvh7EyH6Fliu2ZgqUyzQFgUXEmB1xuRjIi4OxgsEWZmdQNv7NhvPfHZVbDJl
X-Received: by 2002:a65:5a48:: with SMTP id z8mr14547104pgs.157.1581552167135;
 Wed, 12 Feb 2020 16:02:47 -0800 (PST)
Date:   Wed, 12 Feb 2020 16:02:42 -0800
Message-Id: <20200213000242.26245-1-rammuthiah@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH] virtio: virtio_pci_legacy: Remove default y from Kconfig
From:   Ram Muthiah <rammuthiah@google.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ram Muthiah <rammuthiah@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy pci driver should no longer be default enabled. QEMU has
implemented support for Virtio 1 for virtio-pci since June 2015
on SHA dfb8e184db75.

Signed-off-by: Ram Muthiah <rammuthiah@google.com>
---
 drivers/virtio/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 078615cf2afc..eacd0b90d32b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -26,7 +26,6 @@ config VIRTIO_PCI
 
 config VIRTIO_PCI_LEGACY
 	bool "Support for legacy virtio draft 0.9.X and older devices"
-	default y
 	depends on VIRTIO_PCI
 	---help---
           Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
@@ -36,11 +35,6 @@ config VIRTIO_PCI_LEGACY
 	  If disabled, you get a slightly smaller, non-transitional driver,
 	  with no legacy compatibility.
 
-          So look out into your driveway.  Do you have a flying car?  If
-          so, you can happily disable this option and virtio will not
-          break.  Otherwise, leave it set.  Unless you're testing what
-          life will be like in The Future.
-
 	  If unsure, say Y.
 
 config VIRTIO_PMEM
-- 
2.25.0.225.g125e21ebc7-goog

