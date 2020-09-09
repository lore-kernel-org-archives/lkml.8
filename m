Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AA3C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85FF2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRhvZiCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIIBHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgIIBHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:07:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4158FC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=G3jreBmyKffroN4pKjYyxRyZbYNIqoGf6uDQSjc7tpk=; b=rRhvZiCyL3zFwdGsRvla9qewlf
        +DrCxD1sQbHQZl7hKoP9lXnmdXa9SY/8GtMG5KGYgbS+WAICeRKVPgj9R4W9Tm2NxfjI6orfS3A+z
        Z/WCObOo/tmGA2slDv/rNJ5XwpB5jyWN7nmgopqDeJYMEstWOMZh8qojoPDmS5ctTiBsVRDT+AFw0
        cH8I7zBDC2XqoGaQzGwG9HrO/HOjfA9t/LUqsxQi84dtVNIFtuzpRoVqkHf9b5V3WX+MVeH+JWNxk
        v45rPzfkdeSRswr0L7UCl07r1Wznamx+3PMp9zV2CTiojJ9PumGmY/t7Kiy4pcEduxk5HAz0ET+Ue
        yiw1ms8w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFoaN-0006U5-AJ; Wed, 09 Sep 2020 01:07:43 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] lib/mpi: fix spello of "functions"
Message-ID: <8df15173-a6df-9426-7cad-a2d279bf1170@infradead.org>
Date:   Tue, 8 Sep 2020 18:07:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typo/spello of "functions".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/mpi/mpi-bit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200908.orig/lib/mpi/mpi-bit.c
+++ linux-next-20200908/lib/mpi/mpi-bit.c
@@ -1,4 +1,4 @@
-/* mpi-bit.c  -  MPI bit level fucntions
+/* mpi-bit.c  -  MPI bit level functions
  * Copyright (C) 1998, 1999 Free Software Foundation, Inc.
  *
  * This file is part of GnuPG.

