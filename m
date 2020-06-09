Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078A0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A0220734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725822;
	bh=mlChgyTv5SQLeyzNVZm89cxyxj49nT+0TF3uaH4MMaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=igv63E178ZwXVv10suW+5tN/D2g3BOvFzc+efMeZsk+kjZptfn4K+5uCWiodS9fQ7
	 ADNHWis72I2dwYJhidxmFfD28dZA/PKkYsYYy5Y1evh+65/go2OqMrMXU/z51O1F6h
	 WlzQz65+oOK+3yRl0K0WQtNI9/7j59kRPleeKyv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgFISDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732922AbgFIRwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:52:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72603207F9;
        Tue,  9 Jun 2020 17:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725160;
        bh=mlChgyTv5SQLeyzNVZm89cxyxj49nT+0TF3uaH4MMaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GavMI/mRc+WajWXLqaPhQxH5t7oLAx/qRwoQ5nOfH3LKYBOZJBhf0AZNkaRQchwZ6
         AKlgmvnQyqlKmBAqMUYv+37YQ9jNqV3LyppgtFKBtDVIUBE1iGHO82GYQLPRv8Knbp
         hcwPWiRBIiEz0dakRjdL1ut921HqfEzUBJ2ZBs8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 5.4 26/34] nvmem: qfprom: remove incorrect write support
Date:   Tue,  9 Jun 2020 19:45:22 +0200
Message-Id: <20200609174056.359919958@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174052.628006868@linuxfoundation.org>
References: <20200609174052.628006868@linuxfoundation.org>
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


