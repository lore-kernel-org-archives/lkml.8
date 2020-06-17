Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9194FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69941207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opw6v2If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFQOOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgFQOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:14:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A61BC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:14:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z63so1211210pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=3KiZ0hsFJ+V+TJvcKVSj6rh18GdO0J2gStEd7h7xqpg=;
        b=opw6v2IfUvgqBueRp51a44SpADRCD96H75Z9wgZYxdRCL0z489mhKZdp3w6BhKGn7t
         imuobN/052eagO4Plk+U+r6h27UBQyguV7j+LWeAHR7DlfPcUfmoByA/ZRxUxrLDo+nK
         3Pn2KCCRYkLoFnLYxqD0b5hSOq2uH5dYv1b793wlErhDxR1+Gjvpu37adroL85qwURSz
         D2wMbmnS6l5VZik962yZARVB+rBzk+j8osOK7H1sD2ZSSmy8dxEU2UUUnk0NubHrwrKX
         L7EeKFqc/en249INHm9DrfYw5QtCmvFCJfOssPwdxi5ykozbb7s6yqXbpEEVpcazSVxk
         oDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=3KiZ0hsFJ+V+TJvcKVSj6rh18GdO0J2gStEd7h7xqpg=;
        b=Kbq18FcdIXCRGCLjgOhw9rY7+0Y0G0X34HViKRPer+nWcDFy6qI1lOClQEd3FDapu3
         TzpxojiiqO02k1WXpLx3OoU1kxjWJCJhxQ4tscZjb53GPprdM9HSahAuZI3Jpsv/slrM
         NzKbM+I4adkHaSJvotCr/g2Yy1SYTsNEyfLjpH8yfwIvp3N+Urn6Xr3O4LYIlFfcmb97
         b0Sm42XaFJvxAcT8yuefrVC6vPFmG0gEeO43CQ2RnyFm5HP2k4fE2YwPBbbKfg8Ckpky
         NH4BpqS7GsQadEoCh+HX8x9eM/goEgLcjX91CzHqPra+1YOlrxCftQc4LebV6NSP/MFq
         JAhQ==
X-Gm-Message-State: AOAM53010vR8uQwX/HajU9VycPQ8xL5R6q0sfiOiEDSpHdtzd9GR3AeA
        Dtp9FcOajpA+YX7QqHjghTE=
X-Google-Smtp-Source: ABdhPJzLuh+VgNQ2uDJCaxCsaAhu2mSppIYfZN9hPqQRVgrswIbvTNxTg1+ifHt2G84jaeCsPvWu2w==
X-Received: by 2002:a62:1d8e:: with SMTP id d136mr6797346pfd.323.1592403261956;
        Wed, 17 Jun 2020 07:14:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 67sm85375pga.44.2020.06.17.07.14.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 07:14:20 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Mark Gross <mgross@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] cpu/speculation: Add prototype for cpu_show_srbds
Date:   Wed, 17 Jun 2020 07:14:10 -0700
Message-Id: <20200617141410.93338-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-day is not happy that there is no prototype for cpu_show_srbds().

drivers/base/cpu.c:565:16: error:
		no previous prototype for 'cpu_show_srbds'

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 7e5b3c267d25 ("x86/speculation: Add Special Register Buffer Data Sampling (SRBDS) mitigation")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 52692587f7fe..8aa84c052fdf 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -64,6 +64,7 @@ extern ssize_t cpu_show_tsx_async_abort(struct device *dev,
 					char *buf);
 extern ssize_t cpu_show_itlb_multihit(struct device *dev,
 				      struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
-- 
2.17.1

