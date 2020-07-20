Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B0CC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A122065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261662;
	bh=5rXQzEYU2+gqpuTghtoF8F6v6J2dFvnYt0oGnr0YInE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1MTzo+2edPusTrLMsvjZNokeHvaxxPBy0RWgq+TxOl8WyY+GElyV/cMg7FQiVqJxt
	 hnJpvrNurv8KfwUzHROkAciD09d4USWEYlyG24UiIRIKNzMPJuc+YT0JeFsdt6uib+
	 VbazYhZ1vGMwV6wJNztMNI97v3JHYSADMIM4Ldn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgGTQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388247AbgGTQOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:14:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0907F2064B;
        Mon, 20 Jul 2020 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261658;
        bh=5rXQzEYU2+gqpuTghtoF8F6v6J2dFvnYt0oGnr0YInE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8vYR9mYs1HfqRm5V2PBrACeLpw78YHNvvgwaZJ2YdUCXL03ypkAaJIPgfTrs960K
         duTX6D3n7++B4KnLdxO2AI7M7cnZUrpdTPTTcvTxp/aDF4v7eBdOYNuMKlEzAVmd25
         7lE4AS/UwqJ6pnvGm0xwFbPOnumD2cVNkLH/PV40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.7 195/244] timer: Fix wheel index calculation on last level
Date:   Mon, 20 Jul 2020 17:37:46 +0200
Message-Id: <20200720152835.122048387@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

commit e2a71bdea81690b6ef11f4368261ec6f5b6891aa upstream.

When an expiration delta falls into the last level of the wheel, that delta
has be compared against the maximum possible delay and reduced to fit in if
necessary.

However instead of comparing the delta against the maximum, the code
compares the actual expiry against the maximum. Then instead of fixing the
delta to fit in, it sets the maximum delta as the expiry value.

This can result in various undesired outcomes, the worst possible one
being a timer expiring 15 days ahead to fire immediately.

Fixes: 500462a9de65 ("timers: Switch to a non-cascading wheel")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200717140551.29076-2-frederic@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -522,8 +522,8 @@ static int calc_wheel_index(unsigned lon
 		 * Force expire obscene large timeouts to expire at the
 		 * capacity limit of the wheel.
 		 */
-		if (expires >= WHEEL_TIMEOUT_CUTOFF)
-			expires = WHEEL_TIMEOUT_MAX;
+		if (delta >= WHEEL_TIMEOUT_CUTOFF)
+			expires = clk + WHEEL_TIMEOUT_MAX;
 
 		idx = calc_index(expires, LVL_DEPTH - 1);
 	}


