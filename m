Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083FC22CAD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931220;
	bh=nibtvUdmYlYfzAmksvOuc+YpD990OolnyT4nsyqRArQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rs91NVGUqmQZQOkm1iNBE9ZrBb6eIn4pjKM5PgF+WzkGKLSfFE4lIvEmYRMnUFIcu
	 Hxe8akssUx6o27k9OftXh7oqr/JaFjuE3v/oYL7DIzy2XNjJz9FTpeHOF6XZu3ZSVD
	 EGsdZYocx87UknGaUQmoJMJQanH50Cd1VLQ3L9b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgHTNpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgHTJaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:30:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23D8322BEB;
        Thu, 20 Aug 2020 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915818;
        bh=nibtvUdmYlYfzAmksvOuc+YpD990OolnyT4nsyqRArQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=02h011X0haOlRI72Nbs7oianmCMazDs3/HWravs2JnIm78fABiQV3geV9KBhr5Mdt
         Ut96Rcysar2YN6w3F+1mlDmBreI+s3sv/FewMyrTP8tg/Wbht+dvTESasqxiT0BnnH
         9pIR60IRkgGb86Kjev3bGr7nxpWW0s2OvbBeBjiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 144/232] rtc: pl031: fix set_alarm by adding back call to alarm_irq_enable
Date:   Thu, 20 Aug 2020 11:19:55 +0200
Message-Id: <20200820091619.798300902@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 4df2ef85f0efe44505f511ca5e4455585f53a2da ]

Commit c8ff5841a90b ("rtc: pl031: switch to rtc_time64_to_tm/rtc_tm_to_time64")
seemed to have accidentally removed the call to pl031_alarm_irq_enable
from pl031_set_alarm while switching to 64-bit apis.

Let us add back the same to get the set alarm functionality back.

Fixes: c8ff5841a90b ("rtc: pl031: switch to rtc_time64_to_tm/rtc_tm_to_time64")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20200714124556.20294-1-sudeep.holla@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pl031.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 40d7450a1ce49..c6b89273feba8 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -275,6 +275,7 @@ static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
 	writel(rtc_tm_to_time64(&alarm->time), ldata->base + RTC_MR);
+	pl031_alarm_irq_enable(dev, alarm->enabled);
 
 	return 0;
 }
-- 
2.25.1



