Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16FC33CBA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A789F22522
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195239;
	bh=LkVTKsYdHJfdDmmYPdoTfDPNzo2Cyo3Ys6rmxdoBcPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjoZdjdAdGZeAVDN/w4orUxL0mVFySr9tTNVFgJ46HlA38PLPngI6UT1JxoRoKFO7
	 ywpbGEgfzxjlyfDLWXDliiPl1ONxtEgq4XDNcddc3N9oVr2bx9EEJrvQfeLLycL366
	 yCUGaWkFi28mx5WgZGsQwJzT7L/lW6Wr9k7iAXYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391353AbgAPRSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:18:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391292AbgAPRRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:17:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531FD246AF;
        Thu, 16 Jan 2020 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195072;
        bh=LkVTKsYdHJfdDmmYPdoTfDPNzo2Cyo3Ys6rmxdoBcPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PycV3U/JYG06UbsAUCcQHNTJP0V1I7fztaTw+O+I87suysZerD0enRyebygbXUNOD
         bmENc1/ZYkwrHFePqgBwzDpYJ6lQjQsWpd6WHUDB9K6mauxwvjXyFUlxHImcWJiunW
         +mQFCEi51j5KGAYAFgbkrmKtReYZKhXLQNyux3UU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 024/371] pinctrl: sh-pfc: r8a7740: Add missing REF125CK pin to gether_gmii group
Date:   Thu, 16 Jan 2020 12:11:32 -0500
Message-Id: <20200116171719.16965-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116171719.16965-1-sashal@kernel.org>
References: <20200116171719.16965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1ebc589a7786f17f97b9e87b44e0fb4d0290d8f8 ]

The gether_gmii_mux[] array contains the REF125CK pin mark, but the
gether_gmii_pins[] array lacks the corresponding pin number.

Fixes: bae11d30d0cafdc5 ("sh-pfc: r8a7740: Add GETHER pin groups and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 35f436bcb849..d8077065636e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1982,7 +1982,7 @@ static const unsigned int gether_gmii_pins[] = {
 	 */
 	185, 186, 187, 188, 189, 190, 191, 192, 174, 161, 204,
 	171, 170, 169, 168, 167, 166, 173, 172, 176, 184, 183, 203,
-	205, 163, 206, 207,
+	205, 163, 206, 207, 158,
 };
 static const unsigned int gether_gmii_mux[] = {
 	ET_ERXD0_MARK, ET_ERXD1_MARK, ET_ERXD2_MARK, ET_ERXD3_MARK,
-- 
2.20.1

