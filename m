Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7BD207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GTnaR55g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgHaPh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:37:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13511 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgHaPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:37:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d18cf0004>; Mon, 31 Aug 2020 08:35:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 08:37:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 08:37:49 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 15:37:48 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 15:37:48 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.173.243]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4d194b0002>; Mon, 31 Aug 2020 08:37:48 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <hverkuil@xs4all.nl>
CC:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix compile warnings reported during Non TPG build
Date:   Mon, 31 Aug 2020 08:37:37 -0700
Message-ID: <1598888258-25586-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598888143; bh=GGK4Y8UghTcx7ENK145NKST1O+8RRIgQHK06/HSZE2k=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=GTnaR55gjXg/BaZs0XJg+gaVACl7HwZpd7vToZeJOKY8CxKqJsMLFc7/eeLwBOhUC
         xRxyj5LNpZAmhncgCFXOrH2iVF1g5d1WXhKZqiWq8oRP/CYaXlVEd57Q0jEuiyIeJY
         HQmdPcStV3sikvlfj1FL3N4VIdYTmQke4gHDUI4Vph6pY5SD/Y/o6EKRYssMdPADhy
         sgi5vYriUgv423Oq+ENp2/M/fmzpuU1KZhyJlUlk6txZmGVdMv3qPI9HwR9L66RSE3
         VsbL3ELat3LV1d0wlqeraO6NPa1ulBxRv6Sy22l2d4IuBCivOJGiPHpdUWB4gXlgBx
         Mi2m/gG/r1CkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch-0001 fixes compilation warnings for variables used with V4L2
control operation when tegra-video is builded for Non TPG.

Patch-0001 should be applied on top of below external support patches.
https://patchwork.kernel.org/cover/11709839/

Sowjanya Komatineni (1):
  media: tegra-video: Fix compilation warning of unused variable

 drivers/staging/media/tegra-video/vi.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.7.4

