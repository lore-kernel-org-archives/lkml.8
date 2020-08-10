Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8008EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC8C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Tvk+bsSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHJQJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:09:41 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:35328 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgHJQJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:09:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQLWk65PKz2d;
        Mon, 10 Aug 2020 18:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597075778; bh=jnGr4D1typF3L4cvQAPzJLaKj0mF/wj4jmVrPp2Me4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tvk+bsSCrs6bgpYzU6KMHNABcpyYUBxMv3wZFbInjIpbRRQrPreoYIOQuNz7dt1AY
         5/nPfhWDkN8vKhgg5hXmNXs4EbD7+cbq/Sps3eblZ8UUDSNmw+/o7u4MkblxNcnkjo
         J/QhzjVIoMHgpn32iWa4bUIeQ5rX++EA8NaB4yem9C3D+v0jadYpZoBDSN14jlgfdL
         tscVj2VVzczLJHN3931/3Trp+3r1LkXuETBxkf3g8d8miYAkmFXNRoCKqdAuMFF+rj
         b9yU9sV2BWlj4iimuo8Koibr02XlMW1wWohcL+Q8TmsXAg5L244bDQyivTQkWXplrZ
         aoO5jBesVntJw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 18:09:36 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: regulator: deadlock vs memory reclaim
Message-ID: <20200810160936.GA1100@qmqm.qmqm.pl>
References: <20200809222537.GA5522@qmqm.qmqm.pl>
 <20200810153928.GD6438@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810153928.GD6438@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 04:39:28PM +0100, Mark Brown wrote:
> On Mon, Aug 10, 2020 at 12:25:37AM +0200, Micha³ Miros³aw wrote:
> 
> > regulator_lock_dependent() starts by taking regulator_list_mutex, The
> > same mutex covers eg. regulator initialization, including memory allocations
> > that happen there. This will deadlock when you have filesystem on eg. eMMC
> > (which uses a regulator to control module voltages) and you register
> > a new regulator (hotplug a device?) when under memory pressure.
> 
> OK, that's very much a corner case, it only applies in the case of
> coupled regulators.  The most obvious thing here would be to move the
> allocations on registration out of the locked region, we really only
> need this in the regulator_find_coupler() call I think.  If the
> regulator isn't coupled we don't need to take the lock at all.

Currently, regulator_lock_dependent() is called by eg. regulator_enable() and
regulator_get_voltage(), so actually any regulator can deadlock this way.
I concur that the locking rules can (and need to) be relaxed.

> > Basically, we have a BKL for regulator_enable() and we're using ww_mutex
> > as a recursive mutex with no deadlock prevention whatsoever. The locks
> > also seem to cover way to much (eg. initialization even before making the
> > regulator visible to the system).
> 
> Could you be more specific about what you're looking at here?  There's
> nothing too obvious jumping out from the code here other than the bit
> around the coupling allocation, otherwise it looks like we're locking
> list walks.

When you look at the regulator API (regulator_enable() and friends),
then in their implementation we always start by .._lock_dependent(),
which takes regulator_list_mutex around its work. This mutex is what
makes the code deadlock-prone vs memory allocations. I have a feeling
that this lock is a workaround for historical requirements (recursive
locking of regulator_dev) that might be no longer needed or is just
too defensive programming. Hence my other patches and this inquiry.

Best Regards,
Micha³ Miros³aw
