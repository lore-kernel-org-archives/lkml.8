Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6BC206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghMVxlaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgFVLmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgFVLmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:42:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4D3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:42:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so17665301ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7upxflk/uwJVnOQq07I5O9Zu6T4Dkf7XpY3Ofg5BkHw=;
        b=ghMVxlaPyonKoJJOfRxJExOvV0K8wNSBlse7HxWMbjvPxZ4RBiT32xPB4EPv/0UahD
         IO9Et0CBfyfpODfLEOQsnQKO0fIXxmv5kRpsxmwl9T/wj9/fyREskXB5vKWpVImS/x58
         9I6I38qDYvjYJE0+XIh2N3gBmI3/HyRGSfi7DXUIDoMZ+NcHtMLs/Om5HJF96zob06Ef
         +MAC7gLF6bSg/YlqWToFg7nRaQKSGc4tDP0T9F2GIZdwm6AX/5Rc2M9879zSUG4op/0C
         UnwW70xr9aiMzehroKpOQXR3EA4vqe0P8OzbpsyFx7Vwjcz+u79GMqDkYbZ3IUl6iHqN
         KKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7upxflk/uwJVnOQq07I5O9Zu6T4Dkf7XpY3Ofg5BkHw=;
        b=dlXYz4R4X7G0tNcjES/2pLSqW0FBSnYt6V3/HfoYCCBVEM666IIDIDi4Ud/xkm3Are
         OYWLeZiL7fdYuvXW7+Rzg2BvluZzbfrcrPfZAccMvxY4H89ZVkucyUp21I4C00ifg1RV
         7UqStpMxUKEuSXGdFKTG2acJfxdHduS2H4n5F5C59Dp+SzaMKrbRDkOVkFWBuR/BXdmH
         3tRT2G++n2a+NymE7lJIOFcpS36BTXm9s869yU0w/VXub520CRw7bbMYUv9RvXErZlwp
         QgE7krcDybTuRUp/zofxXyVw1S6WOoQtjR4LQMnmWdyr7kSKP+XAj8gpspR1BmB+nqrP
         1e9A==
X-Gm-Message-State: AOAM531gOuf7/DkN/ZORAA/fdgyHKH5ex5NDLAbzqYKO2HpE9Usq0Ydu
        8CsAoRUFHP/LRyfx2yYIdlnYptoB
X-Google-Smtp-Source: ABdhPJzey7sdhU9e0ZLMqY4kyXrz+v29VhwoJu+pL72vZIhn/WiBCAk1LhXgqwfeu3wKoyioj1VZxA==
X-Received: by 2002:a17:906:35ca:: with SMTP id p10mr14893131ejb.392.1592826157033;
        Mon, 22 Jun 2020 04:42:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:c5d2:e67d:372a:5e48])
        by smtp.gmail.com with ESMTPSA id lo20sm5784749ejb.62.2020.06.22.04.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 04:42:36 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] fix annotation of io{read,write}{16,32}be()
Date:   Mon, 22 Jun 2020 13:42:32 +0200
Message-Id: <20200622114232.80039-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <202006182001.EmefYezC%lkp@intel.com>
References: <202006182001.EmefYezC%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These accessors must be used to read/write a big-endian bus.
The value returned or written is native-endian.

However, these accessors are defined using be{16,32}_to_cpu()
or cpu_to_be{16,32}() to make the endian conversion but these
expect a __be{16,32} when none is present. Keeping them would
need a force cast that would solve nothing at all.

So, do the conversion using swab{16,32}, like done in asm-generic
for similar situations.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/alpha/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index a4d0c19f1e79..640e1a2f57b4 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -489,10 +489,10 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
 }
 #endif
 
-#define ioread16be(p) be16_to_cpu(ioread16(p))
-#define ioread32be(p) be32_to_cpu(ioread32(p))
-#define iowrite16be(v,p) iowrite16(cpu_to_be16(v), (p))
-#define iowrite32be(v,p) iowrite32(cpu_to_be32(v), (p))
+#define ioread16be(p) swab16(ioread16(p))
+#define ioread32be(p) swab32(ioread32(p))
+#define iowrite16be(v,p) iowrite16(swab16(v), (p))
+#define iowrite32be(v,p) iowrite32(swab32(v), (p))
 
 #define inb_p		inb
 #define inw_p		inw
-- 
2.27.0

