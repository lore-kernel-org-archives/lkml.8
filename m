Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B90C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F5E20936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QgRU3QLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIHXbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIHXbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:31:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAAAC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 16:31:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so465768pfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 16:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fpQH/xPexxyTS1Nk2wAyu0L+S9B78VfQtAtHXc1iQHU=;
        b=QgRU3QLmEG8rJaIf9I7wydr8fbjEPJ2rN2WWI1phbuI3euh/n64HmPR5QWarkP8CcJ
         heToUVxBAMMlf0frKJs86rwZNPfIu7396CEXUnQ2kkvodaz7PPKnq6plhr72k7nT4b5c
         jkHh0mZmu1zY2Kx+dDO8TaVIylNWZLakQYb6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fpQH/xPexxyTS1Nk2wAyu0L+S9B78VfQtAtHXc1iQHU=;
        b=uoJYLXFU83+jmqM/KKmvfRlhCBmKEvPhP383AJU3kAuM8Ski9dKtWg+mjc8eK+9sZC
         /Tuev+H5tXNu5FmuAYn3zDVgRLypecGHPla7JjRa8EnmFiSKtlxdKnoWQX+jD+uD2sNG
         jRg4nJYndRTMqJ6LE0FCpn0CcOpzL7ql54x6XvU+G/noRjS4Jg6kJXvGrydN/r+aYIdt
         P4RKHsiS7wdSiW9/2eG5CT1i1y9+QSuZTIxrRDglHCi0B7c1TBiRhuqNWlbfPJkR5gJ+
         p3zEIFHViObQwgrpe52tvwDGrJYOFyUllhAlDyPpK919ntgmBYBNvhrfm4eVY+lz+WMX
         UK0w==
X-Gm-Message-State: AOAM5336wXpCqEdNu1qPLqRGs/ChGJuRkEIaQLLNFuo4aVdJyriAl7He
        nQS8PgTAC7JOkZXVfYyLaQ9gxA==
X-Google-Smtp-Source: ABdhPJxep1Fdns5TluQtMHf70Q0VevYoKZi2UXc9tTGNFES8CXtqDvuC2HYp6GSBf9oLl5Zir1T+KA==
X-Received: by 2002:a17:902:c3d3:: with SMTP id j19mr1010227plj.59.1599607874840;
        Tue, 08 Sep 2020 16:31:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14sm326516pgu.47.2020.09.08.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 16:31:13 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:31:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ptrace] 201766a20e: kernel_selftests.seccomp.make_fail
Message-ID: <202009081629.4A31845@keescook>
References: <20190729093530.GL22106@shao2-debian>
 <20190805094719.GA1693@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805094719.GA1693@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 12:47:19PM +0300, Dmitry V. Levin wrote:
> On Mon, Jul 29, 2019 at 05:35:30PM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 201766a20e30f982ccfe36bebfad9602c3ff574a ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: kernel_selftests
> > with following parameters:
> > 
> > 	group: kselftests-02
> > 
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> The URL above also says: "Tests are intended to be run after building,
> installing and booting a kernel".
> 
> Please build selftests with installed kernel headers corresponding to the
> installed kernel.
> 
> Alternatively, tools/testing/selftests/lib.mk could be extended
> to include uapi headers from the kernel tree into CPPFLAGS, e.g.
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 1c8a1963d03f..b5f4f0fb8eeb 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -10,6 +10,9 @@ ifeq (0,$(MAKELEVEL))
>  endif
>  selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>  
> +uapi_dir = $(realpath $(selfdir)/../../../include/uapi)
> +CPPFLAGS += -I$(uapi_dir)
> +
>  # The following are built by lib.mk common compile rules.
>  # TEST_CUSTOM_PROGS should be used by tests that require
>  # custom build rule and prevent common build rule use.

*thread necromancy*

I think this is fixed in the selftest tree itself now (though
differently), in that it depends on having build the headers first.

Anyway, please let me know if this is still a problem, and I'll take
another look (and hopefully I also won't lose the thread for a year...)

Thanks!

-- 
Kees Cook
