Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A4C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C88420663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201082;
	bh=5uQUcB3H1CQ2lUa6ir8ilddCDoUxn3e+FBrMiBQ3mXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tk/cMQ0u2Sw8xaa2CuDEON5pDC1E0GcrmuF+uTn+H8k0yTbvwvXYNJohzrSE634vp
	 58LeysGq/cHQh4ICWPuZZ5IhAjZgbV4aYxTlR8v0vAqEp6Eo5yWlBx4ZclrW5QspV6
	 LM1w3jdRDBqWqJ7xaAv/GaQ3+bH1UFiOV9pRwGuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgAPS6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389029AbgAPRGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBFCB205F4;
        Thu, 16 Jan 2020 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194414;
        bh=5uQUcB3H1CQ2lUa6ir8ilddCDoUxn3e+FBrMiBQ3mXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HprmbQCPrip5RHnaG9BpEYiq1eGy70Lad4MCuViZBCuxob6AxM623lfEeAjlAgnCB
         UAYmCZhsbbWpKaeEVp9gC/QhF5Iu1uA//+ogZkkBYjypDK1fkTE2XjWxyTOkB+P2ND
         7CqMbc3doVmLYgaPmUJy+eMbSFno6TKZ+MhAgUE0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 336/671] mmc: core: fix possible use after free of host
Date:   Thu, 16 Jan 2020 11:59:34 -0500
Message-Id: <20200116170509.12787-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 8e1943af2986db42bee2b8dddf49a36cdb2e9219 ]

In the function mmc_alloc_host, the function put_device is called to
release allocated resources when mmc_gpio_alloc fails. Finally, the
function pointed by host->class_dev.class->dev_release (i.e.,
mmc_host_classdev_release) is used to release resources including the
host structure. However, after put_device, host is used and released
again. Resulting in a use-after-free bug.

Fixes: 1ed217194488 ("mmc: core: fix error path in mmc_host_alloc")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index f57f5de54206..dd1c14d8f686 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -385,8 +385,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
-		ida_simple_remove(&mmc_host_ida, host->index);
-		kfree(host);
 		return NULL;
 	}
 
-- 
2.20.1

