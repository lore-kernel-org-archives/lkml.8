Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F18C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B48A2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217419;
	bh=wbfoAA42oX5l4yauXATlXAMyCq6qjlKLDgmai3tPlJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eTJANFWGfWl8j79gbz9HamxHCQiiIweRc2s62JwEeUcKfS95+4u1M66Q2fd5KYWaP
	 jvf0veT31fIYfjbHfj0nrYQgIHSH9bzEJm16etmDfSP/PiydyCCiEMeEJLJ/CzrBZL
	 zivwDK+Wi9Vr/Wf4KE90nZJbPuF4DmkRF9MW5oiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbgAPXaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391398AbgAPXaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:30:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BD32082F;
        Thu, 16 Jan 2020 23:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217407;
        bh=wbfoAA42oX5l4yauXATlXAMyCq6qjlKLDgmai3tPlJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhdT7lqkkmsOfFBONYJo9pBF3x0UcIaVCH5du2uCNxx8cOwo2Vle/EF4nhdbOeFFt
         nyt6Pnawksi5m66TFY6tLhs8EYRjcMTTWIhqtHGZo7izf690UMqtHHsQpN1tS7PCm+
         JZc0sZI9/tf3AGvDX3VcPjFLpicWn7EC4dFufDxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kars de Jong <jongk@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.19 71/84] rtc: msm6242: Fix reading of 10-hour digit
Date:   Fri, 17 Jan 2020 00:18:45 +0100
Message-Id: <20200116231721.909774423@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kars de Jong <jongk@linux-m68k.org>

commit e34494c8df0cd96fc432efae121db3212c46ae48 upstream.

The driver was reading the wrong register as the 10-hour digit due to
a misplaced ')'. It was in fact reading the 1-second digit register due
to this bug.

Also remove the use of a magic number for the hour mask and use the define
for it which was already present.

Fixes: 4f9b9bba1dd1 ("rtc: Add an RTC driver for the Oki MSM6242")
Tested-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Link: https://lore.kernel.org/r/20191116110548.8562-1-jongk@linux-m68k.org
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-msm6242.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/rtc/rtc-msm6242.c
+++ b/drivers/rtc/rtc-msm6242.c
@@ -132,7 +132,8 @@ static int msm6242_read_time(struct devi
 		      msm6242_read(priv, MSM6242_SECOND1);
 	tm->tm_min  = msm6242_read(priv, MSM6242_MINUTE10) * 10 +
 		      msm6242_read(priv, MSM6242_MINUTE1);
-	tm->tm_hour = (msm6242_read(priv, MSM6242_HOUR10 & 3)) * 10 +
+	tm->tm_hour = (msm6242_read(priv, MSM6242_HOUR10) &
+		       MSM6242_HOUR10_HR_MASK) * 10 +
 		      msm6242_read(priv, MSM6242_HOUR1);
 	tm->tm_mday = msm6242_read(priv, MSM6242_DAY10) * 10 +
 		      msm6242_read(priv, MSM6242_DAY1);


