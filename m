Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D221C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7252A20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203725;
	bh=khBvS0uP1wWlDBUJ8A67iqIDEyy0uCUR0NtvDKkd8bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oh3JdGErM/C/bSiqD1CjqQBPOE1heJjwy4fjPzKtLXMZTDRD1XjAzURgg2XCv08rN
	 10vDQvs+asFfY7+V6s2leYAHr+zgxJrEqtyIrg35bSDtM5kHnv/ifD7RHaQ1PKqRYP
	 AinVkr9AYdY7sPGFkdFgjsdZ6O3ypj8IFLz+lppU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgFOGsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3884420DD4;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=khBvS0uP1wWlDBUJ8A67iqIDEyy0uCUR0NtvDKkd8bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnqDtW1tjlsHFWCd31AlKsGZlrEV++BLd20BbRLNRJi+HQdzy3ZWDZFPCk86r/Vpq
         xfDsBsSDWiiglsj+nGTphvuimv+tSKvJO62PJ677SIlbXgCrLUb40rnuB0+x077xmR
         TBkfzIjpriYC2sCm92H2P+7Cq6vV50VoVUYs37UE=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009nnf-4Y; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 23/29] docs: ABI: fix a typo when pointing to w1-generic.rst
Date:   Mon, 15 Jun 2020 08:47:02 +0200
Message-Id: <8dd4b4a23d51d4e255321857b72b94fe9cd1e6be.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo there:

	w1_generic.rst -> w1-generic.rst

Causing the document reference to point to the wrong place.

Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-w1_therm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 076659d506f2..9b488c0afdfa 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -8,7 +8,7 @@ Description:
 		to device min/max capabilities. Values are integer as they are
 		stored in a 8bit register in the device. Lowest value is
 		automatically put to TL. Once set, alarms could be search at
-		master level, refer to Documentation/w1/w1_generic.rst for
+		master level, refer to Documentation/w1/w1-generic.rst for
 		detailed information
 Users:		any user space application which wants to communicate with
 		w1_term device
-- 
2.26.2

