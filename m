Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B56C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4F520776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448670;
	bh=qqcRd+xS0PYccEaXyI7kdgQx+HoKQW5xSsFSjkSRG7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=je9ZQHOVgrkOj5VB8An31un4XkPf30sNnkgpaBsa4Azw6s00bs6AkdFRqTtN3Wu1q
	 PlM+4fmxy/cQChOcU1P/+KeENLDnVNarvHTWPLDEKIekPgpUfu4yCd8hL7hD2lhNh2
	 WcbbBrC6bQ+WFPVw1gzIEoqDs4s+Ul8v22EmgAuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgFRCvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbgFRBJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:09:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E2C21BE5;
        Thu, 18 Jun 2020 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442546;
        bh=qqcRd+xS0PYccEaXyI7kdgQx+HoKQW5xSsFSjkSRG7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7A2Qo3nnI5wbFSBN/LIWZapkB8bhpfV7ff4cCnn3dkPJJ6MaOpImhmvlBL8t6Iji
         /19c8JFQiaEEF+fGMI9A0eBAsan4JfJMNpODseAqfnwfwNIV9mQa1/sIGkIDflFsA+
         ortFp5IYgDsjeLcJR+pzFZYlQpj+I/wPxM4Mooqw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 045/388] misc: fastrpc: Fix an incomplete memory release in fastrpc_rpmsg_probe()
Date:   Wed, 17 Jun 2020 21:02:22 -0400
Message-Id: <20200618010805.600873-45-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 0978de9fc7335c73934ab8fac189fb4cb3f23191 ]

fastrpc_channel_ctx is not freed if misc_register() fails, this would
lead to a memory leak. Fix this leak by adding kfree in misc_register()
error path.

Fixes: 278d56f970ae ("misc: fastrpc: Reference count channel context")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200511162722.2552-1-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e3e085e33d46..9065d3e71ff7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1613,8 +1613,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 					    domains[domain_id]);
 	data->miscdev.fops = &fastrpc_fops;
 	err = misc_register(&data->miscdev);
-	if (err)
+	if (err) {
+		kfree(data);
 		return err;
+	}
 
 	kref_init(&data->refcount);
 
-- 
2.25.1

