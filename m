Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC4DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E05D221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHGSJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:09:53 -0400
Received: from foss.arm.com ([217.140.110.172]:60936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGSJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:09:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0F551FB;
        Fri,  7 Aug 2020 11:09:52 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C203F7D8;
        Fri,  7 Aug 2020 11:09:51 -0700 (PDT)
Date:   Fri, 7 Aug 2020 19:09:49 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Theodore Ts'o <tytso@mit.edu>, Qian Cai <cai@lca.pw>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] arm64: kaslr: Use standard early random function
Message-ID: <20200807180948.GA27817@gaia>
References: <20200807144521.34732-1-linux@roeck-us.net>
 <20200807173513.GR6750@gaia>
 <CAHk-=wjh1qFxHc2kScvcusv_f3bYangc3cro9s_WCPOvd+biTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjh1qFxHc2kScvcusv_f3bYangc3cro9s_WCPOvd+biTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 10:48:36AM -0700, Linus Torvalds wrote:
> On Fri, Aug 7, 2020 at 10:35 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > Linus, could you please pick this up directly? Otherwise, it will wait
> > until we reach -rc1 to avoid basing a branch on a random commit.
> 
> Already done, since I was the cause of the mess. But because I did it
> early, your Acked-by didn't get in.

Thanks (and no problem about the ack).

-- 
Catalin
