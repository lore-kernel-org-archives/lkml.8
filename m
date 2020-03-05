Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32459C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011F8208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hqjjb1oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgCEGGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:06:22 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:60245 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgCEGGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:06:22 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 08a2443c;
        Thu, 5 Mar 2020 06:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=qf7iBnoAP1jFyvRyxTLvRHeDZ
        Gw=; b=hqjjb1oPQyzgtuRHxsmeTnPMhLgFEGmjPwrYAhrnEz+awDd8V/6AG0VQE
        WSf3c5f5/Hq2YKx0cNHxhawSVObj9ZfX3ddsaMbq3qQP1ycGVZ+QtnVmRxNUWgqm
        I6MY0pvNK+oU9qCybL7j7U3FmpgOYhDsOl+oQR3NCsw+R5JxerzupqC0Ru+XOAOW
        78BmlQkh9mPkIHnO7WRddf+X2we6OGpN1e3gck80CAgXYny4dFzBgAP5GZ+HyjNK
        QcTrIi+IsUD6rT8ik6Jsjyvm4lE52toOye2GjaHLGLr83qUzZWxV9XnCdEraxCTQ
        umpWOehP+LLOvv9GKiIwRvBuJR5qA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f156eac8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 5 Mar 2020 06:01:41 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] KVM: fix Kconfig menu text for -Werror
Date:   Thu,  5 Mar 2020 14:06:04 +0800
Message-Id: <20200305060604.8076-1-Jason@zx2c4.com>
In-Reply-To: <20200304190750.GF21662@linux.intel.com>
References: <20200304190750.GF21662@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was evidently copy and pasted from the i915 driver, but the text
wasn't updated.

Fixes: 4f337faf1c55 ("KVM: allow disabling -Werror")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1bb4927030af..9fea0757db92 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -68,7 +68,7 @@ config KVM_WERROR
 	depends on (X86_64 && !KASAN) || !COMPILE_TEST
 	depends on EXPERT
 	help
-	  Add -Werror to the build flags for (and only for) i915.ko.
+	  Add -Werror to the build flags for KVM.
 
 	  If in doubt, say "N".
 
-- 
2.25.1

