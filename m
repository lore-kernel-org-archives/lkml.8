Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B66C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EADC2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624353;
	bh=3FrZdYvpqhFybQqlRH77rhrJ/OHxk2sMndBLGH2KYyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FvyHiCRaoKsZB73fvczeky8LOaaKUt4N2Lrrjz5F5TazyStrOter7Br3sWWN1gM+V
	 YNZZ+pZWm21PgrfIZzP4k+VeyhrDplQo7yvR9KEcTPgB8L3Hp6TF5N6g1+4QMhx2GO
	 fUCDY2H+nPguxjCWzqOOH9jrPAboP/8aoot0AklM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgCSNZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730229AbgCSNZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:25:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260222080C;
        Thu, 19 Mar 2020 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624348;
        bh=3FrZdYvpqhFybQqlRH77rhrJ/OHxk2sMndBLGH2KYyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsO1JosLthVC4K5VCURVnt4bq4Wu3lc0N/VA5FAwTO7Q1yByusVhtidJFzWk1lLna
         ozyPCbQnq13G3TxeEKjPqS6eI3vICFkE5P0yLEhGTFMOcjxGrGHAANiIftd/T45gNJ
         PWQL6MqDtfaaIs73vkahKEzl6v4CNRM5x109gyfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 12/65] HID: i2c-hid: add Trekstor Surfbook E11B to descriptor override
Date:   Thu, 19 Mar 2020 14:03:54 +0100
Message-Id: <20200319123930.165718974@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit be0aba826c4a6ba5929def1962a90d6127871969 ]

The Surfbook E11B uses the SIPODEV SP1064 touchpad, which does not supply
descriptors, so it has to be added to the override list.

BugLink: https://bugs.launchpad.net/bugs/1858299
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index d31ea82b84c17..a66f08041a1aa 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -341,6 +341,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "Trekstor SURFBOOK E11B",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "SURFBOOK E11B"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{
 		.ident = "Direkt-Tek DTLAPY116-2",
 		.matches = {
-- 
2.20.1



