Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D772AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A762620756
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y99O/yGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgFOSX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:23:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24FCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:23:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v14so2938599pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VZ367eGT3ifWurfr8UHCEsC6mmGGvWYTzHujRDMm0c=;
        b=Y99O/yGXhFb/+FMNsF2zDd0bzBnKGzroBZJ7NXu+iMXnAGS4/KKVJHNTFR6m2Z+gpN
         670vgfCwUYfO3zVSAsYWkxw7pQ55yR2bwQDgEqe5F5JHQctH83HbXxbFir2SvHIdfpN1
         cfk49PsS5ea6fgoOX7yKhx+SGGoL6y131gvcXywcBftHrqChxeM2t+VMNNT4AlKqU6TP
         FffvsC1SopKhiM2OFhesmbc3k4XnUl8ADzOacgDkNVxDhaAehrXzNPkG5Jbyd0pGXeR5
         92hYrbNVkyYeH0vbzIQLd7+R2XrsniamzXZq+CQmIR2kV0kDUCMSQDhcWelJF6Wppabp
         HkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VZ367eGT3ifWurfr8UHCEsC6mmGGvWYTzHujRDMm0c=;
        b=TMEAYAVGbkcFLs7qBvomd452s0U6ux2slD8U+z+zWxNGETBY4pQnhUSPvkYMCpmGbE
         NJCcwx14XXWp61V+R3/JKgytmetwcy9QuSGuySamjdpVRQdT+M/6czcbYIG/Db1QHijN
         zQjbJt9n9/WNcbJzi0ddkZeJPVhRsff75u0udkSS8CaXWl9MdyUNjBnEfEZNWEbfms4Z
         dBM5Bs58+Lbk5qCBiMYP1eVsHtaHSh9l2He/jygYz0do3GdzqOpLqZtU6jnFkfLufXlu
         +wVGuyW2lFpIPtsD05NtfAMfmCyL3L5DtPk1tKyF4RzpjKQU4X/UCLKWmUMZgTN+b0Nh
         a7hw==
X-Gm-Message-State: AOAM533kPqLzAhoTAI52n5MvSDAeXrErWFYByvwKKmL7hyQ8YpCl/Aii
        ZGoUqRiWK/Rx59z6gDNtVHP0vQXG0iobREGrgXYMFQ==
X-Google-Smtp-Source: ABdhPJxOFJlZsySJxeHdV5MjdtePCRSfDcVVTuV0dgbDBfMbuMhFS1KasAR0L0DVA+poXXt9t4Vi7rCooEWiSzEVvkM=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr24653669pfu.169.1592245436161;
 Mon, 15 Jun 2020 11:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200615181232.119491-1-samitolvanen@google.com> <202006151113.7A2F638A7@keescook>
In-Reply-To: <202006151113.7A2F638A7@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Jun 2020 11:23:44 -0700
Message-ID: <CAKwvOdkdy10K+6Jw=Sd4PxrvQgc=HssoJqJN9q8NVWkWiuZtRQ@mail.gmail.com>
Subject: Re: [PATCH] security: fix the key_permission LSM hook function type
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:21 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 15, 2020 at 11:12:32AM -0700, Sami Tolvanen wrote:
> > Commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than
> > a mask") changed the type of the key_permission callback functions, but
> > didn't change the type of the hook, which trips indirect call checking with
> > Control-Flow Integrity (CFI). This change fixes the issue by changing the
> > hook type to match the functions.
> >
> > Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Thanks for fixing this!
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> I wonder if there is any compiler option we can turn on to catch the
> implicit enum/int casting that would help for these kinds of things
> without absolutely exploding the build warnings.
>
> I see -Wenum-conversion, but that seems to be between enums, not between
> int.
>
> I see this, but it's external:
> https://noamlewis.wordpress.com/2017/10/05/type-safe-enums-in-c-using-a-clang-plugin/

Unfortunately, using a looser integral type is the typical workaround
for -Wenum-conversion warnings (which is on by default, GCC recently
added that flag, too).  For warning on enum to int, the kernel would
probably blow up with warnings. I don't know of any such existing
warning flag.

>
> -Kees
>
> > ---
> >  include/linux/lsm_hook_defs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 6791813cd439..24f6683f1cfc 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -360,7 +360,7 @@ LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
> >        unsigned long flags)
> >  LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
> >  LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
> > -      unsigned perm)
> > +      enum key_need_perm need_perm)
> >  LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **_buffer)
> >  #endif /* CONFIG_KEYS */
> >
> >
> > base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> > --
> > 2.27.0.290.gba653c62da-goog
> >
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202006151113.7A2F638A7%40keescook.



-- 
Thanks,
~Nick Desaulniers
