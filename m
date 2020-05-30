Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37CC20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgE3HrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgE3Hqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982C7C03E969;
        Sat, 30 May 2020 00:46:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCW-0001sF-9b; Sat, 30 May 2020 09:46:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA8601C0489;
        Sat, 30 May 2020 09:46:36 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:36 -0000
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iio: dummy_evgen: Fix use after free on error in
 iio_dummy_evgen_create()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159082479679.17951.6915233076766027126.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     128516e49de67d10d52fba62ef8d482b220ac4b0
Gitweb:        https://git.kernel.org/tip/128516e49de67d10d52fba62ef8d482b220ac4b0
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Wed, 20 May 2020 15:03:06 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 May 2020 13:11:41 +01:00

iio: dummy_evgen: Fix use after free on error in iio_dummy_evgen_create()

We need to preserve the "iio_evgen->irq_sim_domain" error code before
we free "iio_evgen" otherwise it leads to a use after free.

Fixes: 337cbeb2c13e ("genirq/irq_sim: Simplify the API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/iio/dummy/iio_dummy_evgen.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index 409fe0f..ee85d59 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -45,6 +45,8 @@ static struct iio_dummy_eventgen *iio_evgen;
 
 static int iio_dummy_evgen_create(void)
 {
+	int ret;
+
 	iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
 	if (!iio_evgen)
 		return -ENOMEM;
@@ -52,8 +54,9 @@ static int iio_dummy_evgen_create(void)
 	iio_evgen->irq_sim_domain = irq_domain_create_sim(NULL,
 							  IIO_EVENTGEN_NO);
 	if (IS_ERR(iio_evgen->irq_sim_domain)) {
+		ret = PTR_ERR(iio_evgen->irq_sim_domain);
 		kfree(iio_evgen);
-		return PTR_ERR(iio_evgen->irq_sim_domain);
+		return ret;
 	}
 
 	mutex_init(&iio_evgen->lock);
