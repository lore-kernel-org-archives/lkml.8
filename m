Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D10C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FACA2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255183;
	bh=HqEmlzxufOwa6YagG4mTNMv27CCEvyFSPzld7zaEp8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cmD6j80B5k8+Z88XTp5cwGHt1Y38spUUR4XWaEhKdFawyCbgyHxv80yb5lACuPRSm
	 w6t/PsCfvTmiANDKjJ9wwmjHIKwlLSH6qs7201tipq5hv0emFLRRYtAIQNbNC1VTfr
	 w4ZMrE+Wrsy0buHDcm7h3TY3mBnhWAvuHkrnpo7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgDGK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgDGK0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:26:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D2B20644;
        Tue,  7 Apr 2020 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255178;
        bh=HqEmlzxufOwa6YagG4mTNMv27CCEvyFSPzld7zaEp8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTjzTp7Jc+Ml7yEiE98yPFTQiSJCQTp+t0cORw+Z+Ggu7gJ1eJao9ZFDKNaUVkNPX
         +mw3ajeqYC8QeJcg/A55F4WVY+SrXHL/iw0H648YBbRqKONR/3O7sNXn1Wd9ldhPcy
         ER2sEzMJonhKuAplEObjL+9sKcJEoymQGduTY1vU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 5.6 15/29] misc: rtsx: set correct pcr_ops for rts522A
Date:   Tue,  7 Apr 2020 12:22:12 +0200
Message-Id: <20200407101453.850101538@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101452.046058399@linuxfoundation.org>
References: <20200407101452.046058399@linuxfoundation.org>
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
 


