Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C16C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D29A2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261657;
	bh=4vriX5B70DVSBvzKafRh6krsUhLdhbdqiDlIJdAuMwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RDeRfFpVxhLcA1yk3NYhaOz4UtLE1Mmq8AnhHu9J0gs44tRKL0SKEkJfpXY3XyOG+
	 thNJD2bZExUlGy72dZfPNNn4zxgutftyu+/EYyYi6LndG0sltnzXAP2YVW2M3altKy
	 i40Ezptgoam1pvl9WBo6s9lrNx//Yiy+zDxRN5Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbgGTQOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388229AbgGTQON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:14:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5292064B;
        Mon, 20 Jul 2020 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261653;
        bh=4vriX5B70DVSBvzKafRh6krsUhLdhbdqiDlIJdAuMwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzPh5nFq+3sPnII/OS/8y3oAW1ULWImMItjRkg0B9xPhLY2+Fwufv9yH87n9v4bDI
         FzcDtbDG/e9x2q2nBTbJIFxrWcqx+reLHG1ACx6juoX85OfaraBpk1A7J9k7KIfAMi
         9HwWLT+/s5FVu0U1un2N3m46Fi++y5LUdDLwRfXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.7 193/244] scsi: megaraid_sas: Remove undefined ENABLE_IRQ_POLL macro
Date:   Mon, 20 Jul 2020 17:37:44 +0200
Message-Id: <20200720152835.023086054@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chandrakanth Patil <chandrakanth.patil@broadcom.com>

commit 07d3f04550023395bbf34b99ec7e00fc50d9859f upstream.

As the ENABLE_IRQ_POLL macro is undefined, the check for ENABLE_IRQ_POLL
macro in ISR will always be false. This leads to irq polling being
non-functional.

Remove ENABLE_IRQ_POLL check from ISR.

Link: https://lore.kernel.org/r/20200715120153.20512-1-chandrakanth.patil@broadcom.com
Fixes: a6ffd5bf6819 ("scsi: megaraid_sas: Call disable_irq from process IRQ")
Cc: <stable@vger.kernel.org> # v5.3+
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/megaraid/megaraid_sas_fusion.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3797,10 +3797,8 @@ static irqreturn_t megasas_isr_fusion(in
 	if (instance->mask_interrupts)
 		return IRQ_NONE;
 
-#if defined(ENABLE_IRQ_POLL)
 	if (irq_context->irq_poll_scheduled)
 		return IRQ_HANDLED;
-#endif
 
 	if (!instance->msix_vectors) {
 		mfiStatus = instance->instancet->clear_intr(instance);


