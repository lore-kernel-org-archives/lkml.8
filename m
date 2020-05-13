Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63172C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EC320727
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJceG01R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgEMVrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729752AbgEMVqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:46:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409BAC061A0C;
        Wed, 13 May 2020 14:46:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so15955541wmf.1;
        Wed, 13 May 2020 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMr7J7ZMfB4ZM2f1GJQW61b2tOU+m7OCFm5Ehp2KhEg=;
        b=IJceG01RlwXhlyQYR4oDOXRYjS0suusZWN7gEsoV+UYCYVKC3AGuaacI2CYgES1w25
         KIYlnNSHLWnkh4DN5BbY3TWXS+Xz1UjZkhCmRAtLry2Q+Qtm/Y96s3FnNG/yVO0EYLMA
         elAU+lC8aibYwI1eWkjl/EAHMbK8Ett9Joh1s5kYnN4X0RcE65AOQUIFtJroEkuk1gKW
         0aG1YtYfz7u5RTiDGYyX4LJjNlPjMNEK/l7Osu6uwgYMWTvDBFem5fOGY6LJYjfLgEeI
         HW5evC0XvWEhhscypqHengf1uA2kgiuRX6YOSBZ99kdQamcW2xmIORNt5cyITPVws8+n
         wMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMr7J7ZMfB4ZM2f1GJQW61b2tOU+m7OCFm5Ehp2KhEg=;
        b=hvlK8nCkwD4o5sSBAKluGE/t+sUsmI21d84Tu06QM8H+hgezcEGuH2pvEHo7zk80xk
         cCT/7IF/OM+3rYhitl9olx4u82CPudI1EzZvpIIuace9M7HmFKqEnmJBoF6bo3OtdYIV
         1Jm/jFK2hoZKzJ8yv4vgLVu3KGDAJLaQOScOG6ontpncVF1pscowVFvNveVPEo9QV5CN
         c2vIvxTndwdXhTsKja+fwRN8P2doHnBpg2b1SdLEt8KhOmh4JS1xVmX3HIR5M2KSH2lc
         T1vlHK1rQjqAXRvU+Rf7VmrUEKmdi2wyg8oHA0UA7XenRVd2MMaUBogldPjv3IzQzFZU
         pxSQ==
X-Gm-Message-State: AGi0PubKsyZbnd4zjhpsVHZUKRNU/ZXJVSPQZJ7wcDCbudDfdt/xB3+s
        JtKIkcThYHjdihEvBOSlsfI=
X-Google-Smtp-Source: APiQypJbt0YC4e23V0PxrpeY5gor4dZlwWjkH+VR4hz5fssJYDKJUwqMu9BWXNbPFa3NgyDWRpCoLw==
X-Received: by 2002:a1c:5944:: with SMTP id n65mr34071597wmb.73.1589406404897;
        Wed, 13 May 2020 14:46:44 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id m23sm1699734wmg.45.2020.05.13.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:46:44 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 07/11] sparc64: constify sysrq_key_op
Date:   Wed, 13 May 2020 22:43:47 +0100
Message-Id: <20200513214351.2138580-7-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With earlier commits, the API no longer discards the const-ness of the
sysrq_key_op. As such we can add the notation.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 arch/sparc/kernel/process_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 4282116e28e7..423011e60982 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -313,7 +313,7 @@ static void sysrq_handle_globreg(int key)
 	trigger_all_cpu_backtrace();
 }
 
-static struct sysrq_key_op sparc_globalreg_op = {
+static const struct sysrq_key_op sparc_globalreg_op = {
 	.handler	= sysrq_handle_globreg,
 	.help_msg	= "global-regs(y)",
 	.action_msg	= "Show Global CPU Regs",
@@ -388,7 +388,7 @@ static void sysrq_handle_globpmu(int key)
 	pmu_snapshot_all_cpus();
 }
 
-static struct sysrq_key_op sparc_globalpmu_op = {
+static const struct sysrq_key_op sparc_globalpmu_op = {
 	.handler	= sysrq_handle_globpmu,
 	.help_msg	= "global-pmu(x)",
 	.action_msg	= "Show Global PMU Regs",
-- 
2.25.1

