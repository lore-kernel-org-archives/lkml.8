Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514E822B43
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgGaVRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:17:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45963 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgGaVRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:17:34 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1k1cPE-0002bb-HW
        for linux-kernel@vger.kernel.org; Fri, 31 Jul 2020 21:17:32 +0000
Received: by mail-wr1-f70.google.com with SMTP id j16so9595398wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 14:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhvoNmpg9YoaWp6/8Gcf6qNFVkrMSaEZ42s1iuHLLhI=;
        b=ClZ7I7gTlKqAUAfG+IXrTepDT8Cg/KfjCMbhzo5fXgf4SdEAiLX9vu0+8vqcazf/RA
         XeTOTlJnBMnjdOlEZ0qMC8GSJzH3tQbt5eBLhU9ZT3KqtOMjSKROF0cJWHxbYGnYp7Gt
         9GUDBmpF9N4RYaFgB7F3MLMim3xnpj8jvU5ASGcmOKpoIgW9MGiy+iE1FOoQpdK5K6vr
         XezCGA2B9wc+CUNGnCMH3XMmBUk5miB0/XS/idtHpVKY3Jx2SbsthEpBHtNJKyJhGAD+
         vDSC2A/+CdX+3UHWcT3UTKmLN3xgEMHr97zFoyfeNspjQ03Ox4loGkIOTqr38amAB3T7
         tCEA==
X-Gm-Message-State: AOAM530REsCOzh9GzM+Oh1kecdu87mCfnWZeWhAfsllJYbmg2aUx/cn7
        6XVQcYVsoW+WE08TIA7wg1Vy36VOhWQdC2EK+V8+RInyN/u9W8YIZixSZgwvsOhkQlrora55Amk
        TEk1P5KwkMwuYc4SLnfYKZWwYUJN1t4ZFaVajDDHWtzmTO4GwBL6suCVyQg==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr5280856wrw.360.1596230252211;
        Fri, 31 Jul 2020 14:17:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVzbiVJGDW3izCpbkUPC5Gw0CD22JF9WGK330ZmUV97C5Rinp/qP6XmGPYgBIOAfT7U7usKQScwuxSCGo5EQE=
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr5280841wrw.360.1596230251908;
 Fri, 31 Jul 2020 14:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200702215812.428188663@goodmis.org> <20200702215832.784471709@goodmis.org>
 <20200731193345.GA54749@xps13.dannf> <20200731171626.2c51e818@oasis.local.home>
In-Reply-To: <20200731171626.2c51e818@oasis.local.home>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Fri, 31 Jul 2020 15:17:20 -0600
Message-ID: <CALdTtntOjg6zdYAYJAY_87Zpf7OYB-ZTp_BSWVOJva5Vx2acPQ@mail.gmail.com>
Subject: Re: [for-next][PATCH 09/18] tracing: Move pipe reference to trace
 array instead of current_tracer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian May <ian.may@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 3:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 31 Jul 2020 13:33:45 -0600
> dann frazier <dann.frazier@canonical.com> wrote:
>
> > > This is marked as "Fixes" but is more of a clean up than a true fix.
> > > Backport if you want, but its not critical.
> >
> > Thanks Steven! In case it helps backport consideration, I wanted to
> > note that this addresses an issue we've seen with users trying to
> > change current_tracer when they happen to have rasdaemon
> > installed. rasdaemon uses the trace_pipe interface at runtime, which
> > therefore blocks changing the current tracer. But of course, unless
> > you know about rasdaemon internals, it isn't exactly an obvious
> > failure mode.
>
> Ah, then this should probably be backported.
>
> When I push to Linus (during the next merge window) and it gets into
> Linus's tree. Feel free to send stable@vger.kernel.org the sha1 of this
> commit, and ask for it to be backported for the above stated reason.

Will do.

 -dann
