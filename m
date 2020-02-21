Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A2FC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDAF2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274879;
	bh=Qt8Et4Nmv72ffbqegZAEOEqYIFv83EAW38M0+ZpuCtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDWirSd0Ovk7J0S2cIsJ5wXrn5iaj/BdM/XQVfN8b+VJWRoUkXusZ9MXUFQo0rfD4
	 ag1pfxoeJWToMrTjFIHajm05Ex7jOu3mvp+VO75QE7Hap5WsXbir2IumjSZYID4kHg
	 1U34NAGM04FAPXvOtyppyxYkKchT8a5iPPk0I2JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgBUIr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgBUHrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:47:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC6720801;
        Fri, 21 Feb 2020 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271266;
        bh=Qt8Et4Nmv72ffbqegZAEOEqYIFv83EAW38M0+ZpuCtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pK2WtX/AHOVokGTtKsRk6JJ9B0KSFKAucmdJVpBmgTyseFHMpvqNkUCCgIS8MKw2Z
         DqOSvng1nkAma1lwW44CO/NtaPNnNwn6tVTjrpbEUTEYIgyGQCQ/E80hVN2cFyfFZj
         07yvzHe4F3Hmt5qWrSppvp0NMYdMuQkSNgVcUUh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christopher Head <chead@chead.ca>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 074/399] x86/sysfb: Fix check for bad VRAM size
Date:   Fri, 21 Feb 2020 08:36:39 +0100
Message-Id: <20200221072409.547692841@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 01f0e2263b86b..298fc1edd9c95 100644
--- a/arch/x86/kernel/sysfb_simplefb.c
+++ b/arch/x86/kernel/sysfb_simplefb.c
@@ -90,11 +90,11 @@ __init int create_simplefb(const struct screen_info *si,
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



