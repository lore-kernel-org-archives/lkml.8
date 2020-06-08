Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A603E20897
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658555;
	bh=h18zp+cWiinCTN71tzoeaw/HPvo6f+dnoFyWsFESrDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YgCdEhbHCaEkuDOX7ZrKkT2dW0i6DYNz3MKccpGcEBAFLQdVyIGI4PyXTS+4ONwYC
	 OxIh58fX699+P9YWsPmlDvQ6DhvTD6cEbxj+iTEoNQREMI06qHk/LT/b+Ehr3n58FQ
	 gkHrOC41WqD/si/pGErusvcPX0Mkk600NQQIk52o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgFHXWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbgFHXRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA64920823;
        Mon,  8 Jun 2020 23:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658275;
        bh=h18zp+cWiinCTN71tzoeaw/HPvo6f+dnoFyWsFESrDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgL2xKhtFF2Ltst7i+X8FWeBsf5MdbxSOMphnCekrmLLyqI4Xj8WnNcdePqrlUsUm
         sr+wrCLVC1GRlUh7Evq7dl/793TQvyZ2/AI+IBW+rNKbjLDHQsM/TB07C2cguerN8x
         zkvEqSLFcFHNv8RJBunnw6P50NsUo68rdxleDZ8g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Yibin <jiulong@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 281/606] csky: Fixup remove duplicate irq_disable
Date:   Mon,  8 Jun 2020 19:06:46 -0400
Message-Id: <20200608231211.3363633-281-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yibin <jiulong@linux.alibaba.com>

[ Upstream commit 6633a5aa8eb6bda70eb3a9837efd28a67ccc6e0a ]

Interrupt has been disabled in __schedule() with local_irq_disable()
and enabled in finish_task_switch->finish_lock_switch() with
local_irq_enabled(), So needn't to disable irq here.

Signed-off-by: Liu Yibin <jiulong@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/entry.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 007706328000..9718388448a4 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -318,8 +318,6 @@ ENTRY(__switch_to)
 
 	mfcr	a2, psr			/* Save PSR value */
 	stw	a2, (a3, THREAD_SR)	/* Save PSR in task struct */
-	bclri	a2, 6			/* Disable interrupts */
-	mtcr	a2, psr
 
 	SAVE_SWITCH_STACK
 
-- 
2.25.1

