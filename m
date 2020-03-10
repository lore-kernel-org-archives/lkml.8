Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920CCC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6B724692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844863;
	bh=AayI18LkSJjxsRqW0wj91p+S39Sy+kfU3MHhJHUHFMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JUTu2MM77KY/4Y9YrEnq6VTKo+j+mYB/v52EIRbQGKDRVRIrBV8Fy/3NNOo5CMW4B
	 3CQZpSErgXfiNTRSzURNEl60m7L/gL84IWa0VV7HIJvx4yFwWCMrIG4BL+lALLFHVw
	 AoVjgkNF8tS5C+fC+vwwuXedDZnX8qvOB3HvTWhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgCJMyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbgCJMyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CA624692;
        Tue, 10 Mar 2020 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844860;
        bh=AayI18LkSJjxsRqW0wj91p+S39Sy+kfU3MHhJHUHFMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkcZzFbZLs8PAbN2BuVJyeZjDphfIU8xtWdUyKyGU7y2Ll5QRVFT/Ucri53J6ZJny
         lckzeVIqe8cOG4giBItTZw3N2zTVrLUjPmDSZv/yocOvQjG4MuGT4d7ZC2MwKOHUxN
         204sGD4v3Y6vSSBdQe1s3noziFPeE7xvvOWfCkZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 144/168] soc: imx-scu: Align imx sc msg structs to 4
Date:   Tue, 10 Mar 2020 13:39:50 +0100
Message-Id: <20200310123650.074277676@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit f10e58a5d20e1cf3a39a842da92c9dd0c3c23849 upstream.

The imx SC api strongly assumes that messages are composed out of
4-bytes words but some of our message structs have odd sizeofs.

This produces many oopses with CONFIG_KASAN=y.

Fix by marking with __aligned(4).

Fixes: 73feb4d0f8f1 ("soc: imx-scu: Add SoC UID(unique identifier) support")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/imx/soc-imx-scu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/imx/soc-imx-scu.c
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -25,7 +25,7 @@ struct imx_sc_msg_misc_get_soc_id {
 			u32 id;
 		} resp;
 	} data;
-} __packed;
+} __packed __aligned(4);
 
 struct imx_sc_msg_misc_get_soc_uid {
 	struct imx_sc_rpc_msg hdr;


