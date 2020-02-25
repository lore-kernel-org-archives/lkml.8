Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB32C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1021221556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF+rJ+xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgBYHe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:34:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38401 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBYHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:34:56 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so896173pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XskRpUztF01a9SskOdCksJRMRljsk5+q6bZK23iH9Gk=;
        b=pF+rJ+xDnIELjc/cifp+km87lUuO/AyOCF7a5yj7AqFYfm8dFu0OYUebQZndCPsjoP
         uPoW/Zs8LZG41rspz/uCIwGnT+XmSq5mgism5Vj72arFklztp2GUbh4wXmdhn2M2XQHE
         X+oIRdqewFcWCoy0OcWLE/t32mWKccE5c9WIIVVrEtuO7wWNMp/Qv6wpBruUVY4haWbz
         UdN7qw5lhlifVIO1Ux5RHNRQyOW3NqBhGsbEiJoRjBZH3T+dWH5/bFJJDcfMtLgs+ZKD
         tl2sfLGicmfJpUmg4UkMac8SJfQ6nP11kByu9nU8UFHPm5T6kjmUX8oTNZ82zJt9TSoR
         tpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XskRpUztF01a9SskOdCksJRMRljsk5+q6bZK23iH9Gk=;
        b=DEk/p2FjnWQNv9uRxuNLirUbb01gbJxryzcGhy4LRcO4u6VwuQYC/qZzx8jMgRTo3X
         aw1s16Fq9SVvW+XEELKJjksROJdjFdFG4xd6uCQ7ueeAlvYD7oSaERmBAkcYbK+DJQw6
         Am1y67o0ibGTnxpqWzOq0GDaljibESvgtZJKM2BxjiPyqqsCcp65Cgh5PbmYJeFkusZB
         epnlNcxhL0pbyKqH0qNUoElWEPU7fNHPvMeFH2D0JIDZSftRwNo6HypKtG8WDCy6LfkO
         eFc82NiL3MyXsrh5seXH93rRaq4bGS6TBrLWU9b4L90T6IXXRNozwzXuTOwPe3WM2z2K
         n7eQ==
X-Gm-Message-State: APjAAAXGd+PkclQhB/qWSeb+IZ+xNN8jMdjnN6s50aKprnctlYf11iP4
        9qWxboJuc9QeU1cJgALThiQ=
X-Google-Smtp-Source: APXvYqwwUapmsPngrJ2lEUoW9ZJ8VZLWD8okbx92cxtjWhmmgZjhUigc/gDKKuXELSJRV5dLYaCxJA==
X-Received: by 2002:a17:902:104:: with SMTP id 4mr53150822plb.24.1582616095537;
        Mon, 24 Feb 2020 23:34:55 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id 26sm1952590pjk.3.2020.02.24.23.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:34:54 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:34:46 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200225073446.GA618392@ziqianlu-desktop.localdomain>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CAERHkrs_WX=gS0sQ2Wg_SZuAcf_qhKfT05co0uYgaQk8cFj0ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrs_WX=gS0sQ2Wg_SZuAcf_qhKfT05co0uYgaQk8cFj0ag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:32:35PM +0800, Aubrey Li wrote:
> Aaron - did you test this before? In other words, if you reset repo to your
> last commit:

I did this test only recently when I started to think if I can use
coresched to boost main workload's performance in a colocated
environment.

> 
> - 5bd3c80 sched/fair : Wake up forced idle siblings if needed
> 
> Does the problem remain? Just want to check if this is a regression
>  introduced by the subsequent patchset.

The problem isn't there with commit 5bd3c80 as the head, so yes, it
looks like indeed a regression introduced by subsequent patchset.

P.S. I will need to take a closer look if each cgA's task is running
on a different core later but the cpu usage of cgA is back to 800% with
commit 5bd3c80.
