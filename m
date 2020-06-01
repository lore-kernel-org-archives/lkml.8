Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCDEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D1C206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMh2YQ00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgFARvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgFARvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:51:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8747CC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:51:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z64so3832433pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbOKQVccoNk2iiaBCxRQwqrB6pY9V3Ek5XyuyrPL344=;
        b=XMh2YQ00G3/iFxRJLp5X+Ffu1aDH9sHaBAby+8PDY928HiuKVov7KQ/xyV987CcyRn
         3R4aqvM9gLbpYp4UbAzd3d5iFf6wumH1UmIPXZ2p4vbGJZZ+QxntY4uYK0dKEUTUleJs
         dOrScvgMF+nbeES+cIfHO/ygGL4HzwCZyxNXui/59j7FOGinXLVFjU3BCmjA7bu7x3Pk
         VnaiHoI+QznyvPmUjFzS9gsGhjwGM9C7UhD/yfhMw5fKoAcUd+ykW/WFDi+PKgCafX2y
         QYa8ivZLmAXdOnHbmdWvicXI0ZyHbptrKor6POUKGswFRWrDNCaPDkKdQgLAHbZROHJu
         9fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbOKQVccoNk2iiaBCxRQwqrB6pY9V3Ek5XyuyrPL344=;
        b=EUHCB4SpQPW8AV4RPrRjwN5jIvAZmQMtl5Ax7awrFICv2BpgN2iAk14r2F97qy3Z07
         UUmWkMr+2LKdows6PXKJfzNguwdYPlPZv6SBzaKZ56QQEjooiA36XYGCZudq57EbN7Zh
         EIRz+3DStGEtI41LkGDlsj/k/DdGc9q+BUZksgv2G4vFwTcAquzddyq/y/ZqjUL26WpE
         eE8c4cUkOiBX7vWs/3X/E5zNqmCS6krqJk6NDT9508LUc4tRmILdXv0vJh1NojGZk3Lu
         3fw2Cbe6Sx7uGotgGoQyqTbYd44AAzvZEskMj5HpGeLr2EuRLII/mU3uiVOZR7/sNewk
         TuGQ==
X-Gm-Message-State: AOAM530StEwmDlrnwe3m45eFWq1ByEXanRdr0hGW2wZy+Gs7g2ygGBBs
        Wv7QZ8ijgVIaJQRtJTUTXzpybA==
X-Google-Smtp-Source: ABdhPJyThCX4Ai+3IbVSLO17nsi28llbYdW3I8iACfWmVTPeTmDXfBXGql/ZgbvdMUU1Q/L9K+JNbw==
X-Received: by 2002:a62:3381:: with SMTP id z123mr22115539pfz.274.1591033903039;
        Mon, 01 Jun 2020 10:51:43 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k12sm58219pfg.177.2020.06.01.10.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:51:42 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com
Subject: [PATCH v4 2/9] remoteproc: Add new attach() remoteproc operation
Date:   Mon,  1 Jun 2020 11:51:32 -0600
Message-Id: <20200601175139.22097-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175139.22097-1-mathieu.poirier@linaro.org>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an new attach() operation in order to properly deal with
scenarios where the remoteproc core needs to attach to a
remote processor that has been booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_internal.h | 8 ++++++++
 include/linux/remoteproc.h               | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 4ba7cb59d3e8..fc710866f8ce 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -79,6 +79,14 @@ static inline int rproc_unprepare_device(struct rproc *rproc)
 	return 0;
 }
 
+static inline int rproc_attach_device(struct rproc *rproc)
+{
+	if (rproc->ops->attach)
+		return rproc->ops->attach(rproc);
+
+	return 0;
+}
+
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 21182ad2d059..bf6a310ba870 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -359,6 +359,7 @@ enum rsc_handling_status {
  * @unprepare:	unprepare device after stop
  * @start:	power on the device and boot it
  * @stop:	power off the device
+ * @attach:	attach to a device that his already powered up
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
  * @da_to_va:	optional platform hook to perform address translations
  * @parse_fw:	parse firmware to extract information (e.g. resource table)
@@ -379,6 +380,7 @@ struct rproc_ops {
 	int (*unprepare)(struct rproc *rproc);
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
+	int (*attach)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
-- 
2.20.1

