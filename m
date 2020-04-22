Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1856C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BFA21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550074;
	bh=nCa1oM8XT517eLWFGFsYd+m5KajbIUI2sv+i1okp1tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aCiN3xjJqo4NMFEh4vnLe11/RMXFJ9POjOxCgfYlduCLqrCP/1h/R1EE68Huf3LcZ
	 QLkpocdC1U1dDBm7YMQ8+opm52iY1DoOmPQwyOZQnuRzgJ18eHhE8nQq9GkuYXDntj
	 JHxLvg4bv3lGN/CrtGKUuL/JrDM+UinSXIKakkBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgDVKHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbgDVKHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:07:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60DC320774;
        Wed, 22 Apr 2020 10:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550064;
        bh=nCa1oM8XT517eLWFGFsYd+m5KajbIUI2sv+i1okp1tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FN7cwchqOcT23rLt3Qbdr7ARjz7U30/uBI9OuGKBki6e2B8cTiqoTxXrqVwnKNEtt
         d+Ru693W9e+YXmOQRvqr8UhxWUUkmmHxu0Ht8Gp5GripqEkr1AvHZ5/yH1bfZkRRiP
         R4QZSuBxYJRpG0Eu7dNwtjhKvrTyjx7604tldmOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.9 120/125] locktorture: Print ratio of acquisitions, not failures
Date:   Wed, 22 Apr 2020 11:57:17 +0200
Message-Id: <20200422095051.906433563@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

commit 80c503e0e68fbe271680ab48f0fe29bc034b01b7 upstream.

The __torture_print_stats() function in locktorture.c carefully
initializes local variable "min" to statp[0].n_lock_acquired, but
then compares it to statp[i].n_lock_fail.  Given that the .n_lock_fail
field should normally be zero, and given the initialization, it seems
reasonable to display the maximum and minimum number acquisitions
instead of miscomputing the maximum and minimum number of failures.
This commit therefore switches from failures to acquisitions.

And this turns out to be not only a day-zero bug, but entirely my
own fault.  I hate it when that happens!

Fixes: 0af3fe1efa53 ("locktorture: Add a lock-torture kernel module")
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/locking/locktorture.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -649,10 +649,10 @@ static void __torture_print_stats(char *
 		if (statp[i].n_lock_fail)
 			fail = true;
 		sum += statp[i].n_lock_acquired;
-		if (max < statp[i].n_lock_fail)
-			max = statp[i].n_lock_fail;
-		if (min > statp[i].n_lock_fail)
-			min = statp[i].n_lock_fail;
+		if (max < statp[i].n_lock_acquired)
+			max = statp[i].n_lock_acquired;
+		if (min > statp[i].n_lock_acquired)
+			min = statp[i].n_lock_acquired;
 	}
 	page += sprintf(page,
 			"%s:  Total: %lld  Max/Min: %ld/%ld %s  Fail: %d %s\n",


