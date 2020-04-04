Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF1AC2BA17
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3940206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDVyVD03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDDCbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 22:31:53 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38296 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgDDCbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 22:31:53 -0400
Received: by mail-il1-f196.google.com with SMTP id n13so9389811ilm.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73jqoDJR4Hmz4eV5wHtz3Ds21ROllKQjJV/hPH99ZdQ=;
        b=VDVyVD036uSZxfqSuWAQxWfPYz/hc1ryWjFRuLKKKmkrG4I2N9Uc4OOCMghKZeSZdo
         05vsC2nxlbYe1LIKVCaHhhrgrSFnZprq1B6P6/EgMJfwm1Rf6ZvruR5bYPhpkYfdhrvm
         a/8s5P0Ad2/3iJXlEbt2prcubwNr5gzhjvQ8zgZMNLKh2IfcbaueRCu0pH7eswPzPcTk
         zKlgXy/O9sZAR4dNEUN/SNXg5Ls7L5D3RhSKvL5zU7d8DmKFoLiYQEBkvaUNaalQ1qNn
         FLaac3BmihOPIWBrjSnM5RZf2jVKS/X0RhOuVcgbJS6tcLsHqG0M31BLvrOK+DICCtWN
         wKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73jqoDJR4Hmz4eV5wHtz3Ds21ROllKQjJV/hPH99ZdQ=;
        b=ecAjLlfALmtiXSvflsBijXqwurE4hdGcVfNhHcgArBbw4D7XrNlqziaMxNOtSlJsXU
         KzzPWJrqU87KG0gov+EK9kyRkzuKPKjQPTvk9rBYGTebzhxBTuahSsjW1r55ZGHVkFv4
         XZXiOs9Dn/lgQ8hdQop2FDkr/N6bAZM0+vqzq8ibPoWQUHX/f/0gdqiW3KnxwgPrSWOP
         NLrGfXymai8f2aa8ijG2iz/3kFBmeFzy4YNpmoYsFwQlMIwgtzN7xKZvnOZkWeWlmc6j
         vgdWAGiBA84A18hFoiJezK6DH+mfhSsm4+bSGNplC4yYpIXol1TYWWALe+Sia4MibUXF
         72Jg==
X-Gm-Message-State: AGi0PubfBuRa94nEhYxOLLsskxWzaqkTV6VD32YoU/GeKmyDJXzdds5E
        M2g1qWq5xf1vkNfsA9eaFaJ3ciw59swl7YQVETQ=
X-Google-Smtp-Source: APiQypJhzFO86yuwD4MhRrgZWWEWwLc7RswAnaUHR2K14Xm7sNF5Vyqy0zppH197durO3VgG/RhP8JdliQMepiw57t4=
X-Received: by 2002:a92:d105:: with SMTP id a5mr11645280ilb.142.1585967512259;
 Fri, 03 Apr 2020 19:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <1585904125-2819-1-git-send-email-laoar.shao@gmail.com> <20200403152016.GA69203@cmpxchg.org>
In-Reply-To: <20200403152016.GA69203@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 4 Apr 2020 10:31:16 +0800
Message-ID: <CALOAHbBqk4s4Nw3Ky3YY66EM7DzUJZTuLZhjw9+ULUE-9O+aDQ@mail.gmail.com>
Subject: Re: [PATCH] psi: fix randomized calculation in record_times()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 11:20 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Apr 03, 2020 at 04:55:25AM -0400, Yafang Shao wrote:
> > @@ -690,7 +690,10 @@ static void psi_group_change(struct psi_group *group, int cpu,
> >        */
> >       write_seqcount_begin(&groupc->seq);
> >
> > -     record_times(groupc, cpu, false);
> > +     if (groupc->total_tasks)
> > +             record_times(groupc, cpu, false);
> > +     else
> > +             groupc->state_start = cpu_clock(cpu);
>
> This change appears is a no-op. If there are no tasks,
> groupc->state_mask is 0, and the only thing record_times() does is
>
>         groupc->state_start = cpu_clock(cpu);
>
> Did you encounter actual problems, or are you just reading the code?

No real issues. Just reading the code and found it looks like a little weird.
But as you explained that state_mask can also guarantee it then we
don't need to make this change.

Thanks for the explanation.

Thanks
Yafang
