Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468E1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CA72076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L4NVGjJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgGPNFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgGPNFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:05:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00654C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:05:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k27so4829992pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9lp+Kxwx0lmE4Cwlw3/F+vQGoahFcCHs4bRN+684nE=;
        b=L4NVGjJ4DvPjs6puIdx8yJNxFpLBd0/It5C6pnxG9k6fFceXEA5VzlWNS11zFIWGwR
         wpwD33JGixX4HMEy9TgBBwvBMY3xVFzWmNJan3dm/m3akokLW3q5PHfwfqtxhD9QOL7H
         4wx20QjtKda8POtSNnsrX5i6o5S+lzGP+04LjZmeYMLPWm+s1iFWqeTqp+n22qgpeAlF
         qnla2J/k+x59dNPck2pkV0riZCslQAD/Xy82YXmK0uSo+QHX5MwVpSAmAjF0TtEWY8Ho
         JEUKqcUXcEDqMxMozlVifBJRVG5t8AaqLcHhi7PpbBx7l+HkV+ilzGH8wB36GnxetM0o
         3Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9lp+Kxwx0lmE4Cwlw3/F+vQGoahFcCHs4bRN+684nE=;
        b=feBe5G/XNbzc+HEYwPLpo+JnRne9/T7xQIW3iGz+Z5LRq2zzyJSUhVGlyS4wl/PX+/
         azGY4uxUnZ5wvHwPVLUvTfHKn6578tWfJdb7TB9/Lv6sUiV7t8a25gGUX4XvcZh0tMZh
         r4VPuCrFvgH99ZCbH6gxo59/Xwjm6v3hKXjqOf4DKpFixn3YQdoys8ljY181UkIgMMSN
         o54cEQ5R1Vn3bEjW3Nd/uwThDr7BmQlfmgmkCiQuSz31nC1Id06c9Lgpg8vC51pSV7kb
         VK7VNDhpCKEsI4zEYNmVuuzIC6Oja4egFUetNUWNCtqIT3yE52/M+IEbHLMHD5K7WWAO
         GCrA==
X-Gm-Message-State: AOAM533WKjKXPbQ/EQRkgMqAVtI7cmuGhSd3XnBHDuxWt3W/eQ6GMuUj
        znn4vq+FuvSglNPcuS6VabrZ7Q==
X-Google-Smtp-Source: ABdhPJwkWq6qUCrMJ7Xg5jzNdHjpMLh+4nr7QZ7Ae/8qhjpcLPgL+7HEDL10K3IpRsGwFWeV3ctDZw==
X-Received: by 2002:a63:ca0c:: with SMTP id n12mr4323915pgi.216.1594904752552;
        Thu, 16 Jul 2020 06:05:52 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id c134sm4770203pfc.115.2020.07.16.06.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:05:51 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 1/2] riscv: Fix build warning for mm/init
Date:   Thu, 16 Jul 2020 21:05:45 +0800
Message-Id: <628efa24c79a493e39ce6ef13017ae52eaf13388.1594886530.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594886530.git.zong.li@sifive.com>
References: <cover.1594886530.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add static keyword for resource_init, this function is only used in this
object file.

The warning message as follow (with W=1 build):

arch/riscv/mm/init.c:520:13:
warning: no previous prototype for 'resource_init' [-Wmissing-prototypes]

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 92002952c621..66f5952f39c0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -517,7 +517,7 @@ void mark_rodata_ro(void)
 }
 #endif
 
-void __init resource_init(void)
+static void __init resource_init(void)
 {
 	struct memblock_region *region;
 
-- 
2.27.0

