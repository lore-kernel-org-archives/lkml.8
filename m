Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116F82071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262223;
	bh=Nv0ZlxUL9h0hYla9KnlDJLL4zcpnRj1q4g8kfSDWpuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7zZaKqj7/9Us3aCOFzzqgYofBemKa9+xPQfx7EpUK4K0OTJIsuxmvveg7AES1paT
	 mJ2NEjRMmS/WA1kxc1cUDxeYQvXqV5jDooyxWfqyg538gLyx+JrIcWJ092FnKtO5nj
	 13V66GCVpet8Z+HqBVodok+etPc2O3KCUFj0q8PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgHXJnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgHXIoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:44:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2C421741;
        Mon, 24 Aug 2020 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258641;
        bh=Nv0ZlxUL9h0hYla9KnlDJLL4zcpnRj1q4g8kfSDWpuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgIwuFPc/KxpnnUwTiKqRNrVMeWVZrfssQhE4vtg0XGTMNuM19OwrbbljrH3pMFNC
         5/Gr933s/kuuFdNZ9bgxorU7xUNbx+e7GcYncO1SzUoaphb59ahg/r/1q4Wg2ThExv
         j9FNMBx4Vbi4RmLhge435pi5E1JCfLvCd0ZPbikk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.7 118/124] EDAC/{i7core,sb,pnd2,skx}: Fix error event severity
Date:   Mon, 24 Aug 2020 10:30:52 +0200
Message-Id: <20200824082415.209791272@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

commit 45bc6098a3e279d8e391d22428396687562797e2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/i7core_edac.c |    4 ++--
 drivers/edac/pnd2_edac.c   |    2 +-
 drivers/edac/sb_edac.c     |    4 ++--
 drivers/edac/skx_common.c  |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1710,9 +1710,9 @@ static void i7core_mce_output_error(stru
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
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1155,7 +1155,7 @@ static void pnd2_mce_output_error(struct
 	u32 optypenum = GET_BITFIELD(m->status, 4, 6);
 	int rc;
 
-	tp_event = uc_err ? (ripv ? HW_EVENT_ERR_FATAL : HW_EVENT_ERR_UNCORRECTED) :
+	tp_event = uc_err ? (ripv ? HW_EVENT_ERR_UNCORRECTED : HW_EVENT_ERR_FATAL) :
 						 HW_EVENT_ERR_CORRECTED;
 
 	/*
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -2982,9 +2982,9 @@ static void sbridge_mce_output_error(str
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
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -494,9 +494,9 @@ static void skx_mce_output_error(struct
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


