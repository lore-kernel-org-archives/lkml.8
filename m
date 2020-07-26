Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF02C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A500206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jt5lU0Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGZAla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgGZAla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:41:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D92C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2W/YyokK+SQgW8x4SF5iqkonYk3xrOuCsFSxdaWkelU=; b=jt5lU0NtYX88pzrhD/Vr80b0Y3
        LtRYdguMF43but7zGSow6whfTKM9kZz6SpfX0B2ksgz+Lv6QFBVOqr+NfjLkHnGkg4TgT9toNjyPX
        hqiUTfJO2NImGrtE98rhDyTsxYlazlt/mk28I3uuzvZjfWwTnhDa2esaNqZ/G8ujRa0ag3Z8dLCBR
        zSgebWftqqol6wyl05FnDY31Mw0sHTCftnHdLm0XmOI/Q4upgcflXj+jIf8u+le61Spug8sbKLNDY
        UfYVQ5h4/dS01C8m6kCtE640E8Y3a6YQoLH4xKzfzMMAVNDQny78SXHmHUcCunF9gOTWHBanaZxNK
        7hYwa1mQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUjH-0003QZ-Tk; Sun, 26 Jul 2020 00:41:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH 0/3] x86: delete duplicated words
Date:   Sat, 25 Jul 2020 17:41:21 -0700
Message-Id: <20200726004124.20618-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in arch/x86/ header files.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org

 arch/x86/include/asm/cmpxchg_32.h     |    2 +-
 arch/x86/include/asm/uv/uv_hub.h      |    2 +-
 arch/x86/include/uapi/asm/bootparam.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
