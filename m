Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F80C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBC82077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjEZli5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404237AbgDCRuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:50:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38493 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404148AbgDCRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:50:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so8922547qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+oLntqojuWdUH12fyW0ncnBZUNvUMEl0ST479v3SavI=;
        b=WjEZli5Y2ZbsGjbFRuKXBBPa3y4gFEAzTwatQ2IXdzW+4mBALDH3CECyepTjQmyzck
         8JlCht3lbpb7d41uQlzpVDj81/Ln3rHLB81SJNxZ3M+Up+aLyA9UEfvA+QQqdRIB1kJO
         0pl4vBdS21KLE8SK3DxXqs1t+iVJOgl++mQl2Z6vJVzfrUi7nX0n3487sv+cjzQVdPm5
         /tcwo0NG+w25yzkjM0Aedf4IrMwAI77dwAGekhIu5mV/rVgJMrwXcDjKaLxmhBOgBsNr
         9EjjTy/+OX4H1N2HGBgAjzg9cGembmRbKgloXYpfw3gsdJbnRH01JDgrXofUh7DGudNB
         T72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+oLntqojuWdUH12fyW0ncnBZUNvUMEl0ST479v3SavI=;
        b=Op/s71ykQD5yIADN0Pk1U8FvjHMjxeKET74ZUwI8y4WZHEI7IWiPaGBNb8MfeiMsBU
         sIfitC7kbf9CWNEoFSsHAEkxSzSCBhIWMmQrZE3PmfNemfpj9J+aeoLBMrMnMGjEsR9g
         SDvpB/TJuJ52MUTtHqyX8EJeLpvrKufWNRxX65E1+xmTJsO9U4r2wyHmnahE4rnG+pEK
         3D/SQ9YfPYzNeePzWsc8zmXNFrRwtSkEclxdruyHHtVNomalCUmYW2JwxZ7A2BnW1Yf5
         EdJy7IqliNEv0dqRmNMO3NApQTXEUye6Zla8QTNa5RWsIfDhW5hsGY9cYifv8dbBU2hH
         0+SA==
X-Gm-Message-State: AGi0PubG31RGzFIAJaALCTzbowAOfIx6Q4ST6f50xKUUimgiKmJxx0lT
        7/mL3bdvJM6ekS+woavQivF334XNvi9AtA==
X-Google-Smtp-Source: APiQypIJYUesBNolCLhwv6B5eaa/K0FLECq529AU39kc1RoB8T/W83qqfbTOjo1T94kludYx50eMcQ==
X-Received: by 2002:a37:e115:: with SMTP id c21mr9366907qkm.249.1585936212649;
        Fri, 03 Apr 2020 10:50:12 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 77sm6821225qkh.26.2020.04.03.10.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 10:50:12 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] remoteproc: fix a bug in rproc_alloc()
Date:   Fri,  3 Apr 2020 12:50:03 -0500
Message-Id: <20200403175005.17130-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403175005.17130-1-elder@linaro.org>
References: <20200403175005.17130-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ida_simple_get() returns an error when called in rproc_alloc(),
put_device() is called to clean things up.  By this time the rproc
device type has been assigned, with rproc_type_release() as the
release function.

The first thing rproc_type_release() does is call:
    idr_destroy(&rproc->notifyids);

But at the time the ida_simple_get() call is made, the notifyids
field in the remoteproc structure has not been initialized.

I'm not actually sure this case causes an observable problem, but
it's incorrect.  Fix this by initializing the notifyids field before
calling ida_simple_get() in rproc_alloc().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e12a54e67588..59b6eb22f01c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2054,6 +2054,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	rproc->dev.class = &rproc_class;
 	rproc->dev.driver_data = rproc;
 
+	idr_init(&rproc->notifyids);
+
 	/* Assign a unique device index and name */
 	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
 	if (rproc->index < 0) {
@@ -2078,8 +2080,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 
 	mutex_init(&rproc->lock);
 
-	idr_init(&rproc->notifyids);
-
 	INIT_LIST_HEAD(&rproc->carveouts);
 	INIT_LIST_HEAD(&rproc->mappings);
 	INIT_LIST_HEAD(&rproc->traces);
-- 
2.20.1

