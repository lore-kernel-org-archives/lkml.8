Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218ABC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB6720758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRN84o1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgERUQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgERUQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:16:53 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B836C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:16:53 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id v26so6433077vsa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2L5t1Sp95sqTVtR6AkRUlfVW8JMFNazZ3b7/dWgmdc8=;
        b=lRN84o1P2f4cfUorpdVHKEFMmmGBZQXD3/THcziCpkhwowpSJz9mGQ2ehXmxCkh8oc
         pOW86mIRYwu+9fWgatuAJwruTnN2l5B5fxBv5tktzAmD4GKJWx8s3aWb8Bec1zsYZRV9
         s/glNUkXcauOZiJ6R4rPMaMSd386/y7VGOh3GZvhdJwEQLOM/lwFcRWGA1Nue1iuI/Jy
         ILQDFIMUphst8PxHU2lyktW3i19RyvKdNN06v/8ej1Lnm4kRDBarQO5FoIz2dZ8SLphK
         mZy3gOu8rxCusU8vVTwsigC3qdMnHKKSSQXh+O6X0g36Zl428GSRiM/Ya+zDJbbGToEx
         boZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2L5t1Sp95sqTVtR6AkRUlfVW8JMFNazZ3b7/dWgmdc8=;
        b=H4Btoj/3de87Sdq6jw9a6rIUvXRfMEq4oXnL7j6VHq4HS5/CJo1HTsjq4FA3v+6PTU
         XgBquAe+Dlpe88iIs4WLDHWkga2+uSNv6ajjxoA986oZaKhG5S8FGdcbqCU463j3qk/L
         +1tHQkH2XRuZtlJWXRgYNLDXEvjtN6RhFXPoe2U5/Dh2af4zqoHC7583erIJfBOLz7pS
         /0Ob7hK6JRnDmCRHp1SEWnQy5E4hmTkEZ10+/R947Mj8ye8utyk9Momt3NVAUoe4XlhP
         ZUXOSQpfueXTtzHXDPNGqPrKxqHLNp7wEoVvW0XnelXDZF3Al5kNiEUlGdxufdRrrJRV
         EwUw==
X-Gm-Message-State: AOAM530WOwLRxx3zzcU4joFrwSLVyHO72QSATjrGqPbWI3hggCHLRfXf
        p6V70gde8zJfjXLv3IyquFbZ6tnNfJPzjfc+dCpNTg==
X-Google-Smtp-Source: ABdhPJw+AcUDhLRBTX9JpNUTxsZ7Ig4UDXf8LfIgGLCMsDdhtI6mrkvkFNe2juMyPsdcJA8XVnnXYnjEvDXx8ikG1nU=
X-Received: by 2002:a67:d981:: with SMTP id u1mr648823vsj.240.1589833012258;
 Mon, 18 May 2020 13:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200515215733.20647-1-eranian@google.com> <20200515215733.20647-4-eranian@google.com>
 <20200518093402.GB277222@hirez.programming.kicks-ass.net>
In-Reply-To: <20200518093402.GB277222@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 18 May 2020 13:16:41 -0700
Message-ID: <CABPqkBQt0a7Pi7X2cLz601TJEqasDXrOZcwuBhDCjcZ+ishPMw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/x86/rapl: add AMD Fam17h RAPL support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 2:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 15, 2020 at 02:57:33PM -0700, Stephane Eranian wrote:
>
> > +static struct perf_msr amd_rapl_msrs[] = {
> > +     [PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL},
> > +     [PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr },
> > +     [PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL},
> > +     [PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL},
> > +     [PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL},
> > +};
>
> Why have those !PKG things initialized? Wouldn't they default to 0
> anyway? If not, surely { 0, } is sufficient.

Yes, but that assumes that perf_msr_probe() is fixed to not expect a grp.
I think it is best to fix perf_msr_probe(). I already fixed one
problem, I'll fix this one as well.
