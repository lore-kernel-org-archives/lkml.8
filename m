Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7892C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F627207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926994;
	bh=HMeLencfP79QnOTHpQu9SCQ8crUYfKYEweeJFlkvMmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BAgUFQgcQoQ8PYP3b21eoGKC+7/EP1EGlk31XKuT6y8Eb5G0UZhaa3QTl/ykY5ssQ
	 VnyV0gcNE7okGUp74Q+PzkbW+NvwTiGD4t7/0PYkO0fStVDuD4k/ua4xfTrDmv2xrO
	 KSjo/A4rpEV1s1GN+jS16BEj+xEViE68RP6PKE34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgHTMgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbgHTJsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:48:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B642920724;
        Thu, 20 Aug 2020 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916881;
        bh=HMeLencfP79QnOTHpQu9SCQ8crUYfKYEweeJFlkvMmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KN8+3S08a+x+eKuhIhepzWwCoYdBmZIPEwn0ZuNcmEH+Q/iaJAxUOlb89pAIWCfR+
         8beqa/zS44ZHAIgKZUVbniMSgEkwuRuwWQiu4l1wGkz3Ihu/qJ4kfm12vETyUCk2LN
         GL9m4q3yWjf0lDyxvFHaITYszgefC9SgbZlN7BQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.4 050/152] MIPS: qi_lb60: Fix routing to audio amplifier
Date:   Thu, 20 Aug 2020 11:20:17 +0200
Message-Id: <20200820091556.268336106@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit 0889a67a9e7a56ba39af223d536630b20b877fda upstream.

The ROUT (right channel output of audio codec) was connected to INL
(left channel of audio amplifier) instead of INR (right channel of audio
amplifier).

Fixes: 8ddebad15e9b ("MIPS: qi_lb60: Migrate to devicetree")
Cc: stable@vger.kernel.org # v5.3
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/dts/ingenic/qi_lb60.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -69,7 +69,7 @@
 			"Speaker", "OUTL",
 			"Speaker", "OUTR",
 			"INL", "LOUT",
-			"INL", "ROUT";
+			"INR", "ROUT";
 
 		simple-audio-card,aux-devs = <&amp>;
 


