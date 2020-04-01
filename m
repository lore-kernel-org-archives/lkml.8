Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146C6C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A292078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVbifz4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgDAKgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:36:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29176 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732208AbgDAKgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+RJMlg5CK8Xf3dXFmPzqcBa4d+f+ZwsjXoAvCEpkVM=;
        b=iVbifz4LZHMKkwAa+gnAFe/fFfXAB2IRk/iQ89R1WBUd2E7Bj4b2bA8v5dljIc0CWHaLJS
        xy5WL/6zVzZPR3HWOavXagLu6bqyQ4lGpGzNUb3nqDoT5sx4Lg+V8mJa8BR6ev5NpcspJm
        rLNjfyteYY3RXaKNuAkZkq5B54mmQ5g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-iYesDvFIPQ6VPz646VdVHQ-1; Wed, 01 Apr 2020 06:36:47 -0400
X-MC-Unique: iYesDvFIPQ6VPz646VdVHQ-1
Received: by mail-wm1-f69.google.com with SMTP id s15so1649112wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+RJMlg5CK8Xf3dXFmPzqcBa4d+f+ZwsjXoAvCEpkVM=;
        b=uoKX5Z97bPkjdHRO0at2HXDrpNvm6zFOM66l1JbPua/u70uixC7yYSeD09LYSp7N1B
         XCLUe6tzL1fkn+CpM++oBFCklqff2f4+yD+z7y5hIL2XIaLPmek6weuekjZWn9g1zkBM
         ACLR/SlvaLnORORM1JLWmBCYwdXiVHfUWSJ36yiaE8mFYWGbm/IpyrM0diEpUptS9j0a
         XYFMLe3OM4HOu/NtDGiGn0a7e8TiaVFPa3e+QSQpRL6Ci+q5FUjigx+/FS2ZoHHTnV3R
         o8HhZR8ehm0PyG7/q46xNFoEBQy+13Y51fpwkIcKgBfnTyC7XHzGBZJXwJkJw+lsXjZk
         xqyA==
X-Gm-Message-State: AGi0PuYYSSng9GsfHxhJvIHx2OI1szI4ycYOLEz31ek6u2/emsPD3DeF
        wF3MoIQ/sVh5o1rNfzvqg6WIJ4AEs3Akcu8gFQVZiXpsKAN/xPxZIUY8+OMdERt7RFj94LgoXr4
        Zv4Xf2Rk1DQkOTPTOH4M6Q18a
X-Received: by 2002:a1c:e203:: with SMTP id z3mr3719389wmg.71.1585737406036;
        Wed, 01 Apr 2020 03:36:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ1GRqYSB9mCxSqLV2KYOT5PI7lUFwv7VuBW5jCqPEGUyfyFKyo1jXzc+EY6I41a9uzyNxVOw==
X-Received: by 2002:a1c:e203:: with SMTP id z3mr3719372wmg.71.1585737405795;
        Wed, 01 Apr 2020 03:36:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b187sm2247522wmc.14.2020.04.01.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:36:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 3/5] Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
Date:   Wed,  1 Apr 2020 12:36:36 +0200
Message-Id: <20200401103638.1406431-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103638.1406431-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmbus_onmessage() doesn't need the header of the message, it only
uses it to get to the payload, we can pass the pointer to the
payload directly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/channel_mgmt.c | 7 +------
 drivers/hv/vmbus_drv.c    | 3 ++-
 include/linux/hyperv.h    | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0370364169c4..c6bcfee6ac99 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1360,13 +1360,8 @@ channel_message_table[CHANNELMSG_COUNT] = {
  *
  * This is invoked in the vmbus worker thread context.
  */
-void vmbus_onmessage(void *context)
+void vmbus_onmessage(struct vmbus_channel_message_header *hdr)
 {
-	struct hv_message *msg = context;
-	struct vmbus_channel_message_header *hdr;
-
-	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
-
 	trace_vmbus_on_message(hdr);
 
 	/*
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 642782bef863..0f7bbf952d89 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1007,7 +1007,8 @@ static void vmbus_onmessage_work(struct work_struct *work)
 
 	ctx = container_of(work, struct onmessage_work_context,
 			   work);
-	vmbus_onmessage(&ctx->msg);
+	vmbus_onmessage((struct vmbus_channel_message_header *)
+			&ctx->msg.payload);
 	kfree(ctx);
 }
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 692c89ccf5df..cbd24f4e68d1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1017,7 +1017,7 @@ static inline void clear_low_latency_mode(struct vmbus_channel *c)
 	c->low_latency = false;
 }
 
-void vmbus_onmessage(void *context);
+void vmbus_onmessage(struct vmbus_channel_message_header *hdr);
 
 int vmbus_request_offers(void);
 
-- 
2.25.1

