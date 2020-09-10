Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D3CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187E32067C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DxY9c8U9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgIJIPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgIJIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E9EC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 67so3816745pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tH3VhkqM1acAjytNJ62tEalL9JPHCW4E9Rj2E8HYRpU=;
        b=DxY9c8U9Y9+lT00hgUY1Dsf/2yUU0Gi/XRr5Frt32Dvn/gZKLgbfq0kXissj8X1brN
         zGi0+/brafrYW6kvNcl0M6gsJTBDzg4aLpdcr9NhPEvxGTXAEyaJilT9aC56iLqkAxlW
         Gbeaiu7RxZKWqxGuMnq8LubvdzQz4qtiHH6owgpbr1c5b6pgzaZtl7W2l0hh8CbY4xXg
         u4QnKFS/tnAflzcYUfnBT8wteBrcz4y18klUYEZsp3HtzHV0YDaQNjHDPMbcyBrlLlDQ
         vFElbORqveFSUjvbIITPmqMO0Q83HHU9EnOYmb7bhlQKFEM3nTA6ryetRga19tUyMhJt
         c3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tH3VhkqM1acAjytNJ62tEalL9JPHCW4E9Rj2E8HYRpU=;
        b=ef5IJMvOElHPNlu+43eU0cDmbO9K9aGxugIDb5tTTxeSt9mYIHhkhawbbx1b2YH2kE
         qpEFQuf9qQEHd6RSoqMka6vv4V1iKx2bSXTqa1jg9L/OwRHXpUP2dPKBlvXRftzsO3p9
         dCBIjwb+io2n9Jn6SJi2BH0+p70/vP4A3oSv+SqtVNYhNn5xE1hKpHKQ7x7jBNi72bwP
         YABbvbvMAKnlD0ZEy67ATw0SSMsb/uG9IpJoundTKATVNWVXO2tAChaPMflCNaDsdg0e
         03tAeO0GFV7tfOebDLI8+ZBpekge7WxMAr38IjktnN7PSlDJTuL/PeRFVseemL4opOP4
         2/3w==
X-Gm-Message-State: AOAM530RyHLY6cI+B96kno4IhKuLQgK70uXzOdYZw+R2UNIccpOiBqEh
        2sXXDXRbjib+KPo3vPYjyazAiPnxNKu5Vy3j
X-Google-Smtp-Source: ABdhPJz6n4IqjVW7yXiLfH7sWwLDESD0k7agKvdLsXi71/Eg+VoM+FG5UXouQdF/P8pn2bMKy8zmoQ==
X-Received: by 2002:aa7:9ac9:0:b029:13e:d13d:a133 with SMTP id x9-20020aa79ac90000b029013ed13da133mr4368433pfp.27.1599725563195;
        Thu, 10 Sep 2020 01:12:43 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:42 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>
Subject: [RFC PATCH v7 03/21] riscv: Extending cpufeature.c to detect V-extension
Date:   Thu, 10 Sep 2020 16:11:58 +0800
Message-Id: <119d2ae4fd376a2095129144b0ac32970ecf7e86.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Current cpufeature.c doesn't support detecting V-extension, because
"rv64" also contain a 'v' letter and we need to skip it.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/uapi/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
index 46dc3f5ee99f..c52bb7bbbabe 100644
--- a/arch/riscv/include/uapi/asm/hwcap.h
+++ b/arch/riscv/include/uapi/asm/hwcap.h
@@ -21,5 +21,6 @@
 #define COMPAT_HWCAP_ISA_F	(1 << ('F' - 'A'))
 #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
 #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
+#define COMPAT_HWCAP_ISA_V	(1 << ('V' - 'A'))
 
 #endif /* _UAPI_ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ac202f44a670..f11ada3fa906 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -73,6 +73,7 @@ void riscv_fill_hwcap(void)
 	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
 	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
 	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
+	isa2hwcap['v'] = isa2hwcap['V'] = COMPAT_HWCAP_ISA_V;
 
 	elf_hwcap = 0;
 
-- 
2.28.0

