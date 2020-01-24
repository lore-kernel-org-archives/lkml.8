Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC84C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C2B2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865258;
	bh=oiRbZ4IejSTVbITUJfWxW0E+PXGnQSYFhihhwiMoM/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DG9x5S1VBxx0DoByR/0h5sDrMCx278NX9CiACn64/motHxZwL8kmTJT4v0LIopMnx
	 z/pHG3Olw6TthTqt7fapAvGWwUGzlr7wmu/brTftCsXOBKHIWyR000OlPhL0WPkUd4
	 fSwUlyc/aWALdDQZABHHgL/U3FjtmZAaVnfHheGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbgAXL1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391647AbgAXL1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:27:33 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CB4214AF;
        Fri, 24 Jan 2020 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865251;
        bh=oiRbZ4IejSTVbITUJfWxW0E+PXGnQSYFhihhwiMoM/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xwpgvKcPCj1CTlOq+jOFVyLn0tc6bgdVh4Tyr3e5izXnttcVgxjwCnf4Hhr6Us39n
         3/uomZyCJp0pxh2fOU15WEOLJCwjLtVzvDWhQIEzyjVwsbydzF9pdzTPKbHb9n4DGV
         0LZa0xl5LFPyRiAr/Y/f/cvy/nNGscFotqCbXngY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 482/639] PM: sleep: Fix possible overflow in pm_system_cancel_wakeup()
Date:   Fri, 24 Jan 2020 10:30:52 +0100
Message-Id: <20200124093148.826111775@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 2933954b71f10d392764f95eec0f0aa2d103054b ]

It is not actually guaranteed that pm_abort_suspend will be
nonzero when pm_system_cancel_wakeup() is called which may lead to
subtle issues, so make it use atomic_dec_if_positive() instead of
atomic_dec() for the safety sake.

Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 7c84f64c74f77..2dfa2e0487451 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -875,7 +875,7 @@ EXPORT_SYMBOL_GPL(pm_system_wakeup);
 
 void pm_system_cancel_wakeup(void)
 {
-	atomic_dec(&pm_abort_suspend);
+	atomic_dec_if_positive(&pm_abort_suspend);
 }
 
 void pm_wakeup_clear(bool reset)
-- 
2.20.1



