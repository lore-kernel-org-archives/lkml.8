Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B719C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA420709
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rrxm18qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgHQXWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHQXW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:22:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E75C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=tIkEgB+fwOAFOaf/drqEAz6ed9qOY9fx/AstJdlgNn8=; b=rrxm18qIu8NdWfouL+ehSetkl5
        FF39KTB+dxivXDkfkPpGw8wyQEZFLg/t237j1WMdVvt35Uq9TEbWSSLDNg44gcjT5F1Dr2lucTjUL
        bzri83NZuQUXhE2Ck9K8lTWEmUGi+Wcr/olCtaFKfUlHVaSUkd6QXk4HOHcE2GkPsJO45LQWVmMCo
        mCrpd1DFFSVTW0Vw5PK+/nx9D0bV0UsV6i90OZusjNR8MUgYZKlivAJfxTM3xgoOobreQtd2y11mW
        ZlCaZL41ZRs4jMB9bKpXZICj3OIcJ0wKDsAx67nAon3lLQNfJL5rt+XDCo0lZpkZCZGYAJJ8OiUty
        bAPozAdg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7oSP-0007ci-Pu; Mon, 17 Aug 2020 23:22:26 +0000
Subject: Re: .config file attached for your perusal..build stopped... Linux
 5.9-rc1
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
 <20200816225822.GA3222@debian>
 <CAHk-=wgOaEmFGYhnx7XLe8AbQKYpgMAzyuHuS8dYZoB2hS3C=A@mail.gmail.com>
 <20200817212519.GA11141@debian>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <35fc1d2a-aff5-42d4-bd4b-6cabaa67fe8e@infradead.org>
Date:   Mon, 17 Aug 2020 16:22:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817212519.GA11141@debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 2:25 PM, Bhaskar Chowdhury wrote:
> On 09:44 Mon 17 Aug 2020, Linus Torvalds wrote:
>> On Sun, Aug 16, 2020 at 3:58 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>>>
>>> I am scared that I might have missed something very obvious ...am I?? And the build abort...take a peek..
>>>
>>> ./arch/x86/include/asm/io.h:292:2: error: implicit declaration of function ‘slow_down_io’ [-Werror=implicit-function-declaration]
>>
>> I'm not seeing how that would happen with a pristine codebase, but
>> send me your config just in case.
>>
>> slow_down_io() is declared not that much further up in that file (or
>> in paravirt.h that gets included before for the CONFIG_PARAVIRT case).
>>
>>             Linus
> 
> Thanks, Linus ...I have attached the .config file with this mail for your
> perusal.

Hi--
I don't see any build errors with your config file.

-- 
~Randy

