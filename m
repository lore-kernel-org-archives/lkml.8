Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FBCC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FA820842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgCCS3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:29:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45133 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgCCS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:29:05 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j9CHl-0003Rq-VG; Tue, 03 Mar 2020 19:28:54 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BEA38104098; Tue,  3 Mar 2020 19:28:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf bench: Share 'start', 'end', 'runtime' global vars
In-Reply-To: <20200303155811.GD13702@kernel.org>
Date:   Tue, 03 Mar 2020 19:28:52 +0100
Message-ID: <87eeu92syj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
>> > Don't we have header files for that?
>  
>> Sure, that was the laziest/quickest way to "fix" that, the other was to
>> stick a 'static' in front of it.
>  
>> I'll go see if pushing them to a header file will not clash with other
>> stuff.
>
> Better now? Had to prefix those, not to clash with local variables when
> adding it to bench/bench.h.

Yes.

> Looking at the patch more can be done to share those benchmark
> arguments, but this is the second minimal patch to get tools/perf to
> build with the latest gcc (the one in Fedora rawhide and some other
> distros).

Right, but yes there is definitely quite some overlap there.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
