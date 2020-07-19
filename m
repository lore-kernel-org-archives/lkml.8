Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D5AC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4E1208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="10INcLcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgGSAbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:31:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1EAC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QgQQzsrMmD3EZFV2hxjqmAf6S3mWfgP7FJPU+KHnJVw=; b=10INcLcpOOInRsnglgxnCarwX3
        1BjgOpiaO0MZTKMJWjCkksGuMbldgNFuWURzBBwPVexP9hT5g1rggq+Xwt4JPyMbx6Wvs+88Sak55
        5QyF87sWFaA8/u1Be1mw0giMGt0QNaf4NEL8hMINKCgW2XRTzoPBcuj2rY9yvvuxVaVoSciQgLQ+p
        krojbhOaXBJH01W4dUgteihXL55IR/l48AcLJU0mnUR7S63guxTz5gOX5gZXm7GQ5vx01r88tQoll
        Fn5mCQXaaFiwE1930Io2aaq4BeMr6tMumIRnQwb5ElqaQDCpXaRSbGGDUvNVK3Im8VwjifS3Q5Jfx
        ZUf5KiRQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxEH-0002rA-3D; Sun, 19 Jul 2020 00:30:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] platform_data: cros_ec_commands.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:30:53 -0700
Message-Id: <20200719003053.20899-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "using" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tzung-Bi Shih <tzungbi@google.com>
Cc: Mark Brown <broonie@kernel.org>
---
or "using the" ?

 include/linux/platform_data/cros_ec_commands.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/platform_data/cros_ec_commands.h
+++ linux-next-20200717/include/linux/platform_data/cros_ec_commands.h
@@ -783,7 +783,7 @@ struct ec_host_response {
  *
  * Packets always start with a request or response header.  They are followed
  * by data_len bytes of data.  If the data_crc_present flag is set, the data
- * bytes are followed by a CRC-8 of that data, using using x^8 + x^2 + x + 1
+ * bytes are followed by a CRC-8 of that data, using x^8 + x^2 + x + 1
  * polynomial.
  *
  * Host algorithm when sending a request q:
