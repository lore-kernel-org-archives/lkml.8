Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0533BC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B444F2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ve3aQ+oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbgIHTUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbgIHQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:02:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C7C08C5E8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:31:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so19543286wrl.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YQgUsxZ9GX3vVBI6rWEDHgnkdvr/rXnkrQPmjYVedKg=;
        b=Ve3aQ+oisG54K1DBOJ6Vv+bfGmYnw8xEga4PIbgpydxas1I6Ucz4AP85ilqGU5v42M
         ppBWoLaAg0QPXJrjC+pTOvaXY3oT3KTo5FkSxl5Br19DLYKrIf4ZE7i5XBHZfPaLWdLq
         swqZEgFcwM2oTWjcAm4wstHbLRyWM5dXa7puN16iULpm1dLlLp2PcZojXIWrAaAeMpne
         gGcrBg5oM48MAvo0LKHh34SO0eWxkl32XY8o0kJFUU6BPKXe7UVuPJTWZaMw/9ppvdlK
         v4uSzjMcHxXNB7lV2zW69TkrrX70h/88OKykIHufyVSGOfbJ2+daKNTfnHctp1asLp75
         moPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YQgUsxZ9GX3vVBI6rWEDHgnkdvr/rXnkrQPmjYVedKg=;
        b=tC6VjDZtljCg+qUsnF5buabKVmimRcLhGLXgFpVrJqyosdWgTUBQk8+7gKNLau3cKm
         +BNyBJiD21Ue3WkRSBetbNe+f6svgzSjLVMJcYWwqhgb3Ja9Wd5uD89MObUoxI2bGDJF
         XZFtNQ6TuDE/CjQYqLXHlPLn4sweWQrz4P+Qak3WttCZowlqQu/WeQ5ZxfPPpHpd6+y4
         fTlwlegxOeyQUVdGdoGMo0ouj6oVElcDt0IKI3oIivlUfyQL9zxBcJC9EoxIl9QkrCVq
         732wBsLpv4TFwAX8FVrwqhGKpOiuPFkPFsrXfLhohvliyaFf+9Bldl40Fmr1nR81tpGl
         mZSw==
X-Gm-Message-State: AOAM532vs+Zx+fR0kF8QDWiZnjtToyDCwA95kx0J6J19SF7OcpCDMh/I
        KkbxYE82FBOnVUwO0JQqP8pcKA==
X-Google-Smtp-Source: ABdhPJzpeL/LG5MivE4qK84Vzr9Pz3Mah/87BWpTWioecpMtrDM52Kk30hPIYNgBxE+EHgxQQKTYoQ==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr172681wrv.141.1599579070236;
        Tue, 08 Sep 2020 08:31:10 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id d6sm34017392wrq.67.2020.09.08.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:31:09 -0700 (PDT)
Date:   Tue, 8 Sep 2020 17:31:02 +0200
From:   Marco Elver <elver@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
Message-ID: <20200908153102.GB61807@elver.google.com>
References: <20200907134055.2878499-1-elver@google.com>
 <e399d8d5-03c2-3c13-2a43-3bb8e842c55a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e399d8d5-03c2-3c13-2a43-3bb8e842c55a@intel.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:52AM -0700, Dave Hansen wrote:
> On 9/7/20 6:40 AM, Marco Elver wrote:
> > KFENCE is designed to be enabled in production kernels, and has near
> > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > for precision. 
> 
> Could you talk a little bit about where you expect folks to continue to
> use KASAN?  How would a developer or a tester choose which one to use?

We mention some of this in Documentation/dev-tools/kfence.rst:

	In the kernel, several tools exist to debug memory access errors, and in
	particular KASAN can detect all bug classes that KFENCE can detect. While KASAN
	is more precise, relying on compiler instrumentation, this comes at a
	performance cost. We want to highlight that KASAN and KFENCE are complementary,
	with different target environments. For instance, KASAN is the better
	debugging-aid, where a simple reproducer exists: due to the lower chance to
	detect the error, it would require more effort using KFENCE to debug.
	Deployments at scale, however, would benefit from using KFENCE to discover bugs
	due to code paths not exercised by test cases or fuzzers.

If you can afford to use KASAN, continue using KASAN. Usually this only
applies to test environments. If you have kernels for production use,
and cannot enable KASAN for the obvious cost reasons, you could consider
KFENCE.

I'll try to make this clearer, maybe summarizing what I said here in
Documentation as well.

> > KFENCE objects each reside on a dedicated page, at either the left or
> > right page boundaries. The pages to the left and right of the object
> > page are "guard pages", whose attributes are changed to a protected
> > state, and cause page faults on any attempted access to them. Such page
> > faults are then intercepted by KFENCE, which handles the fault
> > gracefully by reporting a memory access error.
> 
> How much memory overhead does this end up having?  I know it depends on
> the object size and so forth.  But, could you give some real-world
> examples of memory consumption?  Also, what's the worst case?  Say I
> have a ton of worst-case-sized (32b) slab objects.  Will I notice?

KFENCE objects are limited (default 255). If we exhaust KFENCE's memory
pool, no more KFENCE allocations will occur.
Documentation/dev-tools/kfence.rst gives a formula to calculate the
KFENCE pool size:

	The total memory dedicated to the KFENCE memory pool can be computed as::

	    ( #objects + 1 ) * 2 * PAGE_SIZE

	Using the default config, and assuming a page size of 4 KiB, results in
	dedicating 2 MiB to the KFENCE memory pool.

Does that clarify this point? Or anything else that could help clarify
this?

Thanks,
-- Marco
