Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C8C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBC62070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550231;
	bh=vYw31K3dfJsinyVeUtCj5HraLL20BgC3xRu/iOIZ+8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HnC/obV8eyWxk9UmfrqVZxMZgg6IMybzRFL8nKIE1nEjlK0XDW/+MTsMea2XetNPs
	 SSQpfdkMZyKakFCVegPwf8OqHirBgcx8j9p7pcIS8iJy1LITYti9kojlW6LwY10Du1
	 F08SQ+2PGiEuw7T31cA3pX+dw8JeseUKHuyAiOEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgDVKK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgDVKKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:10:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7C82071E;
        Wed, 22 Apr 2020 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550219;
        bh=vYw31K3dfJsinyVeUtCj5HraLL20BgC3xRu/iOIZ+8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7zKkuDGikZIKPS6Ud0v3W2liaCS7Pr4xHiyhMC5z4l0wIsJc5fjR0Cm9QJxn5rEF
         ST1z1ciH9fy3hmv14e87pZE+4WqsuusTTwv2Z6C0mgSnJMGFS+CTgDeZAEpyYZH1n/
         KwRqXhB2NJDiehvgXIFohlK9+FZ0v/qgtdgrJiJw=
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
Subject: [PATCH 4.14 016/199] PCI/switchtec: Fix init_completion race condition with poll_wait()
Date:   Wed, 22 Apr 2020 11:55:42 +0200
Message-Id: <20200422095059.842802344@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
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
index bf229b442e723..6ef0d4b756f09 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -412,7 +412,7 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	kref_get(&stuser->kref);
 	stuser->read_len = sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	init_completion(&stuser->comp);
+	reinit_completion(&stuser->comp);
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
 
 	mrpc_cmd_submit(stdev);
-- 
2.20.1



