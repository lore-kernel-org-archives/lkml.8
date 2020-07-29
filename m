Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A91C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9721420838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596008666;
	bh=uisBrp03mBj+7I52p1yLCddU9KzH618rf8vZLEo8Blo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vrJ+UZ3snZIjISQC9vrRhUXQY27p0FsNLhT2D4oC/kIFax8eQAlaHFzStv3SO+lAE
	 nWCxWXk+rnS0U90ZB1IbXRcVNPURFW9iTGK8TWDsGYZiM4CeuxL1WF65z8/cI3rPQs
	 OAfuMto3Nu9dGJ4qvHeQjA5xxZBmWT+O4DEn4/p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgG2HoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2HoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:44:24 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241AA2084D;
        Wed, 29 Jul 2020 07:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596008663;
        bh=uisBrp03mBj+7I52p1yLCddU9KzH618rf8vZLEo8Blo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dph5wHjHRyz2edLmnKeCf7nt2rq2NGIOMLn8qX4MjQeY6VrRzSOGRu7fDOqUXe579
         nCSgXVpkOu/vImotkkdF+Xw7c95oEAsXN6b2o82pGQ486jz5kQKA1Vdsto0jCu89zW
         8+YcpSc66SljkuWLQmi1sMuEFYpB6HmvLRqnFNi4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] soc: qcom: smd-rpm: Fix kerneldoc
Date:   Wed, 29 Jul 2020 09:44:15 +0200
Message-Id: <20200729074415.28393-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729074415.28393-1-krzk@kernel.org>
References: <20200729074415.28393-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/soc/qcom/smd-rpm.c:35: warning: Function parameter or member 'dev' not described in 'qcom_smd_rpm'
    drivers/soc/qcom/smd-rpm.c:99: warning: Function parameter or member 'state' not described in 'qcom_rpm_smd_write'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/qcom/smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 877b13850730..1d4eb46b417a 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -20,6 +20,7 @@
  * struct qcom_smd_rpm - state of the rpm device driver
  * @rpm_channel:	reference to the smd channel
  * @icc:		interconnect proxy device
+ * @dev:		rpm device
  * @ack:		completion for acks
  * @lock:		mutual exclusion around the send/complete pair
  * @ack_status:		result of the rpm request
@@ -86,6 +87,7 @@ struct qcom_rpm_message {
 /**
  * qcom_rpm_smd_write - write @buf to @type:@id
  * @rpm:	rpm handle
+ * @state:	active/sleep state flags
  * @type:	resource type
  * @id:		resource identifier
  * @buf:	the data to be written
-- 
2.17.1

