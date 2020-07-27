Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3461AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0531E206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="useCPffe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbgG0Pqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgG0Pqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:46:43 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50869C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:46:43 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so13943468qkn.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eq6Q8ztU/SV0qKLD6bpCFHf5g7ycq71mi8wbaYyCfwM=;
        b=useCPfferacyo/0JUXOwYUSEUXb19osX2BOfpi1ycjVc26Azr4WGsIO+HRRWYTQr30
         ySYFahM0ujDCbR+y3GgsggUMD87PZjJagx6VbBz9Vl6sire8+gHrnPbKMCOGyTfujuv2
         RcQgoQWn38hlsB6hYzRNKe3yQfu11PHLhztVBbtLsP5nvUSCSOqDLKfV7HJR0So428Kx
         vzVnQEAK+vY+ePlywy2k6mxRztpQxEbhVd9c0M/oK7EzxRiqm7cmvka0Mkb1byNec6lO
         7NMb6BRwQs5LTdbinevBq0SBoK/XHbKto6yTn1+SYs+JjMMutAWY2c6AnDIYoCHLbLmS
         bzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eq6Q8ztU/SV0qKLD6bpCFHf5g7ycq71mi8wbaYyCfwM=;
        b=ZqcBuHy3xFiMgS2nvtazsxCLNTAKh05VRThExKM3lCT23ZZu1F5MksvMRw01+0vuB6
         sY7wGvRK8lB4ugjB/GeSwgXoqFCAfSqFmhYqsfsegYv6lIyRtlZH75YjB6AZo8bscYzi
         jbHywXU5zIzIJwTiTxit6q5ltWegtT8WFZ3pfUwvJCayTQdm/1mfLudd8TTWVCgxvIsq
         E9LEdgZbqkG5N55CES42rMSdLblSQeTYPox8VqCK+w7d78yWFmX+YAvAzogdWmFu72Jn
         bUanS4qlmFokynBzrtBI8VjEw0SVNVILT9+sfb74lJmtTCriGo+K/rOwYgFFF4N2dCrd
         B47w==
X-Gm-Message-State: AOAM530xFzQtbDCersWaJpvEI/AEBCf2lFRVWkKpjVY5e/gdRLQ9jyTC
        JJ5mpWhbCvjZs8BrtzwZFOri51dcTA==
X-Google-Smtp-Source: ABdhPJwVxJVQnSQkMP5WrsFM11nJ6OZHIQPk6i8j75Z7FhEUMKNos2zkeaTqm2s/ehlmTd+a3DiD4A==
X-Received: by 2002:a05:620a:1089:: with SMTP id g9mr23428430qkk.252.1595864802583;
        Mon, 27 Jul 2020 08:46:42 -0700 (PDT)
Received: from localhost.localdomain ([209.94.141.207])
        by smtp.gmail.com with ESMTPSA id w18sm14390947qtn.3.2020.07.27.08.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:46:42 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v2] firewire: Prevent kernel-infoleak in ioctl_get_info()
Date:   Mon, 27 Jul 2020 11:45:21 -0400
Message-Id: <20200727154521.315774-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727151537.315023-1-yepeilin.cs@gmail.com>
References: <20200727151537.315023-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioctl_get_info() is copying uninitialized stack memory to userspace due to
the compiler not initializing holes in statically allocated structures.
Fix it by initializing `event` using memset() in fill_bus_reset_event().

Cc: stable@vger.kernel.org
Fixes: 344bbc4de14e ("firewire: Generalize get_config_rom to get_info.")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v2:
    - Add an appropriate `Fixes` tag. (Suggested by Arnd Bergmann
      <arnd@arndb.de>)

 drivers/firewire/core-cdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index fb6c651214f3..2341d762df5b 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -340,6 +340,8 @@ static void fill_bus_reset_event(struct fw_cdev_event_bus_reset *event,
 {
 	struct fw_card *card = client->device->card;
 
+	memset(event, 0, sizeof(*event));
+
 	spin_lock_irq(&card->lock);
 
 	event->closure	     = client->bus_reset_closure;
-- 
2.25.1

