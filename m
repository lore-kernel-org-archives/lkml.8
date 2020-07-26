Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C719C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E22206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TJ6enFMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgGZAkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGZAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:40:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D8C08C5C0;
        Sat, 25 Jul 2020 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sQTU7EiSbF6nuRz5kddGWR7FHrJ/c2mknsP6KeJX8nw=; b=TJ6enFMzLeV5zQlaa0wsQaR6x9
        EVn+qds6ObDxyRp5091mg7rlwdeLV721xl8V6FU6q33bnkQnWQrT3dyU1wl6urHeHTVhHcuVTtVcq
        WQTc5IbdqAx/18f/aEyLhUUPDzBQIijc/gdgDxxjxg9iWHnLCRcx3Va3n4XbQJBINdmlFyOwhWHeI
        wWGPzdGICsh6Mbb6cy8qi78rCybrgs8iK5MVwQk1QYoA8/cIwwvicyyjP7tU4KhIZYRtyoq6VY1tg
        ROM0bJb631sdQj4diQSaTN/r7GNjXX14JtWiYhJARf5M07xNY32fs5WQd3cfz78pnyszwqBmOTMh+
        FV/xk62w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUi8-0003NC-OQ; Sun, 26 Jul 2020 00:40:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 0/5] ia64: delete duplicated words
Date:   Sat, 25 Jul 2020 17:40:08 -0700
Message-Id: <20200726004013.20534-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in arch/ia64/ header files.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org

 arch/ia64/include/asm/pal.h          |    2 +-
 arch/ia64/include/asm/perfmon.h      |    2 +-
 arch/ia64/include/asm/spinlock.h     |    2 +-
 arch/ia64/include/asm/uv/uv_hub.h    |    2 +-
 arch/ia64/kernel/perfmon_mckinley.h  |    2 +-
 arch/ia64/kernel/perfmon_montecito.h |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
