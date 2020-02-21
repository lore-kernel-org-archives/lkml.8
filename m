Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF46C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A3F2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274376;
	bh=hDDi7NfkHyAkUUnTbKQGRytKtjAXcZBx1AojSyMOTjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LWT6wK2dcLHy1sSpIt9WDUsKmw9pE654B6KhPcpklUSrO0TUxUvwF2YjCgoMXL5oY
	 LAJdI/nNEg/FKQOMlUYgT4P0jDLb6by9CnQZmEj66PLiNlvkQNEntDCZ2uufcK8T7i
	 GeZpnNpidDi8fnRCHZ0bJVC7OXdtZ0o6TTk0pUtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgBUIje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbgBUIA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:00:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB48206ED;
        Fri, 21 Feb 2020 08:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272056;
        bh=hDDi7NfkHyAkUUnTbKQGRytKtjAXcZBx1AojSyMOTjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1L3pVzJKZuNiOgwUb2P10Q5Yj6WRta6/fLxn9UGm/6F2ukdqruBaLN36qi9thicmF
         K/+MgLsp/za0MGsF/aELw51ilbrRI6Dq2FdDXy7kImgHMEtDFg6wNq2AfBchLQWYj9
         KvdeiWmVKdkKD2eV+9UxXqyxzX2wz0l1FBxLluEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 362/399] char: hpet: Fix out-of-bounds read bug
Date:   Fri, 21 Feb 2020 08:41:27 +0100
Message-Id: <20200221072435.896514172@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

[ Upstream commit 98c49f1746ac44ccc164e914b9a44183fad09f51 ]

Currently, there is an out-of-bounds read on array hpetp->hp_dev
in the following for loop:

870         for (i = 0; i < hdp->hd_nirqs; i++)
871                 hpetp->hp_dev[i].hd_hdwirq = hdp->hd_irq[i];

This is due to the recent change from one-element array to
flexible-array member in struct hpets:

104 struct hpets {
	...
113         struct hpet_dev hp_dev[];
114 };

This change affected the total size of the dynamic memory
allocation, decreasing it by one time the size of struct hpet_dev.

Fix this by adjusting the allocation size when calling
struct_size().

Fixes: 987f028b8637c ("char: hpet: Use flexible-array member")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/r/20200129022613.GA24281@embeddedor.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 9ac6671bb5141..f69609b47fef8 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -855,7 +855,7 @@ int hpet_alloc(struct hpet_data *hdp)
 		return 0;
 	}
 
-	hpetp = kzalloc(struct_size(hpetp, hp_dev, hdp->hd_nirqs - 1),
+	hpetp = kzalloc(struct_size(hpetp, hp_dev, hdp->hd_nirqs),
 			GFP_KERNEL);
 
 	if (!hpetp)
-- 
2.20.1



