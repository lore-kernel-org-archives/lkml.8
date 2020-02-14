Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE7BC3B1A6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD16206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700481;
	bh=gAkfpv4ncOrLT6/j6G/W8e8xXZzuNMbpqDoVeHHi7gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XHGtk0TN7YMRFmGrOpvZzdcVGoabN0VTJGcX/7DZZr9AJDBcYDxzHT/ma6vgM344f
	 HlJhrR32NSQiQIev9DOld3imdjGG6u4z5YRVMd5fmFl8i0pTjI24oMGYFs0CZo2yI4
	 /FFvLtZsUoHbZT8NB//bqBwaIsDcQoDZ2ZJx73Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgBNROl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392008AbgBNQMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:12:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987EA2469F;
        Fri, 14 Feb 2020 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696753;
        bh=gAkfpv4ncOrLT6/j6G/W8e8xXZzuNMbpqDoVeHHi7gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pjo15OuH0EQK5rnDnowdydoT9JLZLSEx0dGccn4GUs9wJdSfz6Xu2c3AFgdAHvxBj
         Y0qbEqSuQAbziy1SERwuPnxl9/zZTTPZ4EG2Cvue0yay8F0OKFv7U8VoAbBtLm+mB/
         /QBbklaTZrn627SOkU9a0Dn5pwCNSjseYY2OR5jo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Christopher Head <chead@chead.ca>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 035/252] x86/sysfb: Fix check for bad VRAM size
Date:   Fri, 14 Feb 2020 11:08:10 -0500
Message-Id: <20200214161147.15842-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

[ Upstream commit dacc9092336be20b01642afe1a51720b31f60369 ]

When checking whether the reported lfb_size makes sense, the height
* stride result is page-aligned before seeing whether it exceeds the
reported size.

This doesn't work if height * stride is not an exact number of pages.
For example, as reported in the kernel bugzilla below, an 800x600x32 EFI
framebuffer gets skipped because of this.

Move the PAGE_ALIGN to after the check vs size.

Reported-by: Christopher Head <chead@chead.ca>
Tested-by: Christopher Head <chead@chead.ca>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206051
Link: https://lkml.kernel.org/r/20200107230410.2291947-1-nivedita@alum.mit.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/sysfb_simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sysfb_simplefb.c b/arch/x86/kernel/sysfb_simplefb.c
index 85195d447a922..f3215346e47fd 100644
--- a/arch/x86/kernel/sysfb_simplefb.c
+++ b/arch/x86/kernel/sysfb_simplefb.c
@@ -94,11 +94,11 @@ __init int create_simplefb(const struct screen_info *si,
 	if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
 		size <<= 16;
 	length = mode->height * mode->stride;
-	length = PAGE_ALIGN(length);
 	if (length > size) {
 		printk(KERN_WARNING "sysfb: VRAM smaller than advertised\n");
 		return -EINVAL;
 	}
+	length = PAGE_ALIGN(length);
 
 	/* setup IORESOURCE_MEM as framebuffer memory */
 	memset(&res, 0, sizeof(res));
-- 
2.20.1

