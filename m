Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E711220657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NFYcAm9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGOTiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGOTiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:38:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F13BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:38:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so3574477pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RKh/vY0BHfd36chDiUTxPLIe+Y+K5A1kkjp71EXwdcE=;
        b=NFYcAm9wvunsDT3O6rABAEXZUTIq2xx4gdZaR6QtXqGqFitWX01bZktZ25OsD3VwlD
         3/RQ9NAAf/BOwnZdQd94jtfO4wkkgYuv4pcx1BtleMgckxJL01rUX371k90SIoMIb9ib
         X+OmPNF1QYkG3wvnjg47HV51rzX9ADmRkZVR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RKh/vY0BHfd36chDiUTxPLIe+Y+K5A1kkjp71EXwdcE=;
        b=qrWAhoGQpbpzst7NddyAXrnfZshct1nGSGJdxrHOadFp8L1U0d4rfAUz4XrJ2nBdrb
         A5vZWlFLQy/G53mRBvpLdbaZV3c/tOrX+RmpNt9Pm1bHP5wyNiBsjgBEIy4A6sqGX3cV
         D9bFOKfHuTsVslhWXy3/MjzCiIW9Fthpl28/x6Z1ZHoQRxYTMtC31tMZ/y9KnB5B/ztW
         DSJo68Q0Ek7RtrTMAnZPOY5YaYaoYS2keP/lOM/RLHkNmAZDNMBOhE3DbLV36iTgQYHl
         ZpW2EhCN68pIG8Dly4KbvEW/MtHwM+FJVHcSxIhxlzuu0NUTyK8+XWqaQ38MntwPhqf5
         65WA==
X-Gm-Message-State: AOAM533i+5pmOAP5p9IaoH8kT4I777UagU1I/b8b6Ub3WsWOnRpmd0CB
        rT2YELCcVX6VWqD8nsvu/7Hnjg==
X-Google-Smtp-Source: ABdhPJw6vSWEWFqHuZieSwcjX3DLbGLbjeUzcn/asl0tR48MGys8ddiDMSEPELGGAFn+G+XeWmPXBQ==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr857212plk.192.1594841901705;
        Wed, 15 Jul 2020 12:38:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y10sm2800537pfn.121.2020.07.15.12.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:38:20 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:38:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Babu Moger <Babu.Moger@amd.com>,
        Omar Sandoval <osandov@fb.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] kprobes: Add text_alloc() and text_free()
Message-ID: <202007151236.FE6CA96261@keescook>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
 <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
 <20200715172732.35110a4e53e84fcec9aeac83@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715172732.35110a4e53e84fcec9aeac83@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 05:27:32PM +0900, Masami Hiramatsu wrote:
> 
> On Wed, 15 Jul 2020 01:32:27 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > [...]
> > -void *module_alloc(unsigned long size)
> > -{
> > -	void *p;
> > -
> > -	if (PAGE_ALIGN(size) > MODULES_LEN)
> > -		return NULL;
> > -
> > -	p = __vmalloc_node_range(size, MODULE_ALIGN,
> > -				    MODULES_VADDR + get_module_load_offset(),
> > -				    MODULES_END, GFP_KERNEL,
> > -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > -				    __builtin_return_address(0));
> > -	if (p && (kasan_module_alloc(p, size) < 0)) {
> > -		vfree(p);
> > -		return NULL;
> > -	}
> > -
> > -	return p;
> > -}
> 
> Please don't touch this module_alloc() at all. Then we can
> just call __vmalloc_node_range() in the text_alloc().

Hm? I thought the requirement was that trampolines needed to stay within
a certain distance of kernel text and that the module_alloc() enforced
that?

-- 
Kees Cook
