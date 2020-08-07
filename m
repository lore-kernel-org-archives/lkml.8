Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B157DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF6A206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qlCBun+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgHGJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgHGJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:39:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7E8C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+m1NmxTmerVA7hYyNCbbSvji27rWMrnyKtnC8SpXeuw=; b=qlCBun+hYZ3NXDb+jynUBPF5jC
        h9Q8p+P3btJMKnRDYbi2BAa/sQ74mPob6WiFPQE7IgnqvAvjrylnmYcrWJF9imSnSE5vuAFnJW6mc
        /y/aeZjjYDdFSGbNOSq2ne5dZoxfVeJSJGt1evL6K7pnXkBi+cEGjvymLKMqvmrbfThHYTlmX1cKW
        Io2IvfmaI+W/P6SHIXiDMP87UdS6e+JDN+LOCBA1KZFBQ34DxczGekQV+vaYBzHAOYqOYYkcnRbly
        B7oGexBlDV3M4ABknh2jvnraRpH0zOmNsZphbhXmzYDft4HfoPllAJsfVSOHfTQFQbje2Cz2bPhXY
        Zk297Ehw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3yqO-0001GI-HQ; Fri, 07 Aug 2020 09:39:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC842300446;
        Fri,  7 Aug 2020 11:39:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E2DC23EA04DA; Fri,  7 Aug 2020 11:39:16 +0200 (CEST)
Date:   Fri, 7 Aug 2020 11:39:16 +0200
From:   peterz@infradead.org
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v3 4/7] x86/paravirt: remove 32-bit support from
 PARAVIRT_XXL
Message-ID: <20200807093916.GF2674@hirez.programming.kicks-ass.net>
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-5-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807083826.16794-5-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 10:38:23AM +0200, Juergen Gross wrote:

> -# else
> -	const unsigned char	cpu_iret[1];
> -# endif
>  };
>  
>  static const struct patch_xxl patch_data_xxl = {
> @@ -42,7 +38,6 @@ static const struct patch_xxl patch_data_xxl = {
>  	.irq_save_fl		= { 0x9c, 0x58 },	// pushf; pop %[re]ax
>  	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
>  	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
> -# ifdef CONFIG_X86_64
>  	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
>  	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
>  	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
> @@ -50,19 +45,11 @@ static const struct patch_xxl patch_data_xxl = {
>  				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
>  	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
>  	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
> -# else
> -	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
> -	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
> -	.cpu_iret		= { 0xcf },		// iret
> -# endif

I was looking at x86_64 paravirt the other day and found we actually
have pv_ops.cpu.iret users there..

So we want to change the above to also patch iret on x86_64 or do we
need to fix x86_64 to not have pv-iret?
