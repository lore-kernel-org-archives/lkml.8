Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526A5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B20820702
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222422;
	bh=A4VOQoF9dWI8S5tSrJ048hbisbbfIjDHmUMOCk3lkHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YWycVo7P4tOqvNZ5pdi45NS2mTr+cNXSe5abqP0V6S8C4/SnZWkoj8wWXd99zyWS+
	 Ho+Yix2wuwQUTMIka4H8xEnwOEb8JLST4j2UXThr83pLt+eCH/c7sWxoGoqau8cmzF
	 9zEiSS9AWqVS1aDpL2rAHGhnX2xhSbjrKimfxyPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgA1OPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgA1OPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:15:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF4822070E;
        Tue, 28 Jan 2020 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220950;
        bh=A4VOQoF9dWI8S5tSrJ048hbisbbfIjDHmUMOCk3lkHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIJV6RSAhOLNtrf0sb7c3S8qCNEFlBi9H9uOxByJ65ESJ0QSa9jDCRDmxRFgxQpGO
         hJ4DKzJDzM7Bh9WDci3NOUXUXFmgSNroklLtu9nhp8e3gyDWz9SQvrYyGTg0EA/Rh5
         cfuNR/32HHp+4AYdgDbDZdeoj9hnB19xmHmUfKyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kubakici@wp.pl>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 003/271] mt7601u: fix bbp version check in mt7601u_wait_bbp_ready
Date:   Tue, 28 Jan 2020 15:02:32 +0100
Message-Id: <20200128135852.655913475@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
 


