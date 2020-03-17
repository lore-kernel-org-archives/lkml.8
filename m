Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E7C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D792F2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442804;
	bh=/o/dZP92oihZTAVHX60MsC00JKR8vTFghzVWUhOiMig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OsUXfm0RL8hnBSX8CDJzn4yz2gd0L/w7VSBn0tL6iNlzi6A1Are1KSa4Uz4BFuqsp
	 WbtPxtZqotkDFWPMMq40BX3G0jDIs7fqwA6xqh3Oe62Mqwjy+eA3Cs/DvmkESWMzd3
	 E5ZC0ITFu/LDEfKk9LevWGoWy+tsKmxzjaXOQG54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCQLAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgCQLAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:00:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8858620719;
        Tue, 17 Mar 2020 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442801;
        bh=/o/dZP92oihZTAVHX60MsC00JKR8vTFghzVWUhOiMig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOiWT1+WlWg9yWCvC+tRjyWhFkk95tfI94/lvYZopS+e/hOeG3kP8rXychJs4KRRu
         DF0PZPi/CHsWbkUdUSvaJBahA+lPvsi0V2I5gVVni0b/cQ97dPJH8Tqe+sdmGh8f4Y
         s6i/46TaWZ4gDG5WN7O7RoAs2D4Q0Ua4F9n9Ql7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+b297c6825752e7a07272@syzkaller.appspotmail.com,
        Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 87/89] net/smc: cancel event worker during device removal
Date:   Tue, 17 Mar 2020 11:55:36 +0100
Message-Id: <20200317103310.078791449@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
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
@@ -561,6 +561,7 @@ static void smc_ib_remove_dev(struct ib_
 	smc_pnet_remove_by_ibdev(smcibdev);
 	smc_ib_cleanup_per_ibdev(smcibdev);
 	ib_unregister_event_handler(&smcibdev->event_handler);
+	cancel_work_sync(&smcibdev->port_event_work);
 	kfree(smcibdev);
 }
 


