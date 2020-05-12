Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1F9C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F72320731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ0l+rzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgELVpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731065AbgELVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:45:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EF8C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:45:42 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z25so11772467otq.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IYUiXiaNBsBZM0iKcHk24e5/fD/U7T1sgmMQxqdI2oM=;
        b=FZ0l+rzzvY68A2zj75Zjc2uCZNGx9Nm07CgzXCbuOsN/VmdEp2Dy7665CJhIXVxlR1
         S1e/6FqwhzlVKp4mcXpSi+RUjuwE2QeKtSa96x6C6Xa5RA2spGApisbeSwSHRlrtNEx9
         gIesQySCWLjNXrG9kKvN5zTpqB7nAwuQ+3We5EBukRSq/RQMCl4Hf7n2cu5KFrYJUI+n
         1vSBExC5Q5jO5seY64Ep8G3xT4qLaSWhb0O99RtEfHtnKef8CHWOKMGHWQcYlR64twd1
         oolDvFrzeEXZX8hFjBrkAZgn98X3tvpg7EUpoqMKOi2D8qzJOx0Fe2PbOmL6ckX7kbDC
         cttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=IYUiXiaNBsBZM0iKcHk24e5/fD/U7T1sgmMQxqdI2oM=;
        b=OEesOzvy1tDiIWXCXCoG6zsWXbFTB9rCebbSP48nHLyMDzaL1xtJhNLo6KBQdmky32
         Y+353YDODQ99oo9G9KH4R0Rvd4niIaCR/Qj8o72HDv+O2hS7HB7yzUDqLEeNzA/nWQh2
         DvL95EXhj8RdOMBglI4hRTBuJXlRs1y0n2p/7UOdeFzNjWwQUwh3+L71IqDWm8XDGnjL
         u07E5i8yhoz3mBUiho8tNLZajND8ukUtqXSbatt6xT2385QNo1kSMkLvFFbs75Hq7zBd
         dFoeMZuRM2edvvI2uRq53n/8Q3e9aSQMjsULdxSKU9ex2ZdT/Efh4q2EJnAris9fmEeb
         o/fw==
X-Gm-Message-State: AGi0PuZX4g52Ow/5DucvRlmkZdem8k3DeuQ645sSLe768jOJzBe6DTMq
        d8Ojp+YUw03sl8Sg/iUlqw==
X-Google-Smtp-Source: APiQypIZndupecq/vOBzka0g47mBSQ6VZVYzrX+GcUnwFEwKBIoSzgu/MiKU8yydf78/zT7X/JUETg==
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr17945553otp.294.1589319942164;
        Tue, 12 May 2020 14:45:42 -0700 (PDT)
Received: from serve.minyard.net ([47.184.149.130])
        by smtp.gmail.com with ESMTPSA id r11sm5547491oib.47.2020.05.12.14.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:45:41 -0700 (PDT)
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPA id F3794180051;
        Tue, 12 May 2020 21:45:39 +0000 (UTC)
From:   minyard@acm.org
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] char: ipmi: convert to use i2c_new_client_device()
Date:   Tue, 12 May 2020 16:45:32 -0500
Message-Id: <20200512214532.14117-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326210958.13051-2-wsa+renesas@sang-engineering.com>
References: <20200326210958.13051-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Move away from the deprecated API.

Based on a patch by Wolfram Sang <wsa+renesas@sang-engineering.com>.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I think this works.

 drivers/char/ipmi/ipmi_ssif.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index b7145f370d3b..65563e5e5731 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1943,12 +1943,14 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 static int ssif_adapter_handler(struct device *adev, void *opaque)
 {
 	struct ssif_addr_info *addr_info = opaque;
+	struct i2c_client *cl;
 
 	if (adev->type != &i2c_adapter_type)
 		return 0;
 
-	addr_info->added_client = i2c_new_device(to_i2c_adapter(adev),
-						 &addr_info->binfo);
+	cl = i2c_new_client_device(to_i2c_adapter(adev), &addr_info->binfo);
+	if (!IS_ERR(cl))
+		addr_info->added_client = cl;
 
 	if (!addr_info->adapter_name)
 		return 1; /* Only try the first I2C adapter by default. */
-- 
2.17.1

