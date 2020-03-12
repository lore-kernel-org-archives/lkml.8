Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826FEC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC38920754
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="frP86w7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbgCLC6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:58:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38453 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbgCLC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:58:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so2043646plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 19:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SeETz7OXYdn/hmWZRZ2XZZ0rT8aYFJbbHfhavYQw3LA=;
        b=frP86w7bphR1Z7uDrs9zocm8B1BWYGaKwCbmSsE+IztfjnVt70UpPd5a2aeEIagfoR
         6/0rDqSEtmn3qHK2h4uhxzYj4N1ZVu7oDmDNa9SBIWYsPz/fl+8SBUyT7ks+RydaAq/R
         8cZOsDWyCmteS8dp9uOZgkXvgAR1fQlfkW3piJcPGWr7onIRpQu3DWdPGWH5bZJTxWPh
         v2zUC4LJzP0QHxc474Guh4ULRGe2tK9B/3v3KQyQvWvvOW6Vu6Su683erl3V5KcLMPw3
         ypWGw3X//xc3BGQYuVnJtfN9b8LLXcYu+iLM1GKUwCwpHdNh4K4i3WKUWL7SDcjqVQ1D
         mIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SeETz7OXYdn/hmWZRZ2XZZ0rT8aYFJbbHfhavYQw3LA=;
        b=ETgAI4/hnQVeNUawg5yrnsr0pwMQHxCaw+BvRBgB3G9QrUxJ/qmNMiZtQgSsJ6xvon
         S1wydhG+Ntk1ObsKYtRKSmAZUSu/MnaOlVwZoky+TRLN+3he+zagwtrfbuIcIahCr6PW
         Sc0NVe46tRqWYisTQds7FNXtGB3JVdydeTUy47yM19N3upxwT2EDmhV+oE71i8275vlU
         b0dzPoeRQM9hasW8zLpVSnQ/TFs97VCXafRRqaJ6KEk3eD8cRVmEV9RphJ55krzdhkMN
         vz4HrKxt/hpKAX1p2AfPUqCbZGti9NGbGfQUdDdLeCsAmDQKHqlCvv+jlojZzt/09ZQ1
         QsQw==
X-Gm-Message-State: ANhLgQ3uK5Lc6SzDC4q98EbgyrJXP+hxgmV+cEsrgk+xIcrTU9AqNbN3
        njXGvOIdoCw6RU1feoY+QZ7N+Q==
X-Google-Smtp-Source: ADFU+vtAAgdfElq06tfd5YckyfvzrJUYbz75snj/PU15B2U+NbNEZx6l8hpSWV3aXzjE8mcVwGUbag==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr5903125plk.294.1583981924663;
        Wed, 11 Mar 2020 19:58:44 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i11sm1910322pfd.202.2020.03.11.19.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 19:58:44 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 2/2] riscv: Use macro definition instead of magic number
Date:   Thu, 12 Mar 2020 10:58:36 +0800
Message-Id: <20200312025836.68977-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312025836.68977-1-zong.li@sifive.com>
References: <20200312025836.68977-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KERN_VIRT_START defines the start virtual address of kernel space.
Use this macro instead of magic number.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/kasan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index eee6e6588b12..b47045cb85ce 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -13,7 +13,7 @@
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
 #define KASAN_SHADOW_SIZE	(UL(1) << (38 - KASAN_SHADOW_SCALE_SHIFT))
-#define KASAN_SHADOW_START	0xffffffc000000000 /* 2^64 - 2^38 */
+#define KASAN_SHADOW_START	KERN_VIRT_START /* 2^64 - 2^38 */
 #define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
 
 #define KASAN_SHADOW_OFFSET	(KASAN_SHADOW_END - (1ULL << \
-- 
2.25.1

