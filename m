Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9DBC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F815206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cpKz2fB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgDGLNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:13:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgDGLNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DGXRNIOm8L3YtK4QEqGYJuqh7vIlYsiM9W/BVycG01s=; b=cpKz2fB8lSsiRrh0SoxEA09KFQ
        HjnomCpyka6wHtm512PgK7Y8A02vA66Zi/VtxBbnwnfOI4zTXn2VdC5C6RZ+H3ROyWiZUIEuNv0qY
        R538mjupiWK6Y4en4es1w3QmxALAPiECZ3SN22U5i6JPQD3r0HxzkJTP9XMX30PUVVBfXz1ffM6T7
        AbcNhYGKGnRXmqeQQylsbRJrKVWrohtPiA/6Bixmp4P1i3dHkWoLBSO8s85buyi0L2E6ybQGwdNXZ
        RqrzR+dsb3NUVqyn7eA4JgCbtd4NbUwUGBTXZ1UJNd7HySXbER3xRsedUzbTgAdR8nigMriWDfeze
        j7aR8mKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLm9n-0002wL-CN; Tue, 07 Apr 2020 11:12:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 463413011DD;
        Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 189DB2856A70A; Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Message-Id: <20200407110236.930134290@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 07 Apr 2020 13:02:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, peterz@infradead.org, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: [PATCH 0/4] x86/module: Out-of-tree module decode and sanitize
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Driven by the SLD vs VMX interaction, here are some patches that provide means
to analyze the text of out-of-tree modules.

The first user of that is refusing to load modules on VMX-SLD conflicts, but it
also has a second patch that refulses to load any module that tries to modify
CRn/DRn.

I'm thinking people will quickly come up with more and more elaborate tests to
which to subject out-of-tree modules.

