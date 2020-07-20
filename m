Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F6C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A4020684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262023;
	bh=5rB47IRt3w2v7qDHOt4FBAEYDoNAJuxs7BoOZJzslfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yAhkw4sKEcjH2AG4HB78MqhX8XV8h8SOlPtX5fdeHTFJ9lagso9Zoz3q9vhWn71FI
	 4KQxhLukk/4r21cqDOt6qtHzkpYWm4vCgWZSQWx1Hx3q2SaBzsICwFZdcM3NXIoOHh
	 1I0OcjRG7Jl2/Fx7oQE2Q28jnOfE+Ijhy+txT1OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbgGTQUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387635AbgGTQKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC2E20734;
        Mon, 20 Jul 2020 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261411;
        bh=5rB47IRt3w2v7qDHOt4FBAEYDoNAJuxs7BoOZJzslfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxGn2nVQpuvB3mDeNxMeDuNcMfzxvEtTaGJ7XSCwD6BQwIFC3vRQKzRVOP030hVG7
         H0nQY6EsoTgtzYhuyvKgmsZbZhSH+/8lukQawG5NvT/pCvY2RRxXwaT+cZi2aHjTjU
         D5hgT/0NNCJ9vsaSFLWODRKJ5cp4COn1zhdEAq/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Andi Shyti <andi@etezian.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 076/244] Input: mms114 - add extra compatible for mms345l
Date:   Mon, 20 Jul 2020 17:35:47 +0200
Message-Id: <20200720152829.455502986@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 7842087b0196d674ed877d768de8f2a34d7fdc53 ]

MMS345L is another first generation touch screen from Melfas,
which uses mostly the same registers as MMS152.

However, there is some garbage printed during initialization.
Apparently MMS345L does not have the MMS152_COMPAT_GROUP register
that is read+printed during initialization.

  TSP FW Rev: bootloader 0x6 / core 0x26 / config 0x26, Compat group: \x06

On earlier kernel versions the compat group was actually printed as
an ASCII control character, seems like it gets escaped now.

But we probably shouldn't print something from a random register.

Add a separate "melfas,mms345l" compatible that avoids reading
from the MMS152_COMPAT_GROUP register. This might also help in case
there is some other device-specific quirk in the future.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Andi Shyti <andi@etezian.org>
Link: https://lore.kernel.org/r/20200423102431.2715-1-stephan@gerhold.net
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/mms114.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 2ef1adaed9afb..5bdf4ac1a3033 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -54,6 +54,7 @@
 enum mms_type {
 	TYPE_MMS114	= 114,
 	TYPE_MMS152	= 152,
+	TYPE_MMS345L	= 345,
 };
 
 struct mms114_data {
@@ -250,6 +251,15 @@ static int mms114_get_version(struct mms114_data *data)
 	int error;
 
 	switch (data->type) {
+	case TYPE_MMS345L:
+		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
+		if (error)
+			return error;
+
+		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x\n",
+			 buf[0], buf[1], buf[2]);
+		break;
+
 	case TYPE_MMS152:
 		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
 		if (error)
@@ -287,8 +297,8 @@ static int mms114_setup_regs(struct mms114_data *data)
 	if (error < 0)
 		return error;
 
-	/* MMS152 has no configuration or power on registers */
-	if (data->type == TYPE_MMS152)
+	/* Only MMS114 has configuration and power on registers */
+	if (data->type != TYPE_MMS114)
 		return 0;
 
 	error = mms114_set_active(data, true);
@@ -597,6 +607,9 @@ static const struct of_device_id mms114_dt_match[] = {
 	}, {
 		.compatible = "melfas,mms152",
 		.data = (void *)TYPE_MMS152,
+	}, {
+		.compatible = "melfas,mms345l",
+		.data = (void *)TYPE_MMS345L,
 	},
 	{ }
 };
-- 
2.25.1



