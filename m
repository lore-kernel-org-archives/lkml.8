Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D38C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBD120838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863619;
	bh=ZKI9m9r9ZBkJSDjSyGik+RALoIn8moPnYi4EQWm8ZBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C6Jd720aHFePKNTauYL4RRx4f6MjAKDCjSl0mik42Tk07Occ1PboLxhdcLKCfvoB7
	 0kKHZHsV8GRKnqyaINj3pqc9hk+mHqQKmIezCw+JaaQ3PpEmHSwei5ZHe6Q5ZPjiuY
	 uiVRg8EDGNf5yLMD/7VL9h9lfYXLX3A51MuVq66g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbgAXLAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733089AbgAXLAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:00:13 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81112075D;
        Fri, 24 Jan 2020 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863613;
        bh=ZKI9m9r9ZBkJSDjSyGik+RALoIn8moPnYi4EQWm8ZBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTNQMYzpUsYzamqLXxm87tVz9pV6cxIkpPIcp9henuXP2aYZTf85uOWycKh+NIZoi
         DkuByJfDLXreQRhOUjDZpPvSkVyrDC6OlxCHH8kNcTWC/gfiA0VzDiekNDDKcv3Dtu
         nyx+/K1a/yZu+xkirBE87pPMGbaQZDi6xUYHr0jU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Rowand <frank.rowand@sony.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/639] ARM: qcom_defconfig: Enable MAILBOX
Date:   Fri, 24 Jan 2020 10:23:17 +0100
Message-Id: <20200124093050.738625323@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

[ Upstream commit 54c2678cd198f61555796bbda5e1727e6e1858f1 ]

Problem:
ab460a2e72da ("rpmsg: qcom_smd: Access APCS through mailbox framework"
added a "depends on MAILBOX") to RPMSG_QCOM_SMD, thus RPMSG_QCOM_SMD
becomes unset since MAILBOX was not enabled in qcom_defconfig and is
not otherwise selected for the dragonboard.  When the resulting
kernel is booted the mmc device which contains the root file system
is not available.

Fix:
add CONFIG_MAILBOX to qcom_defconfig

Fixes: ab460a2e72da ("rpmsg: qcom_smd: Access APCS through mailbox framework"
added a "depends on MAILBOX")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 6aa7046fb91ff..bd6440f234939 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -207,6 +207,7 @@ CONFIG_MSM_MMCC_8974=y
 CONFIG_MSM_IOMMU=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
+CONFIG_MAILBOX=y
 CONFIG_REMOTEPROC=y
 CONFIG_QCOM_ADSP_PIL=y
 CONFIG_QCOM_Q6V5_PIL=y
-- 
2.20.1



