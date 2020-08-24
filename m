Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CF8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88402177B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258300;
	bh=f3fVCrnyd6RLjHqgwPzYJEygHegsH91uj0rO+tkdHCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M67OGC9K7Y/KmOB+VlVo5n6WjWHah9qGHaa8ok4VLUdeuKeWGv2dg7skAf3T/D9wH
	 P595CrqY1jtdLvtDiZXX2JkxLh95ILtE+Ccsgbjq81mhOpTyE6DuEhD1b+P1/Ss8Pm
	 THckdfvfaM8XwtdtvAwK4b2RQXVFP4l4A6B58zKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHXIiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgHXIiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:38:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8D82177B;
        Mon, 24 Aug 2020 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258285;
        bh=f3fVCrnyd6RLjHqgwPzYJEygHegsH91uj0rO+tkdHCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9EFd6OXbTCstxHn2QifuczQRELL9YNBwBlW78gQGEWb0rigfWBn+e6A/LgSkK6Dp
         Km9RUVxujhXLirK2dJSrP5IT+nY+gmqXoJQMuEvs9Bwj+E26TiZ97wr1X22lZyQJyh
         W/BeN2IX78wrM+pR/YWKXZYUKr65gJCmyYwCON8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.8 142/148] EDAC/{i7core,sb,pnd2,skx}: Fix error event severity
Date:   Mon, 24 Aug 2020 10:30:40 +0200
Message-Id: <20200824082420.823306113@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
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
@@ -493,9 +493,9 @@ static void skx_mce_output_error(struct
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


