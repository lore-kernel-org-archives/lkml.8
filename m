Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D422320768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594984;
	bh=PpOTd+1JuLVd/oGNLu014WCPcxYLqueUtP1FoVeSTfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qu25ZgCe5eGLcoZ2a6VBvzD9/4Wx/MKLB8MnspSzNQJbT7RlfSzeJqKOzaCj4qOoM
	 Rj+F6ZJ9Xd1XoyDTcuUi57RdGRFiL18sly+6MA4A3aPr5tfm5S0oXhhUjm3s1Z+rcO
	 e2OH5jeyXeRC39uzJzIScpIedPn5U5309b77Yln8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbgIHT4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730576AbgIHPgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:36:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD08A22838;
        Tue,  8 Sep 2020 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579313;
        bh=PpOTd+1JuLVd/oGNLu014WCPcxYLqueUtP1FoVeSTfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zM0/GEGbxf1seO7mgAkJ97mi0DUQu+3FK1d82u1ZLrySKovfhFmPNlLrw9pEF78Nn
         PbNb4LciNDzJyokgyvyBPmyP6DZ9TUorRBTsrM/Ljl9I8V+FupU5psTTUZtLlm9DYv
         F67H6aMKYZzLDIzRCDU3iZLVN2/6NNlDRubA/g0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 026/186] cpuidle: Fixup IRQ state
Date:   Tue,  8 Sep 2020 17:22:48 +0200
Message-Id: <20200908152242.925912775@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 49d9c5936314e44d314c605c39cce0fd947f9c3a ]

Match the pattern elsewhere in this file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.251340558@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 87197319ab069..2fe4f3cdf54d7 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -153,7 +153,8 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 */
 	stop_critical_timings();
 	drv->states[index].enter_s2idle(dev, drv, index);
-	WARN_ON(!irqs_disabled());
+	if (WARN_ON_ONCE(!irqs_disabled()))
+		local_irq_disable();
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
 	 * first CPU executing it calls functions containing RCU read-side
-- 
2.25.1



