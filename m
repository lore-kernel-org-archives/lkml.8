Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA87C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E282071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443186;
	bh=PqdHORoBu8IQMRinRk+mOGPyeYvUa3JSAPiknsC39X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JkxFB6fF29Afgt0b7vgIdlPoOAwB4rqxmRLLrvleunQqbm5wFzIOgjNycsFjdUtWu
	 5NM1qpiFDaGYcZvJkEo3+MJqDh8RtHUCNDZ8+DEukNcD/aSJqfTDtnjMNx1BHBRVy5
	 Vizx8zbollSuA+Qf7oylFwmhQav609tkMpKZuUMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgCQLGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbgCQLGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:06:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41A8320658;
        Tue, 17 Mar 2020 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443176;
        bh=PqdHORoBu8IQMRinRk+mOGPyeYvUa3JSAPiknsC39X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwZogs9NbZ64arm9xoJW3HgfzLCBYKLWfaSEuitNVZl9dOsvR/K+xjjS/0CIf7Mdr
         b+K+kc0Hsu+1ZMayox5Tfle2YVulR8JZMwcyErrBLZ7+w9gkoInJ2hd7IdoSkv1YiO
         Ipl3pnfZSMjXEl/6zCMo/utyMmGeovLQopdRl66s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+b297c6825752e7a07272@syzkaller.appspotmail.com,
        Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 123/123] net/smc: cancel event worker during device removal
Date:   Tue, 17 Mar 2020 11:55:50 +0100
Message-Id: <20200317103319.793659199@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

commit ece0d7bd74615773268475b6b64d6f1ebbd4b4c6 upstream.

During IB device removal, cancel the event worker before the device
structure is freed.

Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
Reported-by: syzbot+b297c6825752e7a07272@syzkaller.appspotmail.com
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/smc/smc_ib.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -568,6 +568,7 @@ static void smc_ib_remove_dev(struct ib_
 	spin_unlock(&smc_ib_devices.lock);
 	smc_ib_cleanup_per_ibdev(smcibdev);
 	ib_unregister_event_handler(&smcibdev->event_handler);
+	cancel_work_sync(&smcibdev->port_event_work);
 	kfree(smcibdev);
 }
 


