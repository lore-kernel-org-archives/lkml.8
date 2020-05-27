Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2153BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6222073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntJ5XnpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgE0Swi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE0Swg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:52:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2BC08C5CB
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:35:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x10so10488162plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ac0TzlNqiL+rdZbCAWc33T2M+dlFeVr61CWdwcJ9jPo=;
        b=ntJ5XnpRsas3+IMRMkXV9mcg+6CdbP5T94nDFftj+4ije7j9kUpq40mpLekWlH7lmr
         v0pHPz+h4ZJ7MURzp29LzyPdWpK5hvGFFrBNYkiLR2zpYFkIujD8VfGPfd9EJGJ2RiAH
         eiao4XAVqkbAGxBNqSzZR1BCJagtyVTbzHtnr0RV4y7OVFWJldtsbvj7jS7UOzmirJZn
         8e7c+7y5Dhl9SfuiIxQ+P8quG5KWv6kvHbdpOAf0VGiFlJ1LRg7eUEoXw1khaFbWaOe9
         8mScLq9mra70QUndy0nnxLX5YfwM0TLoSw3U+yyrLPCguSLnac8d3Q4jnxB/MV1JBzS1
         LPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ac0TzlNqiL+rdZbCAWc33T2M+dlFeVr61CWdwcJ9jPo=;
        b=UzSP0Om4kDaoypqPXAMwBHGhlC2YlLsha/7PVrLaIvCOsyBrtsdpjYGQbDGINIxnVO
         xkIWZDKF+f7kpK27TWMaaak/cwM2rrXAKMULC6k+GIb0p2RCyvRZcUs5EM6MisowDuI2
         AgJGzlFCpFnROsYEfwNIxzAi4ZkX6Y5mqGo8Frg9+/wSIgdt8qgByQzd1QHub6SOdNNs
         KCOhauPyufXab6ml6JNJq6cGvKMPlv2Z1PhDaC7uYOagpR1sIAmVNJI7B8iRr9GKvVYx
         h0KukxupJhq3ox7t0guEWrvqnvTP+Do2iglXBlxqVUnd7d42UOfUeWPa7lYLDX+bRzd2
         QBpA==
X-Gm-Message-State: AOAM532tXqPdgbut4EKT42JekubwuqfQwUVPBIWDbwVKzkWEqvtDDyfR
        Ky9eGIsGDv75K5n3woG9Atr1RQ==
X-Google-Smtp-Source: ABdhPJyhIbb+P3aEI+nNHtP5EaxJ5+1NfeT9he/b7PSyOrzjqPRnOl5zjZoroTF+LzRVkxyswCPIDg==
X-Received: by 2002:a17:902:c006:: with SMTP id v6mr6787936plx.53.1590604522433;
        Wed, 27 May 2020 11:35:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id k7sm2497552pga.87.2020.05.27.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 11:35:21 -0700 (PDT)
Date:   Wed, 27 May 2020 11:35:17 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: [PATCH] arm64: disable -fsanitize=shadow-call-stack for
 big-endian
Message-ID: <20200527183517.uhph2pvnkyf6c5p7@google.com>
References: <20200527134016.753354-1-arnd@arndb.de>
 <20200527152406.GD59947@C02TD0UTHF1T.local>
 <CAKwvOdn637hSboMnMV=S5f1wbiEnc6qtnrn=fpeCGtvr2W_Daw@mail.gmail.com>
 <CAK8P3a3-L-AQomvTcBv-KH1cVVu6uYNT_-2Ofir3UgwzGjcSug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a3-L-AQomvTcBv-KH1cVVu6uYNT_-2Ofir3UgwzGjcSug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-27, Arnd Bergmann wrote:
>On Wed, May 27, 2020 at 7:28 PM 'Nick Desaulniers' via Clang Built
>Linux <clang-built-linux@googlegroups.com> wrote:
>>
>> On Wed, May 27, 2020 at 8:24 AM Mark Rutland <mark.rutland@arm.com> wrote:
>> >
>> > On Wed, May 27, 2020 at 03:39:46PM +0200, Arnd Bergmann wrote:
>> > > clang-11 and earlier do not support -fsanitize=shadow-call-stack
>> > > in combination with -mbig-endian, but the Kconfig check does not
>> > > pass the endianess flag, so building a big-endian kernel with
>> > > this fails at build time:
>> > >
>> > > clang: error: unsupported option '-fsanitize=shadow-call-stack' for target 'aarch64_be-unknown-linux'
>> > >
>> > > Change the Kconfig check to let Kconfig figure this out earlier
>> > > and prevent the broken configuration. I assume this is a bug
>> > > in clang that needs to be fixed, but we also have to work
>> > > around existing releases.
>> > >
>> > > Fixes: 5287569a790d ("arm64: Implement Shadow Call Stack")
>> > > Link: https://bugs.llvm.org/show_bug.cgi?id=46076
>> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >
>> > I suspect this is similar to the patchable-function-entry issue, and
>> > this is an oversight that we'd rather fix toolchain side.
>> >
>> > Nick, Fangrui, thoughts?
>>
>> Exactly, Fangrui already has a fix: https://reviews.llvm.org/D80647.
>> Thanks Fangrui!
>
>Ok, great! I had opened the bug first so I could reference it in the
>commit changelog, it seems the fix came fast than I managed to
>send out the kernel workaround.
>
>Do we still want the kernel workaround anyway to make it work
>with older clang versions, or do we expect to fall back to not
>use the integrated assembler for the moment?
>
>      Arnd

We can condition it on `CLANG_VERSION >= 100001` (assuming Tom (CCed)
is happy (and there is still time) cherrying pick the two commits https://bugs.llvm.org/show_bug.cgi?id=46076 to clang 10.0.1)
