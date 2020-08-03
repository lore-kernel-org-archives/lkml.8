Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1361DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE016204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458078;
	bh=hSBw4kuiG9AI2JgvgDHtRSwEZbIlznh+qqR13Tzzt7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H1zXePUCauVScYX/3KwuTD3QBBQvkF4pd2Nvi7ocUA3N//tGGvRAbdFS3N6b2OLND
	 CQ3/fPYoh8scj4frsLXD4mqj9yXANh/uq4z+ivgE8UvgkWhidG4efJWZlXRce9HsxD
	 5Ul0nGJ67u/1rThuqdxYUYz0kGsl0o7T/dmjmhH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgHCMei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgHCMeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:34:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9DFC204EC;
        Mon,  3 Aug 2020 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458060;
        bh=hSBw4kuiG9AI2JgvgDHtRSwEZbIlznh+qqR13Tzzt7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHbYupISdWCItEGK4aSOKvqKyOCCdKPWUnRX2aJRrgMem+YSUMXRZE908salomYeM
         B0nynnd+EUGnAjbUs2F474IZjPie3UaJMjWYKvvP18cqeHoWnfhlZKVe5e8u0gJtJp
         ErKCMo07tbI5Ssuov0oWsurdo3rr3NuV5NBCZIiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 24/51] rds: Prevent kernel-infoleak in rds_notify_queue_get()
Date:   Mon,  3 Aug 2020 14:20:09 +0200
Message-Id: <20200803121850.696632977@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121849.488233135@linuxfoundation.org>
References: <20200803121849.488233135@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>

commit bbc8a99e952226c585ac17477a85ef1194501762 upstream.

rds_notify_queue_get() is potentially copying uninitialized kernel stack
memory to userspace since the compiler may leave a 4-byte hole at the end
of `cmsg`.

In 2016 we tried to fix this issue by doing `= { 0 };` on `cmsg`, which
unfortunately does not always initialize that 4-byte hole. Fix it by using
memset() instead.

Cc: stable@vger.kernel.org
Fixes: f037590fff30 ("rds: fix a leak of kernel memory")
Fixes: bdbe6fbc6a2f ("RDS: recv.c")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rds/recv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -453,12 +453,13 @@ static int rds_still_queued(struct rds_s
 int rds_notify_queue_get(struct rds_sock *rs, struct msghdr *msghdr)
 {
 	struct rds_notifier *notifier;
-	struct rds_rdma_notify cmsg = { 0 }; /* fill holes with zero */
+	struct rds_rdma_notify cmsg;
 	unsigned int count = 0, max_messages = ~0U;
 	unsigned long flags;
 	LIST_HEAD(copy);
 	int err = 0;
 
+	memset(&cmsg, 0, sizeof(cmsg));	/* fill holes with zero */
 
 	/* put_cmsg copies to user space and thus may sleep. We can't do this
 	 * with rs_lock held, so first grab as many notifications as we can stuff


