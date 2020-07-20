Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27CDC433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EA92064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260323;
	bh=CiWAgRrFMF6AkD5NScixcAhor2EXs7j+HVkZRczmRzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rb9F3z5vEaMc+s8nr2z/RcHQMOInL8VWBQ17p2XHrnSBfZP3cx5hDVBXEBt07mRPS
	 5Hysvx0Inks948JXAuEV8PYQmBGsz9rCs8JrTqo4suSpaex22SmkFaIuUYSA8QpKWR
	 UuJaXf8RYyqbM2Mz2J9r2Q03ZwVlNeUDkemh+i8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbgGTPwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbgGTPv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:51:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B578722D00;
        Mon, 20 Jul 2020 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260319;
        bh=CiWAgRrFMF6AkD5NScixcAhor2EXs7j+HVkZRczmRzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koVZ9omFAaD5WzC+WLgcqE9rat2tT/zmJOpZT/Vu4U2yB1PixJONGz5TprdrdbjkI
         TJgIMxnfU+osE5DNkSEEb+5BMuVxEOMbipkYeYxGysAIp3PsyLlxKyfw7VDPTB5kOZ
         ItpcPasIDBAcnGcrY2owH6PjyAMsWjxIrXl0mxQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/133] phy: sun4i-usb: fix dereference of pointer phy0 before it is null checked
Date:   Mon, 20 Jul 2020 17:36:46 +0200
Message-Id: <20200720152806.580399911@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 38b1927e5bf9bcad4a2e33189ef1c5569f9599ba ]

Currently pointer phy0 is being dereferenced via the assignment of
phy on the call to phy_get_drvdata before phy0 is null checked, this
can lead to a null pointer dereference. Fix this by performing the
null check on phy0 before the call to phy_get_drvdata. Also replace
the phy0 == NULL check with the more usual !phy0 idiom.

Addresses-Coverity: ("Dereference before null check")
Fixes: e6f32efb1b12 ("phy: sun4i-usb: Make sure to disable PHY0 passby for peripheral mode")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200625124428.83564-1-colin.king@canonical.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 1f8809bab002c..920f61eff9cd4 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -550,13 +550,14 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	struct sun4i_usb_phy_data *data =
 		container_of(work, struct sun4i_usb_phy_data, detect.work);
 	struct phy *phy0 = data->phys[0].phy;
-	struct sun4i_usb_phy *phy = phy_get_drvdata(phy0);
+	struct sun4i_usb_phy *phy;
 	bool force_session_end, id_notify = false, vbus_notify = false;
 	int id_det, vbus_det;
 
-	if (phy0 == NULL)
+	if (!phy0)
 		return;
 
+	phy = phy_get_drvdata(phy0);
 	id_det = sun4i_usb_phy0_get_id_det(data);
 	vbus_det = sun4i_usb_phy0_get_vbus_det(data);
 
-- 
2.25.1



