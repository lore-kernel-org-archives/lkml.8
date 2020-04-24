Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A5C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF582075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZE878Fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDXGzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbgDXGzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:55:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE92C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:54:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so9380857wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suQ4RDO6wFMF7yNndDjyQyI4nxOZRUEOPb3EJG29NcI=;
        b=XZE878Fe3CvfJwClJO4OFMDn98hJmO2fQ6LWYqcDaiLo+3JL4q/Zd7jGgD5gmAm40v
         kKgK9DhGf3dTYA0zKn5Td5ADNw5PentPTkTwcYV75JjFS5DfR43viYXGpnjuWlz/VbUF
         IEEd8oDeVr+yil+plMELkeB58E6npuPNwf6UQpX2nY24JQ+pcS3uIOCNXjIxHIG7LVNG
         hfPP43NqUJ5f1R/97apyFagFwdeLBIpJKfRirjSaJE+pdgR10SlRSgPuUmEw9oaMi8uY
         JAw7Gd44uPR5tHfOA5CeDnZiixqymoffif8LsUBxRYsiutoM7/sr9RrU60VSRUueAeAf
         Ql7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suQ4RDO6wFMF7yNndDjyQyI4nxOZRUEOPb3EJG29NcI=;
        b=RWq3G0S/AKPkCgOegm5PjEaC0nJLTaWS5bjFitEkO+CCJT1a6TOURWv2/EI0QmjQtb
         5KGLEOKNfZUO0gupakCK1PuPz7PYdwlqc1zdZ7Xr4hipKImoUtwrRhmdrTg3BNXD9YnE
         SXwypqWMEIoL1ks7VqrAB7NR9fu5GYLTzbFTy58CvLpcic3/vOT2GV8GoiCaxk8FVKr+
         dxY4ijkDXdlHnuxbl+XUys44VwsUuBbRbWvaogs96FXi1aLBfyTI6sZlhU6iRUPAjJym
         HL0UOzx0f8avnktEcaR0TLrIEISfWNpGIEteMis6kVjp9pMLYOZte5rkYPh42ka1+uuB
         yPNw==
X-Gm-Message-State: AGi0Pubnjvh6SA4fkFnsayQ+JXtTcUWaRWzc2Wt/CDIqFBrIPFsCgl2u
        OPViXbLQvt5Mh8fnoOivv3LtYemU305MgLYlP/FON3CNTC+RRpk+
X-Google-Smtp-Source: APiQypK0X/llYwGmgoAx2FKi2APDvwatdgw54G+xdccmhBBObjobcT63Tc2IwOpD1Vd5LlrpanOhXQqK2MExJ3YVixM=
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr9377644wrx.203.1587711294889;
 Thu, 23 Apr 2020 23:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200423154503.5103-1-dja@axtens.net>
In-Reply-To: <20200423154503.5103-1-dja@axtens.net>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Apr 2020 14:54:43 +0800
Message-ID: <CABVgOSkwn2Y0khsWw4xLASj5e-m7hng6Z+5wCMYomZbZGn_N2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
To:     Daniel Axtens <dja@axtens.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>, christophe.leroy@c-s.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 11:45 PM Daniel Axtens <dja@axtens.net> wrote:
>
> 3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
> memchr, memcmp and strlen. I have observed this on x86 and powerpc.
>
> When FORTIFY_SOURCE is on, a number of functions are replaced with
> fortified versions, which attempt to check the sizes of the
> operands. However, these functions often directly invoke __builtin_foo()
> once they have performed the fortify check.
>
> This breaks things in 2 ways:
>
>  - the three function calls are technically dead code, and can be
>    eliminated. When __builtin_ versions are used, the compiler can detect
>    this.
>
>  - Using __builtins may bypass KASAN checks if the compiler decides to
>    inline it's own implementation as sequence of instructions, rather than
>    emit a function call that goes out to a KASAN-instrumented
>    implementation.
>
> The patches address each reason in turn. Finally, test_memcmp used a
> stack array without explicit initialisation, which can sometimes break
> too, so fix that up.
>
> v3: resend with Reviewed-bys, hopefully for inclusion in 5.8.
>
> v2: - some cleanups, don't mess with arch code as I missed some wrinkles.
>     - add stack array init (patch 3)
>
> Daniel Axtens (3):
>   kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
>   string.h: fix incompatibility between FORTIFY_SOURCE and KASAN
>   kasan: initialise array in kasan_memcmp test
>
>  include/linux/string.h | 60 +++++++++++++++++++++++++++++++++---------
>  lib/test_kasan.c       | 32 +++++++++++++---------
>  2 files changed, 68 insertions(+), 24 deletions(-)
>
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200423154503.5103-1-dja%40axtens.net.

Thanks, Daniel!

For the series:
Tested-by: David Gow <davidgow@google.com>

(Though I will mirror Dmitry's comment[1] on patch 3 -- I also have a
memset() already present in my branch...)

I'd been digging into what turns out to be this issue, which we were
seeing sporadically[2] with the KUnit port of these tests. v7 of the
KUnit port[3] includes your changes, and fixes the issues.

Cheers,
-- David

[1]: https://lkml.org/lkml/2020/4/23/838
[2]: https://lkml.org/lkml/2020/4/18/570
[3]: https://lkml.org/lkml/2020/4/24/80
