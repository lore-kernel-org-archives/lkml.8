Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918E9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1982078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592919106;
	bh=wN0P/QDy192u7/6MjOrYNxlOo/vHTCArMdyL+uoVyLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zEVzWFdnVyUv7YUoKW6l2pHW5ptKdNFI8mE2XTh4gC01yDUj0i1/MN0CUpfwl77kT
	 VKm4zszAoxvYL3bN4T+fL8sHoIsikDNEnC8QLu9VuU6Xyv/apj0QCx0yLNnnKg5aHM
	 dflMwAoQ83iVrzsY3AOozerZQfWiPfw6f6koi+I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbgFWNbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732622AbgFWNbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:31:44 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A22207D8;
        Tue, 23 Jun 2020 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592919103;
        bh=wN0P/QDy192u7/6MjOrYNxlOo/vHTCArMdyL+uoVyLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VO9Rtb2ITufwU5YFh8tLgEcB8/kDsSItdIiLRKkd0w54P7hYQIs0EA+6y2RYXse2w
         blAwqnqYQMR935GKlbEr8A/GHEpO9nbbzT4r/QQtWfPx9YlQEdSfCaHHi/QLyGRkIm
         iRHksd/Yx3D7OF0iajB3CNftw8tibPGn4aiQuBKo=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnj1Z-007VJt-IA; Tue, 23 Jun 2020 15:31:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 6/7] docs: Add remaining Documentation/*.txt at staging/index.rst
Date:   Tue, 23 Jun 2020 15:31:39 +0200
Message-Id: <35967d18de8b3ee480194acf68e62d515347c1e5.1592918949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592918949.git.mchehab+huawei@kernel.org>
References: <cover.1592918949.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few text files that aren't yet at the docs building
system.

Add those to the staging/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/staging/index.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 8cc9d94b0a13..8e98517675ca 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -19,17 +19,14 @@ Unsorted Documentation
 Atomic Types
 ============
 
-.. include:: ../atomic_t.txt
-   :literal:
+.. literalinclude:: ../atomic_t.txt
 
 Atomic bitops
 =============
 
-.. include:: ../atomic_bitops.txt
-   :literal:
+.. literalinclude:: ../atomic_bitops.txt
 
 Memory Barriers
 ===============
 
-.. include:: ../memory-barriers.txt
-   :literal:
+.. literalinclude:: ../memory-barriers.txt
-- 
2.26.2

