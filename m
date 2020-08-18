Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A78CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FDB206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHRLNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:13:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbgHRLNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:13:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3519F8A2BBA8A78423C9;
        Tue, 18 Aug 2020 19:13:23 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 19:13:15 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Christian Brauner" <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        "Suren Baghdasaryan" <surenb@google.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] binderfs: make symbol 'binderfs_fs_parameters' static
Date:   Tue, 18 Aug 2020 19:22:45 +0800
Message-ID: <20200818112245.43891-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/android/binderfs.c:66:32: warning:
 symbol 'binderfs_fs_parameters' was not declared. Should it be static?

This variable is not used outside of binderfs.c, so this commit
marks it static.

Fixes: 095cf502b31e ("binderfs: port to new mount api")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/android/binderfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7b76fefde3f8..7b4f154f07e6 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -63,7 +63,7 @@ static const struct constant_table binderfs_param_stats[] = {
 	{}
 };
 
-const struct fs_parameter_spec binderfs_fs_parameters[] = {
+static const struct fs_parameter_spec binderfs_fs_parameters[] = {
 	fsparam_u32("max",	Opt_max),
 	fsparam_enum("stats",	Opt_stats_mode, binderfs_param_stats),
 	{}

