Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE271C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCDC206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="deMhuseK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGZAek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:34:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1AC08C5C0;
        Sat, 25 Jul 2020 17:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BQ2zYma7Y0wHo3m3QwZhwQFRnnQduL+BBfZMA8stLg8=; b=deMhuseKQ6jXK57jJvdBnLR7wS
        KHkWPCh8sTmNiWi7hldkYymt7K+HL+rZsaAThx8kciqcb+o4fACuEQM1kBpv1gakKtSNT2OImxKL4
        ePlZr/hGrqaVtKzGEVPZEKR5kxrBFr03g0mj22b6gNxZ/NhS62aCPZgV3SXkG0D/qpLRd9jU27tkI
        633iUc4uTcrM06+4GeOaMRhzvSxZ6snYY58DdeXCpxJzfqm5ahvIa7vtHpS5vFnWseQfOwsiuB8bm
        7wMo7cxe4viFq92ebCd5kBYYEjSbH8a/F2mgt1QRhsTd3JjM/R83x3x45b129jyi08DXul3e6A59f
        Xuk6BdJQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUcf-000328-Li; Sun, 26 Jul 2020 00:34:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 3/6] mips: octeon: cvmx-pip.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:34:26 -0700
Message-Id: <20200726003429.20356-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003429.20356-1-rdunlap@infradead.org>
References: <20200726003429.20356-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/include/asm/octeon/cvmx-pip.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/mips/include/asm/octeon/cvmx-pip.h
+++ linux-next-20200720/arch/mips/include/asm/octeon/cvmx-pip.h
@@ -503,7 +503,7 @@ static inline void cvmx_pip_tag_mask_cle
  *	    offsetof() to determine the offsets into packet headers.
  *	    For example, offsetof(ethhdr, protocol) returns the offset
  *	    of the ethernet protocol field.  The bitmask selects which
- *	    bytes to include the the tag, with bit offset X selecting
+ *	    bytes to include the tag, with bit offset X selecting
  *	    byte at offset X from the beginning of the packet data.
  * @len:    Number of bytes to include. Usually this is the sizeof()
  *	    the field.
