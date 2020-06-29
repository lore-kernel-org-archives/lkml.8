Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4BA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlXQ7z+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbgF2T17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732756AbgF2T1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E678C0307A6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:49:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so17048064wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7aeIRM/Zv/PnpeibkauplfbdEKkZND3pAUldUybN3c=;
        b=KlXQ7z+OO3HgJ9Un57tV9gVx6v38Y/XKvz9AlO7xmfwr4IppUMv0PFlAiwZ37/XG8e
         bMTj/UoTGc1ppjwKDrCkpJaOJtF3aVzebVxZ988qFtdrX50/8PCgwz/1S7zaJqikcJIl
         R3rVI8GX4+TfQGhCRgpACBvNgDUU78JmgvcRimKlzn+AD2WNvd1NpVtsH1tLrFltt+u2
         UYQTEVFWSGu/H3g9+/z1hBRh5qfzZOg7agoKeM7UqD6MSDW4iJ6LpXo/NupjOqWTzfPG
         uDZeS9NmlqYfuZO0pmxKdx8gL7gDNk6uQAY6mrr1+dMoIQfAz3ubafgdf/utDB0u1ZQO
         ZUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7aeIRM/Zv/PnpeibkauplfbdEKkZND3pAUldUybN3c=;
        b=W4VT+Vytd0AXGg2/z9UYUDkZSBjxCEoHuED2vsVqbBcsL1Oop7NqsubxovaYN+XlVX
         Y+8mZC0nHlqEWVpWMMRx4ro4nVeWtaMyL+yM/nz9O/3SKto+ZbhdLLtXftR4VaLyGMWs
         +bmVMdUOySI5fZef0KWN8clATAWzSGQBt/8FS+qvSCLu+C84ka0KF00aL7/EHa04e6de
         skm5bKOY8EMkwOPhsONbpvkli3vqgm0Px/p3rINIMhNha3kCzVCXQrB7yCEXXf+kjNxY
         l6b+3wyhpGzR34vN0BmU7dD7QhsQqu+Z6T34iyJahYo6PpudN3HtsFqdBjpd/Ych57Le
         0oRw==
X-Gm-Message-State: AOAM530140xTGlTU8RstRxKhdVemho1Celp70QXGrXdCjyn60SHMBiem
        t1Bw78rGtQ0+EFfGmqHLRBb9SBZJcnP0lY6NJg8d3w==
X-Google-Smtp-Source: ABdhPJz7hf/e6M4VjuoE6JVvdJBuiyiGgShjAiNH3cgNampUZgdLoTqWr9bSP2QVhdQ9FwwTjAgnWM1TyxmQ7aKHnbI=
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr16865873wrn.48.1593445790006;
 Mon, 29 Jun 2020 08:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-3-jolsa@kernel.org>
 <CAP-5=fVdSmPEYMqGqCEwZXfj=-wg6sJLQ=kuPTLaPdKiAiqTvg@mail.gmail.com> <20200628212448.GI2988321@krava>
In-Reply-To: <20200628212448.GI2988321@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Jun 2020 08:49:38 -0700
Message-ID: <CAP-5=fWNPAwj0uH1ExGBLe+oFBinX3vPRyA4g2KiwRuc8RExsg@mail.gmail.com>
Subject: Re: [PATCH 02/10] perf tools: Add struct expr_parse_data to keep expr value
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 2:25 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jun 26, 2020 at 01:04:41PM -0700, Ian Rogers wrote:
> > On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding struct expr_parse_data to keep expr value
> > > instead of just simple double pointer, so we can
> > > store more data for ID in following changes.
> >
> > Nit, expr_parse_data sounds a bit like data that is created just at
> > parse time. Perhaps id_data, for data associated with an id?
>
> we should keep the expr prefix, expr_id_data ?

Sounds good to me. Thanks,
Ian

> jirka
>
