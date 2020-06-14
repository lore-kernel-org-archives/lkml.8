Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFC3206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aIwjQl1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgFNRsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgFNRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:48:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332EC03E969
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 10:48:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so4336215pge.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iVzpsWsc+ucplBrjqeKrqJAgIWgN+U4AVWHu2CnNfCw=;
        b=aIwjQl1sUiDQ2w0UO6H5e+TIMjXcNjQhvZvthliLOZyfJEdErfxsx9txCoJekTR1hW
         NzbqMEA2ougHWqc3j9sPog4RX9IBSGvyEBS0Fg4w5wuU6pPuGNmKl5YaEItykcdgw0dl
         TwnrEKrubrUOYnfVYJoOsGWqnoHEpQ+GfCWYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iVzpsWsc+ucplBrjqeKrqJAgIWgN+U4AVWHu2CnNfCw=;
        b=PZNp7Fnra/8ZmZ+4721v5xaj78HaF/1AmpHPGAx2jk/7CulNCw7vjRx0Jj4FbKJsId
         hIBqAVxTVdkE15Z9gPpF+2kuYO8Mn3ShVgrnxN5ofdOlnfEFJznGCnjmSvolhUgn9Vop
         tIMwdtVCkkEKakYGff4dXdB7LTo8h2kfTuElzH6QUy5QTxJ20Ko3h6WUiO23WOqDGMvI
         JuQsMPItEAz3KtiAbeEZkD71k2sQdcmouaIR/WP2g+AidnDaVb0vO40o9SXi35hm8fQy
         HPEBC4X6T73iO8L/5NWjcHQg3UWdq7wpWT/iERH9Re2yAFLD2L1QWtYRoWiHjRZJfxZC
         eqKg==
X-Gm-Message-State: AOAM531TriDgGJRdh/mDsR6GDhhNt0FJbMDMuM5OSVvu/wtBDe3TIFhW
        zbJoVJjBao7KoFkQwk0CDPn+Zg==
X-Google-Smtp-Source: ABdhPJz0NFGLAM2yH1jkaSAar+jnewZ2I8xuCgJU32vfOT0pkbbbCkbDUG8eaxV2MohCGeOtVouAlg==
X-Received: by 2002:a63:4f1b:: with SMTP id d27mr18066209pgb.389.1592156891996;
        Sun, 14 Jun 2020 10:48:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ca6sm10154511pjb.46.2020.06.14.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 10:48:11 -0700 (PDT)
Date:   Sun, 14 Jun 2020 10:48:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: common KUnit Kconfig and file naming (was: Re: [PATCH] lib:
 kunit_test_overflow: add KUnit test of check_*_overflow functions)
Message-ID: <202006141005.BA19A9D3@keescook>
References: <20200611215501.213058-1-vitor@massaru.org>
 <202006121403.CF8D57C@keescook>
 <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 02:51:17PM +0800, David Gow wrote:
> Yeah, _KUNIT_TEST was what we've sort-of implicitly decided on for
> config names, but the documentation does need to happen.

That works for me. It still feels redundant, but all I really want is a
standard name. :)

> We haven't put as much thought into standardising the filenames much, though.

I actually find this to be much more important because it is more
end-user-facing (i.e. in module naming, in build logs, in scripts, on
filesystem, etc -- CONFIG is basically only present during kernel build).
Trying to do any sorting or greping really needs a way to find all the
kunit pieces.

> Both of these are slightly complicated by cases like this where tests
> are being ported from a non-KUnit test to KUnit. There's a small
> argument there for trying to keep the name the same, though personally
> I suspect consistency is more important.

Understood. I think consistency is preferred too, especially since the
driving reason to make this conversions is to gain consistency with the
actual tests themselves.

> Alas, the plans to document test coding style / conventions kept
> getting pre-empted: I'll drag it back up to the top of the to-do list,
> and see if we can't prioritise it. I think we'd hoped to be able to
> catch these in review, but between a bit of forgetfulness and a few
> tests going upstream without our seeing them has made it obvious that
> doesn't work.
> 
> Once something's documented (and the suitable bikeshedding has
> subsided), we can consider renaming existing tests if that seems
> worthwhile.

Yes please! :)

> My feeling is we'll go for:
> - Kconfig name: ~_KUNIT_TEST

As mentioned, I'm fine with this, but prefer ~_KUNIT

> - filename: ~-test.c

I really don't like this. Several reasons reasons:

- it does not distinguish it from other tests -- there is no way to
  identify kunit tests from non-kunit tests from directory listings,
  build log greps, etc.

- the current "common" naming has been with a leading "test", ignoring
  kunit, tools/, and samples/:

	53 test_*.c
	27 *_test.c
	19 *[a-z0-9]test.c
	19 selftest*.c
	16 test-*.c
	11 *-test.c
	11 test[a-z0-9]*.c
	 8 *-tests.c
	 5 *-selftest.c
	 4 *_test_*.c
	 1 *_selftest_*.c
	 1 *_selftests.c

(these counts might be a bit off -- my eyes started to cross while
constructing regexes)

- dashes are converted to _ in module names, leading to some confusion
  between .c file and .ko file.

I'd strongly prefer ~_kunit.c, but could live with _kunit_test.c (even
though it's redundant).

> At least for the initial draft documentation, as those seem to be most
> common, but I think a thread on that would probably be the best place
> to add it.

I'm ready! :) (Subject updated)

> This would also be a good opportunity to document the "standard" KUnit
> boilerplate help text in the Kconfig options.

Ah yeah, good idea.

-- 
Kees Cook
