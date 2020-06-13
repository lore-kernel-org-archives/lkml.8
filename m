Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB0E2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="NpXWPGdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgFMXeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:34:11 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45088 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgFMXeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:34:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49kv7N02qJz9vC9j
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gPtBt1Z30pzo for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 18:34:07 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49kv7M5YzKz9vC90
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:34:07 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49kv7M5YzKz9vC90
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49kv7M5YzKz9vC90
Received: by mail-io1-f69.google.com with SMTP id l22so8706390iob.23
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rw3l/3EgPiLpxwjRCzeT9nx9Fa3fAzHH5ifQjv/65KE=;
        b=NpXWPGdo09LFr66WrjTqLnLuG625FPqn7wVIOp3CtrQ9Y5U3G3yvXqolzKUKDqeWF2
         TJM4HhWX4zUbCzpJyDFwqG+TL2XqQNvc7wUAV7xJjltfEK/vRm3frHNZkJAVbsMzZJ2l
         R88awLs4R3u9xFnx7CQ7LEkmACh7CkY+HGIjKsHTWqJJQ48AVQIHhoppZ8KkXi+2WSs4
         AlqMsvfsNp7DhA80DKiyfawcNOUxeIMfK9LIlUudk37cMVBbJoE7zbQSlhElAhQFJsJN
         lq2X+getWxoIVayFeJnSxbu+H3Tg5Psvcjh4S2SNNRxuAu9Cd8/uB4w0mmfF5rw04MEG
         PDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rw3l/3EgPiLpxwjRCzeT9nx9Fa3fAzHH5ifQjv/65KE=;
        b=sqwtlfKdNh2hsvKYKvp+4kW5hV5QJSrIl5ewzFWdfKq1Lt7RWABNtXqmUPQM3lG+7w
         IVDNPqS6oxExQv6aMMBFcT1iKeIj33avN9xDbiz2mnndIomPUl2pUdrAo8mtNDtuOdFC
         tjWJc82UGGEgLLAsw7UBt+8kFJx/kNAyScQKxtD/s5CL7g+8xCp+sG8PUXqgZsDQsB6F
         rVT3Ygh3nnL8ULy6Gl2FI6+4z5IIN0waOhfUbVV6Jvirp4vRAfK5IvazQTvIfXsK4oIB
         oZyD4A9HteIA9dJCvVqVYnkgZvKY8HkEMu4AoQMjPV9IzfNk464LzuLOhLnkBVYrBYJX
         vfOA==
X-Gm-Message-State: AOAM5308iIqbWXbN8igERLEqTSf59nt+nTfCmoPct1BZh5/fI6w8QaFQ
        Uf35tAKm8rVCS4usdbkXz1znPBcS+60VOjjCiSJNnsuzSirWYWJBNPK5V0adE8a14kHkGBGO4oZ
        k6jAJGZxG5YbzSomMmZftWzaYpeGd
X-Received: by 2002:a92:ce48:: with SMTP id a8mr20221722ilr.23.1592091247041;
        Sat, 13 Jun 2020 16:34:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoiENH5HRfU5W1tLLnW9Y1BwMTkjBXpctUOa+EE0t3xLCFwZMw8RuB/tj6g3lzbzX0Hs0ljA==
X-Received: by 2002:a92:ce48:: with SMTP id a8mr20221698ilr.23.1592091246738;
        Sat, 13 Jun 2020 16:34:06 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id v11sm5459221ile.61.2020.06.13.16.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 16:34:06 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hansverk@cisco.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: camss: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 18:34:00 -0500
Message-Id: <20200613233400.20600-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count if pm_runtime_put_sync is not
called in error handling paths. Thus replace the jump target
"error_pm_runtime_get" by "err_clocks".

Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index a8c542fa647d..1e7f23538af6 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1261,7 +1261,7 @@ static int vfe_get(struct vfe_device *vfe)
 
 		ret = pm_runtime_get_sync(vfe->camss->dev);
 		if (ret < 0)
-			goto error_pm_runtime_get;
+			goto error_clocks;
 
 		ret = vfe_set_clock_rates(vfe);
 		if (ret < 0)
@@ -1295,8 +1295,6 @@ static int vfe_get(struct vfe_device *vfe)
 
 error_clocks:
 	pm_runtime_put_sync(vfe->camss->dev);
-
-error_pm_runtime_get:
 	camss_pm_domain_off(vfe->camss, vfe->id);
 
 error_pm_domain:
-- 
2.17.1

