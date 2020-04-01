Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD930C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A75120719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759227;
	bh=hcTIdJiCXvD/krcQTIT1ht5ObWgrP9GQXXZnj8Jlw7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ks05Fki3uHtcoTdzBQO4UHP2eGbDi7DvuT7ZlemoxE+sSNl16iLmOFMQWoS6cnzOY
	 EkVRb/Ccb1HoFIxK1NIadlaD4gNUCu7n3MT3tjggP/dWA+3n2qrcYJS7A4203OmXse
	 G/eE/2SN1ng+/hpzMW9Qj8maayS7RPzZZe5Luyv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbgDAQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389041AbgDAQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:40:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD932063A;
        Wed,  1 Apr 2020 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759219;
        bh=hcTIdJiCXvD/krcQTIT1ht5ObWgrP9GQXXZnj8Jlw7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1ZPHvn2fUrb4XIP7pH7nfSjZLxgFXxG1Cw1GLnt79fr2CLfF/PIt4bjEGsUVE+Es
         JK3rbNehlgNNOQCh54DV7KWMfdCTJYjf0f+x2IqhvoHOSwGjb39UAJor8eeCR2WkKE
         aBpjgaNWHnxaJmxrNG4V5qDvpkB9mYUOKuQ1FQV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>,
        Julien Grall <jgrall@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 012/148] xenbus: req->err should be updated before req->state
Date:   Wed,  1 Apr 2020 18:16:44 +0200
Message-Id: <20200401161553.400413476@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit 8130b9d5b5abf26f9927b487c15319a187775f34 ]

This patch adds the barrier to guarantee that req->err is always updated
before req->state.

Otherwise, read_reply() would not return ERR_PTR(req->err) but
req->body, when process_writes()->xb_write() is failed.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Link: https://lore.kernel.org/r/20200303221423.21962-2-dongli.zhang@oracle.com
Reviewed-by: Julien Grall <jgrall@amazon.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xenbus/xenbus_comms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index 852ed161fc2a7..eb5151fc8efab 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -397,6 +397,8 @@ static int process_writes(void)
 	if (state.req->state == xb_req_state_aborted)
 		kfree(state.req);
 	else {
+		/* write err, then update state */
+		virt_wmb();
 		state.req->state = xb_req_state_got_reply;
 		wake_up(&state.req->wq);
 	}
-- 
2.20.1



