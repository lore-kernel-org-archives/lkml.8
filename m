Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6490C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BEC206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRTt2R5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgGAOxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbgGAOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:53:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27218C08C5C1;
        Wed,  1 Jul 2020 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qv8ZMHyKHCmtMm5Rtqv9XtfpZqKg8Q3pyrTN/4USWyA=; b=MRTt2R5E/H73jBWpLvDEUo1CMX
        1Dzqder3R5kLUZV5Ww+or+SUWGZb9iBA0Ow3Tz1tdlFFRSaB8KSP9MwvNFl6WmZGYVWSqMpt8aeGg
        t0bKO7YB8i4cw4qaGH/pAb5C7g2bF8tUZ+NXvA/XXRtqg2JIQoBrmViPGoiEbCHOhlvitdoUdBlCT
        Q2DmuUvy02L02E6j6zVsx49y3mRs1pNUZQ6owhCImK/rNsgEVRyoVPdXypIWJYOa8ZBuupSyDFW0s
        2SWZWXh1xMcmBmMcqgDhE+tYSiLdd11t6uI5rf7QlXetiY7LMxb2a2mkFK6ISYsHbV7mIzwjgrdhB
        U8Ph/H8g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqe6i-0003q4-57; Wed, 01 Jul 2020 14:53:04 +0000
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
Date:   Wed, 1 Jul 2020 07:52:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 6:32 AM, Markus Elfring wrote:
>>>>> We might stumble on different interpretations according to the wording “file basis”.
>>>>> Do you find a message like “make: Nothing to be done for 'path/to/file.c'.” interesting then?
>>>>>
>>>>> * Would you like to add any links for information around the support for
>>>>>   source code checkers?
>>>>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?id=7c30b859a947535f2213277e827d7ac7dcff9c84#n198
>>> …
>>>> Feel free to submit patches.
>>>
>>> How do you think about to use the following command variant
>>> for the adjustment of the software documentation?
>>>
>>> +    make C=1 CHECK='scripts/coccicheck' 'path/to/file.o'
>>
>> I don't understand the reason for that change...

IOW, your "patch" needs justification and/or explanation. It was missing that info.

> Is our understanding still incomplete for the support of source code checking parameters
> by the make script?
> 
> * Will software analysis be performed in addition to the desired compilation
>   of a source file (according to the selected object file)?
> 
> * How do you think about to trigger only the generation of analysis results
>   for a single file?

Do I need to remove that line from the patch?

Feel free to submit patches, not just comments.

-- 
~Randy

