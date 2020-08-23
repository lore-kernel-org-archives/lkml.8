Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A93E20723
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDPbr0/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHWEFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 00:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:05:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50229C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2lyb4DdlXdbrB4gnZBWByIhHpMOb+b1mrCL9JHGjdNY=; b=FDPbr0/ZjklEH1XfaiYbaE2pPH
        ytgPmhmTlwh/oNr/Sn7ExGLmF5295qLYJa2f8IdNPVsQ3WgAmcpPX8NJuiEqXl6tnjHix5V/x6AL7
        D/T9kr1m5rOFYL54owNj8EsobMRH6Al0sFNt+0iP9W2SdzZwTb+0wPTLX5fOV9ApBWWqg9/ZGXkCu
        BovC5kQvalop/CvWZk2Auy3SYLE+7FUDsQzrfJAgfa+OINioHP5c3ySzme5v/T6hEfWWNC5FSMdiP
        nBSINhQ/EtuKnjejTWZfUcTe66yLJWIG9UAKssCQeSCaV942ZIjxUkEjvM6gq1WInm/7qmLVDHJEH
        MeJjsZfA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hFi-0004rH-66; Sun, 23 Aug 2020 04:05:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] lib: pldmfw: delete duplicated words
Date:   Sat, 22 Aug 2020 21:05:02 -0700
Message-Id: <20200823040502.26040-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "header".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 lib/pldmfw/pldmfw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/pldmfw/pldmfw.c
+++ linux-next-20200730/lib/pldmfw/pldmfw.c
@@ -517,7 +517,7 @@ static int pldm_verify_header_crc(struct
 	u32 calculated_crc;
 	size_t length;
 
-	/* Calculate the 32-bit CRC of the header header contents up to but
+	/* Calculate the 32-bit CRC of the header contents up to but
 	 * not including the checksum. Note that the Linux crc32_le function
 	 * does not perform an expected final XOR.
 	 */
