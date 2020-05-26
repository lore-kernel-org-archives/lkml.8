Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4237C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7462084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBiqTs9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbgEZKxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388501AbgEZKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:53:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45AEC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:53:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s8so19883305wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nU8saynYUtZPSDvPPHKy9vRNOAntHNQylGmuLZh5CaQ=;
        b=bBiqTs9b72ev9erjFKjGGG+M6Nu1PczWqim3YNpR7+Bcug/CY00M+uY1/8NwlBMSXl
         iWN0Wsv2AZqkV060Xy2WUq2vVKNby02ErMinLNop0evTqVO89PdJ9HHaNoWkBzstwIU5
         Qpl6My3j5lM7sJSvdxJQXjw68n7XLb8lo5TTUCxxQxZy8qjDtcxVNOcqU63yc3Nb/vER
         d6tvpiP+CExfjewYAqMY3d/+NFkC2UGSh1cvrD5vSgD4/sM8Ur39+w+tnVNdxn8QBrLj
         M36qQdpdVDP7vxr67OvqQG772+r8I2AMvLOK8/o2l2ru86AtlXljb1p7jH4i8VuToioF
         8f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nU8saynYUtZPSDvPPHKy9vRNOAntHNQylGmuLZh5CaQ=;
        b=QS9nHOsPWvkSFHjc2o5UK01wbzhNydToUI/UTRmU48QcR8JT17h/8Z/DbEbsYh/uz7
         aB/0bArrK386e7/VpIlhezu2xeVvxf6Y5P+cVLFhsOWmdPzUe8Z48p7kURLJYxhIr+Nb
         LxMe2QSJ5Mkxe9X+10ovIqd0BO/RFKPYTVbs0lSGAOyIh6OYCS+Vuu/jbceuBLQPurM4
         Dq7SSk6Mj/ubiDKDHWINZ6Y/45amaTd1rdOIIQr/CxCgvujGKe2jVIEsdZvToeVsj0jF
         E67xPsJB1+7Uc41DnCzgaXUpop/1Jg1jNdkrc3e7TsbRcPlg4R5rcTAhE1zIiDRXtnDr
         COIw==
X-Gm-Message-State: AOAM5337HetVzup0anTSawmQJlvuTe7LhbtZiI659PUZVruFmzYYfvrF
        9FY8BOmwMFy5wMOH+zLO47pqEA==
X-Google-Smtp-Source: ABdhPJzYaV2HXztaCU+TbT3Dx7Qj6u8OyL3CG7a35UxM842Pztr092teJMQu2q6UL5uGnD0UP2XPQQ==
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr21259112wrx.105.1590490393478;
        Tue, 26 May 2020 03:53:13 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:8bee:312:6092:58f2])
        by smtp.gmail.com with ESMTPSA id s7sm7244395wrr.60.2020.05.26.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 03:53:12 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 0/1] perf: cs_etm: Allow no sink on command line.
Date:   Tue, 26 May 2020 11:53:09 +0100
Message-Id: <20200526105310.9706-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently starting CoreSight tracing using perf requires a sink selection
on the command line:-

sudo ./perf record -e cs_etm/@tmc_etr0/ --per-thread uname -a

Not providing the @<sink> here results in an error and no trace produced.

After this set (alongside the CoreSight change set [1]) the infrastructure
will be able to select a default sink:-

sudo ./perf record -e cs_etm// --per-thread uname -a

This matches with the default operation provided with perf and intelpt.

This patch removes the check that a sink value is provided on the command
line with a NULL value passed to the CoreSight infrastructure if omitted.

Note: If this set is applied to a system without [1], then the effect is
benign as the existing CoreSight infrastructure will detect the error and
refuse to trace.

Applies to Linux coresight/next branch

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/734854.html

Changes since v3:
1) Removed RFC designation and distributed to wider audience.
2) Split set into perf user runtime (this set), and CoreSight driver code.


Mike Leach (1):
  perf: cs-etm: Allow no CoreSight sink to be specified on command line

 tools/perf/arch/arm/util/cs-etm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1

