Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D2AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E968720C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670807;
	bh=bDug0htbPkTs/pWzV7NVGwmuxDPdL8W15RowRtsr554=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GKec+NMTg/bQw25t8kF/CWFgCq7DKch08Uk+pXOU7MN3t3SnHfJ6dv8ZwzoapMjxR
	 VqTWV46FHQSZMWxLLxMvO+5cZFlT9zmfxrvo4P/xObC5zl4l9QkdHfiYlf9eu/2Z0A
	 KXHK7CmEZbWWnstujH/GjDRAAwYw5vO/FpfIzGng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgIIRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DEEC221EE;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=bDug0htbPkTs/pWzV7NVGwmuxDPdL8W15RowRtsr554=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQv2sxO0Zsye0NXp8e8i/m2mlH4a/zBs+UbaZSmg8+GubGmhR4KlcQOT59f3DDPaz
         oCTHkIrIM+nOM/RxTwixwrDYTBps0kQqlESbc5dIUPSB5xWI1Tr86xIBy3x8DXdV90
         oKr7jCzvLsLIOxTd6lm+o83rg6E7JZtAWq83pHm8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXK-Ha; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/30] block: bio: fix a warning at the kernel-doc markups
Date:   Wed,  9 Sep 2020 16:10:49 +0200
Message-Id: <73fb7b91726f95ba038fbff025bdecdc8faaf204.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using "@bio's parent" causes the following waring:
	./block/bio.c:10: WARNING: Inline emphasis start-string without end-string.

The main problem here is that this would be converted into:

	**bio**'s parent

By kernel-doc, which is not a valid notation. It would be
possible to use, instead, this kernel-doc markup:

	``bio's`` parent

Yet, here, is probably simpler to just use an altenative language:

	the parent of @bio

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a9931f23d933..ccd3ab549d41 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -327,7 +327,7 @@ static void bio_chain_endio(struct bio *bio)
 /**
  * bio_chain - chain bio completions
  * @bio: the target bio
- * @parent: the @bio's parent bio
+ * @parent: the parent bio of @bio
  *
  * The caller won't have a bi_end_io called when @bio completes - instead,
  * @parent's bi_end_io won't be called until both @parent and @bio have
-- 
2.26.2

