Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5504217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609747;
	bh=NvDExIkd7VvoZfA/WuWAvZMYHLhL6Olifa7HBtJrSNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zubWt0EMAaQXKIPcXfA7xdBpu4ZwNoJ96TALqOHcaUgBkzafkRXwAdXAlK43fEkmQ
	 bAH3edaDPeGdEWWnSE28nZrkYgX3jpwRTOccPdU88jJtgVRKXkkxIIvH9Er3KRWY/1
	 GK9HWv5zmU0JAR4uICClovbkR3OSNrKiMRxsKoe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgBMQCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:02:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBMPYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:31 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225F024689;
        Thu, 13 Feb 2020 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607471;
        bh=NvDExIkd7VvoZfA/WuWAvZMYHLhL6Olifa7HBtJrSNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y59ohT2e+ogbgbh6XLXsG21vp2d9tcnetCTIQJIupEBJ946jceikIKgtJqAF0a5/S
         v9EUGTH2/kTGM6kyEuOVNGW/F3WrTyqDqfWZo0wyeiKaigp8+I2JYWOseZzEg38bsJ
         TV5w1PktwFgrUagyv+QZc9U4DLeiSAtlRnOEH5Es=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        YueHaibing <yuehaibing@huawei.com>, Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 001/173] kernel/module: Fix memleak in module_add_modinfo_attrs()
Date:   Thu, 13 Feb 2020 07:18:24 -0800
Message-Id: <20200213151932.230666732@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit f6d061d617124abbd55396a3bc37b9bf7d33233c ]

In module_add_modinfo_attrs() if sysfs_create_file() fails
on the first iteration of the loop (so i = 0), we forget to
free the modinfo_attrs.

Fixes: bc6f2a757d52 ("kernel/module: Fix mem leak in module_add_modinfo_attrs")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index feb1e0fbc3e85..2806c9b6577c1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1730,6 +1730,8 @@ static int module_add_modinfo_attrs(struct module *mod)
 error_out:
 	if (i > 0)
 		module_remove_modinfo_attrs(mod, --i);
+	else
+		kfree(mod->modinfo_attrs);
 	return error;
 }
 
-- 
2.20.1



