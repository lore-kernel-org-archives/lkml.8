Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9640C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A211320714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="c2oOuwjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgBLI62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42929 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgBLI60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so1179283wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzoziiVR7vR4PzyoA0R1BtNvL298bTwPbZ8hvbCMo1k=;
        b=c2oOuwjQAiTZ7GPYvkNIjvl9NWvz4/CTahKxhijQ1hN8Adwfa06Z/GVtGe3o5StzrT
         /VhUf+E4b69zWDv19xPgeoane1VcpT/5lqmNw7aBFN5Mo0BkRzsNNrmHsJ3dL6XxEI5A
         ZI66pEcR77E4obf895OK/PMVEuYRKHWHUDFuVa8x2ZkIM1+BReFipnrL3A53mUQeAY2t
         QTCt/cJ4KTnRLoAd5sdjkH14RJAueDkJ1YHru/5I/hP1AXipArjAEAXfK8G/4MeV0Wbg
         i/zVIEt+OWhh9U50Uoo7YtvKlhN5SgXW5c5n4IHo9hy9nEol+nUdSBmOR69SiLZFiyR0
         7unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lzoziiVR7vR4PzyoA0R1BtNvL298bTwPbZ8hvbCMo1k=;
        b=SEET94QkOUURViQLiKW94MQo5Q/qP5/dc8UgXjdp7zRQWljmfgANEufBjQYreBpSMn
         IeYMNTNEyCbnLBvV4eidz9v1f3b0D4tjsgfnVkV104aW1A39zbQPiNfjH8DSXErfVcp1
         lHT4YxAfj/T14ToIRXJsbdwAIN03XsydSiAzNd6OMY5Z+O+GEfIaIEUDp6mfEJJIwi/p
         nI3NjbqGTbDvi0nr3JYTSKHBr/IyJ+UwM/dhe6ENEP6Sh45KNLHTQiyz1nfrvusAE6CV
         /zd3yA+EZP5Kdhe5uP1Q1fsBqs/2E/IoXOrYLR9Psbi4RAIongWBzvCngm0OZq0uHpq7
         iXqw==
X-Gm-Message-State: APjAAAVk9UDiR+tFlEeaD9eFLTZAJdIomldmv/Oj88Ih2k7AanMHKmMO
        nvespiiGkkZc5VuUTkQC2y4y8s87qGQQFQ==
X-Google-Smtp-Source: APXvYqxsRfOKMsZAEeJFezagdc1amW5plUSVvpuO5+opnrUcBWR+oaI/xUF3fEwPbQ+ATLCn1AOpkA==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr14546209wrp.2.1581497904511;
        Wed, 12 Feb 2020 00:58:24 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a22sm7476983wmd.20.2020.02.12.00.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:24 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Borislav Petkov <bp@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>
Subject: [PATCH 09/10] microblaze: Define percpu sestion in linker file
Date:   Wed, 12 Feb 2020 09:58:06 +0100
Message-Id: <cc32b5d984c7f3087d16f6248b012d9b8d59fa78.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall <stefan.asserhall@xilinx.com>

Adding SMP requires to have percpu section defined.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/vmlinux.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index 2c09fa3a8a01..df07b3d06cd6 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -13,6 +13,7 @@ ENTRY(microblaze_start)
 
 #define RO_EXCEPTION_TABLE_ALIGN	16
 
+#include <asm/cache.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
@@ -89,6 +90,8 @@ SECTIONS {
 		_KERNEL_SDA_BASE_ = _ssro + (_ssro_size / 2) ;
 	}
 
+	PERCPU_SECTION(L1_CACHE_BYTES)
+
 	. = ALIGN(PAGE_SIZE);
 	__init_begin = .;
 
-- 
2.25.0

