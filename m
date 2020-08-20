Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB63208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918128;
	bh=y9THkhiiKJeRDyWCr7ya56n44L9HHZPKZlZQ585Cktc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SH4hvKuPMyzrZtA1H3eJFuHu1ujjmlDGn9MO+XvVe/0PfAhR+XF/6bQDmgX30ZZGv
	 hQRf1JaHWTsazN6l0xR9Fza1GMdopAaq8G4dVpkUF2vMXou5rKk8dfKLQL2Qvwksb/
	 BfO6KihMXt79zhgoEdDVUG/fj1opEmqtH7TxHzDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHTKIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbgHTKIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:08:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38332206DA;
        Thu, 20 Aug 2020 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918117;
        bh=y9THkhiiKJeRDyWCr7ya56n44L9HHZPKZlZQ585Cktc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GonEKgSlM8yYax3+i/VRbiqy4XobGZdpTpw8YFWoeJSlj7jXTp/E2lsZPpfTg/rPa
         lisF4myGrkeekX/tk89dExFK7+Wj4cH2owGq3YeogpmCltJAR0QQ9y1wx2YV761coB
         slrQas5DLRU+K1JcSuy2khujQUxKlhrNefeFWF5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/228] Drivers: hv: vmbus: Ignore CHANNELMSG_TL_CONNECT_RESULT(23)
Date:   Thu, 20 Aug 2020 11:20:03 +0200
Message-Id: <20200820091608.942276190@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit ddc9d357b991838c2d975e8d7e4e9db26f37a7ff ]

When a Linux hv_sock app tries to connect to a Service GUID on which no
host app is listening, a recent host (RS3+) sends a
CHANNELMSG_TL_CONNECT_RESULT (23) message to Linux and this triggers such
a warning:

unknown msgtype=23
WARNING: CPU: 2 PID: 0 at drivers/hv/vmbus_drv.c:1031 vmbus_on_msg_dpc

Actually Linux can safely ignore the message because the Linux app's
connect() will time out in 2 seconds: see VSOCK_DEFAULT_CONNECT_TIMEOUT
and vsock_stream_connect(). We don't bother to make use of the message
because: 1) it's only supported on recent hosts; 2) a non-trivial effort
is required to use the message in Linux, but the benefit is small.

So, let's not see the warning by silently ignoring the message.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/channel_mgmt.c | 21 +++++++--------------
 drivers/hv/vmbus_drv.c    |  4 ++++
 include/linux/hyperv.h    |  2 ++
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 43eaf54736f4e..462f7f363faab 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1228,6 +1228,8 @@ channel_message_table[CHANNELMSG_COUNT] = {
 	{ CHANNELMSG_19,			0, NULL },
 	{ CHANNELMSG_20,			0, NULL },
 	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL },
+	{ CHANNELMSG_22,			0, NULL },
+	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL },
 };
 
 /*
@@ -1239,23 +1241,14 @@ void vmbus_onmessage(void *context)
 {
 	struct hv_message *msg = context;
 	struct vmbus_channel_message_header *hdr;
-	int size;
 
 	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
-	size = msg->header.payload_size;
 
-	if (hdr->msgtype >= CHANNELMSG_COUNT) {
-		pr_err("Received invalid channel message type %d size %d\n",
-			   hdr->msgtype, size);
-		print_hex_dump_bytes("", DUMP_PREFIX_NONE,
-				     (unsigned char *)msg->u.payload, size);
-		return;
-	}
-
-	if (channel_message_table[hdr->msgtype].message_handler)
-		channel_message_table[hdr->msgtype].message_handler(hdr);
-	else
-		pr_err("Unhandled channel message type %d\n", hdr->msgtype);
+	/*
+	 * vmbus_on_msg_dpc() makes sure the hdr->msgtype here can not go
+	 * out of bound and the message_handler pointer can not be NULL.
+	 */
+	channel_message_table[hdr->msgtype].message_handler(hdr);
 }
 
 /*
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1fd812ed679b4..45b8ccdfb0852 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -890,6 +890,10 @@ void vmbus_on_msg_dpc(unsigned long data)
 	}
 
 	entry = &channel_message_table[hdr->msgtype];
+
+	if (!entry->message_handler)
+		goto msg_handled;
+
 	if (entry->handler_type	== VMHT_BLOCKING) {
 		ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
 		if (ctx == NULL)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 8d3ca6da33421..63cd81e5610d1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -422,6 +422,8 @@ enum vmbus_channel_message_type {
 	CHANNELMSG_19				= 19,
 	CHANNELMSG_20				= 20,
 	CHANNELMSG_TL_CONNECT_REQUEST		= 21,
+	CHANNELMSG_22				= 22,
+	CHANNELMSG_TL_CONNECT_RESULT		= 23,
 	CHANNELMSG_COUNT
 };
 
-- 
2.25.1



