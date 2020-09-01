Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B26CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5ED208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977618;
	bh=oQD0mEIsmXocGaiBEYTuH4ifCk0o/+jHnrYlvKhgxZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LLmBMBsvBBn/pxwZ/H+5rkny+onepMnQxW6o77+L9W1uh8kq33goyOsRwZnNCgtva
	 CMc8/SImViC5jRERSUeEX6pdihRQEQKIdQ7riX4eywBBbixBfOQm5pX0yVfkHVT8UV
	 1k/oPAjCeTenGPr0P5VdEDoZGrjFuc3yfQ8SEloo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgIAQ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbgIAPcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED02E20866;
        Tue,  1 Sep 2020 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974325;
        bh=oQD0mEIsmXocGaiBEYTuH4ifCk0o/+jHnrYlvKhgxZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wT/0GhSFxBA9oC/hz1KqHjAqRzdWz0ZhuOThlH3e5oPJiv5mla3hJRNkwfl7ON0wh
         t/IUIX5ASkqVF382wKAH/I5ol2Jn55YEeKtow5cTrB45JYWtV25GslDRePemrEMDIT
         EyQZdvb8YVRjmI4rrO3xUEMndqBMes2Xjnp7eG6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 092/214] EDAC/{i7core,sb,pnd2,skx}: Fix error event severity
Date:   Tue,  1 Sep 2020 17:09:32 +0200
Message-Id: <20200901150957.398269550@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 45bc6098a3e279d8e391d22428396687562797e2 ]

IA32_MCG_STATUS.RIPV indicates whether the return RIP value pushed onto
the stack as part of machine check delivery is valid or not.

Various drivers copied a code fragment that uses the RIPV bit to
determine the severity of the error as either HW_EVENT_ERR_UNCORRECTED
or HW_EVENT_ERR_FATAL, but this check is reversed (marking errors where
RIPV is set as "FATAL").

Reverse the tests so that the error is marked fatal when RIPV is not set.

Reported-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20200707194324.14884-1-tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/i7core_edac.c | 4 ++--
 drivers/edac/pnd2_edac.c   | 2 +-
 drivers/edac/sb_edac.c     | 4 ++--
 drivers/edac/skx_common.c  | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index a71cca6eeb333..6be7e65f7389d 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1711,9 +1711,9 @@ static void i7core_mce_output_error(struct mem_ctl_info *mci,
 	if (uncorrected_error) {
 		core_err_cnt = 1;
 		if (ripv)
-			tp_event = HW_EVENT_ERR_FATAL;
-		else
 			tp_event = HW_EVENT_ERR_UNCORRECTED;
+		else
+			tp_event = HW_EVENT_ERR_FATAL;
 	} else {
 		tp_event = HW_EVENT_ERR_CORRECTED;
 	}
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index b1193be1ef1d8..dac45e2071b3f 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1155,7 +1155,7 @@ static void pnd2_mce_output_error(struct mem_ctl_info *mci, const struct mce *m,
 	u32 optypenum = GET_BITFIELD(m->status, 4, 6);
 	int rc;
 
-	tp_event = uc_err ? (ripv ? HW_EVENT_ERR_FATAL : HW_EVENT_ERR_UNCORRECTED) :
+	tp_event = uc_err ? (ripv ? HW_EVENT_ERR_UNCORRECTED : HW_EVENT_ERR_FATAL) :
 						 HW_EVENT_ERR_CORRECTED;
 
 	/*
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index a2fd39d330d67..b557a53c75c46 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -2982,9 +2982,9 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	if (uncorrected_error) {
 		core_err_cnt = 1;
 		if (ripv) {
-			tp_event = HW_EVENT_ERR_FATAL;
-		} else {
 			tp_event = HW_EVENT_ERR_UNCORRECTED;
+		} else {
+			tp_event = HW_EVENT_ERR_FATAL;
 		}
 	} else {
 		tp_event = HW_EVENT_ERR_CORRECTED;
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 4ca87723dcdcd..99dea4f66b5e9 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -490,9 +490,9 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 	if (uncorrected_error) {
 		core_err_cnt = 1;
 		if (ripv) {
-			tp_event = HW_EVENT_ERR_FATAL;
-		} else {
 			tp_event = HW_EVENT_ERR_UNCORRECTED;
+		} else {
+			tp_event = HW_EVENT_ERR_FATAL;
 		}
 	} else {
 		tp_event = HW_EVENT_ERR_CORRECTED;
-- 
2.25.1



