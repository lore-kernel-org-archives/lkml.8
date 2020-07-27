Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4885C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994542073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859246;
	bh=pNZ5dqteI6Mnoc1TUKncTKofJ2ZiWdSCFdqSL3JX16o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1s1rdeY2OuIRvRVF/OK08OLLSg0dQft7MZB4nlidJ46pKD4aM8BrsBqehwGSXqXHD
	 CCeEN+hLeiqwF7kinuuCzGhxWpXHji88tK7Qg4I5WNb+5e/P5Yn4F79q+icBOn4Hft
	 GfPKqXtmNrfvtG6oJavjqYtFTnxzTw8wWn1ocxHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgG0OOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgG0OOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:14:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843562073E;
        Mon, 27 Jul 2020 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859243;
        bh=pNZ5dqteI6Mnoc1TUKncTKofJ2ZiWdSCFdqSL3JX16o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDFTlHwuAqtWfi/ywMeXmM0/urCNb8cdKtz/hyQltM3uQGvMeTAn82YDV0xRHOCuF
         /cxx9EXgkK3Ev4K3gllyIe8mG6PTza8ZTi6iGcFdT3Uz8xuwe8Os9zt7D91T/v8I74
         Kx6ogiW2ktxE8dPO3MTqQJj/9U3Tlb8rvSYeVDZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 032/138] ASoC: rt5670: Correct RT5670_LDO_SEL_MASK
Date:   Mon, 27 Jul 2020 16:03:47 +0200
Message-Id: <20200727134926.981403633@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
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
@@ -757,7 +757,7 @@
 #define RT5670_PWR_VREF2_BIT			4
 #define RT5670_PWR_FV2				(0x1 << 3)
 #define RT5670_PWR_FV2_BIT			3
-#define RT5670_LDO_SEL_MASK			(0x3)
+#define RT5670_LDO_SEL_MASK			(0x7)
 #define RT5670_LDO_SEL_SFT			0
 
 /* Power Management for Analog 2 (0x64) */


