Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D524AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD532070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340303;
	bh=EoklstDWNnn2rWz0l7oezB9IjLDwq59jnrNWLRfUkFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQNp8+7fAHqbj8jifWTmL8raFDQKSjQVTrt1Y+I4lHiRNNAkNuRbwZjwVW0rpn5hi
	 AlMQOhNA8L5VaIhLqc7/BsXUx208sbPzBGkIpQSnZe8j3HJJCR3Ipnu6oFCoarlE20
	 I4XZZeiWlJwUyO6RAxNLQX29vjSYViKSi94/PpuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgBJNLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:11:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbgBJMjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:00 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32582080C;
        Mon, 10 Feb 2020 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338339;
        bh=EoklstDWNnn2rWz0l7oezB9IjLDwq59jnrNWLRfUkFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLcz46Xofb1OzTHd2O7eDQAF1wLPjrCzY+AcZViF+OdM/CPNE8JZJ3rI4tmJOUJOa
         ziC/ZbAmrjvsGTywKJMrV2JNQKdEYPjzP7ZuBQiVPwotr1YpbW4RM7ZgxU8oUXidQ5
         b0qpxYw8TGIJ4fpejMTltpPJNt8Caitd9hd5K8ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5.4 290/309] mfd: bd70528: Fix hour register mask
Date:   Mon, 10 Feb 2020 04:34:06 -0800
Message-Id: <20200210122434.575666509@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

commit 6c883472e1c11cb05561b6dd0c28bb037c2bf2de upstream.

When RTC is used in 24H mode (and it is by this driver) the maximum
hour value is 24 in BCD. This occupies bits [5:0] - which means
correct mask for HOUR register is 0x3f not 0x1f. Fix the mask

Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mfd/rohm-bd70528.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/mfd/rohm-bd70528.h
+++ b/include/linux/mfd/rohm-bd70528.h
@@ -317,7 +317,7 @@ enum {
 #define BD70528_MASK_RTC_MINUTE		0x7f
 #define BD70528_MASK_RTC_HOUR_24H	0x80
 #define BD70528_MASK_RTC_HOUR_PM	0x20
-#define BD70528_MASK_RTC_HOUR		0x1f
+#define BD70528_MASK_RTC_HOUR		0x3f
 #define BD70528_MASK_RTC_DAY		0x3f
 #define BD70528_MASK_RTC_WEEK		0x07
 #define BD70528_MASK_RTC_MONTH		0x1f


