Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8721AC3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3602465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Q34BR4Yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBSAUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:20:52 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:42504 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbgBSAUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:20:51 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2B208C00A4;
        Wed, 19 Feb 2020 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582071650; bh=49HIPV7UVjMJfo0JxqqaYUaFztMT5Pl+eqcCydvEj0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Q34BR4YfOfzg0GjdllVRD1JoImwYzmv9qLtGWrY11hQKY0Bawam1oWDCCh6cBRZj4
         uIAB1d5Vef/vBRUVnxI1HaS0shoT2T7flSzqvgIWpirFGpSY+SQOp7aiBHA+qMGwL6
         rWwZMhSeygkAzFKx+d/F/O0rQ4xG3nnXPDfNGiJmm0mxy1a0cvvJFjGQyWGAXeih/I
         uVe1CkIjvV8bR9JfO6dt7SmN3O5Lh1g5UseuGvmHadHi9qRmIqBfZKTZVhlnkXaWCt
         3sd5gEmYltG0aCy01DrPT1tk2UudkzAFDumGpU5L228peOZk0Lx4DQDQl4ZfazlR4C
         nqgVbdd2vm/gg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3A98BA0079;
        Wed, 19 Feb 2020 00:20:47 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 26A223D24C;
        Wed, 19 Feb 2020 01:20:47 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        corbet@lwn.net, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 3/5] i3c: master: add i3c_for_each_dev helper
Date:   Wed, 19 Feb 2020 01:20:41 +0100
Message-Id: <868e5b37fd817b65e6953ed7279f5063e5fc06c5.1582069402.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce i3c_for_each_dev(), an i3c device iterator for use by i3cdev.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/internals.h |  1 +
 drivers/i3c/master.c    | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index bc062e8..a6deedf 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *));
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 21c4372..8e22da2 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2640,6 +2640,18 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	dev->ibi = NULL;
 }
 
+int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *))
+{
+	int res;
+
+	mutex_lock(&i3c_core_lock);
+	res = bus_for_each_dev(&i3c_bus_type, NULL, data, fn);
+	mutex_unlock(&i3c_core_lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(i3c_for_each_dev);
+
 static int __init i3c_init(void)
 {
 	return bus_register(&i3c_bus_type);
-- 
2.7.4

