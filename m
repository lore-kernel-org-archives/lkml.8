Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0136C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE26522D6D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgHERdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:33:11 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36668 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgHER1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:27:50 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A6D8A1C0BE1; Wed,  5 Aug 2020 19:27:47 +0200 (CEST)
Date:   Wed, 5 Aug 2020 19:27:46 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL 0/5] ARM: SoC: changes for v5.9
Message-ID: <20200805172746.GC1118@bug>
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 2. In the past few merge windows we have seen an increase in (usually
>    older) Android phones and tablets gaining mainline kernel support.
>    This time we get a total of eight Snapdragon phones and two Tegra
>    tablets. To me this indicates that we finally have sufficient driver
>    support, in particular on the GPU side, to make this workable.
>    It also shows the impact that a single hobbyist developer can have,
>    as most of the new support was submitted by Konrad Dybcio who only
>    started contributing kernel patches to mainline Linux for postmarketos
>    earlier this year.

I'm happy to see that. So far, Nokia N900 is reaonably supported (basically everything
but Bluetooth works, voicecalls miss userland daemon for audio), and Motorola
Droid 4 (modem needs some more in kernel, camera will be hard).

Is there anything with similar support coming in, or is it usual "it boots,
serial console works"?

Should we have some kind of linux-phones mailing list? There is quite a lot of
stuff common in phones.

Best regards,
									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
