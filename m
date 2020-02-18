Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9ACC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7AA24670
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055797;
	bh=dAT9oHY5S1QBY8l/r7SZDhg9s8hu+A+WT3ErkO/jMA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c21st/rO0auiMaXCMirXysuon+uon07wdAl+cL5/PsYUKzOUhtjSbxtUzlf2XcZBc
	 oCl9PoDmFbzncvdkUgIoqdqY0v1igSDnHjgtjdjsjAiqVuz4Yq/RZevCd/KzNlUcRn
	 waIzRLsjMTOFlu4XjJ1yCT9cf0ob/PoRcNeDyPmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgBRT4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgBRT4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:56:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 061F224654;
        Tue, 18 Feb 2020 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055788;
        bh=dAT9oHY5S1QBY8l/r7SZDhg9s8hu+A+WT3ErkO/jMA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RydTMaoUUK5a1vmOeROMhZq5bxYHAtEpGFzYZ0VeIFG12Q7FGbVR4PNWAgUQ8ndjn
         2kVp+Qi8p1KwSfZoozQScjibOlKJXY1rJsEnJTnhkTTHKdKyyBNgprI5BfwJBKcSn5
         8zLOKtzV87/6CZWujxrYukqRGGtfTxqkld8PRXcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 4.19 21/38] arm64: ssbs: Fix context-switch when SSBS is present on all CPUs
Date:   Tue, 18 Feb 2020 20:55:07 +0100
Message-Id: <20200218190421.213827644@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190418.536430858@linuxfoundation.org>
References: <20200218190418.536430858@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit fca3d33d8ad61eb53eca3ee4cac476d1e31b9008 upstream.

When all CPUs in the system implement the SSBS extension, the SSBS field
in PSTATE is the definitive indication of the mitigation state. Further,
when the CPUs implement the SSBS manipulation instructions (advertised
to userspace via an HWCAP), EL0 can toggle the SSBS field directly and
so we cannot rely on any shadow state such as TIF_SSBD at all.

Avoid forcing the SSBS field in context-switch on such a system, and
simply rely on the PSTATE register instead.

Cc: <stable@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Srinivas Ramana <sramana@codeaurora.org>
Fixes: cbdf8a189a66 ("arm64: Force SSBS on context switch")
Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/process.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -414,6 +414,13 @@ static void ssbs_thread_switch(struct ta
 	if (unlikely(next->flags & PF_KTHREAD))
 		return;
 
+	/*
+	 * If all CPUs implement the SSBS extension, then we just need to
+	 * context-switch the PSTATE field.
+	 */
+	if (cpu_have_feature(cpu_feature(SSBS)))
+		return;
+
 	/* If the mitigation is enabled, then we leave SSBS clear. */
 	if ((arm64_get_ssbd_state() == ARM64_SSBD_FORCE_ENABLE) ||
 	    test_tsk_thread_flag(next, TIF_SSBD))


