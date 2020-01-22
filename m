Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C5FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A53F20678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699673;
	bh=rMJpW72a9e+MfLrCZdg2hQqhumhsVPzcIB18p64kLCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ML+UYYuWOuDatLgzv7rTug4uhumdYPy9L7464tir1e2tLIbZmZzcc5gsh46tH0aIu
	 y88AgerjJagwClupaTEsS5hIfjc1ARMV39GuAfS/rJF+CUE7B0WbmjMJlFadX8wPmB
	 SfYmn6S4k+nV09QTVt8ogrgI080KBbwlLpYaP+Qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbgAVN1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731806AbgAVN1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:27:48 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8AEE20678;
        Wed, 22 Jan 2020 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699668;
        bh=rMJpW72a9e+MfLrCZdg2hQqhumhsVPzcIB18p64kLCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F04G8oM/3SRN6vvlVStdbW5p+ji/m6k/O/sQNQHKDxDf2hnatoavWCHqqrm6Jk0s+
         de36taq7k5XhAsRhfj/wczd/OTR36t5Wr+23USp9o+5KQPy+okIkScg5Cw04S5S2gJ
         d7FQsTxB8uaR5ERrPWzbL29TqskB6Wp16x+gNw0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 213/222] scsi: lpfc: Fix a kernel warning triggered by lpfc_get_sgl_per_hdwq()
Date:   Wed, 22 Jan 2020 10:29:59 +0100
Message-Id: <20200122092848.944976380@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 765ab6cdac3b681952da0e22184bf6cf1ae41cf8 upstream.

Fix the following kernel bug report:

BUG: using smp_processor_id() in preemptible [00000000] code: systemd-udevd/954

Fixes: d79c9e9d4b3d ("scsi: lpfc: Support dynamic unbounded SGL lists on G7 hardware.")
Link: https://lore.kernel.org/r/20191107052158.25788-2-bvanassche@acm.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/lpfc/lpfc_sli.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20430,7 +20430,7 @@ lpfc_get_sgl_per_hdwq(struct lpfc_hba *p
 		/* allocate more */
 		spin_unlock_irqrestore(&hdwq->hdwq_lock, iflags);
 		tmp = kmalloc_node(sizeof(*tmp), GFP_ATOMIC,
-				   cpu_to_node(smp_processor_id()));
+				   cpu_to_node(raw_smp_processor_id()));
 		if (!tmp) {
 			lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 					"8353 error kmalloc memory for HDWQ "
@@ -20573,7 +20573,7 @@ lpfc_get_cmd_rsp_buf_per_hdwq(struct lpf
 		/* allocate more */
 		spin_unlock_irqrestore(&hdwq->hdwq_lock, iflags);
 		tmp = kmalloc_node(sizeof(*tmp), GFP_ATOMIC,
-				   cpu_to_node(smp_processor_id()));
+				   cpu_to_node(raw_smp_processor_id()));
 		if (!tmp) {
 			lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 					"8355 error kmalloc memory for HDWQ "


