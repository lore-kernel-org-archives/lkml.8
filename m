Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DD3C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AD1206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="UEBq0g6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgGWMdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgGWMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:33:18 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF1C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:33:18 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d133so814228ybh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFgfTkrSPliJdcE2ZgsQWMPTGBVr0aakFg2hA0SWopU=;
        b=UEBq0g6zVMlm+ZOvqr+tCAlWDUA/6n2VoQROx1IZzoTys38IcwrQeOz+GShfaQzW+J
         To5Bmc/Zh7gMKe+cCUyDCqT0y3en2zd0IK7nUUAkONV9Mb0l0kObjCF9GUlkRAudUBhB
         HY/ksvKxacwrGibAXXusQ9lTg2v0qGKwWQ0/C+FS/FqdBwHdECBWUf37nyCrVtjtyq6i
         +vVvOqRZYus8UJRW+lDKpj8v7GVkGvAJoA9I1Lv/lXXf0CUAs1GOqfb6nvbye/plV4Bq
         PtASg15+JaR18XbvVx+Q00QoPJZi2CBDabxZF+Xj6xVM+fDz0gYI3vfatj5joQYchIDI
         2Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFgfTkrSPliJdcE2ZgsQWMPTGBVr0aakFg2hA0SWopU=;
        b=WwX5751rnD1fDeqQcYcIt+bbXCmlAFFH7vEJS7KcYJOp88fvWO+Qg7+pnmNxdqWcOS
         Zuw6Pi7n+6INbcgDsDVbUEx29er+iufjcchpwjg9dUhGKPD5aOWugZQ2z7JBvZm8qBOP
         kO4hmWWocjVL7UkIf3ACIHru96w/ZmQDfKdGHfDorW3aFWHP0C5V5VtM5C7dW8+11Nsc
         23Pt+4sof2/Ru+zfi0CsymmZ+7/ZYjARG9Wg0554GudwX9/bBdgt5shoXRsycocvyQMU
         +8O7uZcBbHW/fK5eLgnGy3yhZsyF1F+oXPDumAgvQfdR/rG39gFmycc1rkvgNVDucj5R
         YfMg==
X-Gm-Message-State: AOAM533C9lM8Nv4GQ511T6y4f8j3ovUpxvjPirpao/SOtScuk8g1xUzu
        T8TZDp1qXkqPsVqUMOpkgrcYPZ8iTFtui2cYtfpKfg==
X-Google-Smtp-Source: ABdhPJyhPrvkl3wnqOJZR+KE4dXDzdfdmBF8NSWdbQMOAwRHnH9rqpSXNAdzCEMhnvUlDuTGwR1GdEdZ4pIM0+kNO2A=
X-Received: by 2002:a25:cfd2:: with SMTP id f201mr6479953ybg.286.1595507597470;
 Thu, 23 Jul 2020 05:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200723000807.171940-1-vitor@massaru.org> <20200723080444.GE3703480@smile.fi.intel.com>
In-Reply-To: <20200723080444.GE3703480@smile.fi.intel.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Thu, 23 Jul 2020 09:32:41 -0300
Message-ID: <CADQ6JjVujdtaG7HxOLxg=vuGjFt--sZ9+6QzY0ZXQuOVBDn+7Q@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: Convert test_sort to KUnit test
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, fkostenzer@live.at, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 5:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 22, 2020 at 09:08:07PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the test_sort.c to KUnit test.
> >
> > Please apply this commit first (linux-kselftest/kunit-fixes):
> > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> ...
>
> >  lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------
>
> Is it established practice to put kunit as a suffix?

Not yet. https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u

Thanks
