Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234E42076C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cozv58Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgDFKnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:43:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727048AbgDFKnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOoW9499EvJVij0307Is5KB/srLre3Eb87DAHnH4ats=;
        b=Cozv58TpD+8sVyog6PTa04WsDU2bLN10kc86FzHzV8A66s4ueTeVkW9tyIe7hhdD7punIc
        NtkbfmCZj6QTStOVkUdTZNsSjOerelgAXL0Zrb655/kC7J9B5Gc9Z6rbul8XIkDQUhAoVn
        ktiDO/c9iAexIuayWiTA5nUKv/+fxnw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-xOjSppvOM3eHWqBFKexvpQ-1; Mon, 06 Apr 2020 06:43:30 -0400
X-MC-Unique: xOjSppvOM3eHWqBFKexvpQ-1
Received: by mail-wr1-f72.google.com with SMTP id g6so2393410wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOoW9499EvJVij0307Is5KB/srLre3Eb87DAHnH4ats=;
        b=Q6PgtqP45evSPQlIKaNOaUF3Ep9/OmdlBAAZZgN7qE7WadjuFQYNutIY4MDOO3jCVK
         e1epMlRbjvl2Z6M+U/ecRD4/+Al8k/JrdUkkaFQ+IMUK5o56mM22fbAjKU7CnSxCazvR
         eXm/ieZAgW8lOhzb4t2lWPDUoF0UOD5W0HI/j127MqLohVEgAUT6wXxsaXpcRjMy1uG6
         hTgsNsEcpCl52GkF5vqkUfQjmgmQvuCt9cQ3CwfwZgGWt+RIdH8I6/2EBIzWBxeVVT41
         8qL2FDNQMh9ZEM8qvtYidgiYDNnyjPnPeCfTIDsFx9l+MkMlK96Y5sDMmrseFtnbxLWK
         uehg==
X-Gm-Message-State: AGi0PuZOR75Cujj5SZ4qNLWIltD64mHTdsJ9pDDNcCg4IaF2vRKtjowx
        bg1zgklfMXGNjSw2pq5zuolFo73/AvOFT2ZAiBufPx3lXsWM3EgHCI0G1FWNEwCmjarhb3i9ytu
        pIPmx4sJbNID+cTvk/5D3JGXF
X-Received: by 2002:a7b:c050:: with SMTP id u16mr23634743wmc.68.1586169809018;
        Mon, 06 Apr 2020 03:43:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypIvdXbdHDNxdM9vCZ47FkUkV3BXmQ41VqT7ZmCSc+rF/xbW8UtoFYMmmzhlMj1eE4dFibGriw==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr23634720wmc.68.1586169808789;
        Mon, 06 Apr 2020 03:43:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g2sm25443360wrs.42.2020.04.06.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:43:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 5/5] Drivers: hv: check VMBus messages lengths
Date:   Mon,  6 Apr 2020 12:43:26 +0200
Message-Id: <20200406104326.45361-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
References: <20200406104154.45010-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMBus message handlers (channel_message_table) receive a pointer to
'struct vmbus_channel_message_header' and cast it to a structure of their
choice, which is sometimes longer than the header. We, however, don't check
that the message is long enough so in case hypervisor screws up we'll be
accessing memory beyond what was allocated for temporary buffer.

Previously, we used to always allocate and copy 256 bytes from message page
to temporary buffer but this is hardly better: in case the message is
shorter than we expect we'll be trying to consume garbage as some real
data and no memory guarding technique will be able to identify an issue.

