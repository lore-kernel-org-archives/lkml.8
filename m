Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D843C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43172078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979803;
	bh=jSanhpfmu+54nj95N++yGFgD3ULnJXuEynxR2aByFL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jeNRjRC3kWE2P52LmZtDRrNiuGw56ow27PDQTKf3RUsgBSdF5jzU741ddx2C7vr6t
	 ReU/ajUBOLscUUxFVIrAuE3QH/1HuJZVyR84VfbJnOqBotfQfE0WfxgkmQrY1nN/l5
	 Dgq5dZqxqaOD5uv0eS9vV+ZHNb11WvGjDq8Hbg2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbgIARDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbgIAPUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:20:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C0120767;
        Tue,  1 Sep 2020 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973609;
        bh=jSanhpfmu+54nj95N++yGFgD3ULnJXuEynxR2aByFL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMI3AyIQXQo9JbT9FiJSztCnSr1JFpITETQCa/PjeFBPGD5m3kUpodD/hAjVzpo3n
         y2wBf8YbZIFw3ChE2KUqhcMviccP6edCnvLWLHCQjhSLdrwfYf3oyI8miBbWV6456j
         IAiADRG2ZpW9Z/j0lVqacMm9J0rWHHSnD+8QvlPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 37/91] KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
Date:   Tue,  1 Sep 2020 17:10:11 +0200
Message-Id: <20200901150929.981171314@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
References: <20200901150928.096174795@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brazdil <dbrazdil@google.com>

[ Upstream commit b38b298aa4397e2dc74a89b4dd3eac9e59b64c96 ]

__hyp_call_panic_nvhe contains inline assembly which did not declare
its dependency on the __hyp_panic_string symbol.

The static-declared string has previously been kept alive because of a use in
__hyp_call_panic_vhe. Fix this in preparation for separating the source files
between VHE and nVHE when the two users land in two different compilation
units. The static variable otherwise gets dropped when compiling the nVHE
source file, causing an undefined symbol linker error later.

Signed-off-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200625131420.71444-2-dbrazdil@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 4a8fdbb292863..0ad952e074457 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -444,7 +444,7 @@ static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par,
 	 * making sure it is a kernel address and not a PC-relative
 	 * reference.
 	 */
-	asm volatile("ldr %0, =__hyp_panic_string" : "=r" (str_va));
+	asm volatile("ldr %0, =%1" : "=r" (str_va) : "S" (__hyp_panic_string));
 
 	__hyp_do_panic(str_va,
 		       spsr,  elr,
-- 
2.25.1



