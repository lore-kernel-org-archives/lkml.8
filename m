Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CABC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A1321707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588016565;
	bh=pHSFHwxnqBXxHCqPQAkxUYpCjZ/3lJQClrx+8qthDWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U3g+JXN6pmqQdckMvxDxGfan+SFxoWFuCdUtCYCb1QfBrrlOmoxe2Oxbru+ZXzad6
	 u8ONyrubIg5nY8D17ZqR0a6wP2A5/ot2MoUxX0Q/bl23KynJJehOPGjPtL9cJhcLCM
	 U+T/bewCAyyGVaa5ndhSkQUFMYOHWBdf09VnS3lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgD0Tmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgD0Tmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:42:42 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71652078C;
        Mon, 27 Apr 2020 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588016562;
        bh=pHSFHwxnqBXxHCqPQAkxUYpCjZ/3lJQClrx+8qthDWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BF4/l8XrQ02299gpcli0FvwYPMF2hN3ZsowBym+oFxLCbmSBv6c8XKoMoCpSUs1mZ
         vLIh3Da+bxY+s/o+fJHms7WltoegzNJwopJah4TrVT7ox2ZS8JuHiDXeMfsgI8/UYZ
         lVmACC6y+QfktaRHOt+ND6M6DoBoUgRMxPoCw4LQ=
Date:   Mon, 27 Apr 2020 12:42:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] mm: add DEBUG_WX support
Message-Id: <20200427124241.28adefc19cfddcf83f75d03c@linux-foundation.org>
In-Reply-To: <CANXhq0rW5j+uAymXbfsND9AXHYvM+fPUX9YYYRVXY-Y1u6yo0Q@mail.gmail.com>
References: <cover.1587455584.git.zong.li@sifive.com>
        <23980cd0f0e5d79e24a92169116407c75bcc650d.1587455584.git.zong.li@sifive.com>
        <20200427074915.GA11787@willie-the-truck>
        <CANXhq0rW5j+uAymXbfsND9AXHYvM+fPUX9YYYRVXY-Y1u6yo0Q@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 16:47:47 +0800 Zong Li <zong.li@sifive.com> wrote:

> > > +       This is useful for discovering cases where the kernel is leaving
> > > +       W+X mappings after applying NX, as such mappings are a security risk.
> > > +       This check also includes UXN, which should be set on all kernel
> > > +       mappings.
> >
> > "UXN" is the name of a bit in the arm64 page-table descriptors, so this
> > should be reworded now that it's in generic help text.
> >
> 
> It's exactly. Sorry for missing the statement.
> 
> Hi Andrew,
> Shall I send a next version patch to fix it? It should be "This is
> useful for discovering cases where the kernel is leaving W+X mappings
> after applying NX, as such mappings are a security risk." here.

I'll add this:

--- a/mm/Kconfig.debug~mm-add-debug_wx-support-fix
+++ a/mm/Kconfig.debug
@@ -128,8 +128,8 @@ config DEBUG_WX
 	help
 	  Generate a warning if any W+X mappings are found at boot.
 
-	  This is useful for discovering cases where the kernel is leaving
-	  W+X mappings after applying NX, as such mappings are a security risk.
+	  This is useful for discovering cases where the kernel is leaving W+X
+	  mappings after applying NX, as such mappings are a security risk.
 	  This check also includes UXN, which should be set on all kernel
 	  mappings.
 
_

