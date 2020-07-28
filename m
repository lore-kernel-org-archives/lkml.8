Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD0C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C1C20656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VxeiPiCr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qblETHe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgG1KuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgG1KuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:50:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9F3C061794;
        Tue, 28 Jul 2020 03:50:14 -0700 (PDT)
Date:   Tue, 28 Jul 2020 10:50:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595933411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dimlmuFieJ1EpplWo3JrvmutEpWN5OaldTsfxRyNdgg=;
        b=VxeiPiCrzgnSn2lG0yJc61nNg4+JWv9C6CFf+98PvpIg74hPEej/0Rns25D8KavyibOSbu
        jGDtRfBmUBhff0gtkvWTblHu405RXfSva3Kf3+u942EOIIBpEn6tpB7y5g7n//v2rVn/+W
        eMyOnJm8cpf7w0SiIW0Jh9CyqYbZcoTUYd25GsxwIVvAOHYRAUVmC6/3IUzFmLoWHdjVP5
        G36TXRZKZMvxIrfl4D0/L8HXREeTFRQLKk4zOA+FlOdRFLxOZWhjZ5I4KvpxjrvzS6wSAl
        QxUY9gmJVevrYYDrPwU/ea+e8Isj9vPdjLktWyCi3i/vKEYlIayRpAx1UTiVmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595933411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dimlmuFieJ1EpplWo3JrvmutEpWN5OaldTsfxRyNdgg=;
        b=qblETHe6v98T8LK4aU8POeFrBdrsbm9kjTMhF1NUaOJwE7aeL8qbFucJzpLSQN7gIdHmz/
        QDD/iL/NDY6b0FDA==
From:   tip-bot2 for =?utf-8?b?546L5paH6JmO?= <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix a typo in a comment
Cc:     Wang Wenhu <wenhu.wang@vivo.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <AAcAXwBTDSpsKN-5iyIOtaqk.1.1595857191899.Hmail.wenhu.wang@vivo.com>
References: <AAcAXwBTDSpsKN-5iyIOtaqk.1.1595857191899.Hmail.wenhu.wang@vivo.com>
MIME-Version: 1.0
Message-ID: <159593341116.4006.140505713819704674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c1b7b8d42b5422627b0a8268416a60748f8d000f
Gitweb:        https://git.kernel.org/tip/c1b7b8d42b5422627b0a8268416a60748f8=
d000f
Author:        =E7=8E=8B=E6=96=87=E8=99=8E <wenhu.wang@vivo.com>
AuthorDate:    Mon, 27 Jul 2020 21:39:51 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jul 2020 23:37:53 +02:00

sched: Fix a typo in a comment

Change the comment typo: "direcly" -> "directly".

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/AAcAXwBTDSpsKN-5iyIOtaqk.1.1595857191899.Hmai=
l.wenhu.wang@vivo.com
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5033813..adf0125 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -374,7 +374,7 @@ struct util_est {
  * For cfs_rq, they are the aggregated values of all runnable and blocked
  * sched_entities.
  *
- * The load/runnable/util_avg doesn't direcly factor frequency scaling and C=
PU
+ * The load/runnable/util_avg doesn't directly factor frequency scaling and =
CPU
  * capacity scaling. The scaling is done through the rq_clock_pelt that is u=
sed
  * for computing those signals (see update_rq_clock_pelt())
  *
