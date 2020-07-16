Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BF2C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D564320775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TCIyS9PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGPBaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgGPBaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:30:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4ECC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FXWTphzrW3vR3I8XbwNjBExTeT5BTHwhRLPG9dUD25I=; b=TCIyS9POj33Ywy9ZzSqL1x7k5Y
        YFcrZQnslWppa4+qd9OVbMQfsq5SuLF3YM+3fkvBduCq9NNqFBAsq0NeUmiTUctnE8Hqphwfl88Jo
        5J9DJRS+Aoiy78X8XFKPvvbpbrAzNiLhTGJQC+6m8XUMPU+2UXh0mRWC/tn1sbJ7bqdCKSRc97mjA
        TUs7DVBqt4mXuJASM1+NpNiZeFeBj7AAQOQb3GMGmgkFHW4Ufi94NaSatqxfwTjewdX2P31mFoNiW
        kC0TgWrmM/eatHudKikAurZ0ApRdaR3yeim4gO8/FeEBmVvKDiWXd/ZORWioQYEsvlGwe10Wx+iVm
        bRsV9+cg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvsj0-0000W0-Oy; Thu, 16 Jul 2020 01:30:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] regmap: fix duplicated word in <linux/regmap.h>
To:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Message-ID: <7ef41bfc-de3e-073a-8746-0b3fdf7628c0@infradead.org>
Date:   Wed, 15 Jul 2020 18:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Change doubled word "be" to "to be".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/regmap.h
+++ linux-next-20200714/include/linux/regmap.h
@@ -275,7 +275,7 @@ typedef void (*regmap_unlock)(void *);
  *			readable if it belongs to one of the ranges specified
  *			by rd_noinc_table).
  * @disable_locking: This regmap is either protected by external means or
- *                   is guaranteed not be be accessed from multiple threads.
+ *                   is guaranteed not to be accessed from multiple threads.
  *                   Don't use any locking mechanisms.
  * @lock:	  Optional lock callback (overrides regmap's default lock
  *		  function, based on spinlock or mutex).

