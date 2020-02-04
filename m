Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB7DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3998B2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkjh2whs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBDLEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:04:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53941 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgBDLEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:04:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so2781941wmh.3;
        Tue, 04 Feb 2020 03:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+g0N6gzVeEl4yKKtr7DaOYgSBwbg66P5K7+2h8eZ3U=;
        b=Bkjh2whshwyX+9ww3JgctLgPWqxctG6mWNr4VpvSa+UMIt1QEyTfvhh8aP7wtqPtKV
         5uS6EOjQyBK1eTQGojdTyErWUyw/MHnDXUsfIqVsaSZD0HzhCM9wsG2x3UDjd6qy2bIu
         FP/GOfSTz7xsgR2U4pxl/1Xw7GwGiFTB2yx4C70JRRSIxQHdX5fZLbsubm9V9QuPsYOy
         bhTjnjwbiwjjF2yv+cyhUBxVnqfHHFEKaOUxlYo1o2PRvgpHTnvTpHt9uYebRDT+ByiV
         2qS5LwsgTMqJuFTH54piSRQCsKnlGjGkg/I2ifB95+TR7OUC5tYRSCjQnVgRqv8xLZK7
         GsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4+g0N6gzVeEl4yKKtr7DaOYgSBwbg66P5K7+2h8eZ3U=;
        b=aWbJEySzRVkJiAB7b9tvS3XmEXDJj8DSKK0vTZr1I8YhTdT5mXzQ3nebvij3HOXnZq
         r7uAto+hpar/LS0bzyGwaA0uR/czS8f0cVe/7kLq9Z9eu8KoVXrpx2YLRgGPrRIzuWWo
         stdUhxXdf1O0LXPSRstiDFZQmA3qGDjCYxgg2qLHQkDfUlNrQxWLqsdcA529ONH4e6Td
         26w8M+49A7v5XozpgBthbu9eOyTDdq3cFA/Gl1SftirWWfTWzV4QXBLJ6htJbXpFCPlW
         waotOfeAR3fmFXL0cWF1QASTwwjjnEmT1nRum9E/+xT/0YKu223kvl5rSwwLhGnwTNQt
         IjcA==
X-Gm-Message-State: APjAAAU7p70u4kge6F2RFaCnA55HhF8HM9peDXnkN+LJKpTK1WrTVLYr
        5ezCAQQ0sjWvPtux7bWw8Qo=
X-Google-Smtp-Source: APXvYqxFFZrD7uKkUyynjgFT4D2bRFWf3GWSrZ2zBWqqKJNYxWrpOO9sBtGCln+zh3lNXbRdk3R1ag==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr5530974wmi.10.1580814272806;
        Tue, 04 Feb 2020 03:04:32 -0800 (PST)
Received: from localhost.localdomain (p5B3F65E4.dip0.t-ipconnect.de. [91.63.101.228])
        by smtp.gmail.com with ESMTPSA id y185sm3476935wmg.2.2020.02.04.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 03:04:32 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for mp5416 PMIC driver
Date:   Tue,  4 Feb 2020 12:04:19 +0100
Message-Id: <20200204110419.25933-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204110419.25933-1-sravanhome@gmail.com>
References: <20200204110419.25933-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mp5416 PMIC driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6d838c52cc5..57f029f89811 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11280,7 +11280,8 @@ F:	drivers/tty/mxser.*
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/regulator/mpq7920.yaml
+F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
+F:	drivers/regulator/mp5416.c
 F:	drivers/regulator/mpq7920.c
 F:	drivers/regulator/mpq7920.h
 
-- 
2.17.1

