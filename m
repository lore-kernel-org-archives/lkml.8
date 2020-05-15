Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5497FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5EE206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589566134;
	bh=ESlVXG+oqcd9xYFxURto9/OPRJKlMx968VMKHxE5ct0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MMAcHF1EDXNebhZYxZlgdUyBqvbBattaKElSWFk5dhIqkTaqzBlx50vz8lUrYl0HL
	 PCyUPrKvwzhXGo3+kkcYhzCCcLBQEyzyWoGcFVobfaMy/QYrMftHvOtt/Jlrzv6TsG
	 spy3C+IbHMbvsL2IrVwuFUtRjn+bpYmmFfavI6QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEOSIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEOSIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:08:53 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC97B20657;
        Fri, 15 May 2020 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589566133;
        bh=ESlVXG+oqcd9xYFxURto9/OPRJKlMx968VMKHxE5ct0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OIf/ZO4kqMQOIrV1HAFCYW52ZXGnXzxq8x+Su+JM1yKLvGE4mMjl0JgYX51tRxtaC
         2aeiMr/iKhar5vo+IEuFJAZiw8NVt5admQnN79SBGbHTBVlkbphPtkHD3CMG/8JV8D
         Rdr2Q2ip48DL41XjRZcl6dHNhxR3zKdliubJ60+E=
Received: by mail-lf1-f52.google.com with SMTP id v5so2553744lfp.13;
        Fri, 15 May 2020 11:08:52 -0700 (PDT)
X-Gm-Message-State: AOAM530hvrPISsyE0v/UIlr5S+ShsmvGYhXb2JHKmjgMWT/tC3oA5hgJ
        ZyHaNaaPjd4BtR8Fp7X/bR3zT7Sk4/G1NtxL3w0=
X-Google-Smtp-Source: ABdhPJzbQo6rOBwWknOrMCZMnmq8FRvflFdJwiKbjOm5/kRGe5wn4Q+82lIJfpDzCJ5+F+TNooMQw4z8nBWo+/AjCUA=
X-Received: by 2002:ac2:558e:: with SMTP id v14mr3228999lfg.138.1589566131003;
 Fri, 15 May 2020 11:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190724185029.26822-1-indigo@bitglue.com>
In-Reply-To: <20190724185029.26822-1-indigo@bitglue.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 15 May 2020 11:08:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW67xTooG7QLwkwLfs=3EgFUXARWtfexdwp4gQHAFv+yoA@mail.gmail.com>
Message-ID: <CAPhsuW67xTooG7QLwkwLfs=3EgFUXARWtfexdwp4gQHAFv+yoA@mail.gmail.com>
Subject: Re: [PATCH] Correct documentation for /proc/schedstat
To:     Phil Frost <indigo@bitglue.com>, davidca@fb.com, haowanglud@fb.com
Cc:     Ingo Molnar <mingo@elte.hu>, trivial@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Wed, Jul 24, 2019 at 12:26 PM Phil Frost <indigo@bitglue.com> wrote:
>
> Commit 425e0968a25fa3f111f9919964cac079738140b5 ("sched: move code into
> kernel/sched_stats.h") appears to have inadvertently changed the unit of
> time from jiffies to nanoseconds as part of the implementation of CFS.
>
> Signed-off-by: Phil Frost <indigo@bitglue.com>

Do you plan to resend this patch? The file has been updated to sched-stats.rst.

Thanks,
Song
