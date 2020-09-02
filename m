Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE4DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023B92087C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBIsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:48:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46598 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:48:07 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDOQk-0007IA-27; Wed, 02 Sep 2020 08:47:46 +0000
Date:   Wed, 2 Sep 2020 10:47:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "madhuparnabhowmik10@gmail.com" <madhuparnabhowmik10@gmail.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: clean up codestyle
Message-ID: <20200902084745.zhwqo56ch6imc6cy@wittgenstein>
References: <e436dd19f0e740ebb93133ae3c625af4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e436dd19f0e740ebb93133ae3c625af4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 01:34:59AM +0000, linmiaohe wrote:
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
> >On Tue, Sep 01, 2020 at 06:39:05PM +0200, Oleg Nesterov wrote:
> >> On 09/01, Christian Brauner wrote:
> >> >
> >> > On Tue, Sep 01, 2020 at 07:58:00AM -0400, Miaohe Lin wrote:
> >> > > No functional change intended.
> >> >
> >> > Hey Miaohe,
> >> >
> >> > Thank you for the patch.
> >> > I'm sure this is well-intended but afaict the whole file has more or 
> >> > less a consistent style already where e.g. sig-1 without spaces 
> >> > seems to be preferred. The same for the casts where most places use 
> >> > a single space.
> >> >
> >> > Now, I know CodingStyle.rst is on your side at least when it comes 
> >> > to the first point:
> >> >
> >> > Use one space around (on each side of) most binary and ternary 
> >> > operators, such as any of these::
> >> >
> >> > 	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
> >> >
> >> > but then you'd need to change each place in kernel/signal.c where 
> >> > that is currently not the case.
> >> 
> >> Or simply leave this code alone ;)
> >
> >I was trying to imply that by pointing out that this would be file-global change. I was likely too subtle. ;)
> >
> >Christian
> 
> Sorry for I did not get the imply.

No need to apologize. That's my bad. 

Maybe some context is useful.
One of the reasons why we tend to sometimes not take changes such as
this even though they would be covered by our officially documented
coding style is to keep the churn minimal.
Whenever functional change happens in codepaths such as this the risk of
regressions is quite high. That's partially because we could use more
tests to catch them (And if you're interested in stuff like this then
writing selftests is always great. We can always use more of them.) but
also simply because the code is complex. Having a lot of non-functional
commits that don't really improve the legibility of the code
significantly can become an issue for maintainers. Personally, I tend to
be less worried about this but this is a collaborative endeavour. :)

Thanks!
Christian
