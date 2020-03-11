Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13363C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2D320873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgCKHlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:41:02 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:16660 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCKHlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:41:02 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2020 03:41:01 EDT
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 4719C4E207F;
        Wed, 11 Mar 2020 15:32:16 +0800 (CST)
From:   Li Tao <tao.li@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     wenhu.pku@gmail.com, Li Tao <tao.li@vivo.com>
Subject: [PATCH] arm64: kexec_file: Fixed code style.
Date:   Wed, 11 Mar 2020 15:31:55 +0800
Message-Id: <20200311073156.125251-1-tao.li@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZQ1VKTklCQkNCSU9JTk5ITFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6FCo4EDgyODMNQxkQT0w4
        Ah8aFD5VSlVKTkNIQkpKQkhCSUxOVTMWGhIXVQ8aFFUXEjsNEg0UVRgUFkVZV1kSC1lBWU5DVUlO
        SlVMT1VJSU1ZV1kIAVlBSkNJSTcG
X-HM-Tid: 0a70c88222989376kuws4719c4e207f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank.

Signed-off-by: Li Tao <tao.li@vivo.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index dd3ae80..b40c3b0 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -121,7 +121,7 @@ static int setup_dtb(struct kimage *image,
 
 	/* add kaslr-seed */
 	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
-	if  (ret == -FDT_ERR_NOTFOUND)
+	if (ret == -FDT_ERR_NOTFOUND)
 		ret = 0;
 	else if (ret)
 		goto out;
-- 
1.9.1

