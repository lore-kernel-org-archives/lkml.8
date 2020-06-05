Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627DB207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeGwUC5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFEDWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFEDWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:22:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CB9C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 20:22:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so4457742pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BsPlBCClkNY3i19jkCcpmxryGhoEl1mZzp7w55xl5k=;
        b=NeGwUC5SuWEfR36Y2HWPbDGCVuTwY3L6o3gm4YbT6IoH+Rj+6El+FYcN/56JxNZ+oO
         bTRhTltrhc+Ffwikfu/W8ddkhlceItIcenPlaR2KQ7iqGJqnHqt3IH9T0tHB0xSHwet4
         FG7ZCQzpNkJGFhgY4NgBjN3Nzv1tHo5Lh+jWlK8kaIMBXNMDcCfLRhCpM0s+MIZ4rv+D
         7jTlQMsbHXUm1/vBnTfNwfGc2yHXzG2UXCHffwM6/SWYmarIjfEy72pAbEfGow8g+gSS
         PB6b/03bgu7bQq3MQ2P9p72etuZ51h6xArh/42oDdyGpHEn5SCZnaguxp0I3LTIcsM/n
         jgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BsPlBCClkNY3i19jkCcpmxryGhoEl1mZzp7w55xl5k=;
        b=Fqt3A3Jr1oSb2oa7DzS6tYY37T5deP3U79PS/4TcxfqWhYbBce/fdttMtUovcijlLC
         gw2RtV0ox5jxHgEg2JfDulPe4xuvRJx5GtsmlxHl4hDHNmGwGcY8KQowgFag7IyyGnFW
         UzJRtKhEQysRGZjQtCLugizMlHC6pFBcnuxp6jeovoI7ZbPECscCErgSz7Pmj6d+iYOm
         FNqsPNOJdyKfDlzi+GDgRkUSX1xRLsrszZwHaKDYj5pviHfgwYyQjhyAHvIxh/EVsi11
         eHb54EWKwsQ3V8/UTagY8MYPSKDC9Em6EP9Ii9avb4SddKgW2jnzE1od96qt9KVaSHYO
         CJJA==
X-Gm-Message-State: AOAM53099+TaafY4WwOZ51AWNtRcNO9AQ6KLnOx96AOo4IgYwwuuHmAk
        bvYbwJVLWeHWEbeRg4pfRbM=
X-Google-Smtp-Source: ABdhPJytvjFMr1e82qYio8uFLx+ShTDgJaWolaqdqqamVortvV8WNBsc755YCgcIe15apNvm12G5aw==
X-Received: by 2002:a63:c948:: with SMTP id y8mr7468775pgg.118.1591327355373;
        Thu, 04 Jun 2020 20:22:35 -0700 (PDT)
Received: from localhost.localdomain ([223.29.222.28])
        by smtp.gmail.com with ESMTPSA id nl8sm7685405pjb.13.2020.06.04.20.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:22:34 -0700 (PDT)
From:   Divyansh Kamboj <kambojdivyansh2000@gmail.com>
To:     abbotti@mev.co.uk
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kambojdivyansh2000@gmail.com
Subject: [PATCH] Staging: comedi: Added blank lines to fix coding style issue
Date:   Fri,  5 Jun 2020 08:51:40 +0530
Message-Id: <20200605032140.31287-1-kambojdivyansh2000@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue by adding a blank line after declarations

Signed-off-by: Divyansh Kamboj <kambojdivyansh2000@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index e85a99b68f31..3f70e5dfac39 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2169,6 +2169,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case COMEDI_CHANINFO: {
 		struct comedi_chaninfo it;
+
 		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
 			rc = -EFAULT;
 		else
@@ -2177,6 +2178,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 	}
 	case COMEDI_RANGEINFO: {
 		struct comedi_rangeinfo it;
+
 		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
 			rc = -EFAULT;
 		else
@@ -2249,6 +2251,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 	}
 	case COMEDI_INSN: {
 		struct comedi_insn insn;
+
 		if (copy_from_user(&insn, (void __user *)arg, sizeof(insn)))
 			rc = -EFAULT;
 		else
-- 
2.26.2

