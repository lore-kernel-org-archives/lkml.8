Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54221C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334372074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgGaFqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 01:46:35 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:39236 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbgGaFqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 01:46:35 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 06V5k2gM016532;
        Fri, 31 Jul 2020 07:46:02 +0200
Date:   Fri, 31 Jul 2020 07:46:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Emese Revfy <re.emese@gmail.com>,
        hsinyi@chromium.org, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm64: pointer_auth.h:40:3: error: implicit declaration of
 function 'get_random_bytes'; did you mean 'get_random_once'?
Message-ID: <20200731054602.GA16529@1wt.eu>
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
User-Agent: Mutt/1.6.1 (2016-04-27)
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

OK then!

> The immediate problems seem to have been resolved.
> 
> Knock wood.

Yes, that's my feeling as well. I'm going to resend you your patch
moving prandom32 definitions to prandom.h rebased on these latest
changes, add add a commit message. It would be nice for 5.9, but
maybe it could put an end to this mess once for all :-/

Willy
