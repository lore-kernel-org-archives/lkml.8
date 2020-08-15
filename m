Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B9C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731A62053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GPHj7mF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgHOV4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgHOVwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65BC004597
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SYhsdz9Ikw/5Id67XdrFAG6RYY/GnifUtuavkK2F1mo=; b=GPHj7mF5tQxFUHGIb+vUHBhFvb
        viu4v6hOIabQCCvC2ShC+wg5VDEpFLVz3pQ9emHprrtHALfAeBm8tyXyXzr+5ScH78gcFybPBuBFp
        8JoyUaq4GaPGa9sNYZ/RdQWnBZZO5NgJVySKsAbK0v35o2Mt5iRFpJBOy6SDfSAL5zCQathZaYN45
        aIKp7Fxx83adx921tPLvn93HeDfLHLek7YBiuGjhTMdquC435ptpkXDvrPlyaAXEnoK34Yk+ugwbX
        /++ZiDWW2wuYR6x4WAiq2ZCcu3A1BddzYWUKJhR6Kb9jmMzcxus+gohduHlSqtPrS6HYuabKex/Sf
        h/l9nB9w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k71KR-00061N-Qf; Sat, 15 Aug 2020 18:54:55 +0000
Date:   Sat, 15 Aug 2020 19:54:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        notify@kernel.org
Subject: Re: [PATCH RFC 1/2] mm: Extract SLAB_QUARANTINE from KASAN
Message-ID: <20200815185455.GB17456@casper.infradead.org>
References: <20200813151922.1093791-1-alex.popov@linux.com>
 <20200813151922.1093791-2-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813151922.1093791-2-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:19:21PM +0300, Alexander Popov wrote:
> +config SLAB_QUARANTINE
> +	bool "Enable slab freelist quarantine"
> +	depends on !KASAN && (SLAB || SLUB)
> +	help
> +	  Enable slab freelist quarantine to break heap spraying technique
> +	  used for exploiting use-after-free vulnerabilities in the kernel
> +	  code. If this feature is enabled, freed allocations are stored
> +	  in the quarantine and can't be instantly reallocated and
> +	  overwritten by the exploit performing heap spraying.
> +	  This feature is a part of KASAN functionality.

After this patch, it isn't part of KASAN any more ;-)

The way this is written is a bit too low level.  Let's write it in terms
that people who don't know the guts of the slab allocator or security
terminology can understand:

	  Delay reuse of freed slab objects.  This makes some security
	  exploits harder to execute.  It reduces performance slightly
	  as objects will be cache cold by the time they are reallocated,
	  and it costs a small amount of memory.

(feel free to edit this)

> +struct qlist_node {
> +	struct qlist_node *next;
> +};

I appreciate this isn't new, but why do we have a new singly-linked-list
abstraction being defined in this code?

