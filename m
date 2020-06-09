Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817E2206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726969;
	bh=L99taIM+omKw6xpLci/GzbwOu6gRvGvUPFTqXy6EsDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KjtjgZpoeH7+QasHz+IJBfmU3S2eFFfm085IfliPrRvYB8nCU4H1zt7DCAk5lMIsw
	 Zy6GdQeXdameTFMj9mmUlCKqcYBioma82GsmyxQPLZfxtyBjbncARJJZLaaf7+2G1p
	 /WiTxU4ZDEvHXQs6TzShD9aYLb4ASl8k486zhOx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbgFISWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732212AbgFIRsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:48:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D5F207F9;
        Tue,  9 Jun 2020 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724883;
        bh=L99taIM+omKw6xpLci/GzbwOu6gRvGvUPFTqXy6EsDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09hjy3maDUW6fBMjwjHJLi0y+SfOjlsDmm8SvCAUkAmoNtB5dd7lqABoX84vCc/51
         vw0CIJKTfvZXG+tzOL8vxLgaNU+WjdwQsR/JYVYb1eABr7qm6x46j9OCeTnzamLWsS
         tiWpfN8Jg/SAbafr5RQ77QImqLBpf2xZlrLFf56U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
        Can Guo <cang@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.9 20/42] scsi: ufs: Release clock if DMA map fails
Date:   Tue,  9 Jun 2020 19:44:26 +0200
Message-Id: <20200609174017.670122929@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174015.379493548@linuxfoundation.org>
References: <20200609174015.379493548@linuxfoundation.org>
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
@@ -1512,6 +1512,7 @@ static int ufshcd_queuecommand(struct Sc
 
 	err = ufshcd_map_sg(hba, lrbp);
 	if (err) {
+		ufshcd_release(hba);
 		lrbp->cmd = NULL;
 		clear_bit_unlock(tag, &hba->lrb_in_use);
 		goto out;


