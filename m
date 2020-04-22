Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FF8C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9452075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="bPE7bNu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDVJdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgDVJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:33:01 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B935C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iEdwfLPox7oZxLW8B0dEMX68Aup6NCI3jJ4OA1EvO08=; b=bPE7bNu2dmhnJKpN4BIFbCHyqu
        1qH0uDzyHhMtwgcI5ekXwk5+C+WobT2ROdwCHeZuIKLddReop2g2S5AL8PenCOsWQOWqRckZLUpu0
        xdbK6C3lUPuU9Idk4hQjQGEVJJrlScVTlUyOwnJCvOaR/YSEkV5R6fCrBGb6XJ4LYuk6ldcQrUpcH
        AGpTbIonvDa4rrmjgiuzrpmUkBuA0Gb30oJZ6hy1lCUfs5p+cIqzDrsOlJHfnp1Cc02/PJIyB5qBJ
        a+feCFWdtof/tjV59+ULOEGCj0nuGmwT3VEEUMD2nPk+fOU8lEXoQPbn5GlCrkf03V+szXGicWh28
        jFoCdJfA==;
Received: from [2a01:79c:cebf:7fb0:d967:6cf9:736f:4613] (port=42882)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1jRBkZ-0000F6-Jj; Wed, 22 Apr 2020 11:32:59 +0200
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
 <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <395f63b5-a24b-0eb9-4cb2-06057c1882d8@skogtun.org>
Date:   Wed, 22 Apr 2020 11:32:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [21.04.2020 21:03]:

> On Mon, Apr 20, 2020 at 1:52 AM Harald Arnesen <harald@skogtun.org> wrote:
>>
>> Neither rc1 nor rc2 will boot on my laptop. The attached picture is all
>> I have been able to capture.
> 
> I know you saw the reply about this probably being fixed by
> 
>   https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/
> 
> but it would be lovely if you could actually verify that that series
> of four patches does indeed fix it for you.
> 
> Your oops is on that divide instruction:
> 
>         freq_scale = div64_u64(acnt, mcnt);
> 
> and while we had a check for mcnt not being zero earlier, we did
> 
>         mcnt *= arch_max_freq_ratio;
> 
> after that check. I could see it becoming zero either due to an
> overflow, or due to arch_max_freq_ratio being 0.
> 
> I think the first commit in that series is supposed to fix that
> arch_max_freq_ratio being 0 case, but it still feels like the code
> that does the divide is checking for zero in the wrong place...
> 
>                   Linus

I will try the patches today, and report back.
-- 
Hilsen Harald
