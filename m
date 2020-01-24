Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62761C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C94C214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858611;
	bh=A4VOQoF9dWI8S5tSrJ048hbisbbfIjDHmUMOCk3lkHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tDOg1O6bwnYyUIX4ayhS6LKADuQVM1TDuDlLYd72cZU7TVkBCnBSHX9xQdaTRJeHX
	 qYJd36gfJO2LMx2bwBaez29JO7Tqy32VJKfgrsSEFHPqKxq4TBH6CXHFdxbYu3M+7j
	 3vFduBR9xLbJSkOVF3sQybT/LskeT1B33B6XeEfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgAXJgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAXJgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:36:50 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14D0A2087E;
        Fri, 24 Jan 2020 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858609;
        bh=A4VOQoF9dWI8S5tSrJ048hbisbbfIjDHmUMOCk3lkHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5OkEeuDv0bOftGzHB4BYBvatX19xscPK34FVJmK7ebR2bB05Pgod1T6i8fGpFPX8
         K3IMPm1gevWZQ02DWarZ+0sZzFsQV1Tzrr7wV/L1g3VcxlHzUlVrl8jJu/hM+vgsKt
         0yDJbC7g4+j8SwmwOWmCR2PueW81MtDN6/VASNWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kubakici@wp.pl>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 005/343] mt7601u: fix bbp version check in mt7601u_wait_bbp_ready
Date:   Fri, 24 Jan 2020 10:27:03 +0100
Message-Id: <20200124092920.259665009@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

commit 15e14f76f85f4f0eab3b8146e1cd3c58ce272823 upstream.

Fix bbp ready check in mt7601u_wait_bbp_ready. The issue is reported by
coverity with the following error:

Logical vs. bitwise operator
The expression's value does not depend on the operands; inadvertent use
of the wrong operator is a likely logic error.

Addresses-Coverity-ID: 1309441 ("Logical vs. bitwise operator")
Fixes: c869f77d6abb ("add mt7601u driver")
Acked-by: Jakub Kicinski <kubakici@wp.pl>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt7601u/phy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mediatek/mt7601u/phy.c
+++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
@@ -221,7 +221,7 @@ int mt7601u_wait_bbp_ready(struct mt7601
 
 	do {
 		val = mt7601u_bbp_rr(dev, MT_BBP_REG_VERSION);
-		if (val && ~val)
+		if (val && val != 0xff)
 			break;
 	} while (--i);
 


