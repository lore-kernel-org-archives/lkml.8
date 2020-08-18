Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D14C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866722075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=meinberg.de header.i=@meinberg.de header.b="iJoaDzL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHRUu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:50:56 -0400
Received: from server1a.meinberg.de ([176.9.44.212]:56954 "EHLO
        server1a.meinberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgHRUux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:50:53 -0400
Received: from srv-kerioconnect.py.meinberg.de (unknown [193.158.22.2])
        (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by server1a.meinberg.de (Postfix) with ESMTPSA id 8CD5871C12CD;
        Tue, 18 Aug 2020 22:50:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meinberg.de; s=dkim;
        t=1597783847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=duR/eyl3+vmwe4wjWP6CNYqeRZKf9PfuW02UUUGINho=;
        b=iJoaDzL31NujwCwMfVNKkqcFs5ZyeilIyIvi1hHKOLgjYjDhbgJuhvimeZOpegw1RqrBGt
        wGU9RlPjIlnNrfiDX5i5eTYqWVa4kEYXiup2NfmG1+Fzz8Fm6gCZPH7uCcWSsbHCZk6+3q
        bQYxJgOufvC7qTFpRlOrLGmuJClCFY8SorshKSEp0jnQIiVCycbrYJC5CavDOsOBk2Fo30
        +jGMU4WED5x5PSXyzKmCaXsO6L2nAFkUcUbyDog+x3UzIKeGKS3dKkOwheBRUvf4Jv6ehA
        1UHF/nuvtHriO/cqE+urYluYenZwIEyr71NMdb7usSHNZPwv2WVl3omNlsRicw==
X-Footer: bWVpbmJlcmcuZGU=
Received: from localhost ([127.0.0.1])
        by srv-kerioconnect.py.meinberg.de with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 18 Aug 2020 22:50:43 +0200
Subject: Re: Kernel build system broken in 5.8?
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1c4d1da4-36a9-c83b-1a8a-95334aa62ce3@meinberg.de>
 <CAK7LNARpC4GHnXoWM=JU=cYxMdamg5iUWGoXt5o6mhf81QkjLw@mail.gmail.com>
From:   Martin Burnicki <martin.burnicki@meinberg.de>
Autocrypt: addr=martin.burnicki@meinberg.de; keydata=
 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
 fPTIMcWxGmfGPw==
Organization: Meinberg Funkuhren GmbH & Co. KG, Bad Pyrmont, Germany
Message-ID: <092a70e9-12c1-29fd-1fb0-fd851024de39@meinberg.de>
Date:   Tue, 18 Aug 2020 22:50:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARpC4GHnXoWM=JU=cYxMdamg5iUWGoXt5o6mhf81QkjLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masahiro,

Masahiro Yamada wrote:
> On Wed, Aug 19, 2020 at 1:14 AM Martin Burnicki
> <martin.burnicki@meinberg.de> wrote:
[...]
>> I usually build the kernel module as standard user, and only install the
>> new module as root, e.g.:
>>
>>   git checkout devel   # The 'devel' branch is appropriate for testing
>>   cd mbgclock          # the subdirectory of the kernel module
>>   git clean -fd; make  # or make V=1 for verbose output
>>   sudo make install
> 
> 
> This is a bad way for reporting a bug
> because your project is too big.

Sorry for this. I wasn't sure which was the best way to get a contact to
folks who are more familiar with details of the kernel build system, and
what may have been changed.

A possibility could have

> mbgclock/Makefile include the top Makefile,
> which is more than 1000 lines.

If you run 'make' in the mbgclock subdirectory then the kernel build
system is just called as usual, i.e.

  make -C <path-to-the-kernel-build-system> M=$PWD <some EXTRA_CFLAGS>

This has been working without problems for many years, for many popular
distros, and all kernels from 2.6 up to 5.7 (except that for older
kernels SUBDIRS=$PWD was used instead of M=$PWD).

> Please provide steps to reproduce it
> with a tiny test module.

I was just hoping that someone had an idea like "Oh, this is because xyz
has changed in kernel 5.18" when he read what I've observed.

In the past I've seen cases where folks e.g. from RedHat or SuSE had
backported patches from newer kernels to older ones, causing build
errors in my driver code, and I was able to apply workarounds to my
source code.

However, this case is different because obviously the kernel source tree
is modified under certain circumstances. Is my assumption correct that
this should not happen if I install Linux header packages for a distro,
that have been pre-configured according to the running kernel?

Anyway, I'm going to try to set up an example which makes it easier to
duplicate the problem.

> You state 5.7.15 was fine.

Yes.

> So, could you also run git-bisect, please?

Sorry, I've just recently started using git, and yet I'm not too
familiar with some of the commands. How could git-bisect help in this case?

>> Also, I was under the impression that the kernel source tree should be
>> read-only, and kept clean, but this doesn't seem to be the case anymore.
>>
>>
>> For example:
>>
>> On Ubuntu 19.10 with kernel 5.8.1-050801-generic from
>> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8.1/
> 
> 
> I cannot try it since that is not what
> I install on my machine, sorry.

What distro are you using? Or do you only run kernels you have compiled
yourself? ;-)

> Please provide steps to reproduce it
> for a person using a different environment.

I'm going to try to do this. Do you have any hints what this should look
like?

Should this topic be continued on linux-kernel@, or better on
linux-kbuild@, or elsewhere?


Thanks,

Martin
-- 
Martin Burnicki

Senior Software Engineer

MEINBERG Funkuhren GmbH & Co. KG
Email: martin.burnicki@meinberg.de
Phone: +49 5281 9309-414
Linkedin: https://www.linkedin.com/in/martinburnicki/

Lange Wand 9, 31812 Bad Pyrmont, Germany
Amtsgericht Hannover 17HRA 100322
Geschäftsführer/Managing Directors: Günter Meinberg, Werner Meinberg,
Andre Hartmann, Heiko Gerstung
Websites: https://www.meinberg.de  https://www.meinbergglobal.com
Training: https://www.meinberg.academy

