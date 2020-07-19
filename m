Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8194C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A715205CB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJow6EuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGSXk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGSXk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:40:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104EAC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:40:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so16275136ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZpW0k/GYDvGVIbl0AD8+EzyQ0cvSvxP2cZcYFH/y7k=;
        b=uJow6EuX18szt6NUOa6T1OU63SkDJ12uMJMDCypVlQ4UyCCLWtbzrqI0b3RB82R8fw
         iSRz8WiUkKsh4HrYLnWJkIZ2V98SQvlJRt/VIw+EeZxFWiEWMXo8azgO6J/mcMnjqjRK
         Lxpfd8DG3wox1lkoebgjbNwLoMlKD9Olid74qE4qGpJLN0EJe5ke24yuhPLF+EnzebG7
         q+JZvL6+xZubr5P8cdDh8hViP5fpNFJPCpXf213hkkjEeN1P5WVYaJ2htfQQbpkgAh7A
         qAdOLy89OdkpFWW/CCofc3bg6IxoypBMDXA0qdLNJLGPJo+s3Tr2R0h2+ERPZfFDPmsc
         y1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZpW0k/GYDvGVIbl0AD8+EzyQ0cvSvxP2cZcYFH/y7k=;
        b=tnZ37okHeHT2+ME87ZGng7dc+SnbEjBopfco5V1kCBeEl5AgUg2GMwPaDFzlq/Ku+b
         SR4iZaR7TAIP6tw7UPChQtDT20uPMmJl6m20vLFzWqhhR+81AvMru4GtJ7HzBaWBEoKH
         T3+7DD40rs6D51sVaUKQ//RHasaSGVVC0TIaSS3a9J/9HgmRI0GpUgCwIWLqUnkCaCD/
         HhJXZoe2AVQNezp/n7P2gDmda0OrvUvxNdLJ3JVgnvW+19n5r+UHSG7GA4IevdP20PNJ
         NbO2COpM+kjsNYXKD/ErCtw+UZyZa9mc2+TtwYizqORVWkBSJQqC+15dGrCxTnGdCrfB
         R0JQ==
X-Gm-Message-State: AOAM53288bu9eZydjh2uGMx4DmXK28WpXvx41PvmcR7O6gDv0o9VC1fK
        HkpH/jbvAlcAzAxc8KGdD5oNOWN55/5CV3sY1L8=
X-Google-Smtp-Source: ABdhPJx3mwhjoiTZO0scA6X5vKeXp5eX9jIbcfVnsKEhDpm/KbDyD19/yJjkmPkf4Sc98P8QPSCbTmyQuY6iWxs+WYg=
X-Received: by 2002:a17:906:dbed:: with SMTP id yd13mr17940117ejb.419.1595202025654;
 Sun, 19 Jul 2020 16:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200718002003.6e0a2aef@f32-m1.lan>
In-Reply-To: <20200718002003.6e0a2aef@f32-m1.lan>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 20 Jul 2020 09:40:14 +1000
Message-ID: <CAPM=9tzJt5W8YpyBpyr0Xk3OwgA8iEOKe_zOtJSM3FThp38K4w@mail.gmail.com>
Subject: Re: [PATCH] copy_xstate_to_kernel: Fix typo which caused GDB regression
To:     Kevin Buettner <kevinb@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just adding Linus, as Al is oft distracted.

Dave.
>
> This commit fixes a regression encountered while running the
> gdb.base/corefile.exp test in GDB's test suite.
>
> In my testing, the typo prevented the sw_reserved field of struct
> fxregs_state from being output to the kernel XSAVES area.  Thus the
> correct mask corresponding to XCR0 was not present in the core file
> for GDB to interrogate, resulting in the following behavior:
>
> [kev@f32-1 gdb]$ ./gdb -q testsuite/outputs/gdb.base/corefile/corefile testsuite/outputs/gdb.base/corefile/corefile.core
> Reading symbols from testsuite/outputs/gdb.base/corefile/corefile...
> [New LWP 232880]
>
> warning: Unexpected size of section `.reg-xstate/232880' in core file.
>
> With the typo fixed, the test works again as expected.
>
> Signed-off-by: Kevin Buettner <kevinb@redhat.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 6a54e83d5589..9cf40a7ff7ae 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1022,7 +1022,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
>                 copy_part(offsetof(struct fxregs_state, st_space), 128,
>                           &xsave->i387.st_space, &kbuf, &offset_start, &count);
>         if (header.xfeatures & XFEATURE_MASK_SSE)
> -               copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
> +               copy_part(xstate_offsets[XFEATURE_SSE], 256,
>                           &xsave->i387.xmm_space, &kbuf, &offset_start, &count);
>         /*
>          * Fill xsave->i387.sw_reserved value for ptrace frame:
> --
> 2.26.2
>
>
