Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C07C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EAB206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OO7G/5rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGZAcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:32:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9F5C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MRHoNhAB78rRr+PlqvNw9kGcdwElzzTQP+lMqZg9ftc=; b=OO7G/5rWgEaz1Ib+COcbPnvqd5
        rMblT/U7RrZ5pk0GMWCXNasUf13SxGpqVvzWsQHzIsntLze3UyQdk4bDVNlObDq1F3I/XDC8alF4T
        0VUxdNFDdtsQoGIysVt0w6tBpRAIczvq9owknu6uVMRv265TL7uFemG93xCm+65YWXHVG8YLKVg83
        P3L61KMbryuxoyX42rNqll/kjORse/6RObs0vhqiEZ60WplPqERyU4CtMi8FdUHI7AVYqRjpJsoEw
        NnKNQ2VeN7acC5HBS+3ovS3pV6w8Vvc+VMWAcA+HPRG33imjaSPHf3dsYOnBJm/lt2fQFwhzs3UAy
        iYVTUMAQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUaI-0002x2-BW; Sun, 26 Jul 2020 00:32:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] arm64: delete duplicated words
Date:   Sat, 25 Jul 2020 17:32:04 -0700
Message-Id: <20200726003207.20253-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete duplicated words in arch/arm64/ header files.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org

 arch/arm64/include/asm/pgtable-hwdef.h   |    4 ++--
 arch/arm64/include/asm/ptrace.h          |    2 +-
 arch/arm64/include/uapi/asm/sigcontext.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
