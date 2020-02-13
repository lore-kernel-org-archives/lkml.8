Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DCBC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C3320661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608593;
	bh=JlPOFG2Dfl0ScRZaq+loHRP1Q0SDK9iFvbCKI1AeBV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MpAY83NikOcFOdGTwcuXhqvFSW6QVtGGSEb75PBEZfpS6idKOb/NLizqrMuzvhHSQ
	 ZohmDKThNyfdPhTyrnrhlRAbJH/LOgKQn4gpSx6L9DctQ+8qbH+T0JDrmU9i28+Wy/
	 YR346exX+aRHoy5EtPUmWe3qQzwqMPxcyj0RIe7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgBMPnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbgBMP2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:00 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E56F24677;
        Thu, 13 Feb 2020 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607680;
        bh=JlPOFG2Dfl0ScRZaq+loHRP1Q0SDK9iFvbCKI1AeBV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYoyb+cf0qrxqL8kC4nRacuN2hulHYjy3kkiK31VDRZkPkO9iTpsCaLIyw+o/NgMH
         b0Sr09Bh9sR9dnwPR3d9vDBWXi76q/p7oVTcOoKnOkskvSOceOTTvrTpwby5CZz5ME
         AE6XOJuMvPOlHBOHPvbO9fldOST7oyZ5v0TxuSXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Gorenko <sergeygo@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.5 002/120] IB/srp: Never use immediate data if it is disabled by a user
Date:   Thu, 13 Feb 2020 07:19:58 -0800
Message-Id: <20200213151901.999623265@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Gorenko <sergeygo@mellanox.com>

commit 0fbb37dd82998b5c83355997b3bdba2806968ac7 upstream.

Some SRP targets that do not support specification SRP-2, put the garbage
to the reserved bits of the SRP login response.  The problem was not
detected for a long time because the SRP initiator ignored those bits. But
now one of them is used as SRP_LOGIN_RSP_IMMED_SUPP. And it causes a
critical error on the target when the initiator sends immediate data.

The ib_srp module has a use_imm_date parameter to enable or disable
immediate data manually. But it does not help in the above case, because
use_imm_date is ignored at handling the SRP login response. The problem is
definitely caused by a bug on the target side, but the initiator's
behavior also does not look correct.  The initiator should not use
immediate data if use_imm_date is disabled by a user.

This commit adds an additional checking of use_imm_date at the handling of
SRP login response to avoid unexpected use of immediate data.

Fixes: 882981f4a411 ("RDMA/srp: Add support for immediate data")
Link: https://lore.kernel.org/r/20200115133055.30232-1-sergeygo@mellanox.com
Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srp/ib_srp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2546,7 +2546,8 @@ static void srp_cm_rep_handler(struct ib
 	if (lrsp->opcode == SRP_LOGIN_RSP) {
 		ch->max_ti_iu_len = be32_to_cpu(lrsp->max_ti_iu_len);
 		ch->req_lim       = be32_to_cpu(lrsp->req_lim_delta);
-		ch->use_imm_data  = lrsp->rsp_flags & SRP_LOGIN_RSP_IMMED_SUPP;
+		ch->use_imm_data  = srp_use_imm_data &&
+			(lrsp->rsp_flags & SRP_LOGIN_RSP_IMMED_SUPP);
 		ch->max_it_iu_len = srp_max_it_iu_len(target->cmd_sg_cnt,
 						      ch->use_imm_data,
 						      target->max_it_iu_size);


