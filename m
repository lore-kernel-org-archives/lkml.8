Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98728C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695B524673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685588;
	bh=wbfoAA42oX5l4yauXATlXAMyCq6qjlKLDgmai3tPlJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hp3AraR7mNPCz6EhOdF/LlCM4iBjv7vO3P0EloEhwdXPfl6uMwpy64Bw9IxBxwtK5
	 9e4tDdru+LZLBSCa0QfqwoJLir4ZwX8BabTXKDSAPTljFO7tQ+qwiy37fTNYjXM4Ft
	 8kQxJ7hl8xjMWmLKHJHmvawfDnrE8AUq/fwnYQMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgAVJdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbgAVJdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:33:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B34C24672;
        Wed, 22 Jan 2020 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685584;
        bh=wbfoAA42oX5l4yauXATlXAMyCq6qjlKLDgmai3tPlJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhD5J9rgWbvaq57NR9MowP2Dmnpu6PWOhhmJXyFW1cW2iwiPEg6TDWR86ySTd5Fy8
         3qWTXdqT5zRPtQnR7fNJIhbO4A0DYyZ0nCkIifQmu+EtLweiLQMr71cnu6qYFpTGun
         SM830QfaSdquU7r27xCkB54tPrmOAUA2YUv8eYlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kars de Jong <jongk@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.4 36/76] rtc: msm6242: Fix reading of 10-hour digit
Date:   Wed, 22 Jan 2020 10:28:52 +0100
Message-Id: <20200122092755.802958083@linuxfoundation.org>
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


