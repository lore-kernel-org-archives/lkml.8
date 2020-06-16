Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D69C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25472071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592324126;
	bh=BQIdZJeDOCE9WwM3JO92EX6gcXA+2swmmGH6Vio4rTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pJ+QN13+G8FPtMvTR9WsAxefdVCVPBZHl3UD5CQa4/hBUQK3mGX6fdtIEkqnCRzoo
	 y6MsfkbL3PcAeJx1NhQIuM6+cIY5lp3BDJ4lDgl/prLJH2gSOPnz6E2/VfCKxbS6NY
	 VscrxkNc/QriYbEtNllKPjNVBGFVbdeWgM2+QnQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbgFPPlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731493AbgFPPlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:41:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA0D21527;
        Tue, 16 Jun 2020 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322100;
        bh=BQIdZJeDOCE9WwM3JO92EX6gcXA+2swmmGH6Vio4rTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jtmJ0YBpTucN5eu3mSem1O34rQUaAXnjnKuhJ3Smv33+LNVd+JUlp+bW0dUWMpxN
         KX1GsfYr0rRGy6l1zbwsZ4Tk+VtVRm45tJOCiHJ4GKcVnqn5fKK2LL+9//vHLraniQ
         W4u0UHnSZMexuxZopEZU6pl+sPxV6FS+HSQheI/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sumit Saxena <sumit.saxena@broadcom.com>,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 110/134] scsi: megaraid_sas: TM command refire leads to controller firmware crash
Date:   Tue, 16 Jun 2020 17:34:54 +0200
Message-Id: <20200616153106.054546563@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Saxena <sumit.saxena@broadcom.com>

commit 6fd8525a70221c26823b1c7e912fb21f218fb0c5 upstream.

When TM command times out, driver invokes the controller reset. Post reset,
driver re-fires pended TM commands which leads to firmware crash.

Post controller reset, return pended TM commands back to OS.

Link: https://lore.kernel.org/r/20200508085242.23406-1-chandrakanth.patil@broadcom.com
Cc: stable@vger.kernel.org
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/megaraid/megaraid_sas_fusion.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -4227,6 +4227,7 @@ static void megasas_refire_mgmt_cmd(stru
 	struct fusion_context *fusion;
 	struct megasas_cmd *cmd_mfi;
 	union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc;
+	struct MPI2_RAID_SCSI_IO_REQUEST *scsi_io_req;
 	u16 smid;
 	bool refire_cmd = 0;
 	u8 result;
@@ -4284,6 +4285,11 @@ static void megasas_refire_mgmt_cmd(stru
 			break;
 		}
 
+		scsi_io_req = (struct MPI2_RAID_SCSI_IO_REQUEST *)
+				cmd_fusion->io_request;
+		if (scsi_io_req->Function == MPI2_FUNCTION_SCSI_TASK_MGMT)
+			result = RETURN_CMD;
+
 		switch (result) {
 		case REFIRE_CMD:
 			megasas_fire_cmd_fusion(instance, req_desc);
@@ -4481,7 +4487,6 @@ megasas_issue_tm(struct megasas_instance
 	if (!timeleft) {
 		dev_err(&instance->pdev->dev,
 			"task mgmt type 0x%x timed out\n", type);
-		cmd_mfi->flags |= DRV_DCMD_SKIP_REFIRE;
 		mutex_unlock(&instance->reset_mutex);
 		rc = megasas_reset_fusion(instance->host, MFI_IO_TIMEOUT_OCR);
 		mutex_lock(&instance->reset_mutex);


