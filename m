Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34728C433EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A5620700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlmcBdEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgGZAkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgGZAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:40:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA3CC08C5C1;
        Sat, 25 Jul 2020 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3Cu+WHQSreCgWvHynoY8se6WCdSNMDkzH2LBAYBm9MU=; b=LlmcBdELjJxDrZ6YI/AENOSsri
        I1merwGswIL0FAIXnbWmek+u/9V/vNHTFUlqXaNYtH4ltsJkp0qmuyKbfPl8HoavAiTqWtlE87UZm
        VRg82q0ILNiZ3aVO4A3KnkCzKRvEt2VtScGIb+3q/kI/zIrdD+viArMLCTUFl8LKlUoeH8C2JZbcl
        H/1ht4cpzOsbs4OQy2XxZzV3elb0FlfUx+LfWCk6zQod0U+g8cNCrNDTppHrKgsXxBfC7SCkPj3Fi
        HdNQOYSy9s1kqJ+gIpOd0b8dgrTqRiMQ07CUJKky5T4Lt/FCq/JnmkgUZdNAksb6INjCFt5GPlkh1
        lnQeLqjA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUiA-0003NC-JP; Sun, 26 Jul 2020 00:40:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 1/5] ia64: pal.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:40:09 -0700
Message-Id: <20200726004013.20534-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726004013.20534-1-rdunlap@infradead.org>
References: <20200726004013.20534-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/asm/pal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/ia64/include/asm/pal.h
+++ linux-next-20200720/arch/ia64/include/asm/pal.h
@@ -1086,7 +1086,7 @@ static inline long ia64_pal_freq_base(un
 
 /*
  * Get the ratios for processor frequency, bus frequency and interval timer to
- * to base frequency of the platform
+ * the base frequency of the platform
  */
 static inline s64
 ia64_pal_freq_ratios (struct pal_freq_ratio *proc_ratio, struct pal_freq_ratio *bus_ratio,
