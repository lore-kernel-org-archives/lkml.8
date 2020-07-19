Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261C4208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8AwoCNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGSAar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:30:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7D3C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZnUSh8CxSvaPT7bwdhXwlKE3pWrpNUWJZ1f9qWu/kyk=; b=D8AwoCNk/9BJBMcnXIy1kpl1da
        lWJm5B3ebNKCMbqvBRjY+W9QFjAWgxhlevvV+J6drFGWIVTWO7wlSzCBZW11+l9GG18goKNI8WIeD
        xRUhmdGe3ZI8yRMduhXArYvkg3L8JZoDgC+ptdc0YInKeZv8GrPzcpSrF19kFfiJcqMPk5oLX98uS
        DOhIz0iycAQcmFfxqAEURBI/XzHsCnccjQBeAb0eb1ihLqkFdQWMD/E30a+MP+7JySqhb1WT7odZK
        3Kv/rOOlViWcz1TEUNEtAf9dP1Fq5910UyUuwR9Z7FfLlmbsznBQHVKwVjMl+yEa17DoJi9H7oGFp
        xqP3aLZw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxE4-0002q5-JX; Sun, 19 Jul 2020 00:30:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] platform_data: ad7793.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:30:40 -0700
Message-Id: <20200719003040.20848-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "and" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>
---
 include/linux/platform_data/ad7793.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/platform_data/ad7793.h
+++ linux-next-20200717/include/linux/platform_data/ad7793.h
@@ -40,7 +40,7 @@ enum ad7793_bias_voltage {
  * enum ad7793_refsel - AD7793 reference voltage selection
  * @AD7793_REFSEL_REFIN1: External reference applied between REFIN1(+)
  *	and REFIN1(-).
- * @AD7793_REFSEL_REFIN2: External reference applied between REFIN2(+) and
+ * @AD7793_REFSEL_REFIN2: External reference applied between REFIN2(+)
  *	and REFIN1(-). Only valid for AD7795/AD7796.
  * @AD7793_REFSEL_INTERNAL: Internal 1.17 V reference.
  */
