Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 05:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE10920659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 05:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdKwNiEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgFGFbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 01:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFGFbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 01:31:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C018EC08C5C2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 22:31:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u13so12190048wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6yEExVqDmeDh4IMutKinHLuhVten7CyE5RDcivHz3BU=;
        b=rdKwNiEs2tCE3Rcx91Nw6tW29sDgjTNkWsoZTc5HaKGCY0MiudSmxEDEbfjRoPZDjj
         vX4kKiKRXFw7/0ZY3t8RHUHZjAIkkeLMOplPoHQzXKGOW7S2FEefCHYLk0R9vIAfpQma
         +IGiROBAi437491f/6gA5sHV0u/A1X7aGHEMWa1VSuE5E4yCnXwonHioNLOP6/+OoceJ
         fYLEnjwK7NFMtSTwMLMLDLQxEiDIJMyKEg9yVKzGdaNViTLvwj691Rm/7zAgyhEi4zvw
         GFwS7KQVFpmqETYhyWWN4VFocpPmVE6U/85THvr1onbBxTQ0eEeRHZe57T+hpg6Wnfts
         MS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6yEExVqDmeDh4IMutKinHLuhVten7CyE5RDcivHz3BU=;
        b=CXPteg4SkdK3E7c7OMw4ERyfzBNd1eivPKGPgLUZcrylgXBGJdIKC/H35RoiWRmxlh
         Dtsy7Gw8PL8jF4ZrRQrGPSQZ8gjkR8UHIfZwi8YBHSzQYXQSe11k+Ps6+SYXPIKSnO0J
         Meqy3jizhM1u4kSoTpkLDI94NfHpOhpXamBmSNxVwbnY9L9dBXhhLla8ATboo1Z3kopy
         FFUp4ExJ9mHf6+qMwgBt0x7Y3UyL74eyyX958g5d9dsIxqXz/UUT1+ExNmbu6PFqzvih
         wrcDE87+R3T/IFotiq4hn/bIbgjQMVN6VTNbLFjd2oi44zXUa8VPB6/afMTnf7el/muN
         0jng==
X-Gm-Message-State: AOAM530umuy+/sf/R8XFOpqin1FdOztIEjht1oPEU8VrSH3vsPlJ/Npd
        Vj/u/2d+XsD9xXBZOX+BK9QwdPcr
X-Google-Smtp-Source: ABdhPJxqyIkiunLObqczTfIQhwITays+s5dkuPHj7fhUirlulhYbKNpWyp3yBVQix3vlHJW8/CWTRA==
X-Received: by 2002:a1c:3905:: with SMTP id g5mr10187596wma.75.1591507862916;
        Sat, 06 Jun 2020 22:31:02 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id y19sm17374091wmi.6.2020.06.06.22.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 22:31:01 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: rename mmu_write() to mmu_asid_va_write()
Date:   Sun,  7 Jun 2020 08:31:00 +0300
Message-Id: <20200607053100.13596-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function name conflicts with a static inline function in
arch/m68k/include/asm/mcfmmu.h

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 3c8dcdfba20c..fc4372c18ce2 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -480,7 +480,7 @@ static int mmu_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static ssize_t mmu_write(struct file *file, const char __user *buf,
+static ssize_t mmu_asid_va_write(struct file *file, const char __user *buf,
 		size_t count, loff_t *f_pos)
 {
 	struct seq_file *s = file->private_data;
@@ -1125,7 +1125,7 @@ static const struct hl_info_list hl_debugfs_list[] = {
 	{"command_submission_jobs", command_submission_jobs_show, NULL},
 	{"userptr", userptr_show, NULL},
 	{"vm", vm_show, NULL},
-	{"mmu", mmu_show, mmu_write},
+	{"mmu", mmu_show, mmu_asid_va_write},
 	{"engines", engines_show, NULL}
 };
 
-- 
2.17.1

