Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE39C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE334206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eYx8Dswg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD1EVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:21:49 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9756 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgD1EVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:21:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea7af4f0000>; Mon, 27 Apr 2020 21:21:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 27 Apr 2020 21:21:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 27 Apr 2020 21:21:48 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Apr
 2020 04:21:47 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 28 Apr 2020 04:21:47 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.165.152]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ea7af5a0004>; Mon, 27 Apr 2020 21:21:47 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>
CC:     <digetx@gmail.com>, <linux-media@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 1/5] MAINTAINERS: Rename Tegra Video driver path
Date:   Mon, 27 Apr 2020 21:20:46 -0700
Message-ID: <1588047650-29402-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588047650-29402-1-git-send-email-skomatineni@nvidia.com>
References: <1588047650-29402-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588047695; bh=x3uWCWxQaB3Uj5c8FjRrysP8ZsliNjJFnN1vojGL9y0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=eYx8DswgJw9bRX1sNHnQog6RJxTRzLdpQ2OO1v0AcbbcpcW7IzrC6ZqCLuy4uUCT8
         BlHbRj8ykQ5xB0XVhDIh6s9ZkLqPfycqHQmWnrMsIcgrQCeGRPqmzXPrG+cY7U1jxK
         C+0kW+YFCYmaMJjMI2C5f78O722z1e0NOSmt96kEsiNUK5QEV9FvRAn4EP3m8aCaH9
         Jkyx/rpweE86dZ9FK4/Go5fSywf6MIRxTP5jLMG+elI4g/OCEcSaDvBJnpdpEoH/CO
         SgDYaQYc+Onh9v95Kz/tRXzQa/9Bm6lvoEUExZJrP4RDhxsUNNIcCvEgm//gM2+wWo
         JAhLWPbS2atgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames Tegra video driver path from media/tegra to
media/tegra-video as media/tegra is more generic.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 795b201..47cd448 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16652,7 +16652,7 @@ L:	linux-media@vger.kernel.org
 L:	linux-tegra@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
-F:	drivers/staging/media/tegra/
+F:	drivers/staging/media/tegra-video/
 
 TEGRA XUSB PADCTL DRIVER
 M:	JC Kuo <jckuo@nvidia.com>
-- 
2.7.4

