Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D742C352B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD072073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fD9zVjsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgDMOOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:14:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730417AbgDMOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586787283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pz4ecCGHpD54VRs30aCWNG0g9ZT3H7m50d0kjdfWfs=;
        b=fD9zVjsEb4Gp3NZaS9CpwAwDvBDV9Coeb3s0tTDtkoFXvaRlZrTEdJxRWGpwv3ToEJSLs0
        KxQ5RcRZQk+R3RhFq4wrJFq0NpuIi4J9iMk9SUxM7HPbt0DQI806OgdbCW5o+whCriCw1Q
        WUrz68zkfOJroUz0cd5zNv2nZWHCWfk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-CvR-o-1PMPuf_GA8HkEPQg-1; Mon, 13 Apr 2020 10:14:33 -0400
X-MC-Unique: CvR-o-1PMPuf_GA8HkEPQg-1
Received: by mail-qv1-f72.google.com with SMTP id y18so2692811qvx.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pz4ecCGHpD54VRs30aCWNG0g9ZT3H7m50d0kjdfWfs=;
        b=hgrsJCqaOiym+aMK+dJ9pX1smwmgQEuQGyQfTtU0GQ8/IOE2HcIGAnuQgdLk01GFsQ
         4g9sw9ILyhDWxwKWC1NywZwhpmHHzN6HG9yIZiOkOJjEMtSo/T1XAh3yYVvdu5NZiALy
         95swEP9sxskLKI+pCaicAgNAZEX75uYzY8E3Vc0HRJrIbIoyySYsWHTk0YdGoZa6G9rI
         IIsO9WB7x74elznDbfirCqpddH0684IrlCiXV1lDCPgGfIeyKp56idYyd9QVW8bgX7Zt
         fez90e2JL7WwBXxSl3f101a8QthMzuvXamIMKyYnorYDFfPUwTsLrgG7PK962odXttm9
         GHnA==
X-Gm-Message-State: AGi0PubhiaicuoMWhQ8GjDAR3wOVsSfYImupqI/CDYSI6IsoWzM+hmve
        a5YpHxU5+eXHuPN+bcDipkWlVuEDVtVKDibdc7xJG22dENgKkW4G39TROcMwR2iamgnJ0jBevQT
        twnjbs/rNPOzJpzqeLMV/Sed2
X-Received: by 2002:a37:bb01:: with SMTP id l1mr16169738qkf.37.1586787272940;
        Mon, 13 Apr 2020 07:14:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypLcyXUmdwZ9EVtC8gVeFjagGEC3vAwbmtSkkop0oHmZV9eVJO4cB8zuzUmSpI+KklOCOl2lAQ==
X-Received: by 2002:a37:bb01:: with SMTP id l1mr16169713qkf.37.1586787272633;
        Mon, 13 Apr 2020 07:14:32 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w2sm2374972qtv.42.2020.04.13.07.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:14:31 -0700 (PDT)
Date:   Mon, 13 Apr 2020 10:14:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jules Irenge <jbi.octave@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: i386: selftests: vm: compaction_test: BUG: kernel NULL pointer
 dereference, address: 00000000
Message-ID: <20200413141429.GE38470@xz-x1>
References: <CA+G9fYsRGvkqtpdGv_aVr+Hn17KgYq04Q=EE=pB774qVxRqOeg@mail.gmail.com>
 <20200412214150.GB38470@xz-x1>
 <CA+G9fYvARTCKjbfHYEbfOjtn_s7desuAToOF4g+Z_fztzZ-myw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYvARTCKjbfHYEbfOjtn_s7desuAToOF4g+Z_fztzZ-myw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:51:25PM +0530, Naresh Kamboju wrote:
> On Mon, 13 Apr 2020 at 03:12, Peter Xu <peterx@redhat.com> wrote:
> > And since this one is very easy to reproduce, I finally noticed that
> > we have wrongly enabled uffd-wp on x86_32, which is definely not going
> > to work... Because we'll use bit 2 of swap entry assuming that's the
> > uffd-wp bit, while that's part of swp offset on 32bit systems.
> >
> > Naresh, could you try whether below change fixes the issue for you?
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 8d078642b4be..7ac524d1316e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -149,7 +149,7 @@ config X86
> >         select HAVE_ARCH_TRACEHOOK
> >         select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> >         select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
> > -       select HAVE_ARCH_USERFAULTFD_WP         if USERFAULTFD
> > +       select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
> >         select HAVE_ARCH_VMAP_STACK             if X86_64
> >         select HAVE_ARCH_WITHIN_STACK_FRAMES
> >         select HAVE_ASM_MODVERSIONS
> >
> 
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> The above patch tested and did not notice the crash.
> + cd /opt/kselftests/default-in-kernel/vm/
> + ./compaction_test
> No of huge pages allocated = 297
> + ./compaction_test
> [   46.059785] kauditd_printk_skb: 15 callbacks suppressed
> [   46.059786] audit: type=1334 audit(1586776582.927:25): prog-id=17 op=UNLOAD
> [   46.071997] audit: type=1334 audit(1586776582.927:26): prog-id=16 op=UNLOAD
> No of huge pages allocated = 160
> 
> Full test log,
> https://lkft.validation.linaro.org/scheduler/job/1362495#L1308
> 
> Build artifacts.
> https://builds.tuxbuild.com/w0ol7cCsGan0wzPp7bNqkg/

Thanks!  I'll post a formal patch soon.

-- 
Peter Xu

