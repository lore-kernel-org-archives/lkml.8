Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C364C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E464B20665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwA+N+1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgIDSrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIDSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:46:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD741C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:46:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u18so7082284wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/IsrdXrUOtOTBrB3eBrlMDBlKpxWA0R40two4e+nGOc=;
        b=AwA+N+1lENnbpLz/wWhQ8pA4H1pRMZGJ7Ojc10luRGWxPaB62cOcZPCeJlx0uWAvLY
         1gw7bfxy8jwAxBT2g7QRGLLgvvOqAtHRWSxEsEXC0ZDgI4UfI7peuVFYQJM78Y/L9wuG
         ForTiB3vmMI7mtfA8WdGvdcep6tg0cgJLCJybq0YzhKq5RFvHie7dxO6BdI5zsJl86+W
         Ze79gjInHbmCdkBQCEqj0KtLHtR8R0wX/t/kdRuuSgD0Iqj1OPSZck5LrcLaSkRxpXWF
         VwAaqtHACZTe/ZiNL8vDtyjIPuVsXRddzRuBdmCN0MRnhnqS1CqAyaC4wfDut9woCtyA
         pWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/IsrdXrUOtOTBrB3eBrlMDBlKpxWA0R40two4e+nGOc=;
        b=OG2dxVIoHPv8vGnsLoelQ9by5cy5kZhquI+x1soBofwMoLLK8f10C6gNFnugLb55tc
         U0J3UZ38vMbA+rG6w86z1ifYsckBJdS6N5F0VntxeNvXfxVmIGmk1zOvHw+U+VmBdlbv
         DlXewdbaye5770lv2QEKhRWooWj1JCU683eUf3CCxiLrjBijsFzq3Uzm9ZJ0F8ql8WnI
         qCSBf/bKftKO3ctod13VWbVrkWT2gMt19C+mFveGFwO8tlyW0f6dxweI87J26ykX8rQy
         Is66DhEMXc9nYF96dTVejZb+oGZK+KBuDNUCHhrVIkF78TivddYcX2/8NEuSJykYerwg
         0x7g==
X-Gm-Message-State: AOAM532Y39giFoiREd1IE1KcpW8pEdnObN/kgvMcvJ+OByKIE+/CRkZX
        aCyF7OCsAW/L2utAt9qqm9mgN0NcskA=
X-Google-Smtp-Source: ABdhPJxFS6bqY4pw+HEz8iQgV0XYhP1R0DjvZ+TRaQGPKK81WRnoaAV7ouDNjLxOC+QizozsxQFwvw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr9251444wme.46.1599245193526;
        Fri, 04 Sep 2020 11:46:33 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id q186sm14111670wma.45.2020.09.04.11.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:46:32 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/6] habanalabs: Fix alignment issue in cpucp_info structure
Date:   Fri,  4 Sep 2020 21:46:21 +0300
Message-Id: <20200904184623.13478-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904184623.13478-1-oded.gabbay@gmail.com>
References: <20200904184623.13478-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Because the device CPU compiler aligns structures to 8 bytes,
struct cpucp_info has an alignment issue as some parts
in the structure are not aligned to 8 bytes.
It is preferred that we explicitly insert placeholders inside
the structure to avoid confusion

in order to validate this scenario, we printed both pointers:

__u8 cpucp_version[VERSION_MAX_LEN]; (0xffff899c67ed4cbc)
__le64 dram_size;                    (0xffff899c67ed4d40)

we see difference of 132 bytes although the first array
is only 128 bytes long, Meaning compiler added a 4 byte padding.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/include/common/cpucp_if.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 1e8480e978e2..dcde440427b4 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -410,6 +410,7 @@ struct cpucp_info {
 	__u8 fuse_version[VERSION_MAX_LEN];
 	__u8 thermal_version[VERSION_MAX_LEN];
 	__u8 cpucp_version[VERSION_MAX_LEN];
+	__le32 reserved2;
 	__le64 dram_size;
 	char card_name[CARD_NAME_MAX_LEN];
 };
-- 
2.17.1

