Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76926C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4887822BF5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752875;
	bh=sIUlAmhTnfBS1jKcMvo/2Rk0jPaABNfNX5aq1FKva4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvLCxdrN7nLTOV3cvSCmyaEQbjMkbuSnYZPqDhby+xqm95Ue3+oaf16BLxRDe15Se
	 LAf4SrdsjPIQkmJ8LUdIM7Zb688bleT1a/hroC9+vv5+T+hfMcouQIHm6/VnPRppyE
	 GsKBcsUQxZbEW38SamXAu35YDhOWB6h0EMWTM00Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgGNSye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730754AbgGNSy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F2222BED;
        Tue, 14 Jul 2020 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752867;
        bh=sIUlAmhTnfBS1jKcMvo/2Rk0jPaABNfNX5aq1FKva4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4zfaGqSCKKX8eYvwxalLTvkse0RQnVExnf/s1+Nf9Ti+pxvOSYTC/yn9AGAv04b4
         9VJDQCB5WEtjyRSiXklFEn4gDF10zCB6lxeUXuyx6jxpXaGceMnko8GdV+FXwGHzp6
         hb0jM7L/Lr1cL228Z4RvS/BbDIRBuLDeiMga1LBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 006/166] perf/x86/rapl: Fix RAPL config variable bug
Date:   Tue, 14 Jul 2020 20:42:51 +0200
Message-Id: <20200714184116.180516995@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

[ Upstream commit 16accae3d97f97d7f61c4ee5d0002bccdef59088 ]

This patch fixes a bug introduced by:

  fd3ae1e1587d6 ("perf/x86/rapl: Move RAPL support to common x86 code")

The Kconfig variable name was wrong. It was missing the CONFIG_ prefix.

Signed-off-by: Stephane Eranian <eraniangoogle.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200528201614.250182-1-eranian@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index b418ef6878796..726e83c0a31a1 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= core.o probe.o
-obj-$(PERF_EVENTS_INTEL_RAPL)		+= rapl.o
+obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
-- 
2.25.1



