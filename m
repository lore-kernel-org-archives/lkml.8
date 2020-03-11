Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B7C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AAE215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGaA0U9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgCKBZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:25:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40749 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgCKBZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:25:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so568870qka.7;
        Tue, 10 Mar 2020 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Fukjl9q8moe8CzDk64XDMos63vCyfonbgEhEiAaGvw=;
        b=DGaA0U9LZTxFDk9p+UrQTc+2w6FbZ2lAa1NdcuJN6FekMurcJUwLjEEAb30LZopenF
         IhQQqBpDgZ/B1xli5AROa0jXmEJRoFr02uu/7E/l3xzQdINShRX0rY6vlr8pNZDUEmu+
         lZCOyQ6Kz/rqCIq9UC4KZUNXRnvLdwhb/ShruKQrjpmEkIk64zxarVhNYPB8QfGuhQbZ
         CjR6OS8+dQFdIojetGmZej1ArM7tpp/ZT+eMwCO3FmHKjNmgyu5Rw9LxF4HyEAniCgn6
         mTeiCpXNH5mPFpBF7eBXIVTPfqKTUi1t2aq8/UoyLMzwd6IBCM1Z2+ivahWqzXIk+6i+
         P65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Fukjl9q8moe8CzDk64XDMos63vCyfonbgEhEiAaGvw=;
        b=nVj0kCpDDPARGcIpklskZoaiRn0MjAeIrJGKjiUI7VMl0bh0A6iBh5RJxrcvhAOBsI
         iykG/kFWoGX4NwUk+aRbsGQxcdIg43jnY7pDoQQGX35ICKd0zg7OLMGjUeYQEa3yHP4t
         CQpDUr9IJVSGF3gI7w+qNRhvKJ0U0Be9Sj4BwGTw76qE4WXRLWX7/fzYxdaO33sQ4MoC
         nZn9JNWlTfbYCiyIbOsUWn384bySSzhR9/ql2UPXQpKrwWX7D47qEBlxDdldV/hUU2Jj
         dWOjokX+qnK66xzQqBt6Wc17sQQ+kRknGpBTr9eFxm1ECxbIp3lFR9crbgGA5R7X6NcZ
         cRIw==
X-Gm-Message-State: ANhLgQ1od9qkiFT0SJZqaL3Dl5pfxMIXSU5EdO5MPu2/1i2fnuEYao5L
        A5nsD9wlqwbPoC6p3lB3eS0=
X-Google-Smtp-Source: ADFU+vtwivKOZ8x2mrkiVtdyMruWBJg75D32INLdZIi72P50DVRuj9bAjvMTNxFmNm86LOt8++lszQ==
X-Received: by 2002:ae9:f504:: with SMTP id o4mr611927qkg.306.1583889941922;
        Tue, 10 Mar 2020 18:25:41 -0700 (PDT)
Received: from 73ec49dbc856.ic.unicamp.br (wifi-177-220-84-29.wifi.ic.unicamp.br. [177.220.84.29])
        by smtp.gmail.com with ESMTPSA id i66sm4618570qkc.13.2020.03.10.18.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 18:25:41 -0700 (PDT)
From:   Marcio Albano <marcio.ahf@gmail.com>
To:     gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: fbtft: Remove prohibited spaces before ')'
Date:   Wed, 11 Mar 2020 01:25:33 +0000
Message-Id: <20200311012533.26167-1-marcio.ahf@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch errors:

"ERROR: space prohibited before that close parenthesis ')'"
in fbtft-bus.c:65 and fbtft-bus.c:67.

Signed-off-by: Marcio Albano <marcio.ahf@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 63c65dd67..847cbfbbd 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.20.1

