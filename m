Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A819C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058F020644
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586608141;
	bh=GqvXIaxjuuMVkWbvgmnDJJlqisLZZymgyjdUpE30ZoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mHHpPgg2snmCEG8bEWz1K2LK0CV03nof/Dwq7lHd45Vufhhvn1j3Nkm/16SL/UDoj
	 6Ba+3f3vFRxvO+SpA47iq6ndVLvK6qFlgUOA1sz2VxH/qYUVHFe2kbyQasaw3qYgN9
	 4YA4tWsDUECVaf7YlbyrfXadi/Xz5sX/Qfun6oVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgDKM27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgDKMLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:11:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A3A21744;
        Sat, 11 Apr 2020 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607099;
        bh=GqvXIaxjuuMVkWbvgmnDJJlqisLZZymgyjdUpE30ZoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6l+u8KzNhNmkrKe/Aezuj9XLGhrSp55ELTnKaUVXe4+eDFybXxb1VcfgrwLP/8sH
         8qPWWjAwaBG/3AWNcQdyEaix5ImHkxp6IRaLp9K4yfcuxAKwt5vi+bO9Bqi91p6Kzw
         4tkXXzKD/j4H9kZYy6byAsJrDnYzWfjeV9z6qFoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Nobuhiro Iwamatsu (CIP)" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.4 21/29] power: supply: axp288_charger: Fix unchecked return value
Date:   Sat, 11 Apr 2020 14:08:51 +0200
Message-Id: <20200411115411.408033079@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115407.651296755@linuxfoundation.org>
References: <20200411115407.651296755@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit c3422ad5f84a66739ec6a37251ca27638c85b6be upstream.

Currently there is no check on platform_get_irq() return value
in case it fails, hence never actually reporting any errors and
causing unexpected behavior when using such value as argument
for function regmap_irq_get_virq().

Fix this by adding a proper check, a message reporting any errors
and returning *pirq*

Addresses-Coverity-ID: 1443940 ("Improper use of negative value")
Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>

---
 drivers/power/axp288_charger.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/power/axp288_charger.c
+++ b/drivers/power/axp288_charger.c
@@ -883,6 +883,10 @@ static int axp288_charger_probe(struct p
 	/* Register charger interrupts */
 	for (i = 0; i < CHRG_INTR_END; i++) {
 		pirq = platform_get_irq(info->pdev, i);
+		if (pirq < 0) {
+			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
+			return pirq;
+		}
 		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
 		if (info->irq[i] < 0) {
 			dev_warn(&info->pdev->dev,


