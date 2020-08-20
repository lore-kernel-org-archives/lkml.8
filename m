Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89565C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594E72075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916363;
	bh=HMeLencfP79QnOTHpQu9SCQ8crUYfKYEweeJFlkvMmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R1598+85Zi5C0B911YYYMItX3SRn/s67xA3KhxeQ8736TRWhWPuOOXthoT0IG/uMH
	 r2dBp9qQMc31Vhu2sQgh8YGC3UN2Fc8BnaFqQ0bkmnmtp5kH/nOfquB6Olu8/UU0u3
	 C/dhpvdtL+zPN7PN4PbMvLhKXk86hGcmG21vbh5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgHTJjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgHTJi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:38:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA3D9207DE;
        Thu, 20 Aug 2020 09:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916337;
        bh=HMeLencfP79QnOTHpQu9SCQ8crUYfKYEweeJFlkvMmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYsPrtWoZGJU2baS5fmOyrL5EzuEYPRuOY5/VQQJ4aF4uPTqecbixLTKvmplruhub
         Bu3n8zoapgqLF3A7L6lPNLzugPS6kNsAj0IPfEYTQi3CQtsSgjvyQ5fYqs6AJWv2tm
         rdepBxUkd5tRfyZ4cNKFaEARSmVVoEpejamEKcBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.7 064/204] MIPS: qi_lb60: Fix routing to audio amplifier
Date:   Thu, 20 Aug 2020 11:19:21 +0200
Message-Id: <20200820091609.460152322@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
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
 


