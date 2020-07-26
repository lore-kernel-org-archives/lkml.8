Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B736AC433EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8617E206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L+jZCHYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgGZAie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgGZAia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8853C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yXjTR5UJmacFMrqVS6kpsh5Q6lNb8lImeHClMs/Lch8=; b=L+jZCHYFCSMCFqWFGEhcZqS0EI
        9zhrYTVw5jnQGR83Tz9qNywelGWRiD/73fqlbPOHIDPv7iVOrRy0Y5iSLZRK6Aza5Nezc7nBcH5jl
        3IA1hfQUPT9H8H5sowsFhVPJ3q4i+SqUozM6cDb2MztNfiX3p1F+8GvZVrw04ABE2Ym7ey+ORFzU+
        IVoqTntEz3P34glWUc1xsiUgIVblHsGSgswcDS59wtis8Ms3AfUC7MZxiG3j9N/pA1zX06MwHhy18
        +Thy280g0GLNdsaZ7iNvKsw37TJ8c7TopsImSxQb9uopEpxlaZRAEqvd318li4MoSnSrqakYMph/1
        1fZdIf5Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgO-0003Cq-2A; Sun, 26 Jul 2020 00:38:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/9] powerpc: smu.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:38:08 -0700
Message-Id: <20200726003809.20454-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/smu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/smu.h
+++ linux-next-20200720/arch/powerpc/include/asm/smu.h
@@ -108,7 +108,7 @@
  /*
   * i2c commands
   *
-  * To issue an i2c command, first is to send a parameter block to the
+  * To issue an i2c command, first is to send a parameter block to
   * the SMU. This is a command of type 0x9a with 9 bytes of header
   * eventually followed by data for a write:
   *
