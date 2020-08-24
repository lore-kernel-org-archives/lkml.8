Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405FDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089212067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288282;
	bh=9WsD+M7msmhvOrmHNhbANDUr/qQT8t+aOQRv8aa9ybg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pMxYdPJ/sUJidmPrV8qP6gP3rkRrdYqHjDSpHWWnDAcaxCNxYsgcoLF7vc4YqMTXC
	 cF7YHMQoSt3jo2LPtP5ReLpU/NMXef0Q1G3AK15jlVy28xmpq+ZK7Vu+L2S+TpnIqe
	 bQfbeBM3lsU39CwxdlKpZSYdh+QYVd/UyCQAA/3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHXQ57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbgHXQi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72BFD22D08;
        Mon, 24 Aug 2020 16:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287139;
        bh=9WsD+M7msmhvOrmHNhbANDUr/qQT8t+aOQRv8aa9ybg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/6Dc4nasg/Aqo22rLH6mPOIhbbkoR6UqDARiUChV30jY6ji3kaKPIK29EXdyljsF
         bY5JZiDcLHZDNTbVGEQA1ShEQPf26T7EJChlRbz+EzayKnLQq8vrkt+KvoFzJvM58u
         e6JEtwDnmqD4QUnhRmpcwmU88W7tc93FVPFyjDRY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/21] s390/cio: add cond_resched() in the slow_eval_known_fn() loop
Date:   Mon, 24 Aug 2020 12:38:34 -0400
Message-Id: <20200824163845.606933-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163845.606933-1-sashal@kernel.org>
References: <20200824163845.606933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Vijayan <vneethv@linux.ibm.com>

[ Upstream commit 0b8eb2ee9da1e8c9b8082f404f3948aa82a057b2 ]

The scanning through subchannels during the time of an event could
take significant amount of time in case of platforms with lots of
known subchannels. This might result in higher scheduling latencies
for other tasks especially on systems with a single CPU. Add
cond_resched() call, as the loop in slow_eval_known_fn() can be
executed for a longer duration.

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/css.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index df09ed53ab459..825a8f2703b4f 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -615,6 +615,11 @@ static int slow_eval_known_fn(struct subchannel *sch, void *data)
 		rc = css_evaluate_known_subchannel(sch, 1);
 		if (rc == -EAGAIN)
 			css_schedule_eval(sch->schid);
+		/*
+		 * The loop might take long time for platforms with lots of
+		 * known devices. Allow scheduling here.
+		 */
+		cond_resched();
 	}
 	return 0;
 }
-- 
2.25.1

