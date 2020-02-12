Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8A6C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19717206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="iynOD97N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgBLPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:42:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34113 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgBLPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:42:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so988194wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5OPGKMDn7v6yquvwDI32AgBMyK1Qn16Qz2yjNol8DFg=;
        b=iynOD97NVB3crI2MU6hPS1zHYgD6a1SO/HVX3FzDyD0a5T5AiakT13hOPUU/wdoCHf
         HOWkcQpj7D1dmy6zR7n7NqJda4P950XJVTdKkQKuj4uSopI0hWmwEsxwsggK454QBfJW
         tcjZXS8vVpW/yUXnbB+JDJZFhlFgrKu1MpWlZLfrtcUa74myEIQFCYOzSi+O1wdjxqnF
         txsVVPpR8q+DnvYdL8SwIjm9nSqYsA3rmv54nZOBmhYQ3HRpgR3/JkYGnmrKTimb3C+H
         HuqWzaoNES9ehirn5hDDdhwQSdMPxvDye7O8kVuUQxpssrPvfVQeZgYglSvIXc9mnLfk
         AAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5OPGKMDn7v6yquvwDI32AgBMyK1Qn16Qz2yjNol8DFg=;
        b=cWZk6/0w2LWj8y3VcOOGd1z7DXasu1Tkc4aSjMgg3wvxl5uPZYzLtLLRRlFRYyxuev
         5OrQPBzZHKJzC8/JtNQdGOwSofhO1+D84XqH2KMQGQVPW0QMD6GEEOWgINMxsKzr1iNQ
         IRcoivvewgogrPvSDOGl/l+dPSZoByoAqcZS9gd3GKO7CWzChLyujSJthk+OQSn85XQ4
         esARWgf4llXHchXXBE3YKKXt7whxqJM0v+/mAl6UtXcQTOSuVTlZ+A/E/prtImESEYoZ
         n3j4d/16BPKPlL0hjLKMOVXcQLpNH0nPojqo8DaFPMzXIezKl83YIntz/Nq/61OABeh4
         OYmA==
X-Gm-Message-State: APjAAAUB/jFJmz6u0K2mVECmI+vUqoFEQtElC583/2CIvxiQrx7ZOnnQ
        cEymbI6aGu9KoFzt3pHQGjBcsmU5ouLXOySI
X-Google-Smtp-Source: APXvYqwTB/7dFKrv3SfUump6EO/4jrG4PBNTFCscyZ6T0MSXjn8K1UkOhulYTx2yZpzVtbqejHBOxg==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr15347181wrq.43.1581522160957;
        Wed, 12 Feb 2020 07:42:40 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id n3sm1184741wmc.27.2020.02.12.07.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 07:42:40 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/7] microblaze: Remove disabling IRQ while pte_update() run
Date:   Wed, 12 Feb 2020 16:42:27 +0100
Message-Id: <79fa9cfeefc699b21f500c53279098b66275e2bb.1581522136.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581522136.git.michal.simek@xilinx.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall <stefan.asserhall@xilinx.com>

There is no need to disable local IRQ for pte update. Use exclusive
load/store instruction for it.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/pgtable.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 45b30878fc17..cf1e3095514b 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -372,20 +372,19 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 static inline unsigned long pte_update(pte_t *p, unsigned long clr,
 				unsigned long set)
 {
-	unsigned long flags, old, tmp;
-
-	raw_local_irq_save(flags);
-
-	__asm__ __volatile__(	"lw	%0, %2, r0	\n"
-				"andn	%1, %0, %3	\n"
-				"or	%1, %1, %4	\n"
-				"sw	%1, %2, r0	\n"
+	unsigned long old, tmp;
+
+	__asm__ __volatile__(
+			"1:	lwx	%0, %2, r0;\n"
+			"	andn	%1, %0, %3;\n"
+			"	or	%1, %1, %4;\n"
+			"	swx	%1, %2, r0;\n"
+			"	addic	%1, r0, 0;\n"
+			"	bnei	%1, 1b;\n"
 			: "=&r" (old), "=&r" (tmp)
 			: "r" ((unsigned long)(p + 1) - 4), "r" (clr), "r" (set)
 			: "cc");
 
-	raw_local_irq_restore(flags);
-
 	return old;
 }
 
-- 
2.25.0

