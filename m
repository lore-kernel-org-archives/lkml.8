Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAE7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80E221883
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596181963;
	bh=VPyM/T80Mh0zNQ3oSHPpEAvM2H048J59i73NLEzJ1tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xASrLJ5jkwn9krMtG5YGTvZMRHRCn/iQBIuW4z1ENnqNS22XwXSAqptrr7N5r1Hn7
	 oO1E8oQKa6OUqsdDaezn+mZxokLhRxprtNyPYw9hHkp3ckhv0yrI29fYRuSM9pStGU
	 WeZbPWOlMjqfRfmk5hcCaBjvtHT+uoBkX8MiXGn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgGaHwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731644AbgGaHwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:52:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E44207F5;
        Fri, 31 Jul 2020 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596181961;
        bh=VPyM/T80Mh0zNQ3oSHPpEAvM2H048J59i73NLEzJ1tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ba/c3jRnjiXhFqcyN2O051ci5/zcLDA8kN1GqbTLTYfxuJfNv6mYpI3Hg/SturvYF
         c1oGpxEF+1zgyMk0udHoRxjFRXcJWwwXLBm9gklXU+s0AT0qKduaOoS46HtwEY1L3X
         YK/iByno+m0HEuoFg6TNWARy7MpAxjz5Vsa0qWck=
Date:   Fri, 31 Jul 2020 08:52:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Emese Revfy <re.emese@gmail.com>,
        hsinyi@chromium.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm64: pointer_auth.h:40:3: error: implicit declaration of
 function 'get_random_bytes'; did you mean 'get_random_once'?
Message-ID: <20200731075234.GA26018@willie-the-truck>
References: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
 <20200730211522.1ea3561f@canb.auug.org.au>
 <d23eba90-ee2c-efe0-0cb6-88e99fb22e54@ti.com>
 <CAHk-=whn8OB-QbxpffK=Lhh6Mhj+Y2ALFZ1asCgtnQOnmQgWUw@mail.gmail.com>
 <7b0c0f44-f56d-5e71-cf86-dbdea190267a@ti.com>
 <CAHk-=whX7gPBn+jthX8bbfz9kU+0CbYwTxbASwPRCZ1bhVqrOw@mail.gmail.com>
 <20200731021631.GA8247@1wt.eu>
 <CAHk-=wgPPibftjeuvi+s=RSeZij3PEWDOxb05UH4yRJWeDMzFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPPibftjeuvi+s=RSeZij3PEWDOxb05UH4yRJWeDMzFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:25:41PM -0700, Linus Torvalds wrote:
> On Thu, Jul 30, 2020 at 7:16 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > Don't you want to take Mark's patch anyway in addition to all this ? In
> > case anyone meets yet another build issue, they'd have more luck trying
> > to revert any other patch. Right now if they revert one, it breaks the
> > build in a different way and doesn't help much.
> 
> I think Will picked up Mark's patch into the arm64 tree, so I felt I
> should let it come in eventually that way.

Yup, you'll get it later today with a few other fixes that have trickled
in.

Cheers,

Will
