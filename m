Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A73C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7D820759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="uOHtcrYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgG1CPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgG1CPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:15:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89927C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:15:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so9121770plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBlxnjAq+NQ7xq9tyIscN6vQVF0VMix+mjCrmXItPMg=;
        b=uOHtcrYTmCosLIc22eS/NeLsVC6fVrazz3QS9IfOvftpZ3IVdvH2jSELcQ0Je6XAfn
         VpGwJrxu6PCnYN9hqFHF2IIdLqcu19CjfZqEZvgqhU0QWQWzmL+wTIC7Uq2x7OsUB9EO
         xKCUWBc9YUqJhxjPfkDl5NtTJRVDTm4FpftsNZ//mhhq5WkOQAqX6bWILHe4g09GAR3Q
         pdUpSA1e0c7ej0pkI8wZXxJS62RtHuNYBk7+GwV4bJ+06tNjKfVC9r3A5bUBxb6kGSuU
         94VTqY7ku+CAz1Xdai9XfdM4Yg8hsaAcGao5O/433g19X6+0SvtLEI0IVYnzVnHaSeZm
         S+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBlxnjAq+NQ7xq9tyIscN6vQVF0VMix+mjCrmXItPMg=;
        b=AYdUTuVrocWEGqp7PV3345KzOVTvMGXeLR8P2CkLxszozJBZT0hi6j41lByDVwGz2+
         lCSzEdFpKGQ/dpc+1fw/LnEdSI4/N+NjO3NXPfaekOFWN9ZMbqd+qqbcs/p3De0BpUSy
         MQrcCWFOjvZz60toEXlZbKIqpOD2D7+RyGtPtQ1xrO/DG9ibyB0txqxyXrFfI8sV6wkN
         Z6jFZRJXwNDuTYgna5t49MXuiof1qy7zvLY4rM8lW+xTfWNy79hNjZXzOhA0zS4Wbf9E
         Sc5UUZt1nAUx3L1x6ukb+O4tCzJCOJ9KnhvZfBYlIGjMLo/mVGJggq6wVzN1gdvIbmx6
         FH/w==
X-Gm-Message-State: AOAM533xFVGemWp4t0oYk1W4y8KdWkpkysRjRysNj72IsUF5RQzu/UC4
        aC7+SOet3X7fpBvUrDns4/i3eg==
X-Google-Smtp-Source: ABdhPJwzNVTSIeKUloUb5M/3iD6Xn5Y8aCAEXO+PabHJqE0BOsIVOgLuCMNps+33LtqqaT/obVKdiA==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr8654988plo.289.1595902538102;
        Mon, 27 Jul 2020 19:15:38 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id g4sm16732466pgn.64.2020.07.27.19.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 19:15:37 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Ankit Baluni <b18007@students.iitmandi.ac.in>
Subject: [PATCH] Staging : media : atomisp : Fixed a brace coding sytle issue
Date:   Tue, 28 Jul 2020 07:45:18 +0530
Message-Id: <20200728021518.19639-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing coding style issue by removing the braces that are not required.

Signed-off-by: Ankit Baluni<b18007@students.iitmandi.ac.in>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index f8d616f08b51..701de098cb29 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1828,11 +1828,10 @@ static int atomisp_streamon(struct file *file, void *fh,
 			dev_err(isp->dev, "master slave sensor stream on failed!\n");
 			goto out;
 		}
-		if (!IS_ISP2401) {
+		if (!IS_ISP2401)
 			__wdt_on_master_slave_sensor(isp, wdt_duration);
-		} else {
+		else
 			__wdt_on_master_slave_sensor_pipe(pipe, wdt_duration, true);
-		}
 		goto start_delay_wq;
 	} else if (asd->depth_mode->val && (atomisp_streaming_count(isp) <
 					    ATOMISP_DEPTH_SENSOR_STREAMON_COUNT)) {
-- 
2.25.1

