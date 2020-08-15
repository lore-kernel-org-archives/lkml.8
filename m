Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D5DC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5590C204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hyCX5dk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgHOVzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgHOVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D6C0A3BEB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 09:39:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so5707377pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4J3Q2ehkUro4Gqm1OJFrAMNOhAG6pUBKwcsUWslCw24=;
        b=hyCX5dk0lc2fQo6AdVYPsyRwjQfIab+4kVsuGBOTS+rgoLmgvGzpAXpHdYdu25Ucxt
         p2vFxbC2jLyIN89paD62Unq+y0/DgbwcYwsRPTW0bMKamVAtr8RXj0r7D2sTV4u9WLlh
         ofnmietSfjV60Yd2MknF/JhR+Il9lbRkXQsjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4J3Q2ehkUro4Gqm1OJFrAMNOhAG6pUBKwcsUWslCw24=;
        b=skP0VuvAgZAZQ2+pI4gpFUxTD0z7UJ28kpS6bUVlh7WUNb3iWXbWxHg9CtGK0Xd/xn
         Pn8Ism/6ZbUGOb9cUcCWMI+ytiFUSnHLF+DHxN/1rLOtvRD5g2QpRk79NhmrCPsbNPR7
         /hN4oHfIMj+N5QcS0NfG25zU7vheULQQjZezxO4XhMguBjg7UoR5u9biICQq+c06V9zB
         jWlBu1nnxPZrk/DQLsC8kgV+f3RJXC53sIs0YxtUsjdmngsPaG8VWZhF+Y1niOz0hdJE
         FzWBOrWT2OWfGn2m2SZoB1hRz+DcWAKvmJvEoxCANn4CMI8WvnXzALaYj4FjSwBxnvOy
         0PFQ==
X-Gm-Message-State: AOAM5320XVJnGpD6/9N69MLR5iTO93eKFY0zv4ifLZ1r0cLlH5fyih4W
        nP/eH14v8xi4jUiTfhp4jFOoAg==
X-Google-Smtp-Source: ABdhPJwQ7WFh+zuUDNylvWNHBYfJx/1UItdvutSrtmbdzkqKHZNwQsyxlZmknMcj2X+TU5UN9AI9iA==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr6733727pje.197.1597509544802;
        Sat, 15 Aug 2020 09:39:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e3sm11269389pgu.40.2020.08.15.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:03 -0700 (PDT)
Date:   Sat, 15 Aug 2020 09:39:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH RFC 0/2] Break heap spraying needed for exploiting
 use-after-free
Message-ID: <202008150935.4C2F32559F@keescook>
References: <20200813151922.1093791-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813151922.1093791-1-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:19:20PM +0300, Alexander Popov wrote:
> I've found an easy way to break heap spraying for use-after-free
> exploitation. I simply extracted slab freelist quarantine from KASAN
> functionality and called it CONFIG_SLAB_QUARANTINE. Please see patch 1.

Ah yeah, good idea. :)

> [...]
> I did a brief performance evaluation of this feature.
> 
> 1. Memory consumption. KASAN quarantine uses 1/32 of the memory.
> CONFIG_SLAB_QUARANTINE disabled:
>   # free -m
>                 total        used        free      shared  buff/cache   available
>   Mem:           1987          39        1862          10          86        1907
>   Swap:             0           0           0
> CONFIG_SLAB_QUARANTINE enabled:
>   # free -m
>                 total        used        free      shared  buff/cache   available
>   Mem:           1987         140        1760          10          87        1805
>   Swap:             0           0           0

1/32 of memory doesn't seem too bad for someone interested in this defense.

> 2. Performance penalty. I used `hackbench -s 256 -l 200 -g 15 -f 25 -P`.
> CONFIG_SLAB_QUARANTINE disabled (x86_64, CONFIG_SLUB):
>   Times: 3.088, 3.103, 3.068, 3.103, 3.107
>   Mean: 3.0938
>   Standard deviation: 0.0144
> CONFIG_SLAB_QUARANTINE enabled (x86_64, CONFIG_SLUB):
>   Times: 3.303, 3.329, 3.356, 3.314, 3.292
>   Mean: 3.3188 (+7.3%)
>   Standard deviation: 0.0223

That's rather painful, but hackbench can produce some big deltas given
it can be an unrealistic workload for most systems. I'd be curious to
see the "building a kernel" timings, which tends to be much more
realistic for "busy system" without hammering one particular subsystem
(though it's a bit VFS heavy, obviously).

More notes in the patches...

-- 
Kees Cook
