Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FC6C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5472820728
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="m9RIqbaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCEV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:27:16 -0500
Received: from mout.web.de ([217.72.192.78]:47347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCEV1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583443594;
        bh=RawCBO85mwhM4Kxn4AkxSMMV6eYmzXfyQrkWaU7Ehjo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=m9RIqbaCXSlEGtVuC4j9K5sssV054T19YFOatggZ2t86DOD0PXrEWWTbsjzO1lJ+K
         fC5O/MI2mt0LZwB34m/zFRNutZcK0Tp4+f6BSByl6QZkXfCMtofoB1+S5jsZ42aoYN
         QnwQyE1b4rdOFb7ycsN/GDlu0JV8twyjG+BShgFE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZUWH-1ivJRP06g9-00LH42; Thu, 05
 Mar 2020 22:26:34 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
 <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
 <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
 <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
 <20200305140004.535eeb1a@gandalf.local.home>
 <af5d4af0-9e06-cc6e-c29e-4c4eebdb9b0e@web.de>
 <20200305142505.714a5121@gandalf.local.home>
 <2d5df2ac-443b-cc31-c2bf-78947f81dd00@web.de>
 <20200305155628.09a1e1d4@gandalf.local.home>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7976cd6c-da28-2df7-492f-7d412e40ff5e@web.de>
Date:   Thu, 5 Mar 2020 22:26:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305155628.09a1e1d4@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eqUZztE9rXh/5GiMCSBM8j5l63HcsiyIdogsWxzLDYyN0a2UyaS
 KSuelNiQ3xg8sGK0LlapbhVZhkrkGUGSvvyWOdsA0FqPDE4Hi3KnNKzSgKdXoKbOV0Uid3B
 0PXqr4EPCvWRhmQ9z+YZ8leLCpptCbGWKVQ0Ciwqs4g7TI6RPv6r+7BdzbuGfZERPj60NAa
 LcMAPWrDJf+OFCJPOLcvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pC2C8Sde/y0=:RpMkzLATEL/1jrzKbweKyX
 e6AT8Vbts+EB1XEQi9jCEpgTvCl7gSc8WPBhsMcYpXAUYrA8aAqaUo2OF3bDQ5LrjqFsRwaXO
 xdjRpe725Jdl911PKggbAKe02sfuaxY6z8F8OjAR+OFZmA1vHcPsBkKiZCN/xxrBz2ixVjsCj
 tqxew1XcZzwdvgp9Ii/ub3LVaH71WSrpp4d+EQjyFSypXHeYC2QrKttoiL1eo1VAhjaX1mFFu
 Lro601d9zyoVpvNJH/cR9Jfw7LlzkhZav2trQeffF4LJdEhFdcEqQwvLkrSojx8tSbqSMzdfY
 cKm8OTABVJ1zqHU/ZsiA5L4uycmXbctZGKf0KEos3Cloa3luFfPfonz+evCTXgIceGmDEumek
 Zbt6aWiauvmHPAjZ9reCPb5YptDzkmdgE04HrkTRKxgcr3H41gUf37KBNruM1yIGH2xPPSo8r
 Obkhb/0FhIK1r9HPVoy29I3JjcSZnhh5d3KoE3WUdttnXtdDnChSaImM/1hcQ1RT5aFC/WwEI
 funwCeWFQxpmRamYd8AMiaxPvn2H19bzteM927O0ujSIcEOjFcOG1QvntQYWH4H2cZM9IqKwt
 6d5jw/YMqjZoguUqMa8vOMHXHRs3ttih9bdN1zLiuJ4LmIyCYYGjp0M5u8Xh37jN/4iL+1UqC
 kGDUAKJG32EYWhKCZgffK4Jih1CgU0T+z8apfpurDBdA95ASkf1E5S24bXhh6sVmLC90xDady
 t2qNZSq6cyopA3BY7gEIo6i34Em+c66322BqP98ECmXNZmp4BGN+qxx66Mh+mUchWFfVtNHdl
 D558syIZvXtDE5sHSoLAzk23srYArpDfu/88hw9dbl+ajO7YhKOXdIZXGectdXPCDRQ0tFXdb
 u9WZ9o7cSOE8uVYg6LcZYYhW8nrwRsm2P64XCnlF7T6AdREpISVXkpskmHLZUhkeBVowPV9SA
 EVeqWtqRMHO3E1EhO/GQB2KpyLb8DQUC4//XgC+XWDHlJo7BoPFaa7JBG3GivPvgH+KUpaek8
 Ua9EZ1rX6v4R136uSdNYj/7Ar7r7IcJ9+gg8X6KtaQj1UInajr5FwhFs8c6P7j4OmT/K3Bid7
 dVfgqVcIcx8fsPeIhcTuW2TfyoeCM/Ha04fkOf2Kna7e6SxzV3KrGXVzeSsyrsmbtmbp+KO5b
 ZfaY+TmwZjECyius4YdMrIJx/dCnB7iMUJHYFQplqvRcbtcHpZCF8jKjJppZxi196ZAtDKY6t
 /vePUQqYEofc2Ea9K
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> What bug are you reporting?
>>
>> Examples:
>>
>> * Another typo
>>   =E2=80=9C=E2=80=A6 contain only alphabets, =E2=80=A6=E2=80=9D
>>   https://lore.kernel.org/linux-doc/967d6fee-e0cd-c53f-c1f6-b367a979762=
c@web.de/
>>   https://lkml.org/lkml/2020/3/5/247
>
> Legitimate but not critical.

Thanks for such a view.

It might be that less simple update candidates were left over now.



>> * Use case explanation
>>   https://lore.kernel.org/linux-doc/f3c51b0a-2a55-6523-96e2-4f9ef0635d9=
f@web.de/
>>   https://lkml.org/lkml/2020/3/5/429
>
> I believe what Masami has is sufficient.

I got an other impression.

An other document contains background information like the following.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/trace/boottime-trace.rst?id=3Db8381ce7aa8ef1ab5a79bf710508e504=
c494acf7
=E2=80=9C=E2=80=A6
Since kernel command line is not enough to control these complex features,
this uses bootconfig file to describe tracing feature programming.
=E2=80=A6=E2=80=9D



>> * Challenges for the safe application of key hierarchies
>>   =E2=80=9Ckernel.ftrace=E2=80=9D?
>>   https://lore.kernel.org/linux-doc/c4a0bc10-a38b-6ea9-e125-7a37f667e61=
a@web.de/
>>   https://lkml.org/lkml/2020/2/28/363
>
> Again, what Masami has is sufficient.

I would appreciate further clarification also in this area.


>> * Feature request for syntax description
>>   https://lore.kernel.org/linux-doc/2390b729-1b0b-26b5-66bc-92e40e3467b=
1@web.de/
>>   https://lkml.org/lkml/2020/2/27/1869
>
> Masami's reply to you was sufficient.

Yes (in principle).

But I hope to achieve collateral evolution here, too.


> Of your examples, only one do I see can be applied, but is just a minor
> change in wording.

I am trying again to resolve disagreements somehow.


> I don't know where you are going with this, and unless you plan on
> submitting patches, I think this document is complete as is.

I hope also to influence the software development attention another bit.

Regards,
Markus
