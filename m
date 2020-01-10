Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAB6C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3F52072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lclbmfp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgAJJnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:43:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37885 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgAJJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:43:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so751781pga.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6dB9t1B6KGxZok9qfK9D1u/+innROCm2ojD9foG3rk=;
        b=lclbmfp5SUnnaASjcPWXc6B2l1vdPNi/bt6aLBwYDT1XmVbyYt6ZdIBdTbo4yFQh45
         11DvhcR8QfNUZIxCaWYTD7n93QZI5NnxJbTUiQSxevz2UR/lhs+9B93T+vO7Z8d6GQOE
         WoV9kJYMpwMf7nwXPwLSbRFukayu/+bSngY1Pkx5Hfm7cLOc3VXk9MRxmpdPUFQh13cj
         4dlAZ+E4xaCI1tIpG1SMkuknyGdwBvrVnqy9f8yuapXiLjRdPh0MkhEM5i6SctWflc1C
         3Aaqy7vI9L2cymM+B/6bFqF1e953IQzeiV/RDjfNztpZ9LLdDpwkPyzhyi2nNua6s+Q6
         DHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6dB9t1B6KGxZok9qfK9D1u/+innROCm2ojD9foG3rk=;
        b=k45qESL/AweBcUA1+16OLZ8fUiaZAtWPOKcldIFaumd14KGjE3aV0xW3ybzAC+U7JQ
         gXn06m+kzj2qFuy1h8YeNIfauMKIWDJFOAJ75SpQaI/+/vXqp08zIO2F0YpnBdA6gy6N
         RgkuPmuRyGNDxwo8Xc4ocBH8Vwd7Gk2L2oS5s5Grmphr1AbUzsyjhEitOCBLNy7jKCPy
         XELI6c7cQVpT23qclCRpB7bjDsXbInvgFPynhcFCgGPOnxGZpGopMMf2bI4MUrJ0AH1q
         iV/a9VQJGav6BLgCNF5dxqPtBDCuMKYcwu5uDDvdbiA4y7qQ2C5Cd7Retv8ojMA7DM2E
         z6cw==
X-Gm-Message-State: APjAAAXgZAFWPt0kBxsHpE4dL1rn/gJAf/SpX5+Xvs4siNaPj3nEbz7d
        +8CSoeOxh1mkbFh0ULDcbIm/553r
X-Google-Smtp-Source: APXvYqwuThmI/Mo5O3aHvl9cjrf01rnYng3ulZHlX+Pqs7NpjPi7mpZUzINUir7kTUcerWPoyb58mA==
X-Received: by 2002:aa7:9908:: with SMTP id z8mr2927366pff.68.1578649400623;
        Fri, 10 Jan 2020 01:43:20 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id i3sm2090773pfg.94.2020.01.10.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 01:43:19 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] x86/boot/KASLR: Fix unused variable warning
Date:   Fri, 10 Jan 2020 17:43:04 +0800
Message-Id: <20200110094304.446-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
If any of the two macros is undefined, below warning triggers during
build with 'make EXTRA_CFLAGS=-Wall binrpm-pkg', fix it by moving 'i'
in the guard.

arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable ‘i’ [-Wunused-variable]

Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
v3: remove changes from 0/1 to false/true per Tglx
    add the command details about triggering build warning per Boris

v2: update description per Boris.

 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..62bc46684581 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -695,7 +695,6 @@ static bool process_mem_region(struct mem_vector *region,
 			       unsigned long long minimum,
 			       unsigned long long image_size)
 {
-	int i;
 	/*
 	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
 	 * use @region directly.
@@ -711,6 +710,7 @@ static bool process_mem_region(struct mem_vector *region,
 	}
 
 #if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
+	int i;
 	/*
 	 * If immovable memory found, filter the intersection between
 	 * immovable memory and @region.
-- 
2.17.1

