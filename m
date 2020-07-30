Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5C62074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097140;
	bh=391sbRHYpWgc8awcde+J3xrFm3+48hwdU8hDC9WLgas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ORbQEzj228CcoaBb+sDnyWsOo6bJI1cOiqlfwq9Ms+F0j4i+rYXlKztK+edijxU9O
	 roGdh4His2h2+3412qGZ6EMF4qlkADLJn1H8yop+/iMGiFxu0JVklgZvzlkH5Q7gE5
	 WJXZK6vd2cVqeIt8irYeV/0MDesaAEV5tWhUWyMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgG3IS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgG3IIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:08:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86AE62074B;
        Thu, 30 Jul 2020 08:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096502;
        bh=391sbRHYpWgc8awcde+J3xrFm3+48hwdU8hDC9WLgas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfyj2NxwqziDzE451Fyc81eqAvu9+wJqReLzPV6k18bT9oznzfcr1TGpOqgfx2B25
         xwPSmhNLvFPEOvL85yKL1CS6/q5jnfyZDfwSUiDb9y69tiS124YZBEL+M7tndlPYug
         g+XtOGs9CJMOeLdaF86yRnSka0F6E0SMKwoxDcas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 12/61] ASoC: rt5670: Correct RT5670_LDO_SEL_MASK
Date:   Thu, 30 Jul 2020 10:04:30 +0200
Message-Id: <20200730074421.413390352@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.811058810@linuxfoundation.org>
References: <20200730074420.811058810@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 5cacc6f5764e94fa753b2c1f5f7f1f3f74286e82 upstream.

The RT5670_PWR_ANLG1 register has 3 bits to select the LDO voltage,
so the correct mask is 0x7 not 0x3.

Because of this wrong mask we were programming the ldo bits
to a setting of binary 001 (0x05 & 0x03) instead of binary 101
when moving to SND_SOC_BIAS_PREPARE.

According to the datasheet 001 is a reserved value, so no idea
what it did, since the driver was working fine before I guess we
got lucky and it does something which is ok.

Fixes: 5e8351de740d ("ASoC: add RT5670 CODEC driver")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200628155231.71089-3-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/rt5670.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -760,7 +760,7 @@
 #define RT5670_PWR_VREF2_BIT			4
 #define RT5670_PWR_FV2				(0x1 << 3)
 #define RT5670_PWR_FV2_BIT			3
-#define RT5670_LDO_SEL_MASK			(0x3)
+#define RT5670_LDO_SEL_MASK			(0x7)
 #define RT5670_LDO_SEL_SFT			0
 
 /* Power Management for Analog 2 (0x64) */


