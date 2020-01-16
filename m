Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C62DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0794320661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217591;
	bh=7B3kC7sDzXuUH5qWBiXhPresIrx+sW/BhdgmNTFIgas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ee3g2/9FwPPPm8SX9WWf441ysylNv2dYnijRmrYs081am1twEOv+2qW7arWak/Ncp
	 fhLRIkruryLpLIgcQ2rsKB0+3N8SGRGXF9+a1a4csGoGvhHXmz0sFC7JE7YBhCmqSi
	 rCrp4UxRnanpYp4EgTjZssKUInyqR+gYv8uQvEfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbgAPXdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404242AbgAPXdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:33:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C12120661;
        Thu, 16 Jan 2020 23:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217583;
        bh=7B3kC7sDzXuUH5qWBiXhPresIrx+sW/BhdgmNTFIgas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d0xPNxsIzEAoTWVA5e5jJk9y0sy3wAudLc5zChAaK1Y/nLSPrh8vwh+lGmbiHxRLX
         JiW9BdbhpvWBs9OLKlNzfDiJjlI3jPJKnMqRFYxXWg0M7fWrIKY618Ie+ena9fN10x
         vkiIiv4xqKBlGCMPLjxfAJ+jWj7p/KKJTGY8gMwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Honggang Li <honli@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 31/71] RDMA/srpt: Report the SCSI residual to the initiator
Date:   Fri, 17 Jan 2020 00:18:29 +0100
Message-Id: <20200116231714.057840834@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit e88982ad1bb12db699de96fbc07096359ef6176c upstream.

The code added by this patch is similar to the code that already exists in
ibmvscsis_determine_resid(). This patch has been tested by running the
following command:

strace sg_raw -r 1k /dev/sdb 12 00 00 00 60 00 -o inquiry.bin |&
    grep resid=

Link: https://lore.kernel.org/r/20191105214632.183302-1-bvanassche@acm.org
Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Honggang Li <honli@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srpt/ib_srpt.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1246,9 +1246,11 @@ static int srpt_build_cmd_rsp(struct srp
 			      struct srpt_send_ioctx *ioctx, u64 tag,
 			      int status)
 {
+	struct se_cmd *cmd = &ioctx->cmd;
 	struct srp_rsp *srp_rsp;
 	const u8 *sense_data;
 	int sense_data_len, max_sense_len;
+	u32 resid = cmd->residual_count;
 
 	/*
 	 * The lowest bit of all SAM-3 status codes is zero (see also
@@ -1270,6 +1272,28 @@ static int srpt_build_cmd_rsp(struct srp
 	srp_rsp->tag = tag;
 	srp_rsp->status = status;
 
+	if (cmd->se_cmd_flags & SCF_UNDERFLOW_BIT) {
+		if (cmd->data_direction == DMA_TO_DEVICE) {
+			/* residual data from an underflow write */
+			srp_rsp->flags = SRP_RSP_FLAG_DOUNDER;
+			srp_rsp->data_out_res_cnt = cpu_to_be32(resid);
+		} else if (cmd->data_direction == DMA_FROM_DEVICE) {
+			/* residual data from an underflow read */
+			srp_rsp->flags = SRP_RSP_FLAG_DIUNDER;
+			srp_rsp->data_in_res_cnt = cpu_to_be32(resid);
+		}
+	} else if (cmd->se_cmd_flags & SCF_OVERFLOW_BIT) {
+		if (cmd->data_direction == DMA_TO_DEVICE) {
+			/* residual data from an overflow write */
+			srp_rsp->flags = SRP_RSP_FLAG_DOOVER;
+			srp_rsp->data_out_res_cnt = cpu_to_be32(resid);
+		} else if (cmd->data_direction == DMA_FROM_DEVICE) {
+			/* residual data from an overflow read */
+			srp_rsp->flags = SRP_RSP_FLAG_DIOVER;
+			srp_rsp->data_in_res_cnt = cpu_to_be32(resid);
+		}
+	}
+
 	if (sense_data_len) {
 		BUILD_BUG_ON(MIN_MAX_RSP_SIZE <= sizeof(*srp_rsp));
 		max_sense_len = ch->max_ti_iu_len - sizeof(*srp_rsp);


