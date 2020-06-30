Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4820C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D1320724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DjB7k375"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390561AbgF3SBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:01:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43655 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388845AbgF3SBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:01:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593540096; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=f0kIpzkvrOUo1ED/KiFJxCxWmf6P+bTA+15yl4gIQMw=; b=DjB7k375dfglfF6ug0hA3gYqjHzwfoIgHuBBxY0j6kXN9zW7dbqysOtzZosVM5V2yfzGHDUd
 GGYITaN1gPtcJQX6vCoZAWlA7b3FbW2vUz4ePAx6qmq0hHnD3p7GaCqmfD2cHSDoi+XLoutW
 2yK5CUGBUDod8wpW4nOfQl3vjzI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5efb7de50206ad41d1b693f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 18:01:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36E67C43391; Tue, 30 Jun 2020 18:01:08 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 210FBC433C6;
        Tue, 30 Jun 2020 18:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 210FBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/3] Add Kryo4xx gold and silver cores to applicable errata list
Date:   Tue, 30 Jun 2020 23:30:52 +0530
Message-Id: <cover.1593539394.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the Kryo4xx gold/big and silver/LITTLE CPU cores to
the errata list which are applicable to them based on the revisions
of the Cortex CPU cores on which they are based on.

Patch 1 adds the MIDR value for Kryo4xx gold CPU cores.
Patch 2 adds Kryo4xx gold CPU cores to erratum list 1463225 and 1418040.
Patch 3 adds Kryo4xx silver CPU cores to erratum list 1530923 and 1024718.

Sai Prakash Ranjan (3):
  arm64: Add MIDR value for KRYO4XX gold CPU cores
  arm64: Add KRYO4XX gold CPU cores to erratum list 1463225 and 1418040
  arm64: Add KRYO4XX silver CPU cores to erratum list 1530923 and
    1024718

 Documentation/arm64/silicon-errata.rst |  8 ++++++++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 21 +++++++++++++++------
 arch/arm64/kernel/cpufeature.c         |  2 ++
 4 files changed, 27 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

