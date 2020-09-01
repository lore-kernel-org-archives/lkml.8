Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778DDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A26206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979308;
	bh=0p65cccfP4lBE11HHV/k9lvfTWlftLTUIWY9epE+avk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MCucdtOBjJsrY6MgOeezxdedPoR/y7rx8WRu33sd6XfA88c1By6pj7QnbD8vXaFbB
	 XLwVkFvEf1xl4F5ejf0jxq9/iM2TxsxTYkzwptxhyyi4jHCeC4l3yPn0tDZq1lMTfD
	 cHn0dil1+Gd+dLMV2+ZMosBiAu2qNN29nF0zgHgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgIAQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbgIAPYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:24:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09D720BED;
        Tue,  1 Sep 2020 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973854;
        bh=0p65cccfP4lBE11HHV/k9lvfTWlftLTUIWY9epE+avk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAxzYAwIsB37r/o7Sj/Dn7r5oR/SF48TO1st03OeXbMl48moAv1oemzLjDz0sJF/P
         taiV6A+hxow4wiejBNatCX6u9L7wynUVg1uBuC9ihpafinzPDhIcrflb4MRHfJIY9o
         L6gNh/Toxc7ESApTIv6q+J2h1L+L6PlVswPPwTqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/125] scsi: qla2xxx: Check if FW supports MQ before enabling
Date:   Tue,  1 Sep 2020 17:10:29 +0200
Message-Id: <20200901150938.205407874@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

[ Upstream commit dffa11453313a115157b19021cc2e27ea98e624c ]

OS boot during Boot from SAN was stuck at dracut emergency shell after
enabling NVMe driver parameter. For non-MQ support the driver was enabling
MQ. Add a check to confirm if FW supports MQ.

Link: https://lore.kernel.org/r/20200806111014.28434-9-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index b56cf790587e5..e17ca7df8d0e4 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1997,6 +1997,11 @@ skip_pio:
 	/* Determine queue resources */
 	ha->max_req_queues = ha->max_rsp_queues = 1;
 	ha->msix_count = QLA_BASE_VECTORS;
+
+	/* Check if FW supports MQ or not */
+	if (!(ha->fw_attributes & BIT_6))
+		goto mqiobase_exit;
+
 	if (!ql2xmqsupport || !ql2xnvmeenable ||
 	    (!IS_QLA25XX(ha) && !IS_QLA81XX(ha)))
 		goto mqiobase_exit;
-- 
2.25.1



