Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD52C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C59207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HRGJQXJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgE2L4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:56:00 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33928 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbgE2Lzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:55:55 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C25B3C041F;
        Fri, 29 May 2020 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590753355; bh=rl/j7/Cjm4X4ANhwe64JdR/bQf2UVY53T+qmbOpaUEE=;
        h=From:To:Cc:Subject:Date:From;
        b=HRGJQXJr7UqQH3Sy7emt2qiI8WsBKHurEtJeJ0tJHpXaqN9wFxlv4yn7rt/SpuvVh
         qYUMI6fnzye9F5T7d6vsPAqJBLZVODNTI1GJuMrmM3jFEGC7yn3rwwOb3TnIOKikZs
         lnaE8D436I5P/7JnKMj0YT/RZ406NGn2Gq+GkikRf4HDYNieYwxbLyUZRlFoM6PhxP
         eInDZeqd57F1vC0azOHexptgG03Sc7FMfQ9qu0VzTdg6aRfEkWiQtoE0wUZxDiMZtd
         c6EptXd6moMsJ9yiVLpwWvcRBGDxM8aC/+jOJWN0yaoaytp9emu3/fEYZWp4SpkLIw
         hO0J6tnuYzK3w==
Received: from paltsev-e7480.internal.synopsys.com (ru20-e7250.internal.synopsys.com [10.225.50.16])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2C138A005C;
        Fri, 29 May 2020 11:55:51 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/3] ARC: [plat-hsdk-4xd] initial port for HSDK-4xD board
Date:   Fri, 29 May 2020 14:55:30 +0300
Message-Id: <20200529115534.22883-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeniy Paltsev (3):
  ARC: allow to overide default mcpu compiler flag
  ARC: ARCv2: support loop buffer (LPB) disabling
  ARC: [plat-hsdk-4xd] initial port for HSDK-4xD board

 arch/arc/Kconfig                    |  13 ++
 arch/arc/Makefile                   |   4 +
 arch/arc/boot/dts/hsdk-4xd.dts      | 322 ++++++++++++++++++++++++++++
 arch/arc/configs/hsdk_4xd_defconfig |  99 +++++++++
 arch/arc/kernel/devtree.c           |   1 +
 arch/arc/kernel/head.S              |   8 +
 arch/arc/plat-hsdk/Kconfig          |  24 ++-
 arch/arc/plat-hsdk/platform.c       |   6 +
 8 files changed, 476 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/boot/dts/hsdk-4xd.dts
 create mode 100644 arch/arc/configs/hsdk_4xd_defconfig

-- 
2.21.3

