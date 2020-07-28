Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D715DC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD477207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgG1W5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:34 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39442 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgG1W52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:28 -0400
Received: by mail-qv1-f66.google.com with SMTP id o2so9955500qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbgaCyFoSQH758gI8nBq5BNw5E4VtSVD4M81x30MSbg=;
        b=Brwdc6br4tvAEA/I2jfO83vMeXXuXbWsDQVKyo5facOEq9rnQHL7xEKDfJKn2YKkD/
         7Nh3yn7vBFDWs6DiIkvJ6yKsQl8Wh+Iw+lRkqBb2GNxfVFhgATBQNwctugoAAtSPU65V
         akTBDIJqecuGld8GRSkVx6aY2YFcioFAp5hR9GxwjUqVhNNBT9BUAIqq6n9lXy0yAgOi
         qyBu+O2letryTw/l/5vbqKz4LUVAUuUYp6ZEnhdmGys85i+QEAHZrt9gjqJNBr8bqFzp
         iBdVddExdsti2ZMeTAfGQr4CvM/qgluKamkxpeDOlEG73q3EB1ZAC5jkyC0uISSyOTVJ
         MHsw==
X-Gm-Message-State: AOAM531Yurq01kZxoVwnLDB14A1SivXhzNvmCEZaLMireglwv3bpn3aR
        Bt9r1u5tFUMStQELQma7qm85alms
X-Google-Smtp-Source: ABdhPJyKB4BeoxkY8ygbYTskFsMtKAxDVS+XPGsm2B4UhftAe+V5bqFXMkpODRRSrxXtA33FZAYXnw==
X-Received: by 2002:a05:6214:22c:: with SMTP id j12mr16894507qvt.190.1595977047512;
        Tue, 28 Jul 2020 15:57:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:27 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/21] x86/kaslr: Fix off-by-one error in __process_mem_region
Date:   Tue, 28 Jul 2020 18:57:06 -0400
Message-Id: <20200728225722.67457-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of an overlap, the beginning of the region should be used even
if it is exactly image_size, not just strictly larger.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index da45e66cb6e4..848346fc0dbb 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -669,7 +669,7 @@ static void __process_mem_region(struct mem_vector *entry,
 		}
 
 		/* Store beginning of region if holds at least image_size. */
-		if (overlap.start > region.start + image_size) {
+		if (overlap.start >= region.start + image_size) {
 			struct mem_vector beginning;
 
 			beginning.start = region.start;
-- 
2.26.2

