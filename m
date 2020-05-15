Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AB3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8C720756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/0wl3uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgEOU4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgEOU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:56:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7BC05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:56:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k19so1392080pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8VDhGuf90flrni22PAMq0PKDvRvzu01cgQHrQkAFj4=;
        b=y/0wl3uo18c7tS7j57d3Zz+JlewUQBMvtMwNWF0DZ7HLH1KZYmL0up0STGVDbMDtyK
         7HseB+rrPRH1K+IJ4zFxWycOTsh6YlrcOZc4K7vbjrBwwRr1aEeELQxu/JB0ShYEm65Y
         Tc4gNrusae8YlRRDo8NchO+oZrGWxqr+GTdQEEgVoynZ0hHV+PyzI2mpXLHZHLPNvp3Z
         TvltwGzEPHW8vNrozpq/YZBeffCUdr8pQETq0y7jlPy9m3zM3kZicnLcyCZmCCjgyCPK
         JQA/0p9UKXrucdcZECmSi5EoXCMfOEZFfqgZLoSNRYFBtbfOVef+xs8lVNQ7jXg9a3Sj
         pxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8VDhGuf90flrni22PAMq0PKDvRvzu01cgQHrQkAFj4=;
        b=FIiM4dIm+ArJwsQcLbUJWiVKn0FOj7lqZKpDbN3B+DzzAuDxhOfXZmyJLndJKCPpLL
         x3gng59LSdOrLBQJQiAIdQie3+ZPr6iVrV2+ev5d+MoCKxhMy05nr++BN0YqSTmhSajf
         ti22xRh5zYeBRwIcdRRCdiR3to0+x+dejSmofIb+p8wnLtPByFrY4I32tEwuCLJb2W3t
         JgxdjQp0+3/QobDd8IC9Cc/SRBTxogB49kcT9MqD9qs1+H4Pd5MRwekwOC037fAcZBQZ
         ao+e1Ghzvrtca4amLJA1RFv8DtdxrvwQ1XiR1AXCPmIVjWgJpaRscmL63ubn8d0VPvJE
         f5jw==
X-Gm-Message-State: AOAM533XcXaqFxOwkquO2YWJ66Q5zGpZVRYBAvcaDSTGASwZcelPpTv7
        QyNxUloJp6VaPdM5RKJQTdzMMQ==
X-Google-Smtp-Source: ABdhPJx24OkkbS2jhgwfSIrmOtBRqe/ry5dIWhu5gs9ECDMAJuQMhtatx9NQP1yAHm23aPdjWmBFUw==
X-Received: by 2002:a17:90a:4d4a:: with SMTP id l10mr5560683pjh.0.1589576208902;
        Fri, 15 May 2020 13:56:48 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z13sm2208903pjz.42.2020.05.15.13.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:56:47 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] sample: rpmsg: Print out RPMSG device name extension
Date:   Fri, 15 May 2020 14:56:42 -0600
Message-Id: <20200515205642.13529-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515205642.13529-1-mathieu.poirier@linaro.org>
References: <20200515205642.13529-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new rpmsg_device_get_name_extension() API to print the
RPMSG name extension if used by a RPMSG device name.

Suggested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 samples/rpmsg/rpmsg_client_sample.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index ae5081662283..2c5dc65ed844 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -51,8 +51,13 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 static int rpmsg_sample_probe(struct rpmsg_device *rpdev)
 {
 	int ret;
+	const char *extension;
 	struct instance_data *idata;
 
+	extension = rpmsg_device_get_name_extension(rpdev, 1);
+	if (!IS_ERR_OR_NULL(extension))
+		dev_info(&rpdev->dev, "extension: %s\n", extension);
+
 	dev_info(&rpdev->dev, "new channel: 0x%x -> 0x%x!\n",
 					rpdev->src, rpdev->dst);
 
-- 
2.20.1