Introduce 'min_payload_len' to 'struct vmbus_channel_message_table_entry'
and check against it in vmbus_on_msg_dpc(). Note, we can't require the
exact length as new hypervisor versions may add extra fields to messages,
we only check that the message is not shorter than we expect.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 54 ++++++++++++++++++++++-----------------
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    |  6 +++++
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c6bcfee6ac99..d4ccc9b203fa 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1329,30 +1329,36 @@ static void vmbus_onversion_response(
 /* Channel message dispatch table */
 const struct vmbus_channel_message_table_entry
 channel_message_table[CHANNELMSG_COUNT] = {
-	{ CHANNELMSG_INVALID,			0, NULL },
-	{ CHANNELMSG_OFFERCHANNEL,		0, vmbus_onoffer },
-	{ CHANNELMSG_RESCIND_CHANNELOFFER,	0, vmbus_onoffer_rescind },
-	{ CHANNELMSG_REQUESTOFFERS,		0, NULL },
-	{ CHANNELMSG_ALLOFFERS_DELIVERED,	1, vmbus_onoffers_delivered },
-	{ CHANNELMSG_OPENCHANNEL,		0, NULL },
-	{ CHANNELMSG_OPENCHANNEL_RESULT,	1, vmbus_onopen_result },
-	{ CHANNELMSG_CLOSECHANNEL,		0, NULL },
-	{ CHANNELMSG_GPADL_HEADER,		0, NULL },
-	{ CHANNELMSG_GPADL_BODY,		0, NULL },
-	{ CHANNELMSG_GPADL_CREATED,		1, vmbus_ongpadl_created },
-	{ CHANNELMSG_GPADL_TEARDOWN,		0, NULL },
-	{ CHANNELMSG_GPADL_TORNDOWN,		1, vmbus_ongpadl_torndown },
-	{ CHANNELMSG_RELID_RELEASED,		0, NULL },
-	{ CHANNELMSG_INITIATE_CONTACT,		0, NULL },
-	{ CHANNELMSG_VERSION_RESPONSE,		1, vmbus_onversion_response },
-	{ CHANNELMSG_UNLOAD,			0, NULL },
-	{ CHANNELMSG_UNLOAD_RESPONSE,		1, vmbus_unload_response },
-	{ CHANNELMSG_18,			0, NULL },
-	{ CHANNELMSG_19,			0, NULL },
-	{ CHANNELMSG_20,			0, NULL },
-	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL },
-	{ CHANNELMSG_22,			0, NULL },
-	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL },
+	{ CHANNELMSG_INVALID,			0, NULL, 0},
+	{ CHANNELMSG_OFFERCHANNEL,		0, vmbus_onoffer,
+		sizeof(struct vmbus_channel_offer_channel)},
+	{ CHANNELMSG_RESCIND_CHANNELOFFER,	0, vmbus_onoffer_rescind,
+		sizeof(struct vmbus_channel_rescind_offer) },
+	{ CHANNELMSG_REQUESTOFFERS,		0, NULL, 0},
+	{ CHANNELMSG_ALLOFFERS_DELIVERED,	1, vmbus_onoffers_delivered, 0},
+	{ CHANNELMSG_OPENCHANNEL,		0, NULL, 0},
+	{ CHANNELMSG_OPENCHANNEL_RESULT,	1, vmbus_onopen_result,
+		sizeof(struct vmbus_channel_open_result)},
+	{ CHANNELMSG_CLOSECHANNEL,		0, NULL, 0},
+	{ CHANNELMSG_GPADL_HEADER,		0, NULL, 0},
+	{ CHANNELMSG_GPADL_BODY,		0, NULL, 0},
+	{ CHANNELMSG_GPADL_CREATED,		1, vmbus_ongpadl_created,
+		sizeof(struct vmbus_channel_gpadl_created)},
+	{ CHANNELMSG_GPADL_TEARDOWN,		0, NULL, 0},
+	{ CHANNELMSG_GPADL_TORNDOWN,		1, vmbus_ongpadl_torndown,
+		sizeof(struct vmbus_channel_gpadl_torndown) },
+	{ CHANNELMSG_RELID_RELEASED,		0, NULL, 0},
+	{ CHANNELMSG_INITIATE_CONTACT,		0, NULL, 0},
+	{ CHANNELMSG_VERSION_RESPONSE,		1, vmbus_onversion_response,
+		sizeof(struct vmbus_channel_version_response)},
+	{ CHANNELMSG_UNLOAD,			0, NULL, 0},
+	{ CHANNELMSG_UNLOAD_RESPONSE,		1, vmbus_unload_response, 0},
+	{ CHANNELMSG_18,			0, NULL, 0},
+	{ CHANNELMSG_19,			0, NULL, 0},
+	{ CHANNELMSG_20,			0, NULL, 0},
+	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL, 0},
+	{ CHANNELMSG_22,			0, NULL, 0},
+	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL, 0},
 };
 
 /*
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f5fa3b3c9baf..7fd66a4e2951 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -317,6 +317,7 @@ struct vmbus_channel_message_table_entry {
 	enum vmbus_channel_message_type message_type;
 	enum vmbus_message_handler_type handler_type;
 	void (*message_handler)(struct vmbus_channel_message_header *msg);
+	u32 min_payload_len;
 };
 
 extern const struct vmbus_channel_message_table_entry
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 94c02433827d..d770a2582dd0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1054,6 +1054,12 @@ void vmbus_on_msg_dpc(unsigned long data)
 	if (!entry->message_handler)
 		goto msg_handled;
 
+	if (msg->header.payload_size < entry->min_payload_len) {
+		WARN_ONCE(1, "message too short: msgtype=%d len=%d\n",
+			  hdr->msgtype, msg->header.payload_size);
+		goto msg_handled;
+	}
+
 	if (entry->handler_type	== VMHT_BLOCKING) {
 		ctx = kmalloc(sizeof(*ctx) + msg->header.payload_size,
 			      GFP_ATOMIC);
-- 
2.25.1

