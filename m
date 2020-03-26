Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD82C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2384120772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cwhHLgf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgCZDZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:25:08 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34784 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgCZDYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:38 -0400
Received: by mail-qv1-f65.google.com with SMTP id o18so2281353qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=pWO3w3fg/bu1qLpz2kK7AN0HJrvbrhfCZrrLUhDFmXA=;
        b=cwhHLgf1ShP+9c8KtQ5dZpXfzLqFYUBpwqKsV3HZaplJ84EIJbdpHaM6NuJ2wlnEzt
         m08QUXtYf36hyXSeXnPsTpKXEJnJhT/HEeBpgHQpag3F8caUMtXyruGEEUxEb9VuT53N
         xhgjzaa00d1RLd/RIwIljbmeaPfUPwnzdN8U/AzmGBsITwwFUjooj8dcTZl2uUgUmyFv
         8LXYv02eoJxsRq0Y42HhNBBm7SHwtS2dGd9g791Nlg3U+3IAuZ5tjDGYoG8eWK8KIIfT
         30wbQFnx+teO+i/+te5evTv88yW+bxFAV8lL1oHLvRGfQspHQWgQ6RuRbdApM1rSjQLX
         OcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=pWO3w3fg/bu1qLpz2kK7AN0HJrvbrhfCZrrLUhDFmXA=;
        b=VttdHXlfr5p24SOq/l1HEltEzq0lSF2c1az1EBcYUxKC/vB6NkjVaHJLb2sofOa9TR
         6OZh4qv1VosbjnStyZ2dGGbXdv5eudZz/llld+Z7wlPclPLbq60Db3Dye3CVoZK0whM7
         h4oe6U7fxCrkG07oeSR0yaXxbBojUWbGdR8X0PZZnERPbrGx3tc1MS/Qw3FJ8WhECy0o
         iP9BS6U0B+c7/rNrmg7qUK5rci00dAZ7q1xb4O5Ko4haQysOOnQ1E0Aq6c6FGUABqiEl
         SN4VlrBvQgnDJv/gj8Jx1DqQDmcEbmmWYgVSjmuxx6LNDjBqgFdDHkIeXEZUnUS3if61
         9pgg==
X-Gm-Message-State: ANhLgQ1sCsqAy1lCh4QFl6et7XaBRMGLnkfylaTvRRSFfLgDhOKtfpnC
        RD882rrntAPDXQjLy56XkbZEqQ==
X-Google-Smtp-Source: ADFU+vv/k/sLcr5Tyhr8JUG2Ty25MeyzImC89QBOsiqE8u6hhBIFLVdfdL3XZrToBgUbETDslMnrJw==
X-Received: by 2002:a0c:fd6b:: with SMTP id k11mr5890909qvs.99.1585193076738;
        Wed, 25 Mar 2020 20:24:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:36 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 09/18] arm64: kexec: call kexec_image_info only once
Date:   Wed, 25 Mar 2020 23:24:11 -0400
Message-Id: <20200326032420.27220-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kexec_image_info() is called during load time, and
right before kernel is being kexec'ed. There is no need to do both.
So, call it only once when segments are loaded and the physical
location of page with copy of arm64_relocate_new_kernel is known.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index ec71a153cc2d..cee3be586384 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -66,6 +66,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
+	kexec_image_info(kimage);
 
 	return 0;
 }
@@ -79,8 +80,6 @@ int machine_kexec_post_load(struct kimage *kimage)
  */
 int machine_kexec_prepare(struct kimage *kimage)
 {
-	kexec_image_info(kimage);
-
 	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
 		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
 		return -EBUSY;
@@ -166,8 +165,6 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	kexec_image_info(kimage);
-
 	/* Flush the reboot_code_buffer in preparation for its execution. */
 	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
 
-- 
2.17.1

