Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D15AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D847820786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580850;
	bh=bAf65E3ga0SJKOAJCczAPgrFCM/j3BGNsKF5UllZPlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qCIEsKALMY+5noHxeRg+j1dB6zvKz/FLDiRFsmNHtvV6h89UUT4XA5vSwP69jJ1wC
	 j1VPgJx90R8vvANhAZkCVFXaYiv3vX+5LvWcZTjXqKnTgYaGBSsWqFFAjyI7G9gqCV
	 0b6ooP6gITqsH74FFikz5pILDead8aKiQ9La0OfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404935AbgFSPeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404675AbgFSPc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:32:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6F121973;
        Fri, 19 Jun 2020 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580776;
        bh=bAf65E3ga0SJKOAJCczAPgrFCM/j3BGNsKF5UllZPlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDccz0CFVYiflYSPlF2lfrea9LrsuEIR+PfIaHKjyGGPQzyedZfk9ji9P82/V3rpj
         a73v81ePMpMzhlmH3JtuZv1O6y0V44Z97U3eN+R4eI7Ajrq9A2mqIlnwAnFWgv0ya/
         awvhQMB6m8n4+xbmJeKSpl3BE+LMViPkX0uI79Jk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.7 348/376] block: nr_sects_write(): Disable preemption on seqcount write
Date:   Fri, 19 Jun 2020 16:34:26 +0200
Message-Id: <20200619141726.799900818@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed S. Darwish <a.darwish@linutronix.de>

commit 15b81ce5abdc4b502aa31dff2d415b79d2349d2f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/block/blk.h
+++ b/block/blk.h
@@ -470,9 +470,11 @@ static inline sector_t part_nr_sects_rea
 static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	preempt_disable();
 	write_seqcount_begin(&part->nr_sects_seq);
 	part->nr_sects = size;
 	write_seqcount_end(&part->nr_sects_seq);
+	preempt_enable();
 #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 	preempt_disable();
 	part->nr_sects = size;


