Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B516CC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535B3208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FYWuL/bx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgIKBZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKBZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:25:24 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F95C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 18:25:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y13so9363333iow.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 18:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M0h1+gDb9u9/7GRoBPXUiRhLCu1AqpfGRVhaREDJzvE=;
        b=FYWuL/bxPThnma7R4WEwXVU5CSZzAeRcxLZORbaTc26AM6KvTaF8MAXr5Lmxe87hBY
         gcrjugE1QCebBJ06YfmO8yJmNYh0LXgAqZZJE/vT80s2Q57ll0qJEqUNbqARtGmjgZIY
         Avf8GXOLwkcXet85hq4rWi62LJb1hUGstV5u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M0h1+gDb9u9/7GRoBPXUiRhLCu1AqpfGRVhaREDJzvE=;
        b=My3hl/9HkEW1WLLh8UB+Us7huATOhQKLZmFqgvauL4QKAUpnep2x+vfxNr3K0kjBfl
         eO7KXh3GfTpSrhLtVEt49ZHiMf30KjLeY5f4r6yn8CmHZbRpoNq2kFblnnk4rGZaQNM+
         ICT+Jxv7XUbTy7M0ZYz7VnjM8FKFeygID5UC6RkJcO+YU+ZFPFFr8SMSEQzyxdzUu3Cp
         I9yKUmmoyjuFqXze9kUO/eoLKkd487HjT/gXfmV/7/lEM4ByNO0VWPHCihvO/gnf04S9
         8OOA5Vbk+BNEMSSOeHs4toKC63v6g3gWyus0UzEW1uuAr/ucII4lOkYTRWmgllh35Ofl
         GrMg==
X-Gm-Message-State: AOAM530DRS3v27AKo31R6c7tQEZ5oKvvlfaN1NaZj/9mBqJQ8lGVy9GZ
        9W6QOOKjpQFvkmu5R+W4rNuzP+J9nSqVMbIEsHtyug==
X-Google-Smtp-Source: ABdhPJxLOln/0gxJYsCCd7bql39r+3v361e6hMl0I80n6SfkynwTL0V4K1led0lsZpIbMaEvnzLJk5TfV4glDrVSjAQ=
X-Received: by 2002:a02:a0c2:: with SMTP id i2mr10993351jah.92.1599787522983;
 Thu, 10 Sep 2020 18:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599072725.git.nachukannan@gmail.com> <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
 <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
In-Reply-To: <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 10 Sep 2020 21:25:11 -0400
Message-ID: <CAEXW_YTr9VaEY78S_C5iN1EH3hySZOED8F37t1A=7PNgbQK9CA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Trace events to pstore
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nachammai Karuppiah <nachukannan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
(Back from holidays, digging through the email pile). Reply below:

On Thu, Sep 3, 2020 at 2:09 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Sep 2, 2020 at 3:47 PM Joel Fernandes <joel@joelfernandes.org> wr=
ote:
> >
> > On Wed, Sep 2, 2020 at 4:01 PM Nachammai Karuppiah
> > <nachukannan@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > This patch series adds support to store trace events in pstore.
> > >
> > > Storing trace entries in persistent RAM would help in understanding w=
hat
> > > happened just before the system went down. The trace events that led =
to the
> > > crash can be retrieved from the pstore after a warm reboot. This will=
 help
> > > debug what happened before machine=E2=80=99s last breath. This has to=
 be done in a
> > > scalable way so that tracing a live system does not impact the perfor=
mance
> > > of the system.
> >
> > Just to add, Nachammai was my intern in the recent outreachy program
> > and we designed together a way for trace events to be written to
> > pstore backed memory directory instead of regular memory. The basic
> > idea is to allocate frace's ring buffer on pstore memory and have it
> > right there. Then recover it on reboot. Nachammai wrote the code with
> > some guidance :) . I talked to Steve as well in the past about the
> > basic of idea of this. Steve is on vacation this week though.
>
> ramoops is already the RAM backend for pstore and ramoops already has
> an ftrace region defined. What am I missing?

ramoops is too slow for tracing. Honestly, the ftrace functionality in
ramoops should be removed in favor of Nachammai's patches (she did it
for events but function tracing could be trivially added). No one uses
the current ftrace in pstore because it is darned slow. ramoops sits
in between the writing of the ftrace record and the memory being
written to adding more overhead in the process, while also writing
ftrace records in a non-ftrace format. So ramoop's API and
infrastructure fundamentally does not meet the requirements of high
speed persistent tracing.  The idea of this work is to keep the trace
events enabled for a long period time (possibly even in production)
and low overhead until the problem like machine crashing happens.

> From a DT standpoint, we already have a reserved persistent RAM
> binding too. There's already too much kernel specifics on how it is
> used, we don't need more of that in DT. We're not going to add another
> separate region (actually, you can have as many regions defined as you
> want. They will just all be 'ramoops' compatible).

I agree with the sentiment here on DT. Maybe the DT can be generalized
to provide a ram region to which either ramoops or ramtrace can
attach.

 - Joel
