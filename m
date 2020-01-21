Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E80FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BD0206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQvDqxcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAURIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:08:41 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52895 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAURIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:08:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id a6so1660137pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIrTm/RxgY9EJkd3a5Dr38zt2odYwh4TDnr6W5Q+qys=;
        b=gQvDqxcxdamKDQrZx2OQCok3qtKY3gXBWh4kYRqnRnBq3Tkh1aaFaeGIKHiz/q0XGi
         Mlwt/HO/kGUaNKD5Mq7nh8fgYlnqqMEZVQZYcFySKshuCXjiXSSSH2AqSvlbQII4hoVi
         jnBeZQwvk4YTimzyM89BqTwleDidtDJ8+z8Go8jo4lypBMOvp6w1pU3I3AhSv93GugZC
         JT4ipzNaOPItexENB24NeBr8e2BiLREU4dQXqYAeMUhGMeK+33xmXGQ4/2mh0wFF/nBn
         +dwa7kTQlvhCWcSjNa/jW4qQyw3tGQyvcBm2A1Bm04SrnpuucgRNkH3Pv61+hPkCG8Fv
         xBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIrTm/RxgY9EJkd3a5Dr38zt2odYwh4TDnr6W5Q+qys=;
        b=R/RztnUr6OrMwjTsRg2BGJvhO2C8GLCE/gJp3wTru14BRVzBvI7ioM/Fy1OvXspT0J
         1MKIeOA/fZswBxQ1dX2oAELKYIK8IQHZ8A/WcLYzP8XP1uYpc1R6th4DW5ipkpx52Sd6
         x8oxHeMtTXQspCZN6MxSJBGf1gWHQLR0dTLvYDfMfy0lIh/IAJ4lb3ZHkCZ0KptBfkpo
         jzyun3JIiuJ/Z09ud9BI7FSVxEAvzDtQFjW5jTWKT5NZeV1x+tGH5TE21Ta4uiujLZpG
         Xx6PuMcSTHyr460imocg8xV18Wmda2t/XbPo9DKPNaMcMW98gowHKp+sOqS1OyhrrGjP
         RNTg==
X-Gm-Message-State: APjAAAWqR2llKA3EJvICZ1oIdkUiEsUBrUSdmT98JoEN2BnB+KROCi1H
        EHmgXc5AYs+rXaOEbGUuj1DVDA3HWq1x0Q61SkvrjQ==
X-Google-Smtp-Source: APXvYqyo9e64PgawBWyRyPp9bGng3lznayTKxwdX64VZLwZ6nVF+OLAlVfVCrYhXiMNMWoiqJcRPm8Aq9CNAsyYaKCA=
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr6604608pjk.134.1579626520305;
 Tue, 21 Jan 2020 09:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20200109160300.26150-1-jthierry@redhat.com> <20200112084258.GA44004@ubuntu-x2-xlarge-x86>
 <d5bf34f0-22cc-ba46-41b4-96a52d7acfa4@redhat.com> <20200121103101.GE11154@willie-the-truck>
In-Reply-To: <20200121103101.GE11154@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jan 2020 09:08:29 -0800
Message-ID: <CAKwvOd=_PqQWUvd_WZRpEr+T==3w6LpsHKBz3E9ybaQ0javVkw@mail.gmail.com>
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
To:     Will Deacon <will@kernel.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 2:31 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jan 13, 2020 at 07:57:48AM +0000, Julien Thierry wrote:
> > On 1/12/20 8:42 AM, Nathan Chancellor wrote:
> > > The 0day bot reported a couple of issues with clang with this series;
> > > the full report is available here (clang reports are only sent to our
> > > mailing lists for manual triage for the time being):
> > >
> > > https://groups.google.com/d/msg/clang-built-linux/MJbl_xPxawg/mWjgDgZgBwAJ
> > >
> >
> > Thanks, I'll have a look at those.
> >
> > > The first obvious issue is that this series appears to depend on a GCC
> > > plugin? I'll be quite honest, objtool and everything it does is rather
> > > over my head but I see this warning during configuration (allyesconfig):
> > >
> > > WARNING: unmet direct dependencies detected for GCC_PLUGIN_SWITCH_TABLES
> > >    Depends on [n]: GCC_PLUGINS [=n] && ARM64 [=y]
> > >      Selected by [y]:
> > >        - ARM64 [=y] && STACK_VALIDATION [=y]
> > >
> > > Followed by the actual error:
> > >
> > > error: unable to load plugin
> > > './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so':
> > > './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so: cannot
> > > open shared object file: No such file or directory'
> > >
> > > If this plugin is absolutely necessary and can't be implemented in
> > > another way so that clang can be used, seems like STACK_VALIDATION
> > > should only be selected on ARM64 when CONFIG_CC_IS_GCC is not zero.
> > >
> >
> > So currently the plugin is necessary for proper validation. One option can
> > be to just let objtool output false positives on files containing jump
> > tables when the plugin cannot be used. But overall I guess it makes more
> > sense to disable stack validation for non-gcc builds, for now.
>
> Alternatively, could we add '-fno-jump-tables' to the KBUILD_CFLAGS if
> STACK_VALIDATION is selected but we're not using GCC? Is that sufficient
> to prevent generation of these things?

Surely we wouldn't want to replace jump tables with long chains of
comparisons just because objtool couldn't validate jump tables without
a GCC plugin for aarch64 for some reason, right?  objtool validation
is valuable, but tying runtime performance to a GCC plugin used for
validation seems bad.
-- 
Thanks,
~Nick Desaulniers
