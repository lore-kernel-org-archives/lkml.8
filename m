Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2959C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C6F20760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozHbKmHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgFJHpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgFJHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:45:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586E6C08C5C5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:45:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so641347plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBmy6hb5a23KMKQCkK27hu5NhYaoTF5cRzQ7jlandjM=;
        b=ozHbKmHvb28+iRGd9myPIYtpesyrfnme4ad6GKCdJ1tYawHaW7VZxstkzgovVgeT5W
         ICdxDBw/wLmuBAnI/nc7Ue9csPpFKwUczWrf8WKtIJ488USHOc+Nd1F3Znw2AAedAhN7
         0GGM6m0rBqL09iYDtuKC4LEaqhpBJ+IwkATu/ORI8r97eW4PAt3gQe0GDXJFzP/x0EnV
         pktPdj7OGduVeFfJ+0Rzyv13UZOxaieWfWFX40ptaFfPUJ14cEWdnQhg7Um7PPp0ft5u
         TY29UJo8hFOtxn2OAauM88TGGiwhvhdT+CoqUFb+OAIZDo7r7Oph9bFRTkxwb3HWJlaE
         g64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mBmy6hb5a23KMKQCkK27hu5NhYaoTF5cRzQ7jlandjM=;
        b=mXFa/4TcaIMHwvKtzEj39bdNQSy8dyuMrevrDPynS4MdAwhehb01pYWPb4sjkJO2qq
         VHIxlEKdeME6EaIeIcOAGVDMH1ifP5IyTf2EgJEnPo5srWXT4GHkuWHNjqn8YA6sj9gT
         HtD+tHN8EQsqOmDyMvpt6IxgJsaUPpyVBeBcCCceQBj+2+tHna7PxfTkfNxdniggixJs
         KE/9pkVoHTLAC7YRwRb4Hq9Jil7nx3hipKqfCHpKumZgMFGtvsznlsnLUKo2XEZ/KJXw
         QALuUG6nPRkdmKbACj0p3OchF3zgP76zrzhn7YqrmWWSeP0/qHyleNQ9UE/WEDg79rbA
         zBeg==
X-Gm-Message-State: AOAM532BaGeDPEjpJD1YyWRO7B0FlzlpXuTJorpirC0ImDoubCz8KquG
        6FZmcCeHbMN00784nYVQrJ4G
X-Google-Smtp-Source: ABdhPJxfHv272Giz/2wpf5HT8QRu8W5Th971wBoM41pooYlIGx9go8TtZAAFxf2vkL9iJ4D4O3z3zw==
X-Received: by 2002:a17:90a:3489:: with SMTP id p9mr1852483pjb.56.1591775122820;
        Wed, 10 Jun 2020 00:45:22 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:630f:1dba:c41:a14e:6586:388a])
        by smtp.gmail.com with ESMTPSA id a20sm11516795pff.147.2020.06.10.00.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:45:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@martin.sperl.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/6] MAINTAINERS: Add entry for Microchip MCP25XXFD CAN network driver
Date:   Wed, 10 Jun 2020 13:14:42 +0530
Message-Id: <20200610074442.10808-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Microchip MCP25XXFD CAN network driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..591b6fc2d83a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10360,6 +10360,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-mcp2221.c
 
+MCP25XXFD CAN NETWORK DRIVER
+M:	Martin Sperl <kernel@martin.sperl.org>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
+F:	drivers/net/can/mcp25xxfd/
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

