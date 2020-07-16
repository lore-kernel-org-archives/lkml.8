Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69031C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43AD5206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWWjgp5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgGPOAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbgGPOAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:00:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4904C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so7181492wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8klAYyQO0XUjk+Uaf4FLOiJI4lE5n5MAvDNv6XD4s4=;
        b=rWWjgp5yi06+2DXZJxAsdNxCG5tnt2dYAi2ahRNYwJCTEx2h7BaK0uNb3OI+uFFNyh
         rW0mcah5d6ueSxyqHunSJApOSDMbOw8svgfMysK+ef56M57UZEWyiERgsTCLoeZ0I4dL
         0i9nCcefv3Kcv3GZ0/FXR4XgsNlcllSu4RtbhWzs8ev7swk9RY1WdQxAefYUvFLdyunL
         im1eWm3xazGIKw8hNGzSpqXKJId1ZLKkXuk1ORJZfvGHIVF8IpAGH+iYcGDfWnAdVluG
         T2jmNNFhJrOgkDRBXKvZYHj46aRArO9pzKt2YQOiFuLF+8GAj9NDN7Sxbrae1ISzy+Du
         XLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8klAYyQO0XUjk+Uaf4FLOiJI4lE5n5MAvDNv6XD4s4=;
        b=GbGi0vOMr0HKPih8y2HOEtXj0mJ9sC+fAM1Yf3ZDnFr8PDOapq86QtXeH6HeoNby5F
         k/OAyTxkNeRj75t+hGAklpdfS9k+6FljaWFI3rG3zkZp/Pw3R3T3bjwGrtqUPfTTUKB6
         cd9Sc3FElJh1BvK/OJk5wxcZcZW2qNATa2v2xkZKvwJ5bseUeIwCqvh7G+Ymz4PNSqUM
         CDTzLGHIFaAi6+WrLBPjIPEyWiELH/oHHdG1lFDC4wTZqdC+niwMWJRN9OD0J5lCPUr0
         7IVX7qjIh573mjPFhBQgUE8n0GAs+hVX5Advc/w4jkST04DbT8BRi7t/PfpyAN41dqR7
         MsJg==
X-Gm-Message-State: AOAM531v0UREx6NDLW3VVBCl3qzoYFBQuezLPDbmQjFSMSFHDwnukrh3
        lOkDO/4/WrkUAMOlpLniu7fzIw==
X-Google-Smtp-Source: ABdhPJweGCB6iQJoMayzb0bRmwsZwfnIpzosj+nfPpw9Qop4m4IZjfYVe4ImGbZKXoNiKwe+O00u3A==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr5036571wru.88.1594908006570;
        Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 28/30] iio: magnetometer: mmc35240: Fix function header formatting
Date:   Thu, 16 Jul 2020 14:59:26 +0100
Message-Id: <20200716135928.1456727-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All lines in the header must start with " *".

Fixes the following W=1 kernel build warning(s):

 drivers/iio/magnetometer/mmc35240.c:304: warning: bad line:                             compensation for output value.

Cc: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/mmc35240.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 1787d656d0094..19e46b1f4ee81 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -300,8 +300,8 @@ static int mmc35240_read_measurement(struct mmc35240_data *data, __le16 buf[3])
 }
 
 /**
- * mmc35240_raw_to_mgauss - convert raw readings to milli gauss. Also apply
-			    compensation for output value.
+ * mmc35240_raw_to_mgauss() - convert raw readings to milli gauss. Also apply
+ *			      compensation for output value.
  *
  * @data: device private data
  * @index: axis index for which we want the conversion
-- 
2.25.1

