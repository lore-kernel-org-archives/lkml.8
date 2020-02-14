Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C7D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702539;
	bh=H1Pl5C7u+IIKGTxmcgLvipyZTnbCfoWKS0ajJ064jvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c3yshHbAZYDrGGm4ZlOVvfyuwaUqFkRe4MtSm6IHqgJ4Em9Jqwzp+Y+tB5biesy+s
	 sRa7nsQwXdbrxNK2c+NmERmG8AA+30/Pd5G8ld3HMbWM1teeRfWkAma3CvfNZS9HEA
	 ldj68niORBHf/Imma5lMGNh0JaJIn11kLxj60jxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbgBNP7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388922AbgBNP73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:59:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C257F2467C;
        Fri, 14 Feb 2020 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695968;
        bh=H1Pl5C7u+IIKGTxmcgLvipyZTnbCfoWKS0ajJ064jvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KITeqqcW54FlHbINrJWEszTvBsF6ALyqQtEVa71nxYeDQA54D0ZuETtw8y0CJPPzL
         KE1ztewzrLOzOW+6Ey2EGgEjfs/hcRssBqqzBNGoL51WbvWAfWjwBfgo4savel1ucA
         6KCSdLn+sWcAqpdoESS7OCxqBLFcL/iQKz1JTmkU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 496/542] char: hpet: Fix out-of-bounds read bug
Date:   Fri, 14 Feb 2020 10:48:08 -0500
Message-Id: <20200214154854.6746-496-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

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
index aed2c45f7968c..ed3b7dab678db 100644
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

