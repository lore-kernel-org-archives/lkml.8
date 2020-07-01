Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF98C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2845520722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="st9khFND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGAIcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgGAIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CB4C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so22875541wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8/OUfoNrwMRghF2Xm56r8amPV/zzR8eJyRX/3dxUYA=;
        b=st9khFNDH3xQf2hJ5YLeso81Gz5AFUN9O8or/g0IYTWvmC60mIuf5DpcmpN+ZypxQh
         L7//4DX84Rv+sohP1235h5XV02SuclKXxhx+avvcEunppssBbgU/6l+L5y0SZUNUitrW
         yqTEO2OfoeGa/zeNXp4CvjkFz6a5GPM9NjDUYleFDIeMOdiO6EseWV8NdTOplPNR0Aa9
         cnQpbaNOTam//MtoVajCfdsdiX0oLzvvrc4I142JMlQOu4Pdf28ItPLN5nOy28sy9blx
         96sB0IXnmpWgBEvGbQxfV4uZReiaDSbGtFJvymyi/7FhMmkdpWAeJ0zFDQuo1I4L66Hd
         5JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8/OUfoNrwMRghF2Xm56r8amPV/zzR8eJyRX/3dxUYA=;
        b=ePqybdPsFDEOKUq6GFdmYrlUtt0ybfxJFivsl0AYg5YscJgG1ZsEHDRccigDVfUg3/
         yCG9vdnOt7pQiHIxXMT/RoVQL46dgPcLWopB5FAQVnL7OAXeMswHZmx0S8SFCOk0uG3/
         i+zrtLGE/sxWGtIhdBBVojLbuhSkwOhwRZKTnEZhhAmzYm55w4eSRk5D0bhkUw10n9wu
         QM/MvaVQCLKjxcqeHENkFuyeloDpuku5pHQTSR3sVbee2yCcEF5vRk5tGVAfEDFnGQQs
         IoO3/eN3OPnI7vQVULKSRMWvKlRQwrdVVD+sakOvw9dVvqGVYUXvvUkVlfmiCCGTn3FY
         M7vw==
X-Gm-Message-State: AOAM531engExwVKtA1/lVNBa3TYnbPTUqRpxfjArDGow80Xn/QpNBydH
        aUQBXP7Brav7V7FbV3aBx9sGSQ==
X-Google-Smtp-Source: ABdhPJz4nPSjctD17WJOZgqWv8CxdL8DQIOTqp2RBSddELktT6Icfa5fQOy49/+AhZ9uHCv/aOvR1A==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr25251031wrj.273.1593592304581;
        Wed, 01 Jul 2020 01:31:44 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 18/30] misc: mic: scif: scif_api: Remove set but unused variable 'read_size'
Date:   Wed,  1 Jul 2020 09:31:06 +0100
Message-Id: <20200701083118.45744-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'read_size' appears to have been assigned, but never used since the
SCIF messaging and node enumeration APIs were introduced in 2015.
Makes sense to simply remove it.

Fixes the following W=1 warning:

 drivers/misc/mic/scif/scif_api.c: In function ‘_scif_recv’:
 drivers/misc/mic/scif/scif_api.c:1000:6: warning: variable ‘read_size’ set but not used [-Wunused-but-set-variable]
 1000 | int read_size;
 | ^~~~~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_api.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_api.c
index 781217c030a63..d7faffdd87e92 100644
--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -997,7 +997,6 @@ static int _scif_send(scif_epd_t epd, void *msg, int len, int flags)
 
 static int _scif_recv(scif_epd_t epd, void *msg, int len, int flags)
 {
-	int read_size;
 	struct scif_endpt *ep = (struct scif_endpt *)epd;
 	struct scifmsg notif_msg;
 	int curr_recv_len = 0, remaining_len = len, read_count;
@@ -1017,8 +1016,7 @@ static int _scif_recv(scif_epd_t epd, void *msg, int len, int flags)
 			 * important for the Non Blocking case.
 			 */
 			curr_recv_len = min(remaining_len, read_count);
-			read_size = scif_rb_get_next(&qp->inbound_q,
-						     msg, curr_recv_len);
+			scif_rb_get_next(&qp->inbound_q, msg, curr_recv_len);
 			if (ep->state == SCIFEP_CONNECTED) {
 				/*
 				 * Update the read pointer only if the endpoint
-- 
2.25.1

