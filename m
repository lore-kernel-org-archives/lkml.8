Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61140C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4046F206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ai6PKJC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgGHTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGHTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:04:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7E1C061A0B;
        Wed,  8 Jul 2020 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3AzJlAVqai0cEuMOquOSXp3pObZ1zRP/Z2pFW7hrx/g=; b=ai6PKJC+UsG5Jkm6GUeE3ujcur
        vkNSyvL4i2EilTsWrzZR+gl2c9/n8GiVwdCLLnB8zrAwCKR+8ThdGJLmNXs8jK5zj14Km6EekIgI8
        q3KDZIjkVO5/sf3PsdV6rh7T/mwdV7pyYJvVpR+lRlD+6Fb65cRiF086q4SsoV0BnwqdH89KDdzRq
        xyvPbu0veYYampBHlpBU38NR03UCarWi2iDbusbDw7ypxnRa18R/5RwsjRfJwgpWcW5/guqXNmEGu
        j/KeFEIyOatH7mMW8z+zmQ62l/5NFV+T7LiktQKY9bHo9n+jajW5QNSWP/MFkMi9cNtiJ1Bkszm5B
        ksBsG1cA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtFMo-0006ar-8a; Wed, 08 Jul 2020 19:04:26 +0000
Subject: Re: [PATCH] Documentation: update for gcc 4.9 requirement
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <a98e9c26-5405-3894-6197-3f5e388a5698@infradead.org>
 <CAHk-=whkuOeHvA_ws=usQt=rYq_M2vh448mDxY7kYhUmp_Lomw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1ac6b3ba-ad54-a227-94d3-06cdf4fa4c91@infradead.org>
Date:   Wed, 8 Jul 2020 12:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whkuOeHvA_ws=usQt=rYq_M2vh448mDxY7kYhUmp_Lomw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 11:57 AM, Linus Torvalds wrote:
> On Wed, Jul 8, 2020 at 11:45 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> - - Make sure you have at least gcc 4.6 available.
>> + - Make sure you have at least gcc 4.9 available.
>> -GNU C                  4.8              gcc --version
>> +GNU C                  4.9              gcc --version
> 
> Heh. The docs clearly weren't in sync before either.
> 
> Maybe we should add a
> 
>   Fixes: 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for
> kernel builds to 4.8")

uh, yes.
Should I resend it?

> to your patch too.
> 
> I only grepped for the obvious GCC_VERSION string. Which is presumably
> what everybody else who has ever done this have also grepped for,
> although in all fairness Will at least caught the one in
> Documentation/process/changes.rst when he updated it last time.


-- 
~Randy

