Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AA3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F51C2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTDWWzPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgDAKgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:36:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59898 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbgDAKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTMAdqU+ugzMWvGlDNrRAiYz9yYUyPqvJDeNn6ohk+E=;
        b=jTDWWzPIKGimIpbLPB6x0hfuk2ocogAvAoHxS2tguo086X+qy7eiH2zuoNQrt//zXdEI5s
        3ufeX8UWZy9XpeA5TpdpoyYZyNVbOHsMm7UDTVLGJTOs7Sh57gxh/IaEs+sm7Y4/ZRhIq1
        YJSDU6i3kQ+GOmd7izvSaRxKaOxUSOg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-FxTSpXmGMxGSxYCpzd1xLA-1; Wed, 01 Apr 2020 06:36:44 -0400
X-MC-Unique: FxTSpXmGMxGSxYCpzd1xLA-1
Received: by mail-wm1-f71.google.com with SMTP id e16so1412751wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTMAdqU+ugzMWvGlDNrRAiYz9yYUyPqvJDeNn6ohk+E=;
        b=DLYZPgOSdRo2m7NBxg3QDAM4GvogPjqn3rlRvxXB0GXRrd0R1ZTLtKe4PH3Eg6gKDn
         D3ET0vsGYdQMsDDlnzovCtxtrpaT8MVxgUS+bye7XUOcGMjh/thl30WPztBR5rfEbWQF
         ABssnAcKXuaIBtUhM9D1NZtSBJcypgMgnCMmyAQJqiNZHON6ZUokSbA/ntFL4folq+n5
         Vhba9/IQsWjyTvhTzJOwWicGCMWNd8HHhglRVsFDto0Zh8j62ENRVS9Rqo+fLmikl+HA
         awY3gDAV5wdeccauDoTsUF+hvd0BaIBY6IL4f3jq4kKTieKPG6jYt5Y2IFiE9MmxnmBi
         tkdQ==
X-Gm-Message-State: ANhLgQ2AjLg/dOXYQA9tCjHnUGZ+TaB8KgDreLPL8vslw7d0yHfbQ/YE
        rKk3T897n/tZCffQVEq3z3KXr7xhlccwVSoJSLV6T4Vf77fAMXZGUxa++c7da6xR0f1goKas+1J
        mxvCpxNW6N6QKJStFNdLZc6CH
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr25360958wrx.228.1585737403125;
        Wed, 01 Apr 2020 03:36:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvAMOV86AAHVFcAO0uJb1VAvbbzxIEVyPp1fjfHoIulN0RBiry0OhOybZEb+BNwNyvFyAm+9w==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr25360940wrx.228.1585737402886;
        Wed, 01 Apr 2020 03:36:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b187sm2247522wmc.14.2020.04.01.03.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:36:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 1/5] Drivers: hv: copy from message page only what's needed
Date:   Wed,  1 Apr 2020 12:36:34 +0200
Message-Id: <20200401103638.1406431-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103638.1406431-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
messages. Each message comes with a header (16 bytes) which specifies the
payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
look at the real message length and copies the whole slot to a temporary
buffer before passing it to message handlers. This is potentially dangerous
as hypervisor doesn't have to clean the whole slot when putting a new
message there and a message handler can get access to some data which
belongs to a previous message.

Note, this is not currently a problem because all message handlers are
in-kernel but eventually we may e.g. get this exported to userspace.

Note also, that this is not a performance critical path: messages (unlike
events) represent rare events so it doesn't really matter (from performance
point of view) if we copy too much.

Fix the issue by taking into account the real message length. The temporary
buffer allocated by vmbus_on_msg_dpc() remains fixed size for now.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/vmbus_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378c27421..2b5572146358 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1043,7 +1043,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, msg, sizeof(*msg));
+		memcpy(&ctx->msg, msg, sizeof(msg->header) +
+		       msg->header.payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
-- 
2.25.1

