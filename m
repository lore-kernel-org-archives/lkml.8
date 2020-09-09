Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FA3C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5779820C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670675;
	bh=uVeYyknux3zp8lb02Qzm6gBw6hetVk6RN4v4BL9nthM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2bTOJSLT9k/0fZVkZxYf11qQCPqEEYECYpSSd4VSCWrnfiXzCFkoAPTy+tYhJW8Xd
	 Z+pVHeBy0HoSvrUM+5cd0u0+N0B/rnBnr9y3IX/Z5bFNaDK9XU3eIkEHGwhdL9QZaR
	 Xp9YcHK+tigraHmOeVZf3fScO+Jl7I4vhTZ8OqbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbgIIQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730682AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC692224C;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=uVeYyknux3zp8lb02Qzm6gBw6hetVk6RN4v4BL9nthM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNT/J1dYdb7xQkRmfZmmvxtRpwvl6/Jlgef1pNizEs9bu7/bvPc+sIiw23m1NRCH3
         xmnmoi7Y4teOvmjGL43nqnho3nvg/OFK0Xk5lXct1Mr0kjJ8xlWD2YBtlWaplfWCkr
         3itNXyk7ZvyudFMIj2KI3DbKTTfymM++urgFb8WY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXp-Qz; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/30] drivers: core: fix kernel-doc markup for dev_err_probe()
Date:   Wed,  9 Sep 2020 16:10:59 +0200
Message-Id: <a9c94fa77ef6880b2f583c35f382776194553ca3.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two literal blocks there. Fix the markups, in order
to produce the right html output and solve those warnings:

	./drivers/base/core.c:4218: WARNING: Unexpected indentation.
	./drivers/base/core.c:4222: WARNING: Definition list ends without a blank line; unexpected unindent.
	./drivers/base/core.c:4223: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: a787e5400a1c ("driver core: add device probe log helper")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/base/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8dd753539c06..21f8ae132fff 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4211,13 +4211,16 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  * -EPROBE_DEFER and propagate error upwards.
  * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
  * checked later by reading devices_deferred debugfs attribute.
- * It replaces code sequence:
+ * It replaces code sequence::
+ *
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
  * 	else
  * 		dev_dbg(dev, ...);
  * 	return err;
- * with
+ *
+ * with::
+ *
  * 	return dev_err_probe(dev, err, ...);
  *
  * Returns @err.
-- 
2.26.2

