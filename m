Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D44C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10611207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="Pv4PlDSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgG2HuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgG2HuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:50:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A452C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:50:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so11431870pld.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMRvTgAMRZWNdLWhRQAFPO8+G0B9J9srTu2Fp7kXf3M=;
        b=Pv4PlDSvUs5rLaEoTpzciQ+hhduQt30/O4ei3UMugKzRCA2YIzqApWYMtXjPIAbAIy
         N/++05hCgbTV/pa4HbohOHBt0ijgJXvMJC1D5y3/n6C2lKEX8O3s6LsFTM3Y9PuDZKe1
         zkFkllMX8QCXGPDg7Fum69INLU9jom3EDUcDMFslXxykqS3PEwCPUu0sjFx3N2htljLH
         3TLAA7+sCo6GEk4uSv3QbxhVjFPsaf+XoRHOPZS1ITTsPeEbgiFQY6wrDZTw7BBMgpOR
         3bMfFbfla70s3UMXw/GVZLkMh25P/3DKF8fgIu8P2q8M7j/myo+Yymca7BlT0Tzozi/j
         RKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMRvTgAMRZWNdLWhRQAFPO8+G0B9J9srTu2Fp7kXf3M=;
        b=dNHM2OccZAYJAlyNIJzZsQsTW3SJ7MfVOirQgoqYN0Bg2ZNNqeeywx1xr/RVwgeIA+
         nopWot7bAgFTFsLeEOYqyUKlWCiy1vhBVg6OqPQjzS4/nljGFUQaHiO/mNKJK11yZcbq
         2AVHkUd6Rwv9F1VpoQbDddKkKTKcRoqBcT9fhi7+FcCtLGTTmi4I7WmECH6wig22BWdk
         trmY0vMuAzCQhEenwflPQWGB5ZLhqOF7WCA4NNc4hCbXb4nwM0R5JgSSaFNIgS02bkMz
         FfJDKGM90K5DSeT6s11ncxNlQEzWtkCzi8svM32KXHvWGeRWnQdeaqVaW728NQz1UNA0
         NsQQ==
X-Gm-Message-State: AOAM531IypfefJhJQaRID/HcIHIATrLHyq5qPuXzqUWsqYa0mhb54L49
        r/dtbUhhFUYo68zOL5qjbAIMcA==
X-Google-Smtp-Source: ABdhPJwtuQIMJfXX6BRy9J6K7RurkEhxzJagqM0sTWR72u8s/9BgM6XzZJ/ufJM/E4li4jFFyGNZ1w==
X-Received: by 2002:a17:90a:c693:: with SMTP id n19mr8647892pjt.53.1596009016146;
        Wed, 29 Jul 2020 00:50:16 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id a67sm1406198pfa.81.2020.07.29.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 00:50:15 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, b18007@students.iitmandi.ac.in
Subject: [PATCH v3] Staging: media: atomisp: fixed a brace coding sytle issue
Date:   Wed, 29 Jul 2020 13:19:50 +0530
Message-Id: <20200729074950.2104-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728225935.28880-1-b18007@students.iitmandi.ac.in>
References: <20200728225935.28880-1-b18007@students.iitmandi.ac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed braces for a 'if' condition as it contain only single line & 
there is no need for braces for such case according to coding style
rules.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>

---
Changes in v2:
	-Added more description about the patch.
	-Added space before the symobol '<' in 'From'
	 and 'Signed-off-by' line.
Changes in v3:
	-Removed space before ':' in subject line.

 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 8ea65bef35d2..28b96b66f4f3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -4981,9 +4981,8 @@ enum mipi_port_id __get_mipi_port(struct atomisp_device *isp,
 	case ATOMISP_CAMERA_PORT_SECONDARY:
 		return MIPI_PORT1_ID;
 	case ATOMISP_CAMERA_PORT_TERTIARY:
-		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID) {
+		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID)
 			return MIPI_PORT1_ID + 1;
-		}
 	/* fall through */
 	default:
 		dev_err(isp->dev, "unsupported port: %d\n", port);
-- 
2.25.1

