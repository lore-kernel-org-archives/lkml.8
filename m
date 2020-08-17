Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25B1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933902065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AE9NyKa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbgHQTbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732117AbgHQTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:31:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC4C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:31:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f5so8028202plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4r41zYd/gJVosJ/EXIy5cXoeJGMFSQ3Tn5MDvItSlzo=;
        b=AE9NyKa1SzgSr6aec3gYUTgUeqyGAxC2Bna+yLLAbFcMpkU8Hfepn9dvr/CiXPOf1I
         AaKIgMz+bGmRMcszPQMXl8DzEBe0BDBZR63XnbgL2Mz5vmLPh7FmlbfjaguvQqdPFjPe
         qbWhjUbGadRL5Xc9bBx6vQuRSXlr4wbac8sAaYHdpaSeE1Rz17GJ8F7u2jHarFjCAnm+
         ZIbagz+PbgiPn6AxKbkdJmfQnTPA4JZTSSoKjkQ4uEoEk3u1ulhqVBS6AVIZ3FsWY4ZP
         BHfSFSjC17SfW0SSeGArAxnIFk475WLZ9MQGGobvAJS8HfCFuMYvswyMpJmP+lwQORPF
         63OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4r41zYd/gJVosJ/EXIy5cXoeJGMFSQ3Tn5MDvItSlzo=;
        b=JZJDdbTELgipVTTpGUlqz3B09+KhWDn6Pm5+ypddG9LXlLxY6U8b39KC+0koz3OP0x
         jUupdbsyKRuTCwshaz3Ehf+BnUJQ6PQmvc/+PUDn8kEN5v8INbACJSk0wWFX+sMmngkz
         0Ewhf0A25vh6C77X8FRpkNXb6I4DmqTQnIeNVMYyxPhYuqDML+6QYxqgk/3snWeiBjOA
         sWQxxWFTDwzaA2FSjn6SthjzQbK6n3e6xnB0F1z11lzw9iouF8Vbcc02QFeTqvIyqCdP
         D0g3vlzIoVbVSxyzYtXX/M//GiqN5OH6KI6QAxtEHIVhSumckrmgjJcVEPdA91ViRxxo
         VfeA==
X-Gm-Message-State: AOAM530npWz6mO7Ds2MqXQLymFIgCMyAENcz+0HQs5uZro3Ij4F8GwZd
        zz0vPmntRxgfndC18UMbVnI3cg==
X-Google-Smtp-Source: ABdhPJwC6BUSviDE/TQYXK3X/Udj7mfA/wi6Ei1n9SWXT3ziFif8Z3VSD0qAz95DDdn90KpdUUaa2A==
X-Received: by 2002:a17:902:b194:: with SMTP id s20mr12925335plr.321.1597692702284;
        Mon, 17 Aug 2020 12:31:42 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z25sm21185855pfn.159.2020.08.17.12.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:31:41 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, will@kernel.org, john.garry@huawei.com,
        leo.yan@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add entries for CoreSight and Arm SPE
Date:   Mon, 17 Aug 2020 13:31:40 -0600
Message-Id: <20200817193140.3659956-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for perf tools elements related to the support of
Arm CoreSight and Arm SPE.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2698cc7e23..f9bb76baeec9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13427,8 +13427,18 @@ F:	tools/perf/
 PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
 R:	John Garry <john.garry@huawei.com>
 R:	Will Deacon <will@kernel.org>
+R:	Mathieu Poirier <mathieu.poirier@linaro.org>
+R:	Leo Yan <leo.yan@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
+F:	tools/build/feature/test-libopencsd.c
+F:	tools/perf/arch/arm/util/auxtrace.c
+F:	tools/perf/arch/arm/util/cs-etm.*
+F:	tools/perf/arch/arm/util/pmu.c
+F:	tools/perf/arch/arm64/util/arm-spe.c
+F:	tools/perf/util/arm-spe.h
+F:	tools/perf/util/cs-etm-decoder/*
+F:	tools/perf/util/cs-etm.*
 F:	tools/perf/pmu-events/arch/arm64/
 
 PERSONALITY HANDLING
-- 
2.25.1

