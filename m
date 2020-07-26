Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70CC433ED
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9079206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/jn0/IA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGZAim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGZAi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E4EC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WRuZGyhWT9qXM2YUFo6a0yn/chTXG2BjJ65UzF8UQ7o=; b=o/jn0/IATIUVs+wPQn3s/dkVkH
        I0WTjLtIUllpFWm7sVrQr1Tz3TRfrlT+KVFzoQDAJ/xPIczW0l9e+bGBp1z6/ur1a+sSqFSU+PMVL
        tC56h78hRoADg4WACCqbjbKZc/XQg3ytjufUDTC735qF2d+seCagqI5kadYyFrAjVGMNIiQivJBJt
        bhHIJMnDzq2gPwVLeE+83QanC4cicU+KmxeipJuXiXw7pX+e6qNF412TImeQpyXgRrCIo4wfi8fpu
        x2fqmHLqwQqI7p8Z2ac45xwfQI1tV9s6b6kKrJO59/vxb1IiXl+ULBOFGHeMSruaYdkfU+aT6DPGj
        sia40aDg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgM-0003Cq-26; Sun, 26 Jul 2020 00:38:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/9] powerpc: reg.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:38:07 -0700
Message-Id: <20200726003809.20454-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "a".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/reg.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/reg.h
+++ linux-next-20200720/arch/powerpc/include/asm/reg.h
@@ -1472,7 +1472,7 @@ static inline void update_power8_hid0(un
 {
 	/*
 	 *  The HID0 update on Power8 should at the very least be
-	 *  preceded by a a SYNC instruction followed by an ISYNC
+	 *  preceded by a SYNC instruction followed by an ISYNC
 	 *  instruction
 	 */
 	asm volatile("sync; mtspr %0,%1; isync":: "i"(SPRN_HID0), "r"(hid0));
