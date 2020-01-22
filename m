Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C655C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EDC2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686678;
	bh=e36sjmPaCPPq1/i9Ltj188SqoWa1clYoefAn7mPbTaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5JsLhilYED8d+naDWl10GoKYNJ/Lft1348GSKh+Bl0gQEPKDpK0NKovaKDQMV2v7
	 8N5m/tY46Qr01gqPE/at+BX7AcIYgpSp7BBOIQ3yZSqW5jP8ujfMqNA9XZGV8akvqM
	 K3hY73WQai/yyOf00gjgChvD03au+GV6trGpjz00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbgAVJhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbgAVJhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:37:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA94B20704;
        Wed, 22 Jan 2020 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685838;
        bh=e36sjmPaCPPq1/i9Ltj188SqoWa1clYoefAn7mPbTaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnooiozVxhXCo1UufbsRlPfFwYeyU55shawV9ouqAKrO8cK6KkK/Js9iA0o19hIxY
         CCLqdFSrbobyfiwu2JsmoIADk1MNjZAY4+NItxVJbMGKyooM2bNq33usXF6dH3mo6c
         UiVvQj1IN35qS2nsBer6ESgjjRNKgy0JR+alTvAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 93/97] scsi: bnx2i: fix potential use after free
Date:   Wed, 22 Jan 2020 10:29:37 +0100
Message-Id: <20200122092811.014730379@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

commit 29d28f2b8d3736ac61c28ef7e20fda63795b74d9 upstream.

The member hba->pcidev may be used after its reference is dropped. Move the
put function to where it is never used to avoid potential use after free
issues.

Fixes: a77171806515 ("[SCSI] bnx2i: Removed the reference to the netdev->base_addr")
Link: https://lore.kernel.org/r/1573043541-19126-1-git-send-email-bianpan2016@163.com
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/bnx2i/bnx2i_iscsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -915,12 +915,12 @@ void bnx2i_free_hba(struct bnx2i_hba *hb
 	INIT_LIST_HEAD(&hba->ep_ofld_list);
 	INIT_LIST_HEAD(&hba->ep_active_list);
 	INIT_LIST_HEAD(&hba->ep_destroy_list);
-	pci_dev_put(hba->pcidev);
 
 	if (hba->regview) {
 		pci_iounmap(hba->pcidev, hba->regview);
 		hba->regview = NULL;
 	}
+	pci_dev_put(hba->pcidev);
 	bnx2i_free_mp_bdt(hba);
 	bnx2i_release_free_cid_que(hba);
 	iscsi_host_free(shost);


