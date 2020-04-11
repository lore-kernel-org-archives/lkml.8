Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F81C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAA12051A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647790;
	bh=pUt5lpDgGxoy7XzYt9wec0y/SdJ1EdBeAIyJGVOl62I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VoFgbVtQgo/K4/NCAMbXCyXC4LEPFZJnCf9EQHBZ8RnTyY64zjMq3IpC2titBGzQU
	 V57DqXJa7HokgEmy6D3Cn7pIQhcdU4/DAmFlLceSbjpjB0WLnWZF7c2cCG7ztzconm
	 sLn+RqDobeP380bfyGnU0s7eutQnY8ToiGy6pSQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgDKX3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbgDKXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:10:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DAB22166E;
        Sat, 11 Apr 2020 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646653;
        bh=pUt5lpDgGxoy7XzYt9wec0y/SdJ1EdBeAIyJGVOl62I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2pDYOxwDQZAUAC/SgL3G+5QRquuWLzgzkjmwhivukAvTdgPc1ZB7X5zZ39R+fM7t
         u3YQQllp5AGvKZPVoA7uU74BMfO7H7TeRkT45c1+NzBxu5YiDdrrYV9wr/K84R2/8h
         cEYIpgCAiiomoarw0xJ7qqNdv6w6QAM1lpRO0+Kc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 056/108] scsi: lpfc: Fix RQ buffer leakage when no IOCBs available
Date:   Sat, 11 Apr 2020 19:08:51 -0400
Message-Id: <20200411230943.24951-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 39c4f1a965a9244c3ba60695e8ff8da065ec6ac4 ]

The driver is occasionally seeing the following SLI Port error, requiring
reset and reinit:

 Port Status Event: ... error 1=0x52004a01, error 2=0x218

The failure means an RQ timeout. That is, the adapter had received
asynchronous receive frames, ran out of buffer slots to place the frames,
and the driver did not replenish the buffer slots before a timeout
occurred. The driver should not be so slow in replenishing buffers that a
timeout can occur.

When the driver received all the frames of a sequence, it allocates an IOCB
to put the frames in. In a situation where there was no IOCB available for
the frame of a sequence, the RQ buffer corresponding to the first frame of
the sequence was not returned to the FW. Eventually, with enough traffic
encountering the situation, the timeout occurred.

Fix by releasing the buffer back to firmware whenever there is no IOCB for
the first frame.

[mkp: typo]

Link: https://lore.kernel.org/r/20200128002312.16346-2-jsmart2021@gmail.com
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index e2cec1f6e659b..acd151f99c786 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -17711,6 +17711,10 @@ lpfc_prep_seq(struct lpfc_vport *vport, struct hbq_dmabuf *seq_dmabuf)
 			list_add_tail(&iocbq->list, &first_iocbq->list);
 		}
 	}
+	/* Free the sequence's header buffer */
+	if (!first_iocbq)
+		lpfc_in_buf_free(vport->phba, &seq_dmabuf->dbuf);
+
 	return first_iocbq;
 }
 
-- 
2.20.1

