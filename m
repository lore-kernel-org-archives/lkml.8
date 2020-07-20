Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD6C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6076E22CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259565;
	bh=uUIeuthN7YjPK+Imy+UK5gSEQoybZoUj3NYqZ0gBz7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZlK8X2Z6fTN0uPX6Dm5wqM55SN+j/njj9YlkXMjpaAIkgd12ZMd3NMYVhlNr1qdi
	 VEr3zDqCmGV+bgbPwt6qZrI/fufDmqEAc+EdlOdLCgCG8aGQKo/57hDlo0ho2CyYN1
	 fuOh5vf98FBubaKed1Scq7UVOP+RByXkiSEzkUOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgGTPjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbgGTPjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12EE722CAF;
        Mon, 20 Jul 2020 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259556;
        bh=uUIeuthN7YjPK+Imy+UK5gSEQoybZoUj3NYqZ0gBz7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EsELlNiCQQCWjXaN9teY6xVdHS7T+GqTRttpRGwrbjwg7RTddq695Oo7VcHpjhf9r
         7ZAJadw2bZi6IJG54YP0zQbJqnP3rW09h74BlJuT2wuGCcdKx2JQ8iqwcidI8f/nhD
         es/rfQvxPGIQ5PsyOWFGLF2vK4IhwszoxiTrFDWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Pedersen <limero1337@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 52/58] Input: i8042 - add Lenovo XiaoXin Air 12 to i8042 nomux list
Date:   Mon, 20 Jul 2020 17:37:08 +0200
Message-Id: <20200720152749.865557209@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Pedersen <limero1337@gmail.com>

commit 17d51429da722cd8fc77a365a112f008abf4f8b3 upstream.

This fixes two finger trackpad scroll on the Lenovo XiaoXin Air 12.
Without nomux, the trackpad behaves as if only one finger is present and
moves the cursor when trying to scroll.

Signed-off-by: David Pedersen <limero1337@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200625133754.291325-1-limero1337@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -430,6 +430,13 @@ static const struct dmi_system_id __init
 		},
 	},
 	{
+		/* Lenovo XiaoXin Air 12 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
+		},
+	},
+	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),


