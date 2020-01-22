Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A2C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F0F24684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndmsystems-com.20150623.gappssmtp.com header.i=@ndmsystems-com.20150623.gappssmtp.com header.b="Fb5pQoU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAVMkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:40:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43094 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgAVMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:40:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so7072930wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndmsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VxX43mS0iWUpbkE5n95NgX2FTZO3NdGDZP/Z4S/IGE=;
        b=Fb5pQoU1ctZ9lPR9YUEJPAibeMCFTCP8VrleQodfeto8e/z9pbKmbymipTUPDjyZid
         l+rWGRxRAAh8RoeDMZIk30KoclIWAZh5UqmBzPiesZmToJp3OJ6dxtkQqkH6Ljb2g7m5
         1B/5b6FgTRfwK1Bwk6NEBrR2iw78BxWZiLC5V9g+dR+ypODibZSNR7aNvxgu2INGXuGs
         UNnyT9iRE6M/Tu/k4oASO9I+pPC+2R3j4pK8fiiTlcYYDHFb58cp6tDr97X8H7rOpF05
         R0I4DpZRpM3s11WHuBss9pb8T/MzuSSp3LMqhMLpVVo5pDhoANDpIYJohQ3QlJS7uIrw
         F/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VxX43mS0iWUpbkE5n95NgX2FTZO3NdGDZP/Z4S/IGE=;
        b=MmoOk/f2vmgolwWeqLnmiVjA53zflPr7HPRNVAJ6HJsmForwga3xJN1qqa/sgQHYFg
         NNmfDVeZcZjx/v/7aoYe1wuvi+czNaav1XHR0KPZOjA3tPwf7CTKn6NXYdtHoXMtazcc
         zJ8Iq5O2TGFYR7dD9BqLIOuXSuSNwdLGMAROp0WmcI9BTfUSjK1Jk521kCVuXMcW04hq
         ynjaL6wiH8v4JnENCYr7xsQ3RfyQjfVyvemgv9e6LVUJT6aYK/TtMpLc/VUVKTbGTlQ1
         p1t1lY+L4wrPy183HiqaQhHzVFNjnVx2JqAlLdIPs2WApMpWsWhVQnuUPm5IHMON1FGy
         Kf3Q==
X-Gm-Message-State: APjAAAXV23HeLxD3jBe4qGkMZovv+7i2PCByOOxKbKti6bjhkowKTsza
        +gmfro5tkurb9awTBjSo7NQneA==
X-Google-Smtp-Source: APXvYqxEei9vxIzoKTMFvJrKoh4gJ306MA/qsmhlSCdtv2ugncchWijKTkwhZpCwyJxcDFKnKuY0Pg==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr11534785wrn.124.1579696799115;
        Wed, 22 Jan 2020 04:39:59 -0800 (PST)
Received: from cbox-EPYC.ndm9.net ([2a01:4f8:13b:67::2])
        by smtp.googlemail.com with ESMTPSA id g25sm4833490wmh.3.2020.01.22.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 04:39:58 -0800 (PST)
From:   Sergey Korolev <s.korolev@ndmsystems.com>
To:     linux-mips@vger.kernel.org
Cc:     s.korolev@ndmsystems.com, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sync-r4k: do slave counter synchronization with disabled HW interrupts
Date:   Wed, 22 Jan 2020 15:39:08 +0300
Message-Id: <20200122123909.8188-1-s.korolev@ndmsystems.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

synchronise_count_slave() called with an enabled in mips_clockevent_init()
timer interrupt which may decrease synchronization precision.

Signed-off-by: Sergey Korolev <s.korolev@ndmsystems.com>
---
 arch/mips/kernel/sync-r4k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index f2973ce87f53..abdd7aaa3311 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -90,6 +90,9 @@ void synchronise_count_master(int cpu)
 void synchronise_count_slave(int cpu)
 {
 	int i;
+	unsigned long flags;
+
+	local_irq_save(flags);
 
 	/*
 	 * Not every cpu is online at the time this gets called,
@@ -113,5 +116,7 @@ void synchronise_count_slave(int cpu)
 	}
 	/* Arrange for an interrupt in a short while */
 	write_c0_compare(read_c0_count() + COUNTON);
+
+	local_irq_restore(flags);
 }
 #undef NR_LOOPS
-- 
2.20.1

