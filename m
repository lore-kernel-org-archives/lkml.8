Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC8C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8641820842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737787;
	bh=4YON9OFRZy1HzvpVfNd2cG2zRP0S16fccsztPMSe2kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q9CRpGNkpLjvH+KiQyEAgZaRxG4B5FCNc+Hgb7EUXMhPETF9G9g2hLNm8w/vAYQ+J
	 AXOuFfuOIYww5uUSffrCIZqNZ91w7DLwcL4sG1SMqlf/0kWbBxwuk/FKwJWCkixJZ7
	 L9q23MJqRFm99xB23WEq41L/a2RI5T9mDY1mtITA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgAKKQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:16:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbgAKKQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:16:16 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D0A6205F4;
        Sat, 11 Jan 2020 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737776;
        bh=4YON9OFRZy1HzvpVfNd2cG2zRP0S16fccsztPMSe2kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNPQvX4dyjtkdvCDRB+Lv22eH4ftza52cqsoTqThlp3Aqj/2UHhVJbAR733iMV6zA
         U5ZO6RdB9Bmxr4Cdcw6Ar4v6KFgBtl8QO4C+uuNHzOC5Yof7NFfDpY6ofZPXzIIfL5
         3pw9iW7pr8ZpjDL/1dvqWvdPXnLPH4AcIGTwa4pY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 43/84] regulator: rn5t618: fix module aliases
Date:   Sat, 11 Jan 2020 10:50:20 +0100
Message-Id: <20200111094902.630805516@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 62a1923cc8fe095912e6213ed5de27abbf1de77e ]

platform device aliases were missing, preventing
autoloading of module.

Fixes: 811b700630ff ("regulator: rn5t618: add driver for Ricoh RN5T618 regulators")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://lore.kernel.org/r/20191211221600.29438-1-andreas@kemnade.info
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/rn5t618-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index 790a4a73ea2c..40b74648bd31 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -154,6 +154,7 @@ static struct platform_driver rn5t618_regulator_driver = {
 
 module_platform_driver(rn5t618_regulator_driver);
 
+MODULE_ALIAS("platform:rn5t618-regulator");
 MODULE_AUTHOR("Beniamino Galvani <b.galvani@gmail.com>");
 MODULE_DESCRIPTION("RN5T618 regulator driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1



