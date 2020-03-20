Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F351AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B7A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCTNRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:17:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgCTNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:28 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVh-000489-FQ
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:25 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 83D12FFC8D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:24 +0100 (CET)
Message-Id: <20200320131345.635023594@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:13:45 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch 00/22] x86/treewide: Consolidate CPU match macro maze and get
 rid of C89 (sic!) initializers
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 CPU matching based on struct x86_cpu_id:

  - is using an inconsistent macro mess with pointlessly duplicated and
    slightly different local macros. Finding the places is an art as there
    is no consistent name space at all.

  - is still mostly based on C89 struct initializers which rely on the
    ordering of the struct members. That's proliferated forever as every
    new driver just copies the mess from some exising one.

A recent offlist conversation about adding more match criteria to the CPU
matching logic instead of creating yet another set of horrors, reminded me
of a pile of scripts and patches which I hacked on a few years ago when I
tried to add something to struct x86_cpu_id.

That stuff was finally not needed and ended up in my ever growing todo list
and collected dust and cobwebs, but (un)surprisingly enough most of it
still worked out of the box. The copy & paste machinery still works as it
did years ago.

There are a few places which needed extra care due to new creative macros,
new check combinations etc. and surprisingly ONE open coded proper C99
initializer.

It was reasonably simple to make it at least compile and pass a quick
binary equivalence check.

The result is a X86_MATCH prefix based set of macros which are reflecting
the needs of the usage sites and shorten the base macro which takes all
possible parameters (vendor, family, model, feature, data) and uses proper
C99 initializers.

So extensions of the match logic are trivial after that.

The patch set is against Linus tree and has trivial conflicts against
linux-next.

The diffstat is:
 71 files changed, 525 insertions(+), 472 deletions(-)

but the extra lines are pretty much kernel-doc documentation which I added
to each of the new macros. The usage sites diffstat is:

 70 files changed, 393 insertions(+), 471 deletions(-)

Thoughts?

Thanks,

	tglx


