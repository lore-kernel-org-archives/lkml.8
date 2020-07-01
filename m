Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9347C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CB820747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0Hki9IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgGAKgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgGAKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:36:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1971BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 03:36:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so10134706edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqHfZQ5VWArlU+T9mp3tXwt7J+xQkac4XMwffN8dFDs=;
        b=X0Hki9IXpM0FBnkfoaRIH0151N8k+5RqetQY7M8FYLOwolr3+ZhGOG7fSkTcdUC9m4
         BtDk4QKZieZfuGnheai7HT+iFOfeqKNTwot8PcsLrgEvpoGm7qXHq3inQJ9M4kCL+Hx+
         0AoA8G1sKASglwG1JL70kco3tUJnmIGE+UPVqpz5vaZcQcWTfqC0BikuwyM4ho0AXq9M
         NiPBFisAQzk4DKvIe71VlghSlvZFNY/spmVdcT4HEr5MhJB6V/GwCs5UUlrpMa5A7SkD
         G3+iWCtmufz/st/SHYtMWXBFQTT/FD7lgvPPkYLSut92357MgnPf0K3z3WqwDCYBrGo7
         JLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqHfZQ5VWArlU+T9mp3tXwt7J+xQkac4XMwffN8dFDs=;
        b=WOId4sohpRY4lDiH3JlTgSowlrrS65Ea7+yeOzuS/UDcCY17x4CdA4o9HXSt8j83Sr
         CmsJh7ZnJ77LqDv7zF4mlwWSFVXjf6f9E2cUU0Ot1MyGg0J2U3eeKy/9hcDD09X5g1WK
         MuLNAiCtEZo5GJ2/sWUQPPCwx0zmgqvZHzOPHVPbl69aateqqJS/HqS3oldnmqIZMjG7
         YQ+ScLvo+BFyMZptdb23ZGRsZ4ZceDMyeN3xZIT7ezio69OumfXi7hGScbvN+U7LSa3q
         rfRl6/Ovohp78bD0eXh/DnUDg0gFhzC5f6hsQV3VGNfcx/eg76mzmS3TEDpEOtQ2bo0r
         3lzQ==
X-Gm-Message-State: AOAM53141jJwn1D/IEDw4+1gu6H4EKKFpvjH17jVB3TeEjn481S4Hoix
        Smw3LkIbXgqxW1rJnLmDa6eIOw==
X-Google-Smtp-Source: ABdhPJzRjLPBCOCoyLIkq3rInZtGR4t77y8Tn/Z64rpl56TGAhPWtsmPc+u4vV1L6dE13quGB6wUiQ==
X-Received: by 2002:aa7:db57:: with SMTP id n23mr27787087edt.235.1593599809761;
        Wed, 01 Jul 2020 03:36:49 -0700 (PDT)
Received: from localhost.localdomain ([37.120.9.18])
        by smtp.gmail.com with ESMTPSA id sa10sm4357351ejb.79.2020.07.01.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:36:49 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        linux-kernel@vger.kernel.org, Todor Tomov <todor.too@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1] MAINTAINERS: camss: Add Robert Foss as co-maintainer
Date:   Wed,  1 Jul 2020 12:36:37 +0200
Message-Id: <20200701103637.343425-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to contribute some of my time to co-maintain the CAMSS
driver. I'm currently working to extend CAMSS to new hardware platforms.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---

I'd like to volunteer as co-maintainer or maintainer. Currently I don't
know how active Todor is, but if he is inactive or indeed would like to
hand over the full maintainership, that would also be ok with me.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..39edadd36d24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14140,6 +14140,7 @@ W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
 F:	drivers/net/wireless/ath/ath9k/
 
 QUALCOMM CAMERA SUBSYSTEM DRIVER
+M:	Robert Foss <robert.foss@linaro.org>
 M:	Todor Tomov <todor.too@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-- 
2.25.1

