Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3590C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909A2206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgK/lAMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgDFKnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:43:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60266 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbgDFKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnzvWDxT51ceWkFoDXIfz8ULidaqB4F/U3oJiWp4gvU=;
        b=HgK/lAMSzfijUqkvZDZYzidsfEYYHxUdsvwVqyWilGLdGOKPTv02nf5NIAQJn8k7tZ96Q8
        F3nkqsfs/9CCbI/GwfTRK/Ai21OvjESvCcXxEjqmLfk/I4UN0Ask9bazwO/th2kv2EIYH6
        NDW1iLiQ92eQGSSZqm9PFD/2ajv7Qo4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-XAgnlVE4N0qbSw1n0wYm0Q-1; Mon, 06 Apr 2020 06:43:20 -0400
X-MC-Unique: XAgnlVE4N0qbSw1n0wYm0Q-1
Received: by mail-wr1-f70.google.com with SMTP id c8so8143554wru.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnzvWDxT51ceWkFoDXIfz8ULidaqB4F/U3oJiWp4gvU=;
        b=qUOxiHIvzJPXF5KQZLLnBFeRxyy9KxHC6ydvc/IanntHyvEB/+ev/hMZ/D7ruHS/Vb
         aYFddJr0JzR4Wc5LnNiPrc76qOAGQZdlioSKj8EwIlOAdidWJ4AsPKqgZ7VG/uEI1AuS
         75LlKfEGdRQzv6BihLJRF1vJjg3bE+nhQmV+fZgA9ci00PGKSuU7rwMrRk3u+GBnwP5M
         kK1B1paQp1vx6N2/UVANl+Lpv0pJm4KCDB1swzZCdhW17fOLWwtxRaO0AMMvDLhaum5/
         VWK6BuNs7hYI7ZezWXJWca7kzp12ITcgP95rC5SDHUxhHqePkqVBySV1WsWNER2MUmBS
         TZrg==
X-Gm-Message-State: AGi0PubQlBldx0peGP1hKowlETAVSNg7lAbwdVLEKpBKzgOPoDDCmV7r
        rdnBflnx/MkRHhaCaHLzPLxN50hUjyntIUKesjq1Dzl1ukzR+5tmhMyNwspWdwccEJjHW3PxDHz
        YbxqnoDDBGTKc3tkxWmzsmCGs
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr9114546wrt.164.1586169798978;
        Mon, 06 Apr 2020 03:43:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8yCoOfXBrw2hnivxr3dtp1W/vg3CXlZhUIMMwsfC1gV7Nw0Lbed9ft/EvbBu2UXPFMNgSvg==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr9114520wrt.164.1586169798735;
        Mon, 06 Apr 2020 03:43:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g2sm25442781wrs.42.2020.04.06.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:43:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 4/5] Drivers: hv: make sure that 'struct vmbus_channel_message_header' compiles correctly
Date:   Mon,  6 Apr 2020 12:43:15 +0200
Message-Id: <20200406104316.45303-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
References: <20200406104154.45010-1-vkuznets@redhat.com>
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4ab2f1511dcb..94c02433827d 100644
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

