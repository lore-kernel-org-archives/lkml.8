Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFBDC7659D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B6424656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813763;
	bh=PiciUWh6trivm2waRdUpYO3vt8+/QQj86XcJO2eDsJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RIvEsTcq3znRObJ1yd6UE3TG/W39xyeLAr1z2VXSsK9IAM6tiDhO/b/RhfGMvkuea
	 5u6RLtTIsEJpdTP/PexKLbn4mCfdBYGfmjVK4x/K+N5dAzx2I1z6UT4rPW87NjcdfJ
	 Lt+YHLPaPEVQd35NLMGQfjGLOgQQRJDBB7iQXY/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbgB0O3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:29:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387948AbgB0OGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:06:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C07C21D7E;
        Thu, 27 Feb 2020 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812391;
        bh=PiciUWh6trivm2waRdUpYO3vt8+/QQj86XcJO2eDsJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxXp3AGP3wt7klrNvloidVfkrFhSpDU9i3P9loVzm5t0S/TLVjI6Hr1pLgsm802FS
         URUt8wdH7iixJBgwp8GJXLHnEO/AmkwhPFCPOZtFYKQTQjH6eK9L8sq4et8WyP87wB
         ftG+7XlPZMvw91tHUeRqPU3D4TykNdDm586OzKIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.19 96/97] xen: Enable interrupts when calling _cond_resched()
Date:   Thu, 27 Feb 2020 14:37:44 +0100
Message-Id: <20200227132230.358208395@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 8645e56a4ad6dcbf504872db7f14a2f67db88ef2 upstream.

xen_maybe_preempt_hcall() is called from the exception entry point
xen_do_hypervisor_callback with interrupts disabled.

_cond_resched() evades the might_sleep() check in cond_resched() which
would have caught that and schedule_debug() unfortunately lacks a check
for irqs_disabled().

Enable interrupts around the call and use cond_resched() to catch future
issues.

Fixes: fdfd811ddde3 ("x86/xen: allow privcmd hypercalls to be preempted")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/878skypjrh.fsf@nanos.tec.linutronix.de
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/preempt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/xen/preempt.c
+++ b/drivers/xen/preempt.c
@@ -37,7 +37,9 @@ asmlinkage __visible void xen_maybe_pree
 		 * cpu.
 		 */
 		__this_cpu_write(xen_in_preemptible_hcall, false);
-		_cond_resched();
+		local_irq_enable();
+		cond_resched();
+		local_irq_disable();
 		__this_cpu_write(xen_in_preemptible_hcall, true);
 	}
 }


