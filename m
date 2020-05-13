Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABF0C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2E220708
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="moFWeo0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgEMFKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:10:30 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:21111 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgEMFK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:10:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589346628; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DZQibOhxYLyG5G1VX6UfWA5/4+MXrMRUnbCNt7bbHJk=; b=moFWeo0B2nL97ecFDRa3ZihmQSwKhF9E/UBzpV2V8tJY0GFMlbaRt+n6W1OwuLoDbkZ1QQ+i
 3IC2Q2WVLgjcXCni9LGgYsW90DuHXbVVymg42GFO1GFe9bQF2ll1pIhxADTAdQ6NZabTVopt
 lN4HVYt2uRTAZ2rfcZr4f1K17IM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebb813e.7f33deb01420-smtp-out-n02;
 Wed, 13 May 2020 05:10:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80F38C432C2; Wed, 13 May 2020 05:10:22 +0000 (UTC)
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEC7EC433CB;
        Wed, 13 May 2020 05:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEC7EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V5 0/5] Add chrdev and name query support for GLINK
Date:   Wed, 13 May 2020 10:40:01 +0530
Message-Id: <1589346606-15046-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the GLINK rpmsg transport to register a rpmsg chrdev.
This will create the rpmsg_ctrl nodes for userspace clients to open 
rpmsg epts. The rpmsg chrdev allocation is done by allocating a local
channel which also allocates an ept. We need to add some guards against
edge cases for this chrdev because it will never fully open.

Changes since v4:
- Resending by removing approved patches

Changes since v3:
- Change to device_add_group for rpmsg name attr
- Add patch to unregister the rpmsg device
- Add patch to support compat ioctl for rpmsg char driver

Changes since v2:
- Revert change to make glink attribute table const

Changes since v1:
- Add explanation to dt-bindings commit message
- Add patch complete_all the open_req/ack variables
- Add patch to prevent null pointer dereference in chrdev channel release
- Change chrdev allocation to use glink channel allocation
- Change glink attr struct to const


Arun Kumar Neelakantam (1):
  rpmsg: glink: unregister rpmsg device during endpoint destroy

Chris Lew (4):
  rpmsg: glink: Use complete_all for open states
  rpmsg: Guard against null endpoint ops in destroy
  rpmsg: glink: Add support for rpmsg glink chrdev
  rpmsg: glink: Expose rpmsg name attr for glink

 drivers/rpmsg/qcom_glink_native.c | 79 +++++++++++++++++++++++++++++++++++++--
 drivers/rpmsg/rpmsg_core.c        |  2 +-
 2 files changed, 77 insertions(+), 4 deletions(-)

-- 
2.7.4
