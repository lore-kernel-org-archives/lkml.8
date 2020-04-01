Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C24C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445422078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q025UPL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgDAKg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:36:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54085 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728419AbgDAKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95SLTRxzNA6I7Qs5MDcrqUNSgYhms1oIYNK1Km/D7+g=;
        b=Q025UPL7rkd/gpPIMX9a3RAtbQ1uCsb+v/IzS3zKfRFZ0J0Bi3nHwtw/2QJgC6ZAm0X3vu
        fVwK234unpToF3LHyacL782Vj7l1LbpHb8IBjC1xu848ZZj2XP6ZvgBCmLcQueywMsz4MG
        BV+9FCoeeEvvJC7rebtNKhJ8V4FU0hA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-04I3MTwBNp6C8KE4tN8pWQ-1; Wed, 01 Apr 2020 06:36:45 -0400
X-MC-Unique: 04I3MTwBNp6C8KE4tN8pWQ-1
Received: by mail-wm1-f72.google.com with SMTP id s22so1642067wmh.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95SLTRxzNA6I7Qs5MDcrqUNSgYhms1oIYNK1Km/D7+g=;
        b=IfoGmdt/0cAA7aT7ko2kEGqqcdL19lsCcUaHv17zPE/JJtwCsu/rE2Y3aGWQnGBzoj
         D0U8sz99m/guPTUbQakKR+nyty6ueE0KZT04QXJr5FurE3YUAUo8MmayOL357DxL3Qij
         TuN8mY0XB2BKLaIqXG4pkmtR3W5FENBkgvu4reH6iMGMx2+lY0s7dUqNosEufH+P84pi
         knjzWkAMlhO3dleEasRi2CFUZYFqsM+6wfa+FHG2d7nDulsONDTLxvXs0Wr2UaH6zLUQ
         A5SWBT4tOo6rT8/l2CKsVqtnVFQFjX/M82ThmwLIERff1fLOcU+8HRA6qCDgRj19AGts
         aO6A==
X-Gm-Message-State: ANhLgQ2NtwfUVVB8jAJdph8DkLnFprJEYK8CdrlKFWp612zBZEwdrTLQ
        biiZ8GQ+4BguKjQ9RkmMw5UxB1q4CCFl1RNJC/TjfcdYs6e/WgA4IznecTs5t+3hLq9TnHx9aGh
        3lf4BStHyOgaGMSZKpFIs2Ebs
X-Received: by 2002:adf:f68b:: with SMTP id v11mr24104973wrp.270.1585737404484;
        Wed, 01 Apr 2020 03:36:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupbXj+AHoPKJR8dpFDHt1zLdiYOWj2Qkuu2LQbrdXTWCGsIkDoKHFfZUzBvnLpI5KUmjLZPQ==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr24104958wrp.270.1585737404297;
        Wed, 01 Apr 2020 03:36:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b187sm2247522wmc.14.2020.04.01.03.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:36:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 2/5] Drivers: hv: allocate the exact needed memory for messages
Date:   Wed,  1 Apr 2020 12:36:35 +0200
Message-Id: <20200401103638.1406431-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103638.1406431-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we need to pass a buffer with Hyper-V message we don't need to always
allocate 256 bytes for the message: the real message length is known from
the header. Change 'struct onmessage_work_context' to make it possible to
not over-allocate.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/vmbus_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2b5572146358..642782bef863 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -991,7 +991,10 @@ static struct bus_type  hv_bus = {
 
 struct onmessage_work_context {
 	struct work_struct work;
-	struct hv_message msg;
+	struct {
+		struct hv_message_header header;
+		u8 payload[];
+	} msg;
 };
 
 static void vmbus_onmessage_work(struct work_struct *work)
@@ -1038,7 +1041,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 
 	if (entry->handler_type	== VMHT_BLOCKING) {
-		ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+		ctx = kmalloc(sizeof(*ctx) + msg->header.payload_size,
+			      GFP_ATOMIC);
 		if (ctx == NULL)
 			return;
 
@@ -1092,10 +1096,11 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 	WARN_ON(!is_hvsock_channel(channel));
 
 	/*
-	 * sizeof(*ctx) is small and the allocation should really not fail,
+	 * Allocation size is small and the allocation should really not fail,
 	 * otherwise the state of the hv_sock connections ends up in limbo.
 	 */
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
+	ctx = kzalloc(sizeof(*ctx) + sizeof(*rescind),
+		      GFP_KERNEL | __GFP_NOFAIL);
 
 	/*
 	 * So far, these are not really used by Linux. Just set them to the
@@ -1105,7 +1110,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 	ctx->msg.header.payload_size = sizeof(*rescind);
 
 	/* These values are actually used by Linux. */
-	rescind = (struct vmbus_channel_rescind_offer *)ctx->msg.u.payload;
+	rescind = (struct vmbus_channel_rescind_offer *)ctx->msg.payload;
 	rescind->header.msgtype = CHANNELMSG_RESCIND_CHANNELOFFER;
 	rescind->child_relid = channel->offermsg.child_relid;
 
-- 
2.25.1

