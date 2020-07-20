Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4572070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAAqTyVY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8/s2OVCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbgGTRdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:33:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgGTRdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:33:14 -0400
Date:   Mon, 20 Jul 2020 19:33:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595266391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoAnHu4TNADFW7v8nN8h7OoS9yTv/bzAWj5+wVYWopk=;
        b=NAAqTyVYm4uHo3CDkBt55DRXC7Z2NM98v8FJvxmwcf2kcTuErB5wwRcjsf0+JEYqzzL4Jp
        HwmSD1RAuOgnekQzvL+syuIhXCfed+D4squ8yBocrg9jRc2H1ffLhmBTx/84AsnWHZsttG
        VK+ErscRKJjOvogh8qymjdEgaJ+FXO+ffGxFbtbENcfRv3DS3WZxSzFmGatO0Hb9OQ+Ehh
        VSbffOWSGEpzJavpG0x8EY5imAe7WSnFfoBa6FHX9t74TCYogHu2lbqA0BWHkBXykYnK6m
        y8IgULEOicP2k0XOqCzal70Y45sNFmUb6nd12D+sTNYDlHPlBApdpCjxy5yNpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595266391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoAnHu4TNADFW7v8nN8h7OoS9yTv/bzAWj5+wVYWopk=;
        b=8/s2OVCB2J3GrloxGICGUT3kvbJg9njYRudy5q+UMlBS6n8VO1UHAV9lwnMUcJTtIvy743
        hzCKml97uewQ7/Aw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/24] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200720173309.GA6835@lx-t490>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720164912.GC1292162@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720164912.GC1292162@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:49:12AM -0700, Eric Biggers wrote:
> On Mon, Jul 20, 2020 at 05:55:06PM +0200, Ahmed S. Darwish wrote:
> > Hi,
> >
> > This is v4 of the seqlock patch series:
> >
> >    [PATCH v1 00/25]
> >    https://lore.kernel.org/lkml/20200519214547.352050-1-a.darwish@linutronix.de
> >
> >    [PATCH v2 00/06] (bugfixes-only, merged)
> >    https://lore.kernel.org/lkml/20200603144949.1122421-1-a.darwish@linutronix.de
> >
> >    [PATCH v2 00/18]
> >    https://lore.kernel.org/lkml/20200608005729.1874024-1-a.darwish@linutronix.de
> >
> >    [PATCH v3 00/20]
> >    https://lore.kernel.org/lkml/20200630054452.3675847-1-a.darwish@linutronix.de
> >
> > It is based over:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git :: locking/core
> >
>
> Please include an explanation of the patch series in the cover letter.  It looks
> like you sent it in v1 and then stopped including it.  That doesn't work;
> reviewers shouldn't have to read all previous versions too and try to guess
> which parts are still up-to-date.
>

Noted. Thanks for the heads-up.

--
Ahmed S. Darwish
Linutronix GmbH
