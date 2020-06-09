Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F2B206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725653;
	bh=mlChgyTv5SQLeyzNVZm89cxyxj49nT+0TF3uaH4MMaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgOFU8LmLigOqOwyUOzcxJZNWnwoAR8JOnHK1JD8nosjdkc+Goi2iEduL2PMXGbIF
	 HYc/kIYb8tcb7QqB1wAEGdvMcaRTlE+naMxiI3MGkeWU9+lwGsi0Rj+B/6bB0tqOqp
	 /MINxQhZ2HxZD7v1rN9SEYOcsVhNC8OzP4FbA6aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbgFISAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733074AbgFIRyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:54:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AD66207C3;
        Tue,  9 Jun 2020 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725259;
        bh=mlChgyTv5SQLeyzNVZm89cxyxj49nT+0TF3uaH4MMaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNZL6LZ0wzYL1ltexgz6kaOe4ef0DqMstMUXx2e7REfsRLPL8FBsY1S/VWr6FLAis
         IyakcJ3Ie6vrkTOdKq5J6a+tDTqXAWyoBJkDLB28HIOVfLjppzggOjRJrsBmT4YbBs
         PuLPk5V3fYW0XqpS6c1+rniIoZsatgob628TJXeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 5.6 34/41] nvmem: qfprom: remove incorrect write support
Date:   Tue,  9 Jun 2020 19:45:36 +0200
Message-Id: <20200609174115.324191619@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174112.129412236@linuxfoundation.org>
References: <20200609174112.129412236@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit 8d9eb0d6d59a5d7028c80a30831143d3e75515a7 upstream.

qfprom has different address spaces for read and write. Reads are
always done from corrected address space, where as writes are done
on raw address space.
Writing to corrected address space is invalid and ignored, so it
does not make sense to have this support in the driver which only
supports corrected address space regions at the moment.

Fixes: 4ab11996b489 ("nvmem: qfprom: Add Qualcomm QFPROM support.")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200522113341.7728-1-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvmem/qfprom.c |   14 --------------
 1 file changed, 14 deletions(-)

--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -27,25 +27,11 @@ static int qfprom_reg_read(void *context
 	return 0;
 }
 
-static int qfprom_reg_write(void *context,
-			 unsigned int reg, void *_val, size_t bytes)
-{
-	struct qfprom_priv *priv = context;
-	u8 *val = _val;
-	int i = 0, words = bytes;
-
-	while (words--)
-		writeb(*val++, priv->base + reg + i++);
-
-	return 0;
-}
-
 static struct nvmem_config econfig = {
 	.name = "qfprom",
 	.stride = 1,
 	.word_size = 1,
 	.reg_read = qfprom_reg_read,
-	.reg_write = qfprom_reg_write,
 };
 
 static int qfprom_probe(struct platform_device *pdev)


