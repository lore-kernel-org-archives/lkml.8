Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCEC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A98A21927
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747789;
	bh=ss7Ch1X+1y2bjXhIPfs5CMbSa5TXR6pSfvlg/0M9wrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Unk+t14bojKlr5iAGTCy4Pda2CbbyuQ6R5C5d5XsseZME0b24Km4+QAJDqVoSmTyY
	 PGBIROPCNLz7QpuYtynKytPM16DAgo1oWBTwuZeBJJgXERE8EJ2uqWqJ3320KX+rCb
	 sqNQ9huANJEPU/yki/sWd8qBBdX3/wdzqZn5m/Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgBCQg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgBCQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:36:25 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0376A20CC7;
        Mon,  3 Feb 2020 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747785;
        bh=ss7Ch1X+1y2bjXhIPfs5CMbSa5TXR6pSfvlg/0M9wrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3mT76CfbVjsf9iQPuM/oYn2/Ap5foFFIpnq/VpERa2fBQRCJyrmkrc+hmqccCbmb
         1jOKQNmOQ89XxUh54bRpfmZddVtGAs7dP+uocygiRIjUchK7t12L5yZJlWGxY6512w
         8gp9/0yXBLcUSHuzxyq0hHLHiyYGGvZq4f4od5xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 70/90] Input: max77650-onkey - add of_match table
Date:   Mon,  3 Feb 2020 16:20:13 +0000
Message-Id: <20200203161925.971200751@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[ Upstream commit ce535a2efb48d8d4c4e4b97e2764d7cee73d9b55 ]

We need the of_match table if we want to use the compatible string in
the pmic's child node and get the onkey driver loaded automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/max77650-onkey.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/max77650-onkey.c b/drivers/input/misc/max77650-onkey.c
index 4d875f2ac13d6..ee55f22dbca54 100644
--- a/drivers/input/misc/max77650-onkey.c
+++ b/drivers/input/misc/max77650-onkey.c
@@ -108,9 +108,16 @@ static int max77650_onkey_probe(struct platform_device *pdev)
 	return input_register_device(onkey->input);
 }
 
+static const struct of_device_id max77650_onkey_of_match[] = {
+	{ .compatible = "maxim,max77650-onkey" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77650_onkey_of_match);
+
 static struct platform_driver max77650_onkey_driver = {
 	.driver = {
 		.name = "max77650-onkey",
+		.of_match_table = max77650_onkey_of_match,
 	},
 	.probe = max77650_onkey_probe,
 };
-- 
2.20.1



