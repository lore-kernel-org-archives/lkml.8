Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BBCC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0D02087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670858;
	bh=uhAIZr0X2Q3NYDpcSI4yBl4etfhZlLl3+pYWYXHH7oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MlSKSCuJ5pZKXTp/FOLN3SbG4r/YbTyuGuQp8bbSmFc3Hp0gFxjWqdfwUjz8J+TSL
	 Suz929uY0gHxOTAtgj3g8VdI3eot5khyxgfftqbjq77HO3zKALBa476PEWEg7d863F
	 AjRWsuhfayCReoQiUhHsnm7n3yvbFKACQSeFz+dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgIIRAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730652AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD3522225;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=uhAIZr0X2Q3NYDpcSI4yBl4etfhZlLl3+pYWYXHH7oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gox/MjUogsJfsl1ifAXpMNrV+Fu3fRjLgZ80gkF54lkUC8X9q6z5MrNri8Mah2Zm8
         1LLsaEIfISoNqm2Yp3HvhnLGR5ngcQtW+t/6dtSHzNyyOII72lc4oMLITBVsZWbcCG
         z0qn/JSlkmlv+k0OESgbKQi8CL8flbwWt8S2VNeA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXQ-Jd; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/30] docs: dma-buf: fix some warnings
Date:   Wed,  9 Sep 2020 16:10:51 +0200
Message-Id: <b2bc0bc88eb913635cfece13cc9f6eff7668d333.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix those warnings:

	Documentation/driver-api/dma-buf.rst:182: WARNING: Title underline too short.

	Indefinite DMA Fences
	~~~~~~~~~~~~~~~~~~~~

	Documentation/driver-api/dma-buf.rst:88: WARNING: Unknown target name: "fence poll support".

The first one is due to a shorter markup. The second one is
because the chapter name was wrong.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/dma-buf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 13ea0cc0a3fa..4144b669e80c 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -85,7 +85,7 @@ consider though:
 - Memory mapping the contents of the DMA buffer is also supported. See the
   discussion below on `CPU Access to DMA Buffer Objects`_ for the full details.
 
-- The DMA buffer FD is also pollable, see `Fence Poll Support`_ below for
+- The DMA buffer FD is also pollable, see `Implicit Fence Poll Support`_ below for
   details.
 
 Basic Operation and Device DMA Access
-- 
2.26.2

