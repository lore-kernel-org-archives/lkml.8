Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5AEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BCB2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863674;
	bh=NTOKe81Ovll/ccnsc0uhvOn2So9NzBfexSU+EaXngzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tm0/xf5c9s8N15rIgMwkzcDb1A2UNXYVhuuEuelDL2y5n2F5jaOXlEL6nTDvJI3/0
	 tMQOMf5m/LWqo5sOAwsjXUe0yLCz5VS+wiJIOYxFeGx+IUOwqVAI+py5uPXrBBawlG
	 KZs8Yj6wGlxN157eGbHQVE723cYOw4wmbVniQwUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgAXLBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387563AbgAXLBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:01:11 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E512075D;
        Fri, 24 Jan 2020 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863670;
        bh=NTOKe81Ovll/ccnsc0uhvOn2So9NzBfexSU+EaXngzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whxnUImyZr1x5qmYcz+y4Djleo1f5V6dOM0HChtdtVJ1SfYbEbrfrx5y3FN4wFwPX
         EwKSltqRKzAK9dzT7xHT4TGGlq1g9Ye7F6S/4ahtppJ8bYb/UfihLZQr+5ajjrf40d
         vt8YfDlyt6v0YHw7mctZCjFuIg++QE6k/tS6jp1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/639] mei: replace POLL* with EPOLL* for write queues.
Date:   Fri, 24 Jan 2020 10:23:33 +0100
Message-Id: <20200124093052.836161274@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

[ Upstream commit 03b2cbb6ea3c73e08fcf72d9ef8e286c4dcbd1fe ]

Looks like during merging the bulk POLL* -> EPOLL* replacement
missed the patch
'commit af336cabe083 ("mei: limit the number of queued writes")'

Fix sparse warning:
drivers/misc/mei/main.c:602:13: warning: restricted __poll_t degrades to integer
drivers/misc/mei/main.c:605:30: warning: invalid assignment: |=
drivers/misc/mei/main.c:605:30:    left side has type restricted __poll_t
drivers/misc/mei/main.c:605:30:    right side has type int

Fixes: af336cabe083 ("mei: limit the number of queued writes")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 4d77a6ae183a9..87281b3695e60 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -599,10 +599,10 @@ static __poll_t mei_poll(struct file *file, poll_table *wait)
 			mei_cl_read_start(cl, mei_cl_mtu(cl), file);
 	}
 
-	if (req_events & (POLLOUT | POLLWRNORM)) {
+	if (req_events & (EPOLLOUT | EPOLLWRNORM)) {
 		poll_wait(file, &cl->tx_wait, wait);
 		if (cl->tx_cb_queued < dev->tx_queue_limit)
-			mask |= POLLOUT | POLLWRNORM;
+			mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
 out:
-- 
2.20.1



