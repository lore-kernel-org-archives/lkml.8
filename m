Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C15C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F14E20888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZ2EO3Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE0Lte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgE0Lta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:49:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749CC03E979
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:49:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 202so14275542lfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eb8hhRgWhldc6gNCY/BHu4k6Mc3ON849X4b3k08UMU=;
        b=dZ2EO3LdRXmW0rb/PbGBy5/ATbLPpBSpne2iHWL8g4cHa5pFCH5GCbOAD7jC3Kzi3S
         MISYPGpgS2exm9jQV0gLr3s2v7seE3tyMVMGbhwvcq5KWBC2lbp4WRogLsHJmD56dSoF
         SaGqBkdQFcT/Q8+h09FriRhyy32nZ8Qbam2ia6qehADmirwsw9FzofuUIssUXiEf/O1M
         PNKyMGSEEuXIahADQmZbrbIFZkk9iuRkEcQbQIaG2M4cssRD0uw+ZxOkNkqohemuxYe7
         g5KMFqDZR/29AuHUIPPzijSDWnAEbdNVWRVRrdnecAjUZPqBYLoGLUucygRKxHZITQJs
         lRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eb8hhRgWhldc6gNCY/BHu4k6Mc3ON849X4b3k08UMU=;
        b=F8H4StF5+sHzt4r4UrQKXYEEjOiObxdRiA+DnVe6ESgMHlUtpvJyxviZEV35XMgxF7
         ZY81hI94vz9/rooadXAaduoh4QXoRIhaTh6YFt41kfX7KHcZk2Ds6qs7YVsXhl3wqLFV
         rIydEt/6ObS+SypiCf7A9Tk5jFyow3yfqrQ+5TgNfH3uyZluUvfUAjaLYttEVvr5njEG
         DeluAGdyT/XHh/6p9t7vzQKPHmj7d7vz5TnVMox7Nn3qosilctzq2r152BPfRcoXrgCI
         y/79lH9/TLMW9x2TgNaAJ9LdkxRvvZpiHtKYy2HwPV8F5lBcZzEwcVZCWIgcatyvpyec
         j90g==
X-Gm-Message-State: AOAM5321AezCwd16KUEd8a4e/y61gCe7AFapsgOYpO8zPG/DIXPI9KT5
        nvBtCvzNMsRyR5V/D9FEFMVYAoHH68f6VAxXo/AALw==
X-Google-Smtp-Source: ABdhPJxtfHGgD1x+0sGWQDtxJJeB9uCl6Feg/5utDqmnhP3TYYxI7kATndRbmt63ldid6mOZbKhfx/ZSXQlPvqovUXQ=
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr2908078lfb.206.1590580167403;
 Wed, 27 May 2020 04:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131350.29638-1-anders.roxell@linaro.org>
In-Reply-To: <20200511131350.29638-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 27 May 2020 13:49:16 +0200
Message-ID: <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this?

Cheers,
Anders

On Mon, 11 May 2020 at 15:14, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Hi,
>
> This patchset will try to enable as many KUnit test fragments as
> possible for the current .config file.
> This will make it easier for both developers that tests their specific
> feature and also for test-systems that would like to get as much as
> possible for their current .config file.
>
> I will send a separate KCSAN KUnit patch after this patchset since that
> isn't in mainline yet.
>
> Since v2:
> Fixed David's comments. KUNIT_RUN_ALL -> KUNIT_ALL_TESTS, and he
> suggested a great help text.
>
> Since v1:
> Marco commented to split up the patches, and change a "." to a ",".
>
>
> Cheers,
> Anders
>
> Anders Roxell (6):
>   kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
>   kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS
>
>  drivers/base/Kconfig      |  3 ++-
>  drivers/base/test/Kconfig |  3 ++-
>  fs/ext4/Kconfig           |  3 ++-
>  lib/Kconfig.debug         |  6 ++++--
>  lib/kunit/Kconfig         | 23 ++++++++++++++++++++---
>  security/apparmor/Kconfig |  3 ++-
>  6 files changed, 32 insertions(+), 9 deletions(-)
>
> --
> 2.20.1
>
