Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2930AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E2424672
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685613;
	bh=EUJO2tQhfwVYwxxfWTYEF7FQRmqGWHxjoBjnujI3AV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ty7nvYanTcXsTs6yuuhyoib+rBvAd9k20B8o32cX6PBWKJf4LypFlGW8/YyEsJpS3
	 ic9HW1Gy6OwiSYE44QEIkMg/0JL0wn1MwWXM+MbN8OquXqE38BqVphEKbEbgC55mAs
	 zaVvAyhe/o6C9wO4M0YvKoKkLQw8xH5zbmR0SDXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgAVJdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgAVJd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:33:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6753024672;
        Wed, 22 Jan 2020 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685608;
        bh=EUJO2tQhfwVYwxxfWTYEF7FQRmqGWHxjoBjnujI3AV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhCuQPf0cxfVa70z+CLXXOxQ3WF/HIvoTIHmn1mjSNj7AqoZdpTU1BBuxYHblxgu+
         49kS6gNVB2LAi/ZczA2UzB2qZFKQQZd5FKbvs6+rP0FHJrU7epUS1ieYXQI9ppRIcK
         QtLdaEMyWbC8/jMXAPT/98HNCzIQwAyKC7sAHBoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 76/76] regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id
Date:   Wed, 22 Jan 2020 10:29:32 +0100
Message-Id: <20200122092803.189647649@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit 458ea3ad033fc86e291712ce50cbe60c3428cf30 upstream.

Those regulators are not actually supported by the AB8500 regulator
driver. There is no ab8500_regulator_info for them and no entry in
ab8505_regulator_match.

As such, they cannot be registered successfully, and looking them
up in ab8505_regulator_match causes an out-of-bounds array read.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191106173125.14496-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/regulator/ab8500.h |    2 --
 1 file changed, 2 deletions(-)

--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -44,8 +44,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_ANAMIC2,
 	AB8505_LDO_AUX8,
 	AB8505_LDO_ANA,
-	AB8505_SYSCLKREQ_2,
-	AB8505_SYSCLKREQ_4,
 	AB8505_NUM_REGULATORS,
 };
 


