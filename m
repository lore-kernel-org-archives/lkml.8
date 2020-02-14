Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C78C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403BB206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702296;
	bh=dkb+6SBa4D8pK5Pl0N9HGRV0ODZeGJ8/tYb4qTMpYN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f77WTXv9a98dTRgwo1JGz0PqsCy2sPwD40DUuoM2qlo8QADNV1T47J8MeGhyXz4Sw
	 ir7qySXObVv0BIEILJDrZBq9fgxDh4lv6yVb847xs4Hcx5pHM2d1N1CfQSb1bJhHN9
	 UN4RvLAd6oPzsK/vJcawy8h2rjyjRpRGzg+FidSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbgBNRoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:44:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389498AbgBNQC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:02:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366B5222C2;
        Fri, 14 Feb 2020 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696176;
        bh=dkb+6SBa4D8pK5Pl0N9HGRV0ODZeGJ8/tYb4qTMpYN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olhhOvUR7GZqr4SU7o+kxSSxNOPL4us7FnALFKyjLY3U4W+ubyUa/adn0J6P9ocXN
         x6B1yZ4rItqL7lgvHk2lqudEtrMhapDYKdxmlArD2tD2Ne0/GdTI9tPl3FxtmMu+C/
         HarVxhArwYTp7TH+oA9tbyhDq7aHaDD9Y08Wb+2U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 049/459] kernel/module: Fix memleak in module_add_modinfo_attrs()
Date:   Fri, 14 Feb 2020 10:54:59 -0500
Message-Id: <20200214160149.11681-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index cb09a5f37a5fc..9fb8fa22e16b3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1781,6 +1781,8 @@ static int module_add_modinfo_attrs(struct module *mod)
 error_out:
 	if (i > 0)
 		module_remove_modinfo_attrs(mod, --i);
+	else
+		kfree(mod->modinfo_attrs);
 	return error;
 }
 
-- 
2.20.1

