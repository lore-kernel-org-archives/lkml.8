Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823B3C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C01F208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fyXNkQUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgGSA3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSA3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:29:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4F6C0619D2;
        Sat, 18 Jul 2020 17:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HYwRIseydueaNGPtPxodW7LfJsXFG0DGMiEeAH1qE1M=; b=fyXNkQUne1lyZYcalT4pUQBlmV
        dvpkghuGro/7P7F4HndNjeQJv9LVXwImDDDznJZjmkSGxWANonP6ZE+jPgJI2qztnQExxLK1tbGXt
        cTYfWmHAu/RBWAOAGZmnkBbo/ZihQSHmp1f3McGWAAHRv5JFoAWghtEfqzETlwt9lAGhUgCaIBeJX
        eF7nXUABS1y0Mw/sqdK/LA7NRj9knWWTiW0zNB2LFSIrypZJ4amd1XuARU3BP/x2zJIQC6YUZzqfI
        xFFWVTGaf49YRHjFpqnxug0YbdUCopf92ZMLkkehBJieIno09VqOyLzSSbqeNL7Z/sUZ1mbxcv+kW
        ElX9B+Bw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxCW-0002j2-82; Sun, 19 Jul 2020 00:29:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH] isst: isst_if.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:29:03 -0700
Message-Id: <20200719002903.20469-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "for" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
---
This description could still use some better wording.

 include/uapi/linux/isst_if.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/uapi/linux/isst_if.h
+++ linux-next-20200717/include/uapi/linux/isst_if.h
@@ -69,7 +69,7 @@ struct isst_if_cpu_maps {
  * @logical_cpu:	Logical CPU number to get target PCI device.
  * @reg:		PUNIT register offset
  * @value:		For write operation value to write and for
- *			for read placeholder read value
+ *			read placeholder read value
  *
  * Structure to specify read/write data to PUNIT registers.
  */
