Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7701C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA79124686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221538;
	bh=WZKi91Qb+hIqQzuLMjQLrerJQVMOSj3EzXxFrKloU1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TDRe69mvQBiYGZbZLWWr6GX8jPxZMJXP47bnGgZs60+QbgJ060YdQvcQSP/tiewrP
	 4WHtfQ+mDEEvPq2IpYJkeoqmakRKBWWmuGflRZsJJEW9pgqNgV5/jbM0ZBKLnTGHfv
	 UXYE+4MlSMna+L4vPgB8QRIPtM4Oi7RUzjjbGgAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbgA1OZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbgA1OZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:25:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F4D24686;
        Tue, 28 Jan 2020 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221535;
        bh=WZKi91Qb+hIqQzuLMjQLrerJQVMOSj3EzXxFrKloU1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQv9aVtKvqY9vDcTRwdJ1FUJhAggwrWD5FY0HK3V+OWO4k8ThWCnG4MvWhkW3Qkz5
         Ix1XojhJZcYi9SZD+N7TZbWg7Wi99RmuFIMmUz708pH1kcMQ6ALRrGdmFdBCE7TJSq
         r2/S2ay1MxCixamIF3azt85pisITHWclAVLWIcZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4.9 262/271] arm64: kpti: Whitelist Cortex-A CPUs that dont implement the CSV3 field
Date:   Tue, 28 Jan 2020 15:06:51 +0100
Message-Id: <20200128135912.099755783@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 2a355ec25729053bb9a1a89b6c1d1cdd6c3b3fb1 upstream.

While the CSV3 field of the ID_AA64_PFR0 CPU ID register can be checked
to see if a CPU is susceptible to Meltdown and therefore requires kpti
to be enabled, existing CPUs do not implement this field.

We therefore whitelist all unaffected Cortex-A CPUs that do not implement
the CSV3 field.

Signed-off-by: Will Deacon <will.deacon@arm.com>
[florian: adjust whilelist location and table to stable-4.9.y]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/cpufeature.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -789,6 +789,11 @@ static bool unmap_kernel_at_el0(const st
 	switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
 	case MIDR_CAVIUM_THUNDERX2:
 	case MIDR_BRCM_VULCAN:
+	case MIDR_CORTEX_A53:
+	case MIDR_CORTEX_A55:
+	case MIDR_CORTEX_A57:
+	case MIDR_CORTEX_A72:
+	case MIDR_CORTEX_A73:
 		return false;
 	}
 


