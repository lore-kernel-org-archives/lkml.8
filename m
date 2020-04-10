Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51216C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DBE2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="qVOz/Mcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgDJKYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:24:42 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:57142 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgDJKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:24:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4B6CB27E0566;
        Fri, 10 Apr 2020 12:24:40 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aLP0ixhF3Vdn; Fri, 10 Apr 2020 12:24:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 0A2D327E039A;
        Fri, 10 Apr 2020 12:24:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 0A2D327E039A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1586514280;
        bh=Fuewdad1fAPYUYavFKBJ1ELvfko88w6R3xYRHUH3S40=;
        h=From:To:Date:Message-Id;
        b=qVOz/McsGNTJMHfkamSpXlba8MDEHlmARacqIqynXv/SQVnwGK8BfM1S+GYWYQiMN
         9Ucq/1t4Db9Q0ePYcr0a/s4WGf0ch0gnsKAn5o31Sp4iI+4CNGz2+eYWR7LJYAWwwl
         B/TCxrFJzsawYaceFWtTmUODuF2G39UNtt7IeFac=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1wIrsaQBTd8l; Fri, 10 Apr 2020 12:24:39 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id D593327E0566;
        Fri, 10 Apr 2020 12:24:39 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH 0/2] remoteproc: add rproc_coredump_set_elf_info
Date:   Fri, 10 Apr 2020 12:24:31 +0200
Message-Id: <20200410102433.2672-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a way to set the elf informations that will be used to
generate the coredump. Second patch fixes drivers to use this function.

Clement Leger (2):
  remoteproc: add rproc_coredump_set_elf_info
  remoteproc: use rproc_coredump_set_elf_info in drivers

 drivers/remoteproc/qcom_q6v5_adsp.c        |  1 +
 drivers/remoteproc/qcom_q6v5_mss.c         |  3 ++
 drivers/remoteproc/qcom_q6v5_pas.c         |  1 +
 drivers/remoteproc/qcom_wcnss.c            |  1 +
 drivers/remoteproc/remoteproc_core.c       | 32 ++++++++++++++++++++--
 drivers/remoteproc/remoteproc_elf_loader.c |  3 --
 drivers/remoteproc/stm32_rproc.c           |  1 +
 include/linux/remoteproc.h                 |  2 ++
 8 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.17.1

