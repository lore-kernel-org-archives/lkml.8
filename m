Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C3BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BBD2070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3fJQVeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgHDEYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDEYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:24:12 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4734FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 21:24:12 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g19so9585806plq.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 21:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDmLjdzKLB0Osgf6ewGVRDSUgUng436lOPq0tCkDdNg=;
        b=D3fJQVeIEd4R3yAQ6SOOh0aLBpHPeIFCZeNxoOPkIaX0RJKnnfwsRTsaYh7jV4wB1F
         67tpd6pr/2lzwWZCHHGe4k4eUb+nm3LqgfNtBb8tYIz0K1rVdCeoZvlbbG+8u5D1XLkL
         iUwGfQscXVDJB+xXV84kZrlcOneyVn3Q/x21khruEzeGQt2D1sJGP5UuYDyjXDhO2BIc
         4Hr1NunmBuWXSgqQab2vKyFwuB9T6aY0RfZzKl3SoIjpLefYmqJWQOZG98kocG+BTV0K
         1aNkqCbBKj8OvQViPyPSg3DlR7CVizuJjrTSoStfwQWlQDKj7fBY/hsAE/3AQPbzbH5u
         hgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDmLjdzKLB0Osgf6ewGVRDSUgUng436lOPq0tCkDdNg=;
        b=Mx4hoKcG/dtimD+7kRlEltfVAnWi1aIZXmzR5cBSz0F83mNfZ2a3bEG2rODnek2Ktd
         VP+tr2AjkDT67X8xu2ZsU1TIRr6cwh3I+D8m7h2FlM34akQ2f00Gm1d0DEghaVNiEVKE
         IM0q3m+AXMa9MqF+PDSCXtudAhe1zf7zrpHwCgJ2Ah2bRcdO1MOK9n7rAgmMbdLU/a4c
         5NFuOTSKtMq0evQ9Wjeyfxk7VmeFuCEL0djFhWu/48zuzhxSid7urvJjvp8m8mOTXcrE
         C5BbYMV9jJ+yAakcxxAvbk6uTr/0KdsH64SsUwFbXMkt3+oDRAWV1dFBWc/APduUUtHD
         mqiw==
X-Gm-Message-State: AOAM533qoAXnPZr0BM/XyYP91VVw9yTgiruKkkxiZ5dMA83reKeFywqD
        ao3He6zmLgUO0nQC0/b6iwadjlqU
X-Google-Smtp-Source: ABdhPJwQwPhaJgeJn3Mb0+uHOLC5qvkBw7E1WqGqJCFpWn9QFgWarPSt6bLN5/8hkZBlFHHGzb4vYw==
X-Received: by 2002:a17:90a:d78f:: with SMTP id z15mr2570512pju.9.1596515051456;
        Mon, 03 Aug 2020 21:24:11 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id w64sm4864734pfw.18.2020.08.03.21.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 21:24:10 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, openrisc@lists.librecores.org
Subject: [PATCH 1/6] openrisc: io: Fixup defines and move include to the end
Date:   Tue,  4 Aug 2020 13:23:49 +0900
Message-Id: <20200804042354.3930694-2-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This didn't seem to cause any issues, but while working on fixing up
sparse annotations for OpenRISC I noticed this.  This patch moves the
include of asm-generic/io.h to the end of the file.  Also, we add
defines of ioremap and iounmap, that way we don't get duplicate
definitions from asm-generic/io.h.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/io.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index db02fb2077d9..ef985540b674 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -25,9 +25,12 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#include <asm-generic/io.h>
-
+#define ioremap ioremap
 void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+
+#define iounmap iounmap
 extern void iounmap(void *addr);
 
+#include <asm-generic/io.h>
+
 #endif
-- 
2.26.2

