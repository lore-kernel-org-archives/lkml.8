Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA4C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC60207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ST0LKDT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCXMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:47:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52960 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbgCXMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:47:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585054061; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+KQN9xMVdPONR0ZqJSh7cXvXgPgruBMXlHRgc5SZ7Eo=; b=ST0LKDT3Rc5vTo3nbMmBAwRwELY/kk0ZamnS1JhNmAu/lJDobJs9QR8xbINfhDYxRJ0dkFKN
 QMM/NKIXe27ID/yHfDZSAz70/JskI8hCT6e67noe4qEBnIyvvBXAlzVkNCQ5k8NrgL+hVfB2
 /V9VG9HrN2mgkO+n4rofj+6C3Go=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7a0164.7f14b33602d0-smtp-out-n04;
 Tue, 24 Mar 2020 12:47:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60997C432C2; Tue, 24 Mar 2020 12:47:31 +0000 (UTC)
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FD1FC433CB;
        Tue, 24 Mar 2020 12:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FD1FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH 0/3] Add support to handle targets without TrustZone
Date:   Tue, 24 Mar 2020 18:17:21 +0530
Message-Id: <1585054044-18667-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu mapping for S2 SIDs are taken care by TrustZone.
For the targets which does not have the support of TrustZone,
these mappings need to be created in the driver using an
iommu domain.

Leaving these SIDs unconfigured will result in a global
smmu fault. Hence configuring them for Non-TrustZone targets
is mandatory.

Rakesh Pillai (3):
  dt-bindings: ath10k: Add wifi-firmware subnode for wifi node
  ath10k: Setup the msa resources before qmi init
  ath10k: Add support for targets without trustzone

 .../bindings/net/wireless/qcom,ath10k.txt          |  14 ++
 drivers/net/wireless/ath/ath10k/core.h             |   5 +
 drivers/net/wireless/ath/ath10k/qmi.c              |  55 +------
 drivers/net/wireless/ath/ath10k/qmi.h              |   3 -
 drivers/net/wireless/ath/ath10k/snoc.c             | 170 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/snoc.h             |   7 +
 6 files changed, 200 insertions(+), 54 deletions(-)

-- 
2.7.4
