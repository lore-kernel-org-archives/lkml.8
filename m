Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECB2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D3A20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjUoFCsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgH1Ljx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgH1Lgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:36:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F92C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:12:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so559925wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4JiaYoS0HndrreBr2XTvIDvJUjGSip4KNY5rXBxq20=;
        b=PjUoFCsQIiBw798tVdvlNcVfbGwaZ/NnQkuUreKmIJcf5Eic+xteObdrqCyCZLeMyH
         FknyTtV0W5zJXvj7kzAoI3BIAg0CuJy7+gs6Zo1vIgbJprPCFQiE2l+SuC8KDyUZWI/o
         b2oUIMGaJnsushXZ5ogsjyadieMxykjFFQJ+bh5GWS3Sx/e0vBYbtHmmsdOs3ByvsKIm
         v8mDvcvYnc4Gk4isSC5pdnoKIeGF8Y8VOT1JzbT23keLO5XM5PldL8V2sPPwWRJH6NHB
         pb4c6SN/cYoYJiRFXjm1yXkl3SQ2pIrReBIj3VQJcJJeF8YQZtOwgV70/KmzKF7yfUzi
         nwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4JiaYoS0HndrreBr2XTvIDvJUjGSip4KNY5rXBxq20=;
        b=SUXkMQTdExyXDMZo07QOM0P3Ku50TgGqsO4gsqlOMSA149vIhoinASCDaXldwoQyDr
         XCP5fhfIiqB54jNNclzPGJVQQAgZkEtHvNHnKl4UwEud5kOBEdf483cqQLPK4/c61Y18
         7f1fvW7ZIm9A2QV+YUD1bocFWV3+X9Ynm33o+aF0wvSDMfpZJTb+LqdGtif3HZRsuU7K
         z4bTr/tNvFhUcOyvjTdwx1fP8QzH5Ls8wpgK/crdcZ3ZoKnNZxgE3A2IWd3Oj+oh0q+i
         eAE0tZzWVTMkjSmHtxBJtlcPdPNKF/1OBAlXIeBAmViVLOu2KH6b2WwBBIi52P7hWxcb
         bWRQ==
X-Gm-Message-State: AOAM53188jRrGYWXaoh6rvtuvqHOv3w+xVn1PhJGtYNZ/3s/DX3QmjXz
        lxtVVkP0p6duZeVepEUKAl15+w==
X-Google-Smtp-Source: ABdhPJxwEdKAhCgV5UaEJGnDRILZnD/7YgaprlH2rfjyxiJodnAvFOjmY5uPay3ayBT/x4tgoL5qug==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr1090553wmh.140.1598613147805;
        Fri, 28 Aug 2020 04:12:27 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id o128sm1639658wmo.39.2020.08.28.04.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:12:26 -0700 (PDT)
Date:   Fri, 28 Aug 2020 13:12:21 +0200
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/35] kasan: add documentation for hardware tag-based
 mode
Message-ID: <20200828111221.GA185387@elver.google.com>
References: <cover.1597425745.git.andreyknvl@google.com>
 <5d0f3c0ee55c58ffa9f58bdea6fa6bf4f6f973a4.1597425745.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d0f3c0ee55c58ffa9f58bdea6fa6bf4f6f973a4.1597425745.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:27PM +0200, Andrey Konovalov wrote:
> Add documentation for hardware tag-based KASAN mode and also add some
> clarifications for software tag-based mode.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  Documentation/dev-tools/kasan.rst | 73 +++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a3030fc6afe5..aeed89d6eaf5 100644
[...]  
> -Tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64 CPUs to
> -store a pointer tag in the top byte of kernel pointers. Like generic KASAN it
> -uses shadow memory to store memory tags associated with each 16-byte memory
> -cell (therefore it dedicates 1/16th of the kernel memory for shadow memory).
> +Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64
> +CPUs to store a pointer tag in the top byte of kernel pointers. Like generic
> +KASAN it uses shadow memory to store memory tags associated with each 16-byte
> +memory cell (therefore it dedicates 1/16th of the kernel memory for shadow
> +memory).

It might be helpful to be more specific vs. saying "modern arm64 CPUs".
Does the "modern" qualifier suggest not all arm64 CPUs support the
feature?  (HW tag-based KASAN below is specific, and mentions ARMv8.5.)

> +On each memory allocation software tag-based KASAN generates a random tag, tags
> +the allocated memory with this tag, and embeds this tag into the returned
> +pointer.
>  
> -On each memory allocation tag-based KASAN generates a random tag, tags the
> -allocated memory with this tag, and embeds this tag into the returned pointer.
>  Software tag-based KASAN uses compile-time instrumentation to insert checks
>  before each memory access. These checks make sure that tag of the memory that
>  is being accessed is equal to tag of the pointer that is used to access this
> -memory. In case of a tag mismatch tag-based KASAN prints a bug report.
> +memory. In case of a tag mismatch software tag-based KASAN prints a bug report.
>  
>  Software tag-based KASAN also has two instrumentation modes (outline, that
>  emits callbacks to check memory accesses; and inline, that performs the shadow
> @@ -215,9 +222,31 @@ simply printed from the function that performs the access check. With inline
>  instrumentation a brk instruction is emitted by the compiler, and a dedicated
>  brk handler is used to print bug reports.
>  
> -A potential expansion of this mode is a hardware tag-based mode, which would
> -use hardware memory tagging support instead of compiler instrumentation and
> -manual shadow memory manipulation.
> +Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses aren't
> +checked).
> +
> +Software tag-based KASAN currently only supports tagging of slab memory.
> +
> +Hardware tag-based KASAN
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Hardware tag-based KASAN is similar to the software mode in concept, but uses
> +hardware memory tagging support instead of compiler instrumentation and
> +shadow memory.
> +
> +Hardware tag-based KASAN is based on both arm64 Memory Tagging Extension (MTE)
> +introduced in ARMv8.5 Instruction Set Architecture, and Top Byte Ignore (TBI).

Is there anything inherently tying tag-based KASAN to arm64? I guess if
some other architecture supports MTE, they just have to touch arch/,
right?

You could reword to say that "Hardware tag-based KASAN is currently only
supported on the ARM64 architecture.

On the ARM64 architecture, tag-based KASAN is based on both ..."

Thanks,
-- Marco
