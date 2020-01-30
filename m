Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C98C214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410177;
	bh=BG0m2GrDH4m2acE7FgUelvrKxWuUu7u18RQMU/Mm3Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xh+Wxh3TQ9bfNEnSIQ+DreGei833sPzAWHf9zvucaR8GnJLSpseLLXczLhIxlRh3q
	 MTP48gWmsrTlI0einAE/olVU7xjGg1bbT2Cy64IQwbJ5oSXiDnlGOwWmnGSaCBecN3
	 8CRbm+V1DB4ocW37LmLtcSQmw0GM++OzPJ4BLQfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgA3SsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731488AbgA3SsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:48:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9123A2082E;
        Thu, 30 Jan 2020 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410087;
        bh=BG0m2GrDH4m2acE7FgUelvrKxWuUu7u18RQMU/Mm3Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnAYCJ4Iu90alqCQ4AesaaRJmPYQCWZFR8T/LsYH/X2LNUVwWbrmNckW3KJy7IaYZ
         ZcYtCP7oR9NMaHwsUfGxr5THMVkRUMaopzV4slfljBJ+Eg8xlZlVcnrEtUiSpgdrAH
         mv3WuCfL0XI4Gq9hHpi51cihxVhLvXDjr4TDIipQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 40/55] HID: steam: Fix input device disappearing
Date:   Thu, 30 Jan 2020 19:39:21 +0100
Message-Id: <20200130183615.719491608@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>

[ Upstream commit 20eee6e5af35d9586774e80b6e0b1850e7cc9899 ]

The `connected` value for wired devices was not properly initialized,
it must be set to `true` upon creation, because wired devices do not
generate connection events.

When a raw client (the Steam Client) uses the device, the input device
is destroyed. Then, when the raw client finishes, it must be recreated.
But since the `connected` variable was false this never happended.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-steam.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 8dae0f9b819e0..6286204d4c560 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -768,8 +768,12 @@ static int steam_probe(struct hid_device *hdev,
 
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver connected");
+		/* If using a wireless adaptor ask for connection status */
+		steam->connected = false;
 		steam_request_conn_status(steam);
 	} else {
+		/* A wired connection is always present */
+		steam->connected = true;
 		ret = steam_register(steam);
 		if (ret) {
 			hid_err(hdev,
-- 
2.20.1



