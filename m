Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABABDC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8842D208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xd/xfXfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgGSA1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgGSA1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:27:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDFAC0619D2;
        Sat, 18 Jul 2020 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MKnRSn9ikggE7UY557Wd06+HvUOU7pMMUIJgzPPPakE=; b=Xd/xfXfEpCib5FjYLFIKtdmNeN
        FPqt78GL88bzKCk0QExzVcvGoYw7jazk08V9OHPR+qInKRdMEqxRKFnJFq5cqmsjMpf7c1NTWvEmb
        79ulqK7rL5ezpIa3b5bqnbsvG7Fh9CV4eJvMWFVYAv4SP8tZO4OqBmITGOn1ZEBidy2IzKpEzE8kO
        Q4TK8BbcSUHlafDChsKfMsS2VG0kF2f3lFpIoqQC7rW5lYxM8qHb20x0U/MVihAyEHLdNhz30Rzsb
        eE5EdjSlY0vo2sSNBFAWANRtMyCvrerxIxgzPEKNlvuFDtKUbmzCLALI5xDuyivL8vaCzKtxHJCD3
        u9GiiNug==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxAQ-0002TO-Bo; Sun, 19 Jul 2020 00:27:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: actypes.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:26:52 -0700
Message-Id: <20200719002652.20155-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "an" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 include/acpi/actypes.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/acpi/actypes.h
+++ linux-next-20200717/include/acpi/actypes.h
@@ -824,7 +824,7 @@ typedef u8 acpi_adr_space_type;
  *
  * Note: A Data Table region is a special type of operation region
  * that has its own AML opcode. However, internally, the AML
- * interpreter simply creates an operation region with an an address
+ * interpreter simply creates an operation region with an address
  * space type of ACPI_ADR_SPACE_DATA_TABLE.
  */
 #define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 0x7E	/* Internal to ACPICA only */
