Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E53AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E097B205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974416;
	bh=TJXeZSGzwfNiVC7VyxV4h8RVxP7uqTTnzNYyvYWstFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RRkpXrIvm/7UZypd66CbHzYVNhLRhjN8Bsyr9N5HmdmsiJkiwNwj6xaqUWBp2bBQv
	 XiS1uk8X1RUjrO2SaQAxSLy5OcJxDEdurNDFljkGXV12OAihIRJ9Qu72NEXysXPmXY
	 WqvNKvpGyhul5/yeCEMr6zrxovt+kXUM5lkrYihk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgIAPd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731167AbgIAPd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:33:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A994205F4;
        Tue,  1 Sep 2020 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974405;
        bh=TJXeZSGzwfNiVC7VyxV4h8RVxP7uqTTnzNYyvYWstFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hu0djrURqG6Eo3CobaGPRrdqkL57+nJyG+YLg6IOqkGl7FKqlanUpASgQDW8B0Wbq
         NuGj+1guTp93HQxjOpXoUGMlgf4f/nMG4NbhjU/GtRiwIs326VHBMX7Fp72yT6AChS
         5hNtbiSNLgnQUhQGg1ddovdGKrnXo5b/4Cj31QGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 133/214] s390/cio: add cond_resched() in the slow_eval_known_fn() loop
Date:   Tue,  1 Sep 2020 17:10:13 +0200
Message-Id: <20200901150959.357707885@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 831850435c23b..5734a78dbb8e6 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -677,6 +677,11 @@ static int slow_eval_known_fn(struct subchannel *sch, void *data)
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



