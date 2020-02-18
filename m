Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BAC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9F42465D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056087;
	bh=gXlqe2ZJceVqgHl8SGNURvfC+AiCU2Ij8n9ZA2sMH2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CvZvXeEuQixkOPnRo7jfNuKgoaOzcw1yjXtroIY8BDanxYowULl+8BmXv3eh7tnlU
	 /aT+RRt+vlFK6BF0bSKIO3ftFXl+8BdviYTJs1OOcGqpUZryUiESC1yXM8k+5/pGUO
	 9UwsQaN6JaCjiwfaai4KDMbtVuyNeM5oCygp/5IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgBRUBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgBRUBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:01:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC9824670;
        Tue, 18 Feb 2020 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056081;
        bh=gXlqe2ZJceVqgHl8SGNURvfC+AiCU2Ij8n9ZA2sMH2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rw7sYefGQd/goG4OovIR9gzH63LeuZ0A6T5ukvWPdcMBWcW23k6lnfKMBPDyxOzGK
         wegVdq3VWjIe7xjyk+hoNVgJRpLXR3RqQ17CtIuybF0PlHnQ9F2VoIKRBbn2rnreoQ
         W+eZfPybQiDCcu3/xImRZzrbJHe5JblQdzKAb6dQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 5.5 27/80] arm64: ssbs: Fix context-switch when SSBS is present on all CPUs
Date:   Tue, 18 Feb 2020 20:54:48 +0100
Message-Id: <20200218190435.049644874@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
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
@@ -466,6 +466,13 @@ static void ssbs_thread_switch(struct ta
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


