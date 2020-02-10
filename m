Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB1AC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E076620661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338629;
	bh=GwZdwREzGE9MPLKTYsn7DObTxaT5mDCtNNqqyD94k+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cbku4ymbAIYOJEuxrufXMlkHkU6ujZAwKXw4PPITy3sTeDan+ZOZKEGiOUzERKzSo
	 J6vA5n9I7ynmI4HR8PypcDsmLFvF57EB9nE9OJ3MtdbxSxz4XIReLJB5tvYonBJVKr
	 oTnKchxNhs9qJZqNmZU1MoXjfP8tmk+n7Y7iPhoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgBJMns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbgBJMkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:08 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE2120842;
        Mon, 10 Feb 2020 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338408;
        bh=GwZdwREzGE9MPLKTYsn7DObTxaT5mDCtNNqqyD94k+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igWQLZEC0jdldBjvKiIskR5zONHfjoaP4wlms3OrSPc39eewrnjknKPXxM/vsL3ab
         UPlKoUyod0bhi82WzY0wNeIT+++9iykKSMW0oTInwSkuLHbJMJ/hgkd5R8z/kVNUje
         D3uvw0gIZZDys3ZIKhzuzpQBYdFmdkAx+aYO/dLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.5 112/367] nvmem: imx: scu: fix write SIP
Date:   Mon, 10 Feb 2020 04:30:25 -0800
Message-Id: <20200210122434.896078564@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 40bb95dbb8acca35f8d52a833393ddbb01cfa2db upstream.

SIP number 0xC200000A is for reading, 0xC200000B is for writing.
And the following two args for write are word index, data to write.

Fixes: 885ce72a09d0 ("nvmem: imx: scu: support write")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200109104017.6249-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvmem/imx-ocotp-scu.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -15,8 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#define IMX_SIP_OTP			0xC200000A
-#define IMX_SIP_OTP_WRITE		0x2
+#define IMX_SIP_OTP_WRITE		0xc200000B
 
 enum ocotp_devtype {
 	IMX8QXP,
@@ -212,8 +211,7 @@ static int imx_scu_ocotp_write(void *con
 
 	mutex_lock(&scu_ocotp_mutex);
 
-	arm_smccc_smc(IMX_SIP_OTP, IMX_SIP_OTP_WRITE, index, *buf,
-		      0, 0, 0, 0, &res);
+	arm_smccc_smc(IMX_SIP_OTP_WRITE, index, *buf, 0, 0, 0, 0, 0, &res);
 
 	mutex_unlock(&scu_ocotp_mutex);
 


