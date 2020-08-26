Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84713C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9D2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qm/4WZiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgHZQqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgHZQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12859C06179A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s2so527969pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lYOgLwnu7WcXXfGvAZrIa+HvcswO98ITukkP4wr02mQ=;
        b=Qm/4WZizP1KnyzgrqrSHdleNAP9snMSeWa1K5KztBk5eaOiDE1sfr5M06EEs7mq51Q
         ojW3MSEtGwhKk0v0h5flQ3LUG8aI68i2z2HYgyTb8rNm6N3QTm2iqZbnPrVaUuPMeCum
         cqpoYqEHg3wO/Xc0VJMXnoCEbD8G82Eqnv9KsmcoaNAU00Xuz23+s7qmIJK5az0cXhio
         jy77TmnzR4OTRHk25OIsp6rz5RrlvgQe+x+JeEwjQyqrKROf2EqT0XIjUOeVEyHKvLsz
         AwILZNfUx/NmEXjBUnfUMdCAMWAPUFgM9Kmp9ehd+2DpSLHzR77lVA57Ujw3FmYtrIQa
         bqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYOgLwnu7WcXXfGvAZrIa+HvcswO98ITukkP4wr02mQ=;
        b=jmxUqxymLnYBnX4gqL66+UXf8lgq34TDsgX7ddulYx+q7iErcGVZc89chNwukbUT5N
         FEuZng9rOU2h+JkHvwQdZjitVzYufXmuIXRtlLeFl0YAlb/R5UkzKjLZOHPOwQV0+9YN
         JHXfT39rMGNuez+l5J/I7AhMhHpVilYghWEr1TGsgZ2J6PDfJQnYhbMBEB2USCFiULq8
         3p/YGaDjl0z56i0sm5O+0gt3vxZNEIj/QL6FYdlVk6D5LDDzgXvjqp5gwYPoJo6A4DAu
         i8J5D9NTgx00hmoGgCai10u9lrDCP/e6i/kAua+QA9ALMgMchM1b66Qv53d4H4zOoDNN
         6ORw==
X-Gm-Message-State: AOAM530aQU/oSkp2DOluK5pvhwRXTcwKeFwY15JkaC76uJjop8yFCiSl
        5eSyNEpfZkGd+CT01yOB7M1U+A==
X-Google-Smtp-Source: ABdhPJweiYXaAr9UZI8x6z3Q44YMLqlq8O7xiCK7/w7vL2hDv8FZ/av6l24rnOYusePiQaYrD9OW2w==
X-Received: by 2002:a17:90a:39c8:: with SMTP id k8mr7142436pjf.19.1598460336599;
        Wed, 26 Aug 2020 09:45:36 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:36 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] remoteproc: Add new detach() remoteproc operation
Date:   Wed, 26 Aug 2020 10:45:21 -0600
Message-Id: <20200826164529.224476-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an new detach() operation in order to support scenarios where
the remoteproc core is going away but the remote processor is
kept operating.  This could be the case when the system is
rebooted or when the platform driver is removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/remoteproc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index fe383392a821..1a57e165da2c 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -361,6 +361,7 @@ enum rsc_handling_status {
  * @start:	power on the device and boot it
  * @stop:	power off the device
  * @attach:	attach to a device that his already powered up
+ * @detach:	tell the remote processor that the core is going away
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
  * @da_to_va:	optional platform hook to perform address translations
  * @parse_fw:	parse firmware to extract information (e.g. resource table)
@@ -382,6 +383,7 @@ struct rproc_ops {
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	int (*attach)(struct rproc *rproc);
+	int (*detach)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
-- 
2.25.1

