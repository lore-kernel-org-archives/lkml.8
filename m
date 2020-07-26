Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0102AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A2A206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Is4NIr3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgGZAld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgGZAlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:41:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA2C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6hZTWpnBwISZCzAWYTxODtwFNBVTABBJu809BCFvPpw=; b=Is4NIr3cXUPFPa7xZzFJ6I+LpN
        LRan/UHnLQdvsEEcaI/oEm3y+fGRXvE+ABOnkt/Uo+336kbB/75+P0N2GMvXvvzb6LXeQTWw7pGpM
        BNXyMa8TPO41rMMCDkT6AUKzHioueHtX81zsx69peYfD3si7Uj/If6lBgtoUb62x7cEOBMYmzH1ur
        jflVdaixyLAZXw2eKcsxPXCBxyW6PQe9+oCn3RBZ+VifZEmrA4/KPYXuVpBXktYJprgKeXCi0GebS
        KQiqtZk646r8OtNh2qvXKR/DMlBaCbFGnR20tj67mGZNmhUOwFITszgHTMc4PQvxSScpysG+L9W0H
        W84z+/1w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUjJ-0003QZ-Sw; Sun, 26 Jul 2020 00:41:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH 1/3] x86: bootparam.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:41:22 -0700
Message-Id: <20200726004124.20618-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726004124.20618-1-rdunlap@infradead.org>
References: <20200726004124.20618-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "for".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
---
 arch/x86/include/uapi/asm/bootparam.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/x86/include/uapi/asm/bootparam.h
+++ linux-next-20200720/arch/x86/include/uapi/asm/bootparam.h
@@ -255,7 +255,7 @@ struct boot_params {
  * 	currently supportd through this PV boot path.
  * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet Device) platform
  *	systems which do not have the PCI legacy interfaces.
- * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC for
+ * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC
  * 	for settop boxes and media devices, the use of a subarch for CE4100
  * 	is more of a hack...
  */
