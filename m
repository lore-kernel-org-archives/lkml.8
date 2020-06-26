Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D42C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CFE2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VIGOIHNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgFZVwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFZVwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:52:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25518C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:52:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f3so5525654pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q757IDXyRukGvX5SZOHlJdoHJ/1n6S14vTGyo4zvXBQ=;
        b=VIGOIHNEEU9j/QBCfkBjGdBcqAkDVMSPH2V6E9pYYKa7w0oI1NtGdugkcB6s2J7djs
         DSZ85QWa+gMBeGdBreMiRKvPJcdHicHe0ZZZe3JPNlhdZodj/p1tvl8Xip3Cc2IPrr+s
         lsiie+VLCThaSSaloZS5eYhO67RiKTuNXrYns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q757IDXyRukGvX5SZOHlJdoHJ/1n6S14vTGyo4zvXBQ=;
        b=iv6TgftpAGOzxp/muGXTsV3bAy/c+ScABRT/313NdMFLWLJJZGcLk1Bl7gKIB9rDRt
         VFUcloR7n0LRf3b+JObVCKCEGnp/4LZ4rray274YOo5Tz1cM4sOPU59STMwVDObc3CRg
         sq8oO2T2cUDSw0YQKe9kqq/TZPZvlWAOnuNOjBA55hPJyfIf+xwZGLCNfwBtgzQw0lSp
         RVCI6/fpPD7QZ7D6VJMwKSPuONtWCAqzn4K8mkBkEJ1J1k2bADAA2piCxXD+GFLzyzgc
         GqWz7vWqYe5EBFHfRzy4rBNRd1belOkJq/ctqkJlB+xeLOGitRId9eUtnfDkj1gwmLus
         5LNQ==
X-Gm-Message-State: AOAM531Unu+3Um/Pv+tO9EQ73OxRj5hlttXs/wCUb71Qfwev3tL1CeD/
        +gFLZiyU2v3A33N6P5TILv3wqg==
X-Google-Smtp-Source: ABdhPJxjew6vuVd8xK7z4Or0D8mu7tCMflIKF0q/SKBZ2je3Uo1yszhe7quUG/VVVAWRTDES/M5wNg==
X-Received: by 2002:a62:ea0b:: with SMTP id t11mr4824646pfh.276.1593208359728;
        Fri, 26 Jun 2020 14:52:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o16sm23597011pgg.57.2020.06.26.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:52:38 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:52:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 00/12] kunit: create a centralized executor to
 dispatch all KUnit tests
Message-ID: <202006261442.5C245709@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:05PM -0700, Brendan Higgins wrote:
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.

So, the new section looks fine to me (modulo the INIT_DATA change). The
plumbing to start the tests, though, I think is redundant. Why not just
add a sysctl that starts all known tests?

That way you don't need the plumbing into init/main.c, and you can have
a mode where builtin tests can be started on a fully booted system too.

i.e. boot with "sysctl.kernel.kunit=start" or when fully booted with
"echo start > /proc/sys/kernel/kunit"

And instead of the kunit-specific halt/reboot stuff, how about moving
/proc/sysrq-trigger into /proc/sys instead? Then you (or anything) could
do:

sysctl.kernel.kunit=start sysctl.kernel.sysrq-trigger=b

-- 
Kees Cook
