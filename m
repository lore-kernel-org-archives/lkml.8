Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD1AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B5820724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597932671;
	bh=HMeLencfP79QnOTHpQu9SCQ8crUYfKYEweeJFlkvMmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D9v5LrZjhdXtBGqzBfigk+Y6woQnKAiodqVbr4yJEf0SaaxSC4YggMjjg2S1xArCu
	 Pe48yhmc9LIbJzAj/GSL6pUmkbUACtAqsRA96oIFHttv2Svmv6iGTH64vK6NNupWL+
	 JeUoXkRi9TTfrr4nTtupFf9yQ+yJIYPcueDJz5RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgHTNyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgHTJ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:26:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5562122D0B;
        Thu, 20 Aug 2020 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915609;
        bh=HMeLencfP79QnOTHpQu9SCQ8crUYfKYEweeJFlkvMmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YT/zfQBXHi3eFcJYXFTYgXIVV8X0QlZLNEnTzWQsWdGWQ7P7skGRsUHcOr0n1+RnJ
         3Pp8xJZjxwkylvvfR6twVHanuqs2H000zcrQgQXcu+5rlZ+vkl+2MHq3A6w48Kizx8
         yQNUImnpwNKuDOq8VrcIa5VgheWjmIbIV/Daof5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.8 074/232] MIPS: qi_lb60: Fix routing to audio amplifier
Date:   Thu, 20 Aug 2020 11:18:45 +0200
Message-Id: <20200820091616.393166982@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
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
 


