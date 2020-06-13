Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883A320792
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LZ16KaVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgFMXTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:19:53 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59228 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgFMXTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:19:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49ktpv3vTGz9vbsj
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:19:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LRtjbYdbHpDU for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 18:19:51 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49ktpv2FCNz9vbsc
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:19:51 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49ktpv2FCNz9vbsc
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49ktpv2FCNz9vbsc
Received: by mail-io1-f71.google.com with SMTP id c5so8716550iok.18
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0J2WzBmWJmFnCbwYpPhvfRXosCtqPD3qdOkqR/y7HfE=;
        b=LZ16KaVj+L/3PDGxv7dCNxew4d6GRS3dAPrHGIhz3WLmeRcvax7dsMWazwLOa71YcI
         xtSaRmDB8bABi3Qdc6wmIhg2jHxqlMkFR91nj9cd4Xig5PwgsFgXShqy+gcpYaK7R6v2
         iq0y5reDWT1PT7CXeV2Z09/GTpQOTg9OcAnzggn6BCu8WaIWB+HUBhRjouCMHFitHuQR
         M85GgP3ymW2EQPt0EJEaIAqQcFVriggBmvTUe9M+J/Qe3oR1kuDtJAMxEszxyRne/xrk
         M4pjDGufS1MEgCB0aLW0aZ47WSMF9nV7KkUTJF3j5YmuzK0FhyiLwElRZ8N9HtvT/dxD
         vH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0J2WzBmWJmFnCbwYpPhvfRXosCtqPD3qdOkqR/y7HfE=;
        b=K+OkcsiO5z2wcQY3JcERc75goOE6WfblYhPOaptcZQ1dWDCfR/jaD+u1cJkrx3FXIh
         XOhw4ObOhbmKsV29BsP3yJYfPVhWdHEpA8OV7ljogHE/keNRoR2qGwd43AJAaMv+CaNV
         K6nmhLDPqbD5eKECPo/YiLwZHFj8lvuwAhZheu163b83a9Q7BN5N9NQsPbiJ8Tj1jkbh
         z+eVf4ZbfcxedGPbmsICncPIWRRXXA6PmfSlyFnPUhfNNHoPcBjumjNko82zz9A+qi1R
         kgtYP1r9G043fMY76jyJ/qWGJ883NfG4jcD+Xfe9ghnFbn53CjuyeYvkxiQ7lVPVYDB7
         v/CA==
X-Gm-Message-State: AOAM531F1gAQlNPR58nLYovuJor0K0B4v+CtytIcdc/+rMOP8FratUGb
        OMXC8rfLbXos+dFMom0jkOyclmaOsRCYoHyXHpUJ6q2w8TNcQxDzUXDGRERVAASbidbDogU9FPX
        BpdEHRQhnegLqQUts6m4J7yAwVKdJ
X-Received: by 2002:a92:c04d:: with SMTP id o13mr19972745ilf.201.1592090390828;
        Sat, 13 Jun 2020 16:19:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0AiM64XcNUQP5F+CpQiJ5n6UALfY3rldZ+jTicz2fR35pa0C6ClNe+eDg1obTNeFpnA6oCA==
X-Received: by 2002:a92:c04d:: with SMTP id o13mr19972718ilf.201.1592090390494;
        Sat, 13 Jun 2020 16:19:50 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id c5sm4391570ioq.9.2020.06.13.16.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 16:19:49 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: fcp: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 18:19:44 -0500
Message-Id: <20200613231944.16730-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Fixes: 6eaafbdb668b ("[media] v4l: rcar-fcp: Keep the coding style consistent")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/rcar-fcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-fcp.c b/drivers/media/platform/rcar-fcp.c
index 5c6b00737fe7..05c712e00a2a 100644
--- a/drivers/media/platform/rcar-fcp.c
+++ b/drivers/media/platform/rcar-fcp.c
@@ -103,8 +103,10 @@ int rcar_fcp_enable(struct rcar_fcp_device *fcp)
 		return 0;
 
 	ret = pm_runtime_get_sync(fcp->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(fcp->dev);
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.17.1

