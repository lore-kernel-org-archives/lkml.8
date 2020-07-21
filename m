Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9F8C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882E52068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwGNS76u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgGUVAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:00:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC1C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OwmmUSu+YwfeAN7y20o0JC90UT6XTQ3k5DrjwodZqbg=; b=YwGNS76usJRdbfvpxjWDQ1204I
        dfyYcGSiXvyLKx5AwYgL6/Vu3uq6sDNav4PSUN3GCeOCLNRwgBXaxXHpc+WJVlpUWPFscJtP9lVEK
        t4/ioxXmOtF4kGlekqsVpFLrm8/TFk6mtgHguhwoTbCNinx79DLSqojepSgwRlx8VqhSic2wJklQr
        aPuryPP4eWU+YQixiEgizL+3BZBoQF7fubKAxw+42IHlh0AqZrjqQ6uRsUwVPKRR5Nq2cv99wNqXn
        gAJwPrOjWUo/uRfi0r9QZMklOse/igh2j8fSjfmw1wILYqd9mIlcK9td283/bhgFZf+RyGEHqARB/
        RGAfPEoA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxzN2-0000aK-Cl; Tue, 21 Jul 2020 21:00:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH] H8/300: flat.h: fix a duplicated word
Date:   Tue, 21 Jul 2020 14:00:12 -0700
Message-Id: <20200721210012.15304-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the phrase "is is" to "it is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
---
 arch/h8300/include/asm/flat.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/h8300/include/asm/flat.h
+++ linux-next-20200720/arch/h8300/include/asm/flat.h
@@ -12,7 +12,7 @@
  * on the H8 a couple of the relocations have an instruction in the
  * top byte.  As there can only be 24bits of address space,  we just
  * always preserve that 8bits at the top,  when it isn't an instruction
- * is is 0 (davidm@snapgear.com)
+ * it is 0 (davidm@snapgear.com)
  */
 
 #define	flat_get_relocate_addr(rel)		(rel & ~0x00000001)
