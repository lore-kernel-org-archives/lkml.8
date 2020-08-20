Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639ACC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E0722CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915772;
	bh=nXxn6AExSKETrl/wuR8oL+HzJPV9Lfh1UPh27qA0cJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2YHZ3ux+tr/HO9lznIPMbwhUKnEfk52pmoOZ2br8rlbD+LfLxDnkfDuyKDaTrRg9g
	 Pb1zkodlO8vQDtk5RGhVjPRYWV4k29AL4UwKIt1aD+qaHxQfbyLjP4z+8oWVLTmifA
	 +O2RFncpKvYj8SJz3ap8e7aIm87NFOt7oYOS0uiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHTJ3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgHTJ2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:28:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C49522B4B;
        Thu, 20 Aug 2020 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915712;
        bh=nXxn6AExSKETrl/wuR8oL+HzJPV9Lfh1UPh27qA0cJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiREwHBPCVhoVZ/x/gccQKDWXk7ShZQGC22GmvMmMvrWhX5QxQ8gQLUDEz2pm4AqZ
         hVv+iouQuDOlR54irFKNfE+bmH/ZzB3gO97taC3MOKKUoxDE7Q1If7agxZT2FKxGvA
         Kr/iVM/YvGEMb84Mzok8S5pGGRZXBv7UXKJhLuYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 5.8 109/232] remoteproc: qcom_q6v5_mss: Validate MBA firmware size before load
Date:   Thu, 20 Aug 2020 11:19:20 +0200
Message-Id: <20200820091618.100762796@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

commit e013f455d95add874f310dc47c608e8c70692ae5 upstream.

The following mem abort is observed when the mba firmware size exceeds
the allocated mba region. MBA firmware size is restricted to a maximum
size of 1M and remaining memory region is used by modem debug policy
firmware when available. Hence verify whether the MBA firmware size lies
within the allocated memory region and is not greater than 1M before
loading.

Err Logs:
Unable to handle kernel paging request at virtual address
Mem abort info:
...
Call trace:
  __memcpy+0x110/0x180
  rproc_start+0x40/0x218
  rproc_boot+0x5b4/0x608
  state_store+0x54/0xf8
  dev_attr_store+0x44/0x60
  sysfs_kf_write+0x58/0x80
  kernfs_fop_write+0x140/0x230
  vfs_write+0xc4/0x208
  ksys_write+0x74/0xf8
  __arm64_sys_write+0x24/0x30
...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: 051fb70fd4ea4 ("remoteproc: qcom: Driver for the self-authenticating Hexagon v5")
Cc: stable@vger.kernel.org
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Link: https://lore.kernel.org/r/20200722201047.12975-2-sibis@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/qcom_q6v5_mss.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -407,6 +407,12 @@ static int q6v5_load(struct rproc *rproc
 {
 	struct q6v5 *qproc = rproc->priv;
 
+	/* MBA is restricted to a maximum size of 1M */
+	if (fw->size > qproc->mba_size || fw->size > SZ_1M) {
+		dev_err(qproc->dev, "MBA firmware load failed\n");
+		return -EINVAL;
+	}
+
 	memcpy(qproc->mba_region, fw->data, fw->size);
 
 	return 0;


