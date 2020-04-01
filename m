Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9F3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863020842
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M2JhvCc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgDAAzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 20:55:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57458 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732260AbgDAAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 20:55:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 009CF5F754;
        Tue, 31 Mar 2020 20:55:38 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=6Ba61ozdW2ME
        LOxHcef0GuJg9c8=; b=M2JhvCc+9B2kpneG9lvLE1eGQAei6ud+gSPA3e/lbYks
        8cN1y4+oAC6Z4CBbo0fCjRDbtD+oe3QD2WD2O5A2PO2O2yVOvn2a3jj6lY4iDAUT
        Fv7puagSxG+isEymArxt00AxfusJYZPiSFz7BuZ0FvwPE801o7dC5+0m7eMoA5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=s55EjS
        +lK/gKaaXKg73GamDej40JdmwryHyqVSBh0Yr7r7ELKeid1vkG8NmS+s00Kb4zmu
        CHzt5lbO0KvitmG1Jy75S8rIY48cD6ABX9cY5EJtcyc3Q802EHbtnv5wGr3JKHSv
        qfs887/+nqhpiUT/1q2JeD+V28gmbNzmQ44Z8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB7515F752;
        Tue, 31 Mar 2020 20:55:37 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Received: from [192.168.0.8] (unknown [76.183.130.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E4445F751;
        Tue, 31 Mar 2020 20:55:35 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
 <91730318-da0e-c992-f154-a74044b26650@pobox.com>
 <20200331223638.GA53668@ubuntu-m2-xlarge-x86>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <88a1f7e9-596b-1973-a122-b90ef5a36af4@pobox.com>
Date:   Tue, 31 Mar 2020 19:53:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200331223638.GA53668@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 802654EC-73B3-11EA-8093-C28CBED8090B-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/20 5:36 PM, Nathan Chancellor wrote:
> On Tue, Mar 31, 2020 at 05:25:38PM -0500, Daniel Santos wrote:
>>
>> This will break builds using gcc 4.2 and earlier and the expectation w=
as
>> that you don't put two of them on the same line -- not helpful in macr=
os
>> where it all must be on the same line.=C2=A0 Is gcc 4.2 still supporte=
d?=C2=A0 If
>> so, I recommend using another macro for the unique number that uses
>> __COUNTER__ if available and __LINE__ otherwise.=C2=A0 This was the de=
cision
>> for using __LINE__ when I wrote the original anyway.
>>
>> Also note that this construct:
>>
>> BUILD_BUG_ON_MSG(0, "I like chicken"); BUILD_BUG_ON_MSG(1, "I don't li=
ke
>> chicken");
>>
>> will incorrectly claim that I like chicken.=C2=A0 This is because of h=
ow
>> __attribute__((error)) works -- gcc will use the first declaration to
>> define the error message.
>>
>> I couple of years ago, I almost wrote a gcc extension to get rid of th=
is
>> whole mess and just __builtin_const_assert(cond, msg).=C2=A0 Maybe I'l=
l
>> finish that this year.
>>
>> Daniel
> No, GCC 4.6 is the minimum required version and it is highly likely tha=
t
> the minimum version of GCC will be raised to 4.8 soon:
>
> https://lore.kernel.org/lkml/20200123153341.19947-10-will@kernel.org/
> https://git.kernel.org/peterz/queue/c/0e75b883b400ac4b1dafafe3cbd2e0a39=
b714232
>
> Cheers,
> Nathan

Thank you Nathan.=C2=A0 In that case this is definitely what we want now.

Reviewed-by: Daniel Santos <daniel.santos@pobox.com>

Cheers,
Daniel
