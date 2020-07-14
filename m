Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C6EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3650422209
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753263;
	bh=3WhSWmNNy5hqVAlzz7aFIf/TWdrTr8fOsaf6M/t9T9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EISsJIFn/FFiORz7FbsdJBlpp05A/KcgxRwlEK5PTRnxufkUGMWSQxXJnbXfEFWCy
	 +1x1I2fEItMBROfHSPAHx8vrvPtQxCmHKRSrMPKlZR6q2Y4A2tz6gYI3oDU1xc7712
	 bfoKQTkW83PmRDI39TDrSw0Gf7sZUAyCLoWQ+rqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgGNTBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgGNTAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:00:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE5BF22A99;
        Tue, 14 Jul 2020 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753224;
        bh=3WhSWmNNy5hqVAlzz7aFIf/TWdrTr8fOsaf6M/t9T9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1d8R2x/mVU2mJUZZmMeOqYsc4qNCTAEa3Y0SQtZU5WSL5MM6+am4MzibaXQ1truIG
         8UxkiHudXuVv2QTXt6GAa1LN1uvisKMLxYHQhp4+YJMFhfI5t8H1nZfLuVHLklYzE/
         BXKkYfuj7iQRnmwbEX1gPrkUUlBf9ZnL+IE0v5CM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.7 158/166] arm64: arch_timer: Allow an workaround descriptor to disable compat vdso
Date:   Tue, 14 Jul 2020 20:45:23 +0200
Message-Id: <20200714184123.389060989@linuxfoundation.org>
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

From: Marc Zyngier <maz@kernel.org>

commit c1fbec4ac0d701f350a581941d35643d5a9cd184 upstream.

As we are about to disable the vdso for compat tasks in some circumstances,
let's allow a workaround descriptor to express exactly that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200706163802.1836732-3-maz@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/arch_timer.h  |    1 +
 drivers/clocksource/arm_arch_timer.c |    3 +++
 2 files changed, 4 insertions(+)

--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -58,6 +58,7 @@ struct arch_timer_erratum_workaround {
 	u64 (*read_cntvct_el0)(void);
 	int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
 	int (*set_next_event_virt)(unsigned long, struct clock_event_device *);
+	bool disable_compat_vdso;
 };
 
 DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -566,6 +566,9 @@ void arch_timer_enable_workaround(const
 	if (wa->read_cntvct_el0) {
 		clocksource_counter.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
 		vdso_default = VDSO_CLOCKMODE_NONE;
+	} else if (wa->disable_compat_vdso && vdso_default != VDSO_CLOCKMODE_NONE) {
+		vdso_default = VDSO_CLOCKMODE_ARCHTIMER_NOCOMPAT;
+		clocksource_counter.vdso_clock_mode = vdso_default;
 	}
 }
 


