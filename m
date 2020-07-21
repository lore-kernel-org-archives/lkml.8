Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61603C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BD0206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595345635;
	bh=O3qI2mXrdTflvfugVglnyd3tv2QJQZMDj+1webP82jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GlPYNNetSVNDHa2oufhjwcxEIjLQgQv5rnEl2M/RIhROkZjXhMr9jpnFLazyUbWEN
	 wzyRVkwaxYGtMulaZLumAWCJuPV2vJoA3LUwgZ9P+fLq4wQ/0fIb43y8aVrG16bLO6
	 iKD/ygmVkNUBI3716kvEXLaZbaG9pfL2vnW7hUWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgGUPdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgGUPdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:33:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07433C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:33:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k13so2939264lfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njynPEuSAx3YutPUm1Ks7mASPVE5qpU/6FLY7l0S5aI=;
        b=eQ7WI6xkilW9FmgBXW/xysDF/3IDtBx6ypESMtBihC1eSPJLn5eC8eHS5o6dVcno9s
         vwH7lLb02YEl6fLuBANrEc7wsinozUQG/BuWIv3nBwdXFniYX41S1JKBigNvoypkkWDt
         v7e3VdKkBjijF9BamxUZuXGlgb38adI4J9jRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njynPEuSAx3YutPUm1Ks7mASPVE5qpU/6FLY7l0S5aI=;
        b=k9CfoI7Nak32nFGNz8gYBmPPB7TohseDbNyRLFIOPAV6cRq2ffh2YgOUOH2mLeON0o
         3Oi9wsKdZnrHoF8ujypl3vA30YAYtwR4aH5P1NXKjtB/2ZOFs2c9efXUiVDaZy50fsKp
         fJjSudsyWjcNaMmxS6C4/+YJPW5kOH+7sDALTV3XhTVy6nLPeuGTGEsikYinUwh02WMJ
         spAz6tEOZvpwUBF5Q0pOQM9ANWE0SDRGstd4Yz3FH0KJE78HtqYhzo2qQT8Qqp41mGCV
         XviE7LVkPbWTcNmqNZ2GDzVl71EDFUMLDUmhh37OSie4aY9776vbmyPxQqmR0bSHkuXQ
         DCbg==
X-Gm-Message-State: AOAM532YwyHpe5E0bIjT7h5O0U5a1Mx7yEib2rYjfkC5npV7R/ajerO1
        UCy2KFUYJmE1jxuu9o4xUfVlSmulyZs=
X-Google-Smtp-Source: ABdhPJzFllXxNGPXCKkzWRuXJUCMruSycsoI5XWRQ4LtxOFFeKeOox3Roha37ATij/VfbE92P09ZPQ==
X-Received: by 2002:ac2:4241:: with SMTP id m1mr13966554lfl.20.1595345630949;
        Tue, 21 Jul 2020 08:33:50 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b16sm4600173ljp.124.2020.07.21.08.33.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:33:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 140so1520652lfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:33:49 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr3650183lfo.31.1595345629595;
 Tue, 21 Jul 2020 08:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org>
In-Reply-To: <20200721063258.17140-1-mhocko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 08:33:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
Message-ID: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:33 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> The lockup is in page_unlock in do_read_fault and I suspect that this is
> yet another effect of a very long waitqueue chain which has been
> addresses by 11a19c7b099f ("sched/wait: Introduce wakeup boomark in
> wake_up_page_bit") previously.

Hmm.

I do not believe that you can actually get to the point where you have
a million waiters and it takes 20+ seconds to wake everybody up.

More likely, it's actually *caused* by that commit 11a19c7b099f, and
what might be happening is that other CPU's are just adding new
waiters to the list *while* we're waking things up, because somebody
else already got the page lock again.

Humor me.. Does something like this work instead? It's
whitespace-damaged because of just a cut-and-paste, but it's entirely
untested, and I haven't really thought about any memory ordering
issues, but I think it's ok.

The logic is that anybody who called wake_up_page_bit() _must_ have
cleared that bit before that. So if we ever see it set again (and
memory ordering doesn't matter), then clearly somebody else got access
to the page bit (whichever it was), and we should not

 (a) waste time waking up people who can't get the bit anyway

 (b) be in a  livelock where other CPU's continually add themselves to
the wait queue because somebody else got the bit.

and it's that (b) case that I think happens for you.

NOTE! Totally UNTESTED patch follows. I think it's good, but maybe
somebody sees some problem with this approach?

I realize that people can wait for other bits than the unlocked, and
if you're waiting for writeback to complete maybe you don't care if
somebody else then started writeback *AGAIN* on the page and you'd
actually want to be woken up regardless, but honestly, I don't think
it really matters.

                Linus

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1054,6 +1054,15 @@ static void wake_up_page_bit(struct page *page,
int bit_nr)
                 * from wait queue
                 */
                spin_unlock_irqrestore(&q->lock, flags);
+
+               /*
+                * If somebody else set the bit again, stop waking
+                * people up. It's now the responsibility of that
+                * other page bit owner to do so.
+                */
+               if (test_bit(bit_nr, &page->flags))
+                       return;
+
                cpu_relax();
                spin_lock_irqsave(&q->lock, flags);
                __wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
