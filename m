Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1716C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957322168B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945307;
	bh=Z7MgLABaEcjFwT2VaSQCZaosSX4/V77Xd/L2Oy4OCDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gy2FdZs5NEupz+Oyii52E4am33tTJ/tjD+gb1F35xA6KzAWEzD0tyYwt4lRQKBHq6
	 yRCAceL2mJrqLogcL+BMars8uJ2ShUoUbY+/EX5Rb/IP7Qrh583n7cdemOW5zVK7VB
	 JAsknWB9wTtY8LlZw183gWLmWUKPTSRUMLAqd/XM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392712AbgFWUsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392936AbgFWUsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:48:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA9221582;
        Tue, 23 Jun 2020 20:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945303;
        bh=Z7MgLABaEcjFwT2VaSQCZaosSX4/V77Xd/L2Oy4OCDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vASzgM7DpcB9EWXkqCbvXfJyXhWrtP+XFs+y7kQoGbGTQCyzJyLFgNWEMk4E2hi2f
         8hiC63yu76MHZ/ntaKn1xPGcFeA3Lu49nT9DiRE6aOea+2V/y/w0W/IujMFsU/pZaO
         00hbdCBT8stRSmKA9Jh7IaxnsTlV8BokVVPxqdDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 118/136] block: nr_sects_write(): Disable preemption on seqcount write
Date:   Tue, 23 Jun 2020 21:59:34 +0200
Message-Id: <20200623195309.660019420@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed S. Darwish <a.darwish@linutronix.de>

[ Upstream commit 15b81ce5abdc4b502aa31dff2d415b79d2349d2f ]

For optimized block readers not holding a mutex, the "number of sectors"
64-bit value is protected from tearing on 32-bit architectures by a
sequence counter.

Disable preemption before entering that sequence counter's write side
critical section. Otherwise, the read side can preempt the write side
section and spin for the entire scheduler tick. If the reader belongs to
a real-time scheduling class, it can spin forever and the kernel will
livelock.

Fixes: c83f6bf98dc1 ("block: add partition resize function to blkpg ioctl")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/genhd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 550fa358893ae..37f30d62f3a2e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -693,9 +693,11 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
 static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_LBDAF) && defined(CONFIG_SMP)
+	preempt_disable();
 	write_seqcount_begin(&part->nr_sects_seq);
 	part->nr_sects = size;
 	write_seqcount_end(&part->nr_sects_seq);
+	preempt_enable();
 #elif BITS_PER_LONG==32 && defined(CONFIG_LBDAF) && defined(CONFIG_PREEMPT)
 	preempt_disable();
 	part->nr_sects = size;
-- 
2.25.1



