Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37F3C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3062063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046756;
	bh=RNwFNWBjhyFKt/046IiLuAMSumi5DABqIaiGdEpHIl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nRwEbDfQPn1tAjFPKPsnEVJlBKvOyohlhwte85wggwdukcpmDD+T4rdmO27PM0QFt
	 v/piixGRdskdUCJ44OBQnoaPZ+C6hHRofvoz990t+B+Uaxp5iZsAysArWnOH8L2x8y
	 gp4P5mYlpalDnp8FFCt+jUVQpud1HCcq1jjK/QZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442340AbgDPOTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409047AbgDPNx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:53:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C7F2076D;
        Thu, 16 Apr 2020 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045207;
        bh=RNwFNWBjhyFKt/046IiLuAMSumi5DABqIaiGdEpHIl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMghaPCJQkk1bkc36xf83pdL4zWbg1urlXmXnygiZuVXkeAB1ciEv+0/xblpEX9g2
         uQzzlt5Rtw+ZCU5RO7xk8Jf2/EgoY3dm5FpQ97B/cYGqgcz+sxy4NT13w6t8LDdwA9
         Tt6CJsGH+QOBKvuRF2aRf+quo06zCUzu0a6bkqIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 039/254] PCI/switchtec: Fix init_completion race condition with poll_wait()
Date:   Thu, 16 Apr 2020 15:22:08 +0200
Message-Id: <20200416131330.744544737@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit efbdc769601f4d50018bf7ca50fc9f7c67392ece ]

The call to init_completion() in mrpc_queue_cmd() can theoretically
race with the call to poll_wait() in switchtec_dev_poll().

  poll()			write()
    switchtec_dev_poll()   	  switchtec_dev_write()
      poll_wait(&s->comp.wait);      mrpc_queue_cmd()
			               init_completion(&s->comp)
				         init_waitqueue_head(&s->comp.wait)

To my knowledge, no one has hit this bug.

Fix this by using reinit_completion() instead of init_completion() in
mrpc_queue_cmd().

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/20200313183608.2646-1-logang@deltatee.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index a823b4b8ef8a9..81dc7ac013817 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -175,7 +175,7 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	kref_get(&stuser->kref);
 	stuser->read_len = sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	init_completion(&stuser->comp);
+	reinit_completion(&stuser->comp);
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
 
 	mrpc_cmd_submit(stdev);
-- 
2.20.1



