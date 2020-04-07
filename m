Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B56C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1D820644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255334;
	bh=HqEmlzxufOwa6YagG4mTNMv27CCEvyFSPzld7zaEp8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j8BODz2xaiLKcxmgvnOjYnqAraxJVLo94xZNhfqFBvanhpo+vGRv+vxUyif5W0IDr
	 E+rk8+Ea6dlLJUPq2yNF3qPpvCRh1aJGql8qpWDGedqganesRqtHpXhq/+3TZTr7eM
	 /0eHsBt6J3/uy/ghVvRgTMtG09Xx1lRVGz7zOnww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgDGKYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbgDGKYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:24:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2D12083E;
        Tue,  7 Apr 2020 10:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255080;
        bh=HqEmlzxufOwa6YagG4mTNMv27CCEvyFSPzld7zaEp8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzM786Q/Cpo5EA+ytJnq5SdLYvmFSmYNzA0ZrbnUpSXxM0/Rb7Al0N4hJQG1pxkT8
         jLwrH3+e7GW1OljqnKfSyVMFmU2KYLnNtT/8kV0APt3g48xi8z6uDVD2fHnAnMNLpS
         Km0tYqhnAULC1kAs/2+TSnOIyX6z7yif8gaZBoV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 5.5 21/46] misc: rtsx: set correct pcr_ops for rts522A
Date:   Tue,  7 Apr 2020 12:21:52 +0200
Message-Id: <20200407101501.776964498@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101459.502593074@linuxfoundation.org>
References: <20200407101459.502593074@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 10cea23b6aae15e8324f4101d785687f2c514fe5 upstream.

rts522a should use rts522a_pcr_ops, which is
diffrent with rts5227 in phy/hw init setting.

Fixes: ce6a5acc9387 ("mfd: rtsx: Add support for rts522A")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200326032618.20472-1-yuehaibing@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/cardreader/rts5227.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -394,6 +394,7 @@ static const struct pcr_ops rts522a_pcr_
 void rts522a_init_params(struct rtsx_pcr *pcr)
 {
 	rts5227_init_params(pcr);
+	pcr->ops = &rts522a_pcr_ops;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 20, 11);
 	pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
 


