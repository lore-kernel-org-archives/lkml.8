Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A74AC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 08:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61A120848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 08:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jwoUgF7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgAKIEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 03:04:13 -0500
Received: from mout.web.de ([212.227.17.11]:41305 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbgAKIEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 03:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578729832;
        bh=u3JVOzmY9RZcOpZJsz/ULDggfGkDL2Vs0JKaJtLOWfo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jwoUgF7ly7ib79xO+lrctmhMebwW6nt26p6tyR/D4RlzEtelquuINV1BgLJMAF33V
         b0wr72ZKGyRjmFpW0uZ93WaZRdsJ3oaFF8UrqMoNyDsloftU5ff/U6a86OhaovwKYJ
         zTeujOsV+OzAB7RbPQfb/t8u8e1WCNgzYzCgFy48=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.100.149]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4ZPc-1jbRmW1bYK-00ykZ2; Sat, 11
 Jan 2020 09:03:52 +0100
Subject: Re: [v3] coccinelle: semantic patch to check for inappropriate
 do_div() calls
To:     Julia Lawall <julia.lawall@inria.fr>,
        Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
 <91abb141-57b8-7659-25ec-8080e290d846@web.de>
 <c4ada2f2-19b0-91ef-ddf3-a1999f4209ea@linux.alibaba.com>
 <5a9f1ad1-3881-2004-2a7b-d61f1d201cf9@web.de>
 <alpine.DEB.2.21.2001110841140.2965@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c64b6f61-f523-dc8a-2abc-b0e9a8cd2d98@web.de>
Date:   Sat, 11 Jan 2020 09:03:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001110841140.2965@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jVQTek2AXtBLvSkyVRcKs/6xhkcFHSLhffxZJp9lhW2a99Ztx97
 coVts5CkRzcT/I3p+szi28ZM7TaPY3UAzBzEJkkG3cDWPtw/ZPNuRdA/NzGLbfTR2pejQkG
 jiS78/79vcFsub7DCkE2Z6GBKqhM4cYqRc3pWKtZsMTFAUeFgIAh2rYIMWU3GqYNH62dTq+
 MDZHVrR6Au9t0MSSI9JDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R6qPDdIJhDQ=:8KBdRyt2NghKwuBQPzHqFc
 K+9M47ha8wqP42MC3JrSY9PjRyHBDtIAn+8SdzoQtwXfaGoPqB3kyelEb3f3ohHA3w8oSBCHN
 Q7/lUB+fX9AQ+CIdtiRZedeP6p7VkEqLcuPPKcrtX0NNjbqkDUm8H2vs6uqeyJS8j2wlUKSqD
 NrrGVC5idnQkPZvNJMsWTLn44BGR8JC4yZe1mmyXgzvm8S8ItUMi4aGFPar4/STU77sJ33xt4
 hvYS+9QmA8DGt/H8v/92z5+BHr9fCL2bK60b0xao0CQ+WlhpClYCgP1fhdEn+DuLlgInGyDzD
 J+m+sHCFceYoxALv77Hnxj34ZeLkZBcPu0fTZ5ctlZlU0N/JmX2VeXotNBxqDzS+hZfHw9IsN
 EPnPh9mFAa9MWeLlAHPR250p24/EwbrCl8u/Gxb3MeWrid8k2UNkAWq93vzJtrBpFnAPfiiPD
 ZXSQxkRoxMpuzFH2+w9KC89Rwk9Sp6P7fsPofv97Pw6OWOQJgW2S+ocBLaeWm6n79JNImrENT
 Pvp6ofcf92EWI1JCRAvvDyt1P2ZlR/F4pzKkcbeSdSgq4xWzlFVF2PF4KvDmzj2z+qX63DbHq
 WVlIkSnic/+UXStZqXD0ElxFmgNUXjNwuLKRbD0RX29Qk8mOiSjRwegAbRl5sZtns83pMVnOX
 /Mmg38dQFuSErK86U4DOSTPqJlQJa6V3kPG8BvWr2mfiBsGXWy3IWHk9gEfY9+7utewYWmvu7
 YHOJ4Boazy6RKmLmhQy7UM4ypBkv7BCLdymOF7gOTD7xL+43K7Wgya0Zmgg+QCNAFKkefH6WC
 tWIa/14vizS/blZ63QM1jRcxQnYE3eI2jhsPSD+qpV4Y8A9XLlAMEdLJI+NIC7hQhQ7/PD+6r
 bZyQcdRU2T+sHC/QalTpmPauyN5B2uUNvMIOdB5IZ6suOkYW4j/83pGQe3UK55GmE05ydsz4A
 8bJh35Jye9Qv6FpCpy+dZRZl/mFT8P0WoPeh7puBdUUWzfK6FFnBK1llw6QvVIypBoES+4VsM
 QuB+MOSrxj6Nt9ptbav8fwGGycHgpk9MdfurweGmgLefgrHRcI62DJ2EuWmoiYK/pI5Kln0Tr
 EjbiPEmoBCPX2kMbm4W5kEblT2gFWxLNpe+pssR4mucYCQ2AAFf+bi/dlxqY0Czzt/Df68BFA
 tJRTl1jjVop4ZK0h4As300rPSNJpXt8/Oby0wdzkbOYHOZyRDC/io3n6hyInhX+Omtl8i/Low
 ubDVgXA6tSKZI8b+vCpystjEs4vsvfeC9lz26UfeVxTIHrwC9nDppgAtb2O0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can the avoidance of duplicate source code (according to SmPL disjuncti=
ons)
>> trigger positive effects on run time characteristics and software maint=
enance?
>
> Markus.  Please stop asking this question.

This will not happen for a while.


> You are bothering people with this advice,

I present just another view.


> why don't _you_ figure out once and for all whether the change
> that you suggest has any "positive effects on the run time characteristi=
cs"?
> Hint: it will not.

* How much attention do you give to the software development principle
  "Don't repeat yourself"?

* Can the file size of a SmPL script matter a bit?


> Coccinelle has a pass that propagates disjunctions at the sub-statement =
level
> to the statement level.

This data processing can probably trigger further development consideratio=
ns.

Regards,
Markus
