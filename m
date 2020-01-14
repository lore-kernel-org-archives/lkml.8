Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD0C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160F12187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhW4irqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgANVjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:39:17 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:55001 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgANVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:39:17 -0500
Received: by mail-pj1-f74.google.com with SMTP id a31so8823954pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ogwhwUXjz2D7m/McSi2ptUkkZ3HC7rjK02YCOSGV8GE=;
        b=OhW4irqszOSJyDSvCfs5rVBGVRl1LZh4zh4uVXI73J5klWOhLw/5SDmpqhDOKCnM2X
         NGos6pYg0iLuzFx3qJueCMUI1/L11oDhEn/FYXQuc8gdgfAmVRk4YpHcQUI67TUzTXj/
         4lJM/xG1EBxMa5+lehOz78N6V9Y8s+gW7uCIfcwox73+wxv1FgiA1DXCJSPIVGhB5gXY
         7AlKOIg1lTrxmm5r2M6gy+KxRQmbuZKjXMrQM4YPYOIwCS/TrJiIV1zPpiLTp1Q7MOK7
         hboocq7wQmlGwoz5x1UopoCo+SNAP8fRSgZygJXJ0lAslC3tt407KsUlCSKfFTA4GcMB
         kgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ogwhwUXjz2D7m/McSi2ptUkkZ3HC7rjK02YCOSGV8GE=;
        b=SdfDC1CPi9YYf0m4YbymkWjYcvoat8y2wEW28m0jFnOLPvh4fXbECxlk0UvyTNxb89
         aEzv96HuauoMdChcuRm51LZlTNp8zv8Two4cuWdyy/JLYefgjFfEVkz35RswBrRFNiOe
         ywpPf0MsAc7dXxX07FU/YcJLUWORfKZspZCiT4RstQ1/ewXWPSaqeLn/bIbuin7M+5yX
         zzWG+BRc2AYVz+GIBfty2jap0BIlMF5uQ6RVfSmC5ZGAoO/naVu9fz5NHMM6YmsesOj0
         14sP57ssE6Z1vkgu91x68hNRdKPRYTj2xPMcu09LvRXyYJK9ZS/FcaH2b9IYvubAcZfW
         J+vw==
X-Gm-Message-State: APjAAAXfWmF79DqBINXM+3+FoFre0gM7Y3NtRjkMAFsHrWCNh9ViypVF
        jdE9/VqSUpDHf6hJuWUJTp/ZPua+4GJEIJE/Wm0=
X-Google-Smtp-Source: APXvYqwzOvBXrG1xFJQFoXWEGTfW6FOLv6mPSRufxWiMXQB9cMwFuAmW+oQTtfPbyjsX4FNOAHEp5TVIiY7QhB3ebB4=
X-Received: by 2002:a63:201d:: with SMTP id g29mr30212874pgg.427.1579037956432;
 Tue, 14 Jan 2020 13:39:16 -0800 (PST)
Date:   Tue, 14 Jan 2020 13:39:14 -0800
In-Reply-To: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
Message-Id: <20200114213914.198223-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     arnd@arndb.de
Cc:     borntraeger@de.ibm.com, kernel-team@android.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        luc.vanoostenryck@gmail.com, mpe@ellerman.id.au,
        peterz@infradead.org, segher@kernel.crashing.org,
        torvalds@linux-foundation.org, will@kernel.org,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 06:35:02PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> >
> > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > discarding the 'volatile' qualifier:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >
> > We've been working around this using some nasty hacks which make
> > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > kernel builds now, emit a warning if we detect it during the build.
> 
> No objection to recommending gcc-4.8, but I think this should either
> just warn once during the kernel build instead of for every file, or
> it should become a hard requirement.

Yeah, hard requirement sounds good to me. Arnd, do you have stats on which
distros have which versions of GCC (IIRC, you had some stats for the GCC 4.6
upgrade)? This allows us to clean up more cruft in the kernel (grep for
GCC_VERSION).

Will, Documentation/process/changes.rst should also be modified.

Android is still using GCC 4.9 (which is more like GCC 4.8 plus patches), but
I've been actively moving them (to Clang) over the past 2 years. I'll check
with our other internal distro's and give them a heads up.
