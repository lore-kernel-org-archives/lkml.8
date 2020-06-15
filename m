Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A652C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16CB2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DyV8XvSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgFOH6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:58:37 -0400
Received: from www.zeus03.de ([194.117.254.33]:49210 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgFOH6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=yWGeIQMB5D8pAO
        0LP5T88hiOoA5j2pcFLVejSajzQPc=; b=DyV8XvSEKw9fiteLuo6hRnnAfgG9gD
        vLWIh2CXAeSXS1UmpnaYV11Hh2oukO7EbnVllnIKgy2AlfX91BcMQpFWDjj6V1MM
        R7NqDxdrYnaP/JQ+3Akz3wwpE+4uc43prWQcr69MzjJ2+8cuUvVajuP4eXmjaGVs
        hn7Vw4zjXXkr8=
Received: (qmail 989221 invoked from network); 15 Jun 2020 09:58:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Jun 2020 09:58:28 +0200
X-UD-Smtp-Session: l3s3148p1@4KfPyhqoDLYgAwDPXwRdAFnN6pRlEuNX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] x86/platform/intel-mid: convert to use i2c_new_client_device()
Date:   Mon, 15 Jun 2020 09:58:12 +0200
Message-Id: <20200615075816.2848-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
References: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

I'd like to push it via I2C for 5.8-rc2.

 arch/x86/platform/intel-mid/sfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/intel-mid/sfi.c b/arch/x86/platform/intel-mid/sfi.c
index b8f7f193f383..30bd5714a3d4 100644
--- a/arch/x86/platform/intel-mid/sfi.c
+++ b/arch/x86/platform/intel-mid/sfi.c
@@ -287,8 +287,8 @@ void intel_scu_devices_create(void)
 
 		adapter = i2c_get_adapter(i2c_bus[i]);
 		if (adapter) {
-			client = i2c_new_device(adapter, i2c_devs[i]);
-			if (!client)
+			client = i2c_new_client_device(adapter, i2c_devs[i]);
+			if (IS_ERR(client))
 				pr_err("can't create i2c device %s\n",
 					i2c_devs[i]->type);
 		} else
-- 
2.27.0

