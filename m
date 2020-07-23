Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231B4C4345B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0069C2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJaDEqfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgGWMZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgGWMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E2C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so5023208wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOTsXsVyK9wcmeKRIO3GiUTJmLIvxWZfHkJHDdHCUzM=;
        b=RJaDEqfJS1fB0dS69jVVhKLiuoW/IXNro/szq1C73p+C7xny14Y60D1Eh50KTX2/OF
         I2GnpTiTJMsGomuvsmzlMSJgC8hokp26aKtPna/LTpvVFrD2h2zbzbizu5czgWUjlQt5
         0Yu2BL1gOQNsr6+AhW/wKNTZKNexnJUoouybRMgbFtUKNInQS1RZDDCXPlHlyNu2a3FV
         7gCWWU0dYqosFtOZAnZBlxVrqBmAqy7ZZ6uymz8MFo2kKqMfg+YZIPh5+MfZfMMYJxHY
         LAhK49eVMWDVugGh0rpeAojCA5T8BJMa3j+yawPQomQZ1xAtdD3Wa8QDFx0ujm+mD9Q2
         9wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOTsXsVyK9wcmeKRIO3GiUTJmLIvxWZfHkJHDdHCUzM=;
        b=DdlcZt25TE2A2BWkM3agz/3MGfIUrhvfQp6ccgTmjtVuTJh1D0THq/GySdhH1tLs+p
         GU3bJYd2qgRa0yYEZIiK2/qLAGspVw/hWZ5jlyfCfsj1JpuVClUW8o8mF7P8+R4JzNS8
         aor3MpCJYEVqOzJUUBA401Z9azuvhJrNCs8EG9EaO/v+KyRDCkujvj9zJ1pru3kBzOkM
         JMqs7umIoSfSjqPCbaiQz2ikPNcjzjmf6MPErvfwoj3qHDBLqOi6h2ykNzP8PAxVBGwe
         EiJMMetqynM5P/68jCMrQgXFt9AllMyamFXSjbJ1kLfl1TXgKN/9lUnS+MAp5++jTDoU
         1rLg==
X-Gm-Message-State: AOAM5336Br+uRxN1lXAo8Oct0aNmYyDCJBUezy7hBM8xBpylfKlATwVv
        PJXljBmhg4P7COFv4Him/Gh1Xw==
X-Google-Smtp-Source: ABdhPJwm1gFat1cUxTpp/ybspw0TU+G9ZDroDChK3K2K67K1pObv8zSnaL9bnABnPw+0YmQQxUANaA==
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr4133869wml.142.1595507133733;
        Thu, 23 Jul 2020 05:25:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@cavium.com
Subject: [PATCH 36/40] scsi: qedi: qedi_main: Demote seemingly unintentional kerneldoc header
Date:   Thu, 23 Jul 2020 13:24:42 +0100
Message-Id: <20200723122446.1329773-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the source file and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qedi/qedi_main.c:1969: warning: Function parameter or member 'qedi' not described in 'qedi_get_nvram_block'

Cc: QLogic-Storage-Upstream@cavium.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qedi/qedi_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 1a7791164de8c..6f038ae5efcaf 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1960,7 +1960,7 @@ void qedi_reset_host_mtu(struct qedi_ctx *qedi, u16 mtu)
 	qedi_ops->ll2->start(qedi->cdev, &params);
 }
 
-/**
+/*
  * qedi_get_nvram_block: - Scan through the iSCSI NVRAM block (while accounting
  * for gaps) for the matching absolute-pf-id of the QEDI device.
  */
-- 
2.25.1

