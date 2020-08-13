Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D896C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBC920658
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uq8roSSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHMPEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:04:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2A4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:04:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so2947694pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j/uG16YSFbVigxh2ulTPjwxYz0Q43CcPT6lWTPkr7TM=;
        b=Uq8roSSrTPLJrRX+IS4VNXSh+8BESaz8fsYpbcchEUJxks+Vpi1WB/ct87UuNCJFuS
         GCF/ItZExgF24pDds+wY0DPZeRWttqVzIINqmJY6CKkvMcv3mjNWshYYSGHRJY7eJ97n
         DndePPUxxzKC+JOSF29MsM5bV+7uuc7nxUG2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j/uG16YSFbVigxh2ulTPjwxYz0Q43CcPT6lWTPkr7TM=;
        b=d7SIL5hBpObevZ6uvSbql+EonT4VTdhGaoLPKvmEKr1+LWsINeEzfrKfK0gMhawREB
         oLxbVUI9T68nxqbQtatU3tJE2jstzsLoTAAThXeai0l2rjH7RaBpLw8IV3btsPwQ5eZ9
         TQXFTPz0MUnl6oRpX1BPZ4LnAIGT8p0fdD3kNpxhigUQlSJsmrgtUnk4Wx9pnxdKpkJJ
         KZKHQ8F6J4wvzhMo0HsqvKf7h7osufijecSnril0GVKhIdFYi2RDQ7VBpiJfxY/5wkHS
         wLyTLxv3aMGIfoOn/KsrASoTzEHkfkWXcEo0qPq0RRFvEwYaOjYodk3M+2xdU+7Guu5D
         QO2w==
X-Gm-Message-State: AOAM5304ySEjXKh7QHrEXWTszupHNW8UQGMT59cNEQ/Q4kqiGk/iBRwV
        mTapywsy0if3i2aj8rIiE/uKhQ==
X-Google-Smtp-Source: ABdhPJyLOM2g6yjludzH2H3jgbK94iPEoOUGxhCXlOCcMyKMC031EtH8LkWfR6yuDRzDiylOc7zbxQ==
X-Received: by 2002:a63:ed07:: with SMTP id d7mr3933550pgi.414.1597331053190;
        Thu, 13 Aug 2020 08:04:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id b23sm6117014pfo.12.2020.08.13.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:04:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     saiprakash.ranjan@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: socinfo: add SC7180 entry to soc_id array
Date:   Thu, 13 Aug 2020 08:03:52 -0700
Message-Id: <20200813080345.1.I85bb28f9ea3fa3bf797ecaf0a5218ced4cfaa6e2@changeid>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for SC7180 SoC.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index e19102f46302..e56eea29615c 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -223,6 +223,7 @@ static const struct soc_id soc_id[] = {
 	{ 321, "SDM845" },
 	{ 341, "SDA845" },
 	{ 356, "SM8250" },
+	{ 425, "SC7180" },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.28.0.236.gb10cc79966-goog

