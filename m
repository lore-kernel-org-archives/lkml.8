Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E88BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3132078D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr8WqzTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbgFPU1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFPU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:27:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85355C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:27:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t194so4419558wmt.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TP+qVkiiShfjmlFDbsqkgBgPwSAQSfed1CQJN6zPUxk=;
        b=gr8WqzTiJH5/qGRblApIlRwJH/SNUnkL4qmGG1sfC9DOsHAsztaMCuE5weVAhdagn9
         ZhMXhqwkCBimhxY8N5suO671XSrEsPZbe55+qMFuWhZpj/zZAh3Hlk2fnfYFvWXr3MYu
         XZLHo6HJPW2C3bbomOmD9zoXdz292J0BSegHJWROMDLPSaUHRRMpt89ydKlPWyOQrmKV
         O1Sh5MCM6nuMAyK1v6VAVqYyFPd80/rm8fjpv80QpzVYjcYkINat+9UNy/dzK8R7cWi1
         sqKaoHh4yMcGtFbtVG3y0Q7gjaAd/f8MTQL9KBLmuWtE4yyJ55zQ85fZn8eROBy8Q3JE
         CYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TP+qVkiiShfjmlFDbsqkgBgPwSAQSfed1CQJN6zPUxk=;
        b=a47PFnA7nMwErdhB/RU/EtOkSqN5eXIZ9WK/pfEjQc/XlKBX7cr42hY3rQcDQMOxBM
         cQm2U/Yk/5W6RaV9L07DMqDaz9SBtl1B9Qn0fwLYNVIdn93K4bbe0ul3uk1VQVxEe7J9
         oYnmZrHcbK67acbDeMiDsXzq1A0murpzUbFDvdN74Q1rRcl/TiFaRAGyRN68QV1RnoM0
         5qxxCqXEPnUMEaxObZ9VqlhwGG46c4c7TWVaWnbewLNa1F1Jd30RlJlDKnyJC3HMcNVs
         LdwkP+IACkxiqdFrgOErYdI6a9u8E4wioly1bY9DZR3d9assXN2kfp0l01P/zzhsISBg
         nxOA==
X-Gm-Message-State: AOAM531kBttBziXp0CEsFtdiRJv3ktc5v7xUschWEjHYClzHpwM+nXkb
        n4jEBqjHVzEbLApHZOIptUA=
X-Google-Smtp-Source: ABdhPJwEY5epIaFIhnATfuW+CIIqe71BHWTH/FHA2pkTWaiEXvs0EaLM7g5IIC4RthxqcP9xDHULZg==
X-Received: by 2002:a7b:cc08:: with SMTP id f8mr5270576wmh.106.1592339263257;
        Tue, 16 Jun 2020 13:27:43 -0700 (PDT)
Received: from localhost.localdomain ([95.145.157.140])
        by smtp.googlemail.com with ESMTPSA id a3sm29421673wrp.91.2020.06.16.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 13:27:42 -0700 (PDT)
From:   dan love <danlovecomputing@gmail.com>
X-Google-Original-From: dan love <danlove99@hotmail.co.uk>
To:     danlove99@hotmail.co.uk
Cc:     abbotti@mev.co.uk,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed styling issues by adding blank line after definitions.
Date:   Tue, 16 Jun 2020 21:26:55 +0100
Message-Id: <20200616202658.4844-1-danlove99@hotmail.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: dan love <danlove99@hotmail.co.uk>
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
2.17.1

