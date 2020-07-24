Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF5C2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Utl4iStv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHYIU2tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGXXbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:31:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41168 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgGXXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:31:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595633499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s86KpX4gEQp9O8JUTp5Kv2QZ3KmBoiheWWny0AIVQrw=;
        b=Utl4iStvmks4F/x7c50zDmwxsxqWfC484X/c1aGEriQJUQXjdCrez7GOHMCyOooB4JdNQw
        Q8CsNfQVInlbev77cIGJj1lbIXC7PNymbSD0G8pvUhlCr8uZw3Zyd71GIQLo0ID6waEJ7O
        7CLBPgcOrpsUhUXJ4EzP6pvBDUFhUij++AxDYqCcRkz/qtt9MLPWos6+8m6wuxvIxV5gFU
        +Gp+8mJspSLC/uLFw+3J5YGd14jgjMa1v7BObs+OzA404xzYcCFZxp7uHimoXpeFKUVBIh
        UgADjIeLRF1EwUx7Uxg87uewNLCuZumecSXZ5IhX2P6PhRjCh4RIGKwCZoNdsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595633499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s86KpX4gEQp9O8JUTp5Kv2QZ3KmBoiheWWny0AIVQrw=;
        b=RHYIU2tMmbWTK4xQgazmPFYe+Wy35hX0U5R04s9JQHcDADlWTPeZwld4q7THZGfX8ZZjnT
        Gp/SOjSSCx+k0oBQ==
To:     jun qian <qianjun.kernel@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, peterz@infradead.org,
        will@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>, lkp@lists.01.org
Subject: Re: [Softirq] a76eadba0d: WARNING:at_net/mac80211/rx.c:#ieee80211_rx_napi[mac80211]
In-Reply-To: <CAKc596Lp3m3Ny9joOckYPsR5Lmok978bceMYNBrzsk6ozFjqhw@mail.gmail.com>
References: <20200723091715.GL19262@shao2-debian> <87v9iexztl.fsf@nanos.tec.linutronix.de> <CAKc596KA2moT7fgO+Ount5trEbtrYsuLbde5S5Ou-c4EQbHb3g@mail.gmail.com> <874kpyxpro.fsf@nanos.tec.linutronix.de> <CAKc596Lp3m3Ny9joOckYPsR5Lmok978bceMYNBrzsk6ozFjqhw@mail.gmail.com>
Date:   Sat, 25 Jul 2020 01:31:37 +0200
Message-ID: <87y2n8sd5y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jun qian <qianjun.kernel@gmail.com> writes:
> I have two questions that need to be discussed.
>
> 1. If the __do_sofrirq() is executed in the ksoftirqd, we may not need
> to check the timeout in the loop.
> 2. Both the invoke_softirq() and run_ksoftirqd()  will execute
> __do_sofirq, they all execute the same code=EF=BC=8C
>     when it is in the ksoftirqd, Do we need to wake up ksoftirqd in
> the process context according to
>     max_restart and MAX_SOFTIRQ_TIME. In my opinion, If we  use a flag
> to distinguish where
>     __do_softirq() is called from,  we can do what is most suitable
> for __do_softirq based on this flag.

You answered your questions yourself :)
