Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697FE207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aS8KE4iT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgHTQRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbgHTQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:16:03 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD21C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:16:03 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x6so534780ooe.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpPzndwiSYhaVueh4zOqhGfv4Oo3BxfBjljCA4pNUIM=;
        b=aS8KE4iTIRs5uiKqL5IP+COnR+Ldcy7QhNI0Fs+SpBbNkrd+GF28NFlOZwVXfU00zl
         j9xlxMBX1SaNs94apFw+bOvHsfgwzhfHg1mPOjpSs/xwohYSdnaeU8+R/NArdJ7qfbDH
         VS5lDOzW9PQPL6PgxyyMlRs2hVSikCAJXxPls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpPzndwiSYhaVueh4zOqhGfv4Oo3BxfBjljCA4pNUIM=;
        b=aZK5+/FIteJa4Q5cGHaqEzqKzhEk6cKFSnf5J/8shpNXDC45Paou0v/SFZy3mNTuUp
         QE+pWCJwd5l5YV3DXLRSxefYRrjn8RqF3jjONea6MU7sC1TSB04igrkkuid2JWjQufRZ
         0J8iVsWHMRs2VPy59+eIJ9u2+RFH7wR1lYXSCBfNMZ2UeqW1N5C9hLi35nubD0WygV4z
         /u3R+81JOK0Ku4cHhRoZ4N+tOToAFRPWMeeEdyjoVqvuEkGBPo9znyZ7sT6Sk6Vc46LJ
         DUorrhqfoA4ID50TcSg6SfjTAu6dCAU0pknacsl5bRLFIJ6gLxwzrVHZPJljWlJt91it
         8Bmg==
X-Gm-Message-State: AOAM531g6liwZ73P8CrQVYTav8EP3jRDwuF4c3+KmdYF+AVInVeuRE2N
        fz7gVMWWQsit2as+GfaaJk/W5GKR/4Ko0bYAfhQhGA==
X-Google-Smtp-Source: ABdhPJxhIFwfgHxw3SxwdM5trgHfAXmTzg6cKfXYVIO/ijSC/WKBlr9CdxjuEg4Cgs9XTqRC/fGONcWAjPxBeg7NZYw=
X-Received: by 2002:a4a:de49:: with SMTP id z9mr3004747oot.6.1597940160388;
 Thu, 20 Aug 2020 09:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200820135729.135783-1-lmb@cloudflare.com> <20200820135729.135783-5-lmb@cloudflare.com>
 <34027dbc-d5c6-e886-21f8-f3e73e2fde4a@fb.com>
In-Reply-To: <34027dbc-d5c6-e886-21f8-f3e73e2fde4a@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 20 Aug 2020 17:15:48 +0100
Message-ID: <CACAyw98gaWmpJT-LPhqKbKgaPG9s=aNU=K2Db1144dihFHzXJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: override the meaning of
 ARG_PTR_TO_MAP_VALUE for sockmap and sockhash
To:     Yonghong Song <yhs@fb.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 17:10, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/20/20 6:57 AM, Lorenz Bauer wrote:
> > The verifier assumes that map values are simple blobs of memory, and
> > therefore treats ARG_PTR_TO_MAP_VALUE, etc. as such. However, there are
> > map types where this isn't true. For example, sockmap and sockhash store
> > sockets. In general this isn't a big problem: we can just
> > write helpers that explicitly requests PTR_TO_SOCKET instead of
> > ARG_PTR_TO_MAP_VALUE.
> >
> > The one exception are the standard map helpers like map_update_elem,
> > map_lookup_elem, etc. Here it would be nice we could overload the
> > function prototype for different kinds of maps. Unfortunately, this
> > isn't entirely straight forward:
> > We only know the type of the map once we have resolved meta->map_ptr
> > in check_func_arg. This means we can't swap out the prototype
> > in check_helper_call until we're half way through the function.
> >
> > Instead, modify check_func_arg to treat ARG_PTR_TO_MAP_VALUE* to
> > mean "the native type for the map" instead of "pointer to memory"
> > for sockmap and sockhash. This means we don't have to modify the
> > function prototype at all
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >   kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b6ccfce3bf4c..24feec515d3e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3872,6 +3872,35 @@ static int int_ptr_type_to_size(enum bpf_arg_type type)
> >       return -EINVAL;
> >   }
> >
> > +static int resolve_map_arg_type(struct bpf_verifier_env *env,
> > +                              const struct bpf_call_arg_meta *meta,
> > +                              enum bpf_arg_type *arg_type)
> > +{
> > +     if (!meta->map_ptr) {
> > +             /* kernel subsystem misconfigured verifier */
> > +             verbose(env, "invalid map_ptr to access map->type\n");
> > +             return -EACCES;
> > +     }
> > +
> > +     switch (meta->map_ptr->map_type) {
> > +     case BPF_MAP_TYPE_SOCKMAP:
> > +     case BPF_MAP_TYPE_SOCKHASH:
> > +             if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
> > +                     *arg_type = ARG_PTR_TO_SOCKET;
> > +             } else if (*arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
> > +                     *arg_type = ARG_PTR_TO_SOCKET_OR_NULL;
>
> Is this *arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL possible with
> current implementation?

No, the only user is bpf_sk_storage_get and friends which requires
BPF_MAP_TYPE_SK_STORAGE.
I seemed to make sense to map ARG_PTR_TO_MAP_VALUE_OR_NULL, but I can
remove it as
well if you prefer. Do you think this is dangerous?

>
> If not, we can remove this "else if" and return -EINVAL, right?
>
> > +             } else {
> > +                     verbose(env, "invalid arg_type for sockmap/sockhash\n");
> > +                     return -EINVAL;
> > +             }
> > +             break;
> > +
> > +     default:
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> >   static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         struct bpf_call_arg_meta *meta,
> >                         const struct bpf_func_proto *fn)
> > @@ -3904,6 +3933,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               return -EACCES;
> >       }
> >
> > +     if (arg_type == ARG_PTR_TO_MAP_VALUE ||
> > +         arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
> > +         arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
> > +             err = resolve_map_arg_type(env, meta, &arg_type);
>
> I am okay with this to cover all MAP_VALUE types with func
> name resolve_map_arg_type as a generic helper.
>
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> >       if (arg_type == ARG_PTR_TO_MAP_KEY ||
> >           arg_type == ARG_PTR_TO_MAP_VALUE ||
> >           arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
