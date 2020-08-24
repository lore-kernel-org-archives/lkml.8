Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15062207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262361;
	bh=R1B5YlnuzoIxPenPcQddKaeKp1L2RjlrEpwuGhilwK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ew06BAerTCP1JtJVeAr5FRCQTIY4zLK78Vx+lnK0EqNhI1J2IkQR6clmjBsb5SuSz
	 HgOjfGiZlz7t3iUoKz+1TnuLNmepdC4LP9kOAhlR7U/0gWEf30MqTZjLrCws2eyw8n
	 n9mcndd6t1uE0QenGbSC8aNnnvi6PhLvaEnXRUXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgHXJqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbgHXImb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:42:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42BBD2074D;
        Mon, 24 Aug 2020 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258550;
        bh=R1B5YlnuzoIxPenPcQddKaeKp1L2RjlrEpwuGhilwK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmT3e0Y4sfSINf3H6JMwQShFutIPScSqLTDvVMmog8TmsJyrrHQUhRsS0t1Rl4noO
         1OCFDO+I3uL6qNpiRVLZJPdFdkgS49m6jIJSFy9gSeVmjOa8waEHNH6JtnevhU00LD
         5HZ/WL5590qw1c36tWpwUEwl6TS4a2vwpNEM01CA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 085/124] s390/ptrace: fix storage key handling
Date:   Mon, 24 Aug 2020 10:30:19 +0200
Message-Id: <20200824082413.594160646@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit fd78c59446b8d050ecf3e0897c5a486c7de7c595 ]

The key member of the runtime instrumentation control block contains
only the access key, not the complete storage key. Therefore the value
must be shifted by four bits. Since existing user space does not
necessarily query and set the access key correctly, just ignore the
user space provided key and use the correct one.
Note: this is only relevant for debugging purposes in case somebody
compiles a kernel with a default storage access key set to a value not
equal to zero.

Fixes: 262832bc5acd ("s390/ptrace: add runtime instrumention register get/set")
Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/ptrace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index e007224b65bb2..a266ffed04df5 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -1311,7 +1311,6 @@ static bool is_ri_cb_valid(struct runtime_instr_cb *cb)
 		cb->pc == 1 &&
 		cb->qc == 0 &&
 		cb->reserved2 == 0 &&
-		cb->key == PAGE_DEFAULT_KEY &&
 		cb->reserved3 == 0 &&
 		cb->reserved4 == 0 &&
 		cb->reserved5 == 0 &&
@@ -1375,7 +1374,11 @@ static int s390_runtime_instr_set(struct task_struct *target,
 		kfree(data);
 		return -EINVAL;
 	}
-
+	/*
+	 * Override access key in any case, since user space should
+	 * not be able to set it, nor should it care about it.
+	 */
+	ri_cb.key = PAGE_DEFAULT_KEY >> 4;
 	preempt_disable();
 	if (!target->thread.ri_cb)
 		target->thread.ri_cb = data;
-- 
2.25.1



