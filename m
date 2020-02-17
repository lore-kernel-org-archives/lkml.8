Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD8CC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC6A2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgBQV3k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:29:40 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:49271 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729334AbgBQV3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:29:40 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20257453-1500050 
        for multiple; Mon, 17 Feb 2020 21:29:38 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAHk-=wik6C7uCyPZ_qwv0M29uVUdgrpOdubfaVHF8FVBAsCivA@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <158195649797.19707.10238097810752281104@skylake-alporthouse-com>
 <CAHk-=wik6C7uCyPZ_qwv0M29uVUdgrpOdubfaVHF8FVBAsCivA@mail.gmail.com>
Message-ID: <158197497594.2449.9692451182044632969@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: Linux 5.6-rc2
Date:   Mon, 17 Feb 2020 21:29:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (2020-02-17 21:20:27)
> On Mon, Feb 17, 2020 at 8:22 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > Quoting Linus Torvalds (2020-02-16 21:32:32)
> > > Rafael J. Wysocki (4):
> > >       ACPI: EC: Fix flushing of pending work
> > >       ACPI: PM: s2idle: Avoid possible race related to the EC GPE
> > >       ACPICA: Introduce acpi_any_gpe_status_set()
> > >       ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system
> >
> > Our S0 testing broke on all platforms, so we've reverted
> > e3728b50cd9b ("ACPI: PM: s2idle: Avoid possible race related to the EC GPE")
> > fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
> >
> > There wasn't much in the logs, for example,
> > https://intel-gfx-ci.01.org/tree/drm-tip/IGT_5445/fi-kbl-7500u/igt@gem_exec_suspend@basic-s0.html
> 
> So the machine suspends, but never comes back?
> 
> Do you need to revert both for it to work for you? Or is the revert of
> fdde0ff8590b just to avoid the conflict?

fdde0ff85 was just to avoid conflicts.
 
> I'm assuming you bisected this, and the bisect indicated e3728b50cd9b,
> and then to revert it you reverted the other commit too..

Lucky guess based on diff rc1..rc2. Bisect was going to be painful, but
could be done if this is not enough clue for Rafael.
-Chris
