Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C49C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE652072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPsFgD2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgCCXV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:21:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgCCXVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:21:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id m3so4690690wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FQrFyte0eQhkHV1ZGTXUg6vu0R7T0FUdhPvhOFpCIYA=;
        b=iPsFgD2jDudXd8oLP5/RlUPiFg4J+72znOLJ5Ska9NJYuN99ZocKhyYTnQVFFC/LYp
         u6mNao0Vp2XS2KzVSf1XBteBO+5kJ7EANKwnUK6BiGc/5vvrMIYMgMuBXVgy8gXML8s7
         d6qQHWKI2j/SbPHE1yEpdE+jr78Ln7Kzjfk7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FQrFyte0eQhkHV1ZGTXUg6vu0R7T0FUdhPvhOFpCIYA=;
        b=R2RZe2pifHc0ipLFD9htxwADxmx7vr8FZOj1Mpkagd2/0T/0EGR2DitptqSP6t8+ae
         c3P5l0qaCEZM4yplbpenLxf43g4g0VtXY6Z3Guej5HOI4AiLqc33fGU64IlW1fbH7Vat
         xXbMvl2YqUBVLVFYRBXyhqRE6eBc87jeDwRnDbgX4vAh2+qxyiVdG9z0Kwc4YFCFMQH4
         3+nKeX9IBUa2NapN5QBwn3VZOMCbA2e7EWxj7prBPtzssvGf5+BwXlTnxsM2T8yyWB2k
         Yh272yupXxf2Toy5MGFl/3g/lBDNVD55E5WpVMBKoyTSFlu9FPJkh+7JaS+Ay2nmZqBz
         LAJQ==
X-Gm-Message-State: ANhLgQ0l6R34mEe2sJpzaRRECGYnAMfZo+7EMqVwS/1vKjBuV9SyKpO+
        xkxOielEdFS9I0fGQfHTfqV3Dg==
X-Google-Smtp-Source: ADFU+vvjC5U+4JJoqO1RDHDrLaBawo0DQx0B1WnD4mQ0pQbrjsUiuJb5tW5VfgKM87eZBTlna4UbcA==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr24028wmg.140.1583277713458;
        Tue, 03 Mar 2020 15:21:53 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id y139sm983960wmd.24.2020.03.03.15.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:21:53 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 00:21:51 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
Message-ID: <20200303232151.GB17103@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-5-kpsingh@chromium.org>
 <CAEf4BzaviDB+WGUsg1+aO5GAtkJuQ6aYSiB8VaKL0CoQRPs8Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaviDB+WGUsg1+aO5GAtkJuQ6aYSiB8VaKL0CoQRPs8Xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Mär 14:44, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > - Functions that are whitlisted by for error injection i.e.
> >   within_error_injection_list.
> > - Security hooks, this is expected to be cleaned up after the KRSI
> >   patches introduce the LSM_HOOK macro:
> >
> >     https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/
> 
> Commit message can use a bit more work for sure. Why (and even what)
> of the changes is not really explained well.

Added some more details.

> 
> >
> > - The attachment is currently limited to functions that return an int.
> >   This can be extended later other types (e.g. PTR).
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
> >  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 8 deletions(-)
> >

[...]

> > +                       t = btf_type_skip_modifiers(btf, t->type, NULL);
> > +                       if (!btf_type_is_int(t)) {
> 
> Should the size of int be verified here? E.g., if some function
> returns u8, is that ok for BPF program to return, say, (1<<30) ?

Would this work?

       if (size != t->size) {
               bpf_log(log,
                       "size accessed = %d should be %d\n",
                       size, t->size);
               return false;
       }

- KP

> 
> > +                               bpf_log(log,
> > +                                       "ret type %s not allowed for fmod_ret\n",
> > +                                       btf_kind_str[BTF_INFO_KIND(t->info)]);
> > +                               return false;
> > +                       }
> > +               }
> >         } else if (arg >= nr_args) {
> >                 bpf_log(log, "func '%s' doesn't have %d-th argument\n",
> >                         tname, arg + 1);
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2460c8e6b5be..ae32517d4ccd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/sort.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/ctype.h>
> > +#include <linux/error-injection.h>
> >
> >  #include "disasm.h"
> >
> > @@ -9800,6 +9801,33 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
> >
> >         return 0;
> >  }
> > +#define SECURITY_PREFIX "security_"
> > +
> > +static int check_attach_modify_return(struct bpf_verifier_env *env)
> > +{
> > +       struct bpf_prog *prog = env->prog;
> > +       unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
> > +
> > +       if (within_error_injection_list(addr))
> > +               return 0;
> > +
> > +       /* This is expected to be cleaned up in the future with the KRSI effort
> > +        * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
> > +        */
> > +       if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
> > +                    sizeof(SECURITY_PREFIX) - 1)) {
> > +
> > +               if (!capable(CAP_MAC_ADMIN))
> > +                       return -EPERM;
> > +
> > +               return 0;
> > +       }
> > +
> > +       verbose(env, "fmod_ret attach_btf_id %u (%s) is not modifiable\n",
> > +               prog->aux->attach_btf_id, prog->aux->attach_func_name);
> > +
> > +       return -EINVAL;
> > +}
> >
> >  static int check_attach_btf_id(struct bpf_verifier_env *env)
> >  {
> > @@ -10000,6 +10028,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >                 }
> >                 tr->func.addr = (void *)addr;
> >                 prog->aux->trampoline = tr;
> > +
> > +               if (prog->expected_attach_type == BPF_MODIFY_RETURN)
> > +                       ret = check_attach_modify_return(env);
> >  out:
> >                 mutex_unlock(&tr->mutex);
> >                 if (ret)
> > --
> > 2.20.1
> >
