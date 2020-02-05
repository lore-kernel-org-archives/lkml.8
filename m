Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E07C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7C2217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgBEJOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:14:22 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:33026 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:14:22 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48CG8r10mSzQl9f;
        Wed,  5 Feb 2020 10:14:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id cC-7nC6GS1d3; Wed,  5 Feb 2020 10:14:16 +0100 (CET)
Date:   Wed, 5 Feb 2020 10:14:14 +0100
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf script: introduce deltatime option
Message-ID: <20200205091414.GB495987@virgo>
References: <20200204173709.489161-1-hagen@jauu.net>
 <20200204231628.GF302770@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204231628.GF302770@tassilo.jf.intel.com>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen | 2020-02-04 15:16:28 [-0800]:

>> $ perf script --deltatime
>
>It's already implemented as --reltime

Nope ;-)

$ perf script --ns --reltime
           sleep 49148 [000]     0.000000000: probe_libc:sbrk: (7f279d9144f0)
           sleep 49148 [000]     0.000009153: probe_libc:sbrk: (7f279d9144f0)
              sh 49151 [002]     0.099454082: probe_libc:sbrk: (7f9f1c6374f0)
              sh 49151 [002]     0.099468538: probe_libc:sbrk: (7f9f1c6374f0)
            curl 49153 [003]     0.114459574: probe_libc:sbrk: (7f9bb2dfb4f0)
            curl 49153 [003]     0.114474449: probe_libc:sbrk: (7f9bb2dfb4f0)
						[...]

$ perf script --ns --deltatime
           sleep 49148 [000]     0.000000000: probe_libc:sbrk: (7f279d9144f0)
           sleep 49148 [000]     0.000009153: probe_libc:sbrk: (7f279d9144f0)
              sh 49151 [002]     0.099444929: probe_libc:sbrk: (7f9f1c6374f0)
              sh 49151 [002]     0.000014456: probe_libc:sbrk: (7f9f1c6374f0)
            curl 49153 [003]     0.014991036: probe_libc:sbrk: (7f9bb2dfb4f0)
            curl 49153 [003]     0.000014875: probe_libc:sbrk: (7f9bb2dfb4f0)
						[...]


reltime is relative to the *first event* in the record - deltatime is relative
to the *previous* event.

Hagen
