Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D360C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449BF21655
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607143;
	bh=s0u7lDLLVe++4Weesyk9XvhvqRchgRX/r1SYmiD7pWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zgXaNgOCkNtvb6b6wrSP7tmbKHu8M+RCcpvvYylYLQkvI+HDTrM4OLxE8dOg3t2jo
	 NFPH4dkY4i97DhzmWDvip7Gdb/eu6dY7ZGAtTmx9Eqvzfw++777tgwpqZbB93QOZKE
	 mVOM9CYsPE8s24r5bc89geBbW+zVMErGNz7cxfgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgDKMMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgDKMMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:12:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E0920787;
        Sat, 11 Apr 2020 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607136;
        bh=s0u7lDLLVe++4Weesyk9XvhvqRchgRX/r1SYmiD7pWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tp6x0WWthpBvUgUE0Vt34DQGhKv4sjeVKzgSwxfGbsniPe2RFMPJWamkUhsk+qTxJ
         3a1GOCnWXWgbQQecdi+JW3I1wgrWa91/SsYbeUEXElIUpNwvNbKNkp+DKCxqvz1J25
         jWQH9WjtCpex4vGOOkQO3nFDlgMxcZ1ReEDPDSS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 21/32] ASoC: jz4740-i2s: Fix divider written at incorrect offset in register
Date:   Sat, 11 Apr 2020 14:09:00 +0200
Message-Id: <20200411115421.513567057@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115418.455500023@linuxfoundation.org>
References: <20200411115418.455500023@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit 9401d5aa328e64617d87abd59af1c91cace4c3e4 upstream.

The 4-bit divider value was written at offset 8, while the jz4740
programming manual locates it at offset 0.

Fixes: 26b0aad80a86 ("ASoC: jz4740: Add dynamic sampling rate support to jz4740-i2s")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200306222931.39664-2-paul@crapouillou.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/jz4740/jz4740-i2s.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -92,7 +92,7 @@
 #define JZ_AIC_I2S_STATUS_BUSY BIT(2)
 
 #define JZ_AIC_CLK_DIV_MASK 0xf
-#define I2SDIV_DV_SHIFT 8
+#define I2SDIV_DV_SHIFT 0
 #define I2SDIV_DV_MASK (0xf << I2SDIV_DV_SHIFT)
 #define I2SDIV_IDV_SHIFT 8
 #define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)


