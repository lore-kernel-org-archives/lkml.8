Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C623C2D0F1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521612080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlD9w5V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgDAKiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:38:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30167 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbgDAKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3l08e3NHHUaDqXrk79908dgZMwgH9sXBM13wiaRDo4=;
        b=BlD9w5V7d94xSoTkhMAzE8FRP3gqfR0Ab2DBVxWVGtAvLjPYVrnJ7DtFEmfvwVgkTCiWev
        1O20XXlRPElMEV70DaYCx2wA0KYPukeMpKtycpa1zZ/7YyzM8j2mQP1yHBKbW6qX5NXtHC
        GS2oQfG65l7Fqmh4zLm7fQDm8mjxCXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13--_XXpFjRODOXW3BUk5TEsg-1; Wed, 01 Apr 2020 06:38:19 -0400
X-MC-Unique: -_XXpFjRODOXW3BUk5TEsg-1
Received: by mail-wm1-f70.google.com with SMTP id t65so2130177wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3l08e3NHHUaDqXrk79908dgZMwgH9sXBM13wiaRDo4=;
        b=RDtK2yBlgIZzUIptSgpPGe0XpvzXZswajYJAMv8z2q27aczKV76zns1hlmGSTQVT6E
         jT+gN0pPwLTsO5tOKuf8dqE5ubcrW7no6ib3NTeHaupnwfy+MvfYR9N7qX39H7HjawWU
         BSdg8gWR0XkC32Zs07hQnJUBMNIuT28bTYpOmZqstJi9UuvJXLUixHyvo/wHt3GCL/8X
         ZLlYmCRdWrDU50rGPprraJZRsCI/QQoCuARVFxfoA7dF32KQtlVrgX+Tj4tLZfK1Re9q
         LJqEg93eMdqOSspuBCt+8nJn8yVh1QDWHThb/XqhwCgFpN0QRSDo2KjMJ6M+xPup3qex
         0YAQ==
X-Gm-Message-State: AGi0PuYMUUJ70N++YY7LIa3uhOCwFuR+mY2JKhRyddWS992ct7t0hFYs
        8ObLT/R/ef3Q28TwuKQE3/bCUIUonzVHVMD9I5imzbHlUeHdVce8GoIv+yTnTnLO8k0msy6HL5y
        RC8npBFHdQxoqdMME9T41YsiV
X-Received: by 2002:a5d:544b:: with SMTP id w11mr3134799wrv.37.1585737498645;
        Wed, 01 Apr 2020 03:38:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLN7G4Aa0czWFigGqcuI9gJgdp31NcwN9McEtnJE8lGgECyLcFLZeBMfZYUSqBHvzZV6+uT1g==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr3134790wrv.37.1585737498476;
        Wed, 01 Apr 2020 03:38:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r3sm2380098wrm.35.2020.04.01.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:38:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 4/5] Drivers: hv: make sure that 'struct vmbus_channel_message_header' compiles correctly
Date:   Wed,  1 Apr 2020 12:38:15 +0200
Message-Id: <20200401103816.1406642-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103638.1406431-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strictly speaking, compiler is free to use something different from 'u32'
for 'enum vmbus_channel_message_type' (e.g. char) but it doesn't happen in
real life, just add a BUILD_BUG_ON() guardian.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/vmbus_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0f7bbf952d89..d684cbee7ae6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1023,6 +1023,13 @@ void vmbus_on_msg_dpc(unsigned long data)
 	struct onmessage_work_context *ctx;
 	u32 message_type = msg->header.message_type;
 
+	/*
+	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
+	 * it is being used in 'struct vmbus_channel_message_header' definition
+	 * which is supposed to match hypervisor ABI.
+	 */
+	BUILD_BUG_ON(sizeof(enum vmbus_channel_message_type) != sizeof(u32));
+
 	if (message_type == HVMSG_NONE)
 		/* no msg */
 		return;
-- 
2.25.1

