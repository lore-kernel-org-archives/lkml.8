Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C11C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9594D2067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591727009;
	bh=UEtBzpPRnMXXcvZPch0gwKgleya4B+tA/veCfsBObmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snIkk3JRQcpQKJpAh/WQEbwed0jPuP/wJppI+5Sm5fg+XMfLrF0SwpPjf5SQuYR85
	 SJOxCa3ADEQMcFHE0XETLmpnGuhEqc4GyckVyAUnbl/esLeuzje4S3P24etkcoOiOH
	 Yny7HNH+rz9JJ796Jfta9ZkJK7zEQYoLk2U1mzRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbgFISX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732105AbgFIRr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:47:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D7B207F9;
        Tue,  9 Jun 2020 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724849;
        bh=UEtBzpPRnMXXcvZPch0gwKgleya4B+tA/veCfsBObmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cg/wCYhBtWcK/0xuA6lTAjssqmzLsue+TgOh4bSFXvBBXaMO4jZ+Kl2DVMFTrnhcO
         75NLkAfBzYaPs9gAx/s23lEoAzJ1fO9YG6vTXbO4tKseQxDj/i4V/ABgho54/Cgerk
         H/bTKGq5TxGAzzm4gh1go9z+251K8fNv4Xsfffdw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
        Can Guo <cang@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.4 18/36] scsi: ufs: Release clock if DMA map fails
Date:   Tue,  9 Jun 2020 19:44:18 +0200
Message-Id: <20200609173934.332037261@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

commit 17c7d35f141ef6158076adf3338f115f64fcf760 upstream.

In queuecommand path, if DMA map fails, it bails out with clock held.  In
this case, release the clock to keep its usage paired.

[mkp: applied by hand]

Link: https://lore.kernel.org/r/0101016ed3d66395-1b7e7fce-b74d-42ca-a88a-4db78b795d3b-000000@us-west-2.amazonses.com
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[EB: resolved cherry-pick conflict caused by newer kernels not having
 the clear_bit_unlock() line]
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1374,6 +1374,7 @@ static int ufshcd_queuecommand(struct Sc
 	ufshcd_compose_upiu(hba, lrbp);
 	err = ufshcd_map_sg(lrbp);
 	if (err) {
+		ufshcd_release(hba);
 		lrbp->cmd = NULL;
 		clear_bit_unlock(tag, &hba->lrb_in_use);
 		goto out;


