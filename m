Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B56DC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCA420722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgEKL1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:27:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39953 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbgEKL1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:27:08 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jY6aP-0005ZQ-El
        for linux-kernel@vger.kernel.org; Mon, 11 May 2020 11:27:05 +0000
Received: by mail-ej1-f69.google.com with SMTP id cb22so3747266ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6s913c52qXog287G0uRKNKSekm/u+OcHV1ByehHSyNs=;
        b=rwVPt9VGk2LHgJmQ3Hifkm3M896BLggv7ABT5e1qbw4/Q4PuDgLzRB3i8Unz7woY0r
         Vpmiwt+T0g5P6cm486uNaPpLRXZeaox9KfyBPnREYLhAv10DMvGBRG4YRrW/x8OJD5M8
         FzU/+DA3Wo8hR0X6L4gLaznthuVtwinDfpVNc3J6vJubPPyEFcA5eYacl3GKWn3gRvb0
         RRDQNf8355fKizK2bSJspbWq3/C9myj2LMff5W7UhDQEB7rESSaEd+GqB+tjePGRF4uP
         7XchhKbf4COn20wbtr/4S5R8KAtCYlZob3T6gi+DSj6jHPR5mGDPrHF1Y4YrWIPSoJuL
         PS5Q==
X-Gm-Message-State: AGi0PuZrrB4IbDQ8yySVnSJddGzKbVNyLMfx2jSvNNNZI+Oh/aEnkdLw
        MRNMvpCB4wdKgjP3/FTqBwLPsycMXZO6/uRLLA3rDmF7bTl/EOYJykJ6EdQ71r0XrKwMrvvvc7j
        IzvHiFxS9EILoR7gxviTid7dZtdqCoplnOy/dywKlCzWQVjBw6/SX68y0cQ==
X-Received: by 2002:a17:906:e098:: with SMTP id gh24mr13250455ejb.44.1589196425147;
        Mon, 11 May 2020 04:27:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypJK5vYrawWYQ4rT6+ywp/xCU6lU3xhBAyIqYrYAMAAN44ZPbDkRzW2yvynqnjzplQWrqO23kmx5LdF727eZk+s=
X-Received: by 2002:a17:906:e098:: with SMTP id gh24mr13250440ejb.44.1589196424851;
 Mon, 11 May 2020 04:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200507215946.22589-1-gpiccoli@canonical.com>
 <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
 <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
 <CAHD1Q_wF6Mzf5JipXGZKvn2YDR+FQ6ePuKOe-1W-t_VapxMCxg@mail.gmail.com> <alpine.DEB.2.22.394.2005101821160.172131@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.22.394.2005101821160.172131@chino.kir.corp.google.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 11 May 2020 08:26:28 -0300
Message-ID: <CAHD1Q_zrQmUTRpdW3bZ0CRKuu2dKgueXUjqCNtC5oyZ67CGp2A@mail.gmail.com>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
To:     David Rientjes <rientjes@google.com>
Cc:     "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 10:25 PM David Rientjes <rientjes@google.com> wrote:
> [...]
> The kernel log is not preferred for this (or drop_caches, really) because
> the amount of info can causing important information to be lost.  We don't
> really gain anything by printing that someone manually triggered
> compaction; they could just write to the kernel log themselves if they
> really wanted to.  The reverse is not true: we can't suppress your kernel
> message with this patch.
>
> Instead, a statsfs-like approach could be used to indicate when this has
> happened and there is no chance of losing events because it got scrolled
> off the kernel log.  It has the added benefit of not requiring the entire
> log to be parsed for such events.

OK, agreed! Let's forget the kernel log. So, do you think the way to
go is the statsfs, not a zoneinfo stat, a per-node thing? I'm saying
that because kernel mm subsystem statistics seem pretty.."comfortable"
the way they are, in files like vmstat, zoneinfo, etc. Let me know
your thoughts on this, if I could work on that or should wait statsfs.
Thanks,


Guilherme
