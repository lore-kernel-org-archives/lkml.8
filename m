Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D78C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957AF20849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521615;
	bh=8N0lMZjdUztXUFEhxRkHAbX3oX83n7GZBY2Fq6FA18M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lgCKjL+I2DU6C6eseeJiye4sKqV09TceYx2Qul2I1AYcnudgpbP0ZYIv7+lJd/n/1
	 xAA2jE71XcQYDrrkr91tQ19mw7kucbiwMJbl5kbuDLH5EFFwx39PIAKPMX4dpZDxSK
	 wPVHNPYbTLBHyqDGgj8pJMhpnKaqS2OO5Zk8mB0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389740AbgEZS4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389722AbgEZS4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:56:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53CD20870;
        Tue, 26 May 2020 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519365;
        bh=8N0lMZjdUztXUFEhxRkHAbX3oX83n7GZBY2Fq6FA18M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZoDM9m6Y9xxZmbk3nWsxXB90SnpK8MpHPVRxw9MHWavr048TmISyi4z/ZWOVI3c8
         +Gw1q/kIIc8YO/AsJ6mW+TEzw55tx9Gcu9IHqGZViIf8ahso0nQXAYy2DmdgmZHzoE
         Z7YEjb5mDsFA1CRR8LE25HW5BpoS4rcTolbdPiRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Asbjoern Sloth Toennesen <asbjorn@asbjorn.st>,
        "David S. Miller" <davem@davemloft.net>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.4 39/65] net: l2tp: export debug flags to UAPI
Date:   Tue, 26 May 2020 20:52:58 +0200
Message-Id: <20200526183919.240142941@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Asbjørn Sloth Tønnesen <asbjorn@asbjorn.st>

commit 41c43fbee68f4f9a2a9675d83bca91c77862d7f0 upstream.

Move the L2TP_MSG_* definitions to UAPI, as it is part of
the netlink API.

Signed-off-by: Asbjoern Sloth Toennesen <asbjorn@asbjorn.st>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/l2tp.h |   17 ++++++++++++++++-
 net/l2tp/l2tp_core.h      |   10 ----------
 2 files changed, 16 insertions(+), 11 deletions(-)

--- a/include/uapi/linux/l2tp.h
+++ b/include/uapi/linux/l2tp.h
@@ -108,7 +108,7 @@ enum {
 	L2TP_ATTR_VLAN_ID,		/* u16 */
 	L2TP_ATTR_COOKIE,		/* 0, 4 or 8 bytes */
 	L2TP_ATTR_PEER_COOKIE,		/* 0, 4 or 8 bytes */
-	L2TP_ATTR_DEBUG,		/* u32 */
+	L2TP_ATTR_DEBUG,		/* u32, enum l2tp_debug_flags */
 	L2TP_ATTR_RECV_SEQ,		/* u8 */
 	L2TP_ATTR_SEND_SEQ,		/* u8 */
 	L2TP_ATTR_LNS_MODE,		/* u8 */
@@ -173,6 +173,21 @@ enum l2tp_seqmode {
 	L2TP_SEQ_ALL = 2,
 };
 
+/**
+ * enum l2tp_debug_flags - debug message categories for L2TP tunnels/sessions
+ *
+ * @L2TP_MSG_DEBUG: verbose debug (if compiled in)
+ * @L2TP_MSG_CONTROL: userspace - kernel interface
+ * @L2TP_MSG_SEQ: sequence numbers
+ * @L2TP_MSG_DATA: data packets
+ */
+enum l2tp_debug_flags {
+	L2TP_MSG_DEBUG		= (1 << 0),
+	L2TP_MSG_CONTROL	= (1 << 1),
+	L2TP_MSG_SEQ		= (1 << 2),
+	L2TP_MSG_DATA		= (1 << 3),
+};
+
 /*
  * NETLINK_GENERIC related info
  */
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -23,16 +23,6 @@
 #define L2TP_HASH_BITS_2	8
 #define L2TP_HASH_SIZE_2	(1 << L2TP_HASH_BITS_2)
 
-/* Debug message categories for the DEBUG socket option */
-enum {
-	L2TP_MSG_DEBUG		= (1 << 0),	/* verbose debug (if
-						 * compiled in) */
-	L2TP_MSG_CONTROL	= (1 << 1),	/* userspace - kernel
-						 * interface */
-	L2TP_MSG_SEQ		= (1 << 2),	/* sequence numbers */
-	L2TP_MSG_DATA		= (1 << 3),	/* data packets */
-};
-
 struct sk_buff;
 
 struct l2tp_stats {


